/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.controller;

import com.fich.wafproject.model.ConfigurationFile;
import com.fich.wafproject.model.ConfigurationFileAttribute;
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
 
import com.fich.wafproject.model.User;
import com.fich.wafproject.model.UserProfile;
import com.fich.wafproject.service.ConfigurationFileAttributeService;
import com.fich.wafproject.service.ConfigurationFileService;
import com.fich.wafproject.service.UserService;
import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
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
    
    /*@RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String adminPage(ModelMap model) {
        model.addAttribute("user",getPrincipal());
        return "adminHome";
    }*/
    
    /**Show File Configuration Attributes**/
    @RequestMapping(value = "/addFileConfigurationAttributes", method = RequestMethod.GET)
    public String showFileConfigurationParameters(ModelMap model, @RequestParam("fileId") int fileId) {
        ConfigurationFileAttribute cfa = configurationFileAttributeService.findByFileConfiguration(fileId);
        model.addAttribute("configFileAttr",cfa);
        return "showFileConfigurationAttributes";
    }
    /**Show File Configuration Attributes -- END **/
    
    /**Save File Configuration Attributes**/
    @RequestMapping(value = "/addFileConfigurationAttributes", method = RequestMethod.POST)
    public String saveConfigurationFileAttributes(@Valid ConfigurationFileAttribute cfa,
            BindingResult result, ModelMap model) {
        if (result.hasErrors()) {
            System.out.println("There are errors");
            return "modsecurityFileConfig";
        }
        configurationFileAttributeService.save(cfa);
        return "<h1>ANDUVO</h1>";
    }
    /**Save File Configuration Attributes -- END **/
    
    @RequestMapping(value = "/addConfigurationFile", method = RequestMethod.POST)
    public String saveConfigurationFile(@Valid ConfigurationFile cf,
            BindingResult result, ModelMap model) {
        if (result.hasErrors()) {
            System.out.println("There are errors");
            return "modsecurityFileConfig";
        }
        
        configurationFileService.save(cf);
        System.out.println("Name: "+cf.getName());
        System.out.println("Path: "+cf.getPath());
        System.out.println("Description: "+cf.getDescription());
        String state = cf.getState() ? "Active" : "Disable";
        System.out.println("State: "+ cf.getState());
//        List<ConfigurationFile> configurationFilesAll = configurationFileService.findAll();
//        model.addAttribute("configFiles", configurationFilesAll);
        return "modsecurityFileConfig";
    }
    
    @RequestMapping(value = "/addConfigurationFile", method = RequestMethod.GET)
    public String addConfigurationFile(ModelMap model) {
        ConfigurationFile fc = new ConfigurationFile();
        model.addAttribute("configurationFile",fc);
        return "addConfigurationFile";
    }
    
    //Modsecurity File Configuration
    @RequestMapping(value = { "/modsecurityFileConfig" }, method = RequestMethod.GET)
    public String modSecFileConfig(ModelMap model) {
        
        List<ConfigurationFile> configurationFilesAll = configurationFileService.findAll();
        System.out.println("LARGARON!!!!!!!!!!!!!!!!!!!!!!111");
        Iterator iter = configurationFilesAll.iterator();
        while (iter.hasNext()){
          System.out.println(iter.next());
        }
        model.addAttribute("configFiles",configurationFilesAll);
        return "modsecurityFileConfig";
    }
    
    //Configure Request Body Page
    @RequestMapping(value = { "/reqBodyConfig" }, method = RequestMethod.GET)
    public String modSecConfigReqBody(ModelMap model) {
        return "reqBodyConfig";
    }
    
    @RequestMapping(value = "/applyRequestBodyHandlingChanges", method = RequestMethod.POST)
    public String applyReqBodyChanges() throws IOException, InterruptedException {
        String cadena, arch = "";
        FileReader fr = new FileReader("/etc/modsecurity/modsecurity.conf");
        BufferedReader br = new BufferedReader(fr);
        File f;
        f = new File("/home/r3ng0/Desktop/modsecurity.conf");
        try {
            FileWriter w = new FileWriter(f);
            BufferedWriter bw = new BufferedWriter(w);
            PrintWriter wr = new PrintWriter(bw);

            while ((cadena = br.readLine()) != null) { 
                System.out.println(cadena);
                if (!cadena.isEmpty()) {
                    if (cadena.charAt(0) != '#') {
                        
                        if (cadena.contains("SecRuleEngine")) {
//                            cadena = "SecRuleEngine " + SecRuleEngine;
                        }
                    }
                }
//                wr.append(cadena + "\n");
//                arch = arch + cadena + "<br/>";
            }
            wr.close();
            bw.close();

        } catch (IOException e) {
            System.out.println(e);
        };
        br.close();
        
        String cmd = "pkexec sudo /etc/init.d/apache2 reload";
        //Runtime run = Runtime.getRuntime();
        //Process pr = run.exec(cmd);
        //pr.waitFor();
        //BufferedReader buf = new BufferedReader(new InputStreamReader(pr.getInputStream()));
        /*String line = "";
        while ((line = buf.readLine()) != null) {
            System.out.println(line);
        }*/

        return "/modsecurity/request-body-handling";
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
