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
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
 
import com.fich.wafproject.model.Users;
import com.fich.wafproject.model.UserProfiles;
import com.fich.wafproject.service.ConfigurationFileAttributeService;
import com.fich.wafproject.service.ConfigurationFileService;
import com.fich.wafproject.service.UserService;
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
    
    //Configure Request Body Page
    @RequestMapping(value = { "/reqBodyConfig" }, method = RequestMethod.GET)
    public String modSecConfigReqBody(ModelMap model) {
        return "reqBodyConfig";
    }

    @RequestMapping(value = "/applyRequestBodyHandlingChanges", method = RequestMethod.POST)
    public String applyReqBodyChanges(@Valid ConfigurationFiles ccf,
            BindingResult result, ModelMap model) throws IOException, InterruptedException, Exception {
        configurationFileService.save(ccf);
        ccf=configurationFileService.findById(ccf.getId());
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();
        List<ConfigurationFilesAttributes> attrs = configurationFileAttributeService.findByFileConfiguration(ccf.getId());
        try {
            String line = "";
            FileReader fr = new FileReader(ccf.getPathName());
            BufferedReader br = new BufferedReader(fr);
            java.io.File f = new java.io.File("/tmp/modsecurity.conf"); //ARGUMENT MUST BE A GOBAL VARIABLE
            FileWriter w = new FileWriter(f);
            BufferedWriter bw = new BufferedWriter(w);
            PrintWriter wr = new PrintWriter(bw);
            while ((line = br.readLine()) != null) {
                System.out.println("LINEA: " + line);
                if (!line.isEmpty()) {
                    for(ConfigurationFilesAttributes cfa : attrs){
                        if(line.charAt(0)!='#' && !cfa.getConfigurationFileAttributeStates().getName().equalsIgnoreCase("LOCKED") && line.contains(cfa.getName())){
                            line = cfa.getName()+" "+cfa.getValue();
                            break;
                        }
                    }
                }
                wr.append(line + "\n");
            }
            wr.close();
            bw.close();
            br.close();
            
            String cmd = "pkexec sudo mv /tmp/modsecurity.conf /etc/modsecurity-2.9.2/modsecurity.conf";
//            String cmd = "pkexec sudo sh -c \"mv /tmp/modsecurity.conf /etc/modsecurity-2.9.2/modsecurity.conf && /etc/init.d/apache2 reload\"";
            System.out.println("COMANDO QUE VOY A EJECUTAAAAAAAARRRRRRRRRR: " + cmd);
            Runtime run = Runtime.getRuntime();
            Process pr = run.exec(cmd);
            pr.waitFor();
            BufferedReader buf = new BufferedReader(new InputStreamReader(pr.getInputStream()));
            line = "";
            System.out.println("ESTA ES LA SALIDAAAAAAAAAAAAAAAA:");
            while ((line = buf.readLine()) != null) {
                System.out.println(line);
            }
            cmd = " pkexec sudo /etc/init.d/apache2 reload";
            System.out.println("COMANDO QUE VOY A EJECUTAAAAAAAARRRRRRRRRR: " + cmd);
            run = Runtime.getRuntime();
            pr = run.exec(cmd);
            pr.waitFor();
//            pr.wait(10000);
            buf = new BufferedReader(new InputStreamReader(pr.getInputStream()));
            line = "";
            while ((line = buf.readLine()) != null) {
                System.out.println(line);
            }
            
        } catch (IOException e) {
//            System.out.println(e);
            throw new Exception(e);
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
}
