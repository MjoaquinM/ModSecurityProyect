/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.controller;

import com.fich.wafproject.model.ConfigurationFiles;
import com.fich.wafproject.model.ConfigurationFilesAttributes;
import java.util.List;
 
import javax.validation.Valid;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
 
import com.fich.wafproject.model.Users;
import com.fich.wafproject.model.UsersHistory;
import com.fich.wafproject.service.ConfigurationFileAttributeService;
import com.fich.wafproject.service.ConfigurationFileService;
import com.fich.wafproject.service.UserService;
import com.fich.wafproject.service.UsersHistoryService;
import java.io.BufferedReader;
import java.io.BufferedWriter;
//import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Date;

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
        String message = "Succefully applied changes.", messageClass="success";
        try {
            String line = "";
            FileReader fr = new FileReader(ccf.getPathName());
            BufferedReader br = new BufferedReader(fr);
            java.io.File f = new java.io.File("/tmp/"+ccf.getName()); //ARGUMENT MUST BE A GOBAL VARIABLE
            java.io.File forig = new java.io.File("/tmp/original"); //ORIGINAL FILE BEFORE APPLY CHANGES
            FileWriter w = new FileWriter(f);
            FileWriter worig = new FileWriter(forig);
            BufferedWriter bw = new BufferedWriter(w);
            BufferedWriter bworig = new BufferedWriter(worig);
            PrintWriter wr = new PrintWriter(bw);
            PrintWriter wrorig = new PrintWriter(bworig);
            String msgToHistoryLog = ccf.getName()+" setup";
            while ((line = br.readLine()) != null) {
                System.out.println(line);
                wrorig.append(line + "\n");
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
            wr.close();wrorig.close();
            bw.close();bworig.close();
            br.close();
            this.persistEvent(msgToHistoryLog);
            
            if (!this.applyFileConfiguration("/tmp/"+ccf.getName(), ccf.getPathName(), "/tmp/original")){
                message = "There was errors applying the changes.";
                messageClass = "danger";
            }
        } catch (IOException e) {
//            System.out.println(e);
        }
        
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationTemplateModal");
        /*<Build data modal - end>*/
        model.addAttribute("message", message);
        model.addAttribute("messageClass", messageClass);
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
    
    //private boolean apply(ConfigurationFiles ccf,boolean original) throws IOException, InterruptedException{
    private boolean applyFileConfiguration(String fromFile, String toFile, String orgFile) throws IOException, InterruptedException{
        String cmd = "pkexec sudo mv "+fromFile+" "+toFile;
        this.runCommand(cmd);
        String cmdApacheReload = "pkexec sudo /etc/init.d/apache2 reload";
        String output = this.runCommand(cmdApacheReload);
        boolean ret = true;
        if(output.indexOf("apache2.service failed!")>=0){
            cmd = "pkexec sudo mv "+orgFile+" "+toFile;
            this.runCommand(cmd);
            cmd = "rm "+fromFile;
            this.runCommand(cmd);
            cmdApacheReload = " pkexec sudo /etc/init.d/apache2 reload";
            runCommand(cmdApacheReload);
            ret = false;
        }else{
            cmd = "rm "+orgFile;
            this.runCommand(cmd);
        }
        return ret;
    }
    
    private String runCommand(String cmd) throws IOException, InterruptedException{
        String outputCommand = "";
        Runtime run = Runtime.getRuntime();
        Process pr = run.exec(cmd);
        pr.waitFor();
        BufferedReader buf = new BufferedReader(new InputStreamReader(pr.getInputStream()));
//        String line = "";
        String s = null;
        System.out.println("ESCRIBIENDO");

        while ((s = buf.readLine()) != null) {
            outputCommand += " "+s;
            System.out.println(s);
        }
        
        return outputCommand;
    }
}