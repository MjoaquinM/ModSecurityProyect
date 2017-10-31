/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.controller;

import com.fich.wafproject.model.ConfigurationFileAttributeGroups;
import com.fich.wafproject.model.ConfigurationFiles;
import com.fich.wafproject.model.ConfigurationFilesAttributes;
import java.util.List;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
 
import com.fich.wafproject.model.Users;
import com.fich.wafproject.model.UserProfiles;
import com.fich.wafproject.model.UsersHistory;
import com.fich.wafproject.service.ConfigurationFileAttributeService;
import com.fich.wafproject.service.ConfigurationFileService;
import com.fich.wafproject.service.UserService;
import com.fich.wafproject.service.UsersHistoryService;
import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
//import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author r3ng0
 */
@Controller
public class ModsecurityController {
    
    @Autowired
    ConfigurationFileAttributeService configurationFileAttributeService;
    
    @Autowired
    ConfigurationFileService configurationFileService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private UsersHistoryService userHistoryService;
    
    //Configure Request Body Page
    @RequestMapping(value = { "/reqBodyConfig" }, method = RequestMethod.GET)
    public String modSecConfigReqBody(ModelMap model) {
        return "reqBodyConfig";
    }

    @RequestMapping(value = "/configurationFiles/applyRequestBodyHandlingChanges", method = RequestMethod.POST)
    public String applyReqBodyChanges(@Valid ConfigurationFiles ccf,
            BindingResult result, ModelMap model) throws IOException, InterruptedException {
        configurationFileService.save(ccf);
        ccf=configurationFileService.findById(ccf.getId());
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();
        List<ConfigurationFilesAttributes> attrs = configurationFileAttributeService.findByFileConfiguration(ccf.getId());
        try {
            String line = "";
            FileReader fr = new FileReader(ccf.getPathName());
            BufferedReader br = new BufferedReader(fr);
            java.io.File f = new java.io.File("/tmp/"+ccf.getName()); //ARGUMENT MUST BE A GOBAL VARIABLE
            FileWriter w = new FileWriter(f);
            BufferedWriter bw = new BufferedWriter(w);
            PrintWriter wr = new PrintWriter(bw);
            String msgToHistoryLog = ccf.getName()+" setup";
            while ((line = br.readLine()) != null) {
                if (!line.isEmpty()) {
                    String aux = line;
                    if (aux.indexOf(" ")>=0){
                        aux = aux.substring(0, aux.indexOf(" ")+1);
                    }
                    for(ConfigurationFilesAttributes cfa : attrs){
//                        System.out.println(aux + " -- " + cfa.getName());
                        if (aux.contains(cfa.getName()+" ")){
                            if(!cfa.getConfigurationFileAttributeStates().getName().equalsIgnoreCase("LOCKED")){
                                line = line.replaceAll("#", "");
                                msgToHistoryLog = msgToHistoryLog + " - Setup "+cfa.getName()+" Attribute: "+line.replaceAll(cfa.getName(), "").trim()+" to "+cfa.getValue()+"\n";
                                line = cfa.getName()+" "+cfa.getValue();
//                                msgToHistoryLog = msgToHistoryLog + " - "+cfa.getName()+" was blocked \n";
//                                line = "# "+line;
//                            }else{
//                                msgToHistoryLog = msgToHistoryLog + " - Setup "+cfa.getName()+" Attribute: "+line.replaceAll(cfa.getName(), "").trim()+" to "+cfa.getValue()+"\n";
//                                line = cfa.getName()+" "+cfa.getValue();
                            }
                        }
                    }
                }
                wr.append(line + "\n");
            }
            wr.close();
            bw.close();
            br.close();
            this.persistEvent(msgToHistoryLog);
            String cmd = " pkexec sudo mv /tmp/"+ccf.getName()+" "+ccf.getPathName();//+" && /etc/init.d/apache2 reload";
            Runtime run = Runtime.getRuntime();
            Process pr = run.exec(cmd);
            pr.waitFor();
            BufferedReader buf = new BufferedReader(new InputStreamReader(pr.getInputStream()));
            line = "";
            cmd = " pkexec sudo /etc/init.d/apache2 reload";
            run = Runtime.getRuntime();
            pr = run.exec(cmd);
            pr.waitFor();
            buf = new BufferedReader(new InputStreamReader(pr.getInputStream()));
            line = "";
            
        } catch (IOException e) {
//            System.out.println(e);
        }
        
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationTemplateModal");
        /*<Build data modal - end>*/
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("user",getPrincipal());
        model.addAttribute("currentFile",ccf);
        return "configurationFilesTemplate";
    }
    
    private String getPrincipal(){
        String userName = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
 
        if (principal instanceof UserDetails) {
            userName = ((UserDetails)principal).getUsername();
        } else {
            userName = principal.toString();
        }
        return userName;
    }
    
    private void persistEvent(String msg){
        String currentUsr = this.getPrincipal();
        
        Users user = userService.findByUserName(this.getPrincipal());
        UsersHistory uh = new UsersHistory();
        uh.setDescription(msg);
        uh.setUser(user);
        uh.setDateEvent(new Date());
        userHistoryService.save(uh);
        System.out.println("MSG: " + msg + " \n " + "CURRENT USER: " + currentUsr);
    }
}