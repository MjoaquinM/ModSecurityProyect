/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.controller;

/**
 *
 * @author r3ng0
 */
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
import com.fich.wafproject.service.UserProfileService;
import com.fich.wafproject.service.UserService;
 
@Controller
public class WafProjectController {
    
    @Autowired
    UserProfileService userProfileService;
    
    @Autowired
    UserService userService;
    
    /**
     * User Module
     **/
    @RequestMapping(value = "/listUsers", method = RequestMethod.GET)
    public String userListPage(ModelMap model) {        
        //model.addAttribute("users", userService.findAll());
        model.addAttribute("user", getPrincipal());
        return "listUsers";
    }
    
    @RequestMapping(value = "/historyUsers", method = RequestMethod.GET)
    public String userHistoryPage(ModelMap model) {        
        //model.addAttribute("users", userService.findAll());
        model.addAttribute("user", getPrincipal());
        return "historyUsers";
    }
    
    @RequestMapping(value = "/chronHistoryUsers", method = RequestMethod.GET)
    public String userChronHistoryPage(ModelMap model) {        
        //model.addAttribute("users", userService.findAll());
        model.addAttribute("user", getPrincipal());
        return "chronHistoryUsers";
    }
    /**
     * User Module - END
     **/
    
    /**
     * File Configurations Module
     **/
    @RequestMapping(value = "/modSecConf", method = RequestMethod.GET)
    public String modSecurityConfigurationPage(ModelMap model) {        
        //model.addAttribute("users", userService.findAll());
        model.addAttribute("user", getPrincipal());
        return "modSecConf";
    }
    
    @RequestMapping(value = "/modSecLogCollectorConf", method = RequestMethod.GET)
    public String modSecurityLogCollectorConfigurationPage(ModelMap model) {        
        //model.addAttribute("users", userService.findAll());
        model.addAttribute("user", getPrincipal());
        return "modSecLogCollectorConf";
    }
    
    @RequestMapping(value = "/coreRuleSetConf", method = RequestMethod.GET)
    public String coreRuleSetConfigurationPage(ModelMap model) {        
        //model.addAttribute("users", userService.findAll());
        model.addAttribute("user", getPrincipal());
        return "coreRuleSetConf";
    }
    
    @RequestMapping(value = "/rulesConf", method = RequestMethod.GET)
    public String rulesConfigurationPage(ModelMap model) {        
        //model.addAttribute("users", userService.findAll());
        model.addAttribute("user", getPrincipal());
        return "rulesConf";
    }
    
    /**
     * Control Panel Module - END
     **/
    
    /**
     * File Configurations Module
     **/
    @RequestMapping(value = "/charts", method = RequestMethod.GET)
    public String chartsPage(ModelMap model) {        
        //model.addAttribute("users", userService.findAll());
        model.addAttribute("user", getPrincipal());
        return "charts";
    }
    
    @RequestMapping(value = "/reports", method = RequestMethod.GET)
    public String reportsPage(ModelMap model) {        
        //model.addAttribute("users", userService.findAll());
        model.addAttribute("user", getPrincipal());
        return "reports";
    }
    
    @RequestMapping(value = "/events", method = RequestMethod.GET)
    public String eventPage(ModelMap model) {        
        //model.addAttribute("users", userService.findAll());
        model.addAttribute("user", getPrincipal());
        return "events";
    }
    
    /**
     * Control Panel Module - END
     **/
    
 
    @RequestMapping(value = "/db", method = RequestMethod.GET)
    public String dbaPage(ModelMap model) {
        model.addAttribute("user", getPrincipal());
        return "dba";
    }
 
    @RequestMapping(value = "/Access_Denied", method = RequestMethod.GET)
    public String accessDeniedPage(ModelMap model) {
        model.addAttribute("user", getPrincipal());
        return "accessDenied";
    }
 
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage() {
        System.out.println("ESTAS EN EL LOGIN");
        return "login";
    }
 
    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){    
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login?logout";
    }
    
    @RequestMapping(value = "/newUser", method = RequestMethod.GET)
    public String newRegistration(ModelMap model) {
        User user = new User();
        model.addAttribute("user", user);
        return "newuser";
    }
 
    /*
     * This method will be called on form submission, handling POST request It
     * also validates the user input
     */
    @RequestMapping(value = "/newUser", method = RequestMethod.POST)
    public String saveRegistration(@Valid User user,
            BindingResult result, ModelMap model) {
 
        if (result.hasErrors()) {
            System.out.println("There are errors");
            return "newuser";
        }
        userService.save(user);
         
        System.out.println("First Name : "+user.getFirstName());
        System.out.println("Last Name : "+user.getLastName());
        System.out.println("SSO ID : "+user.getSsoId());
        System.out.println("Password : "+user.getPassword());
        System.out.println("Email : "+user.getEmail());
        System.out.println("Checking UsrProfiles....");
        if(user.getUserProfiles()!=null){
            for(UserProfile profile : user.getUserProfiles()){
                System.out.println("Profile : "+ profile.getType());
            }
        }
         
        model.addAttribute("success", "User " + user.getFirstName() + " has been registered successfully");
        return "registrationsuccess";
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
 
    @ModelAttribute("roles")
    public List<UserProfile> initializeProfiles() {
        return userProfileService.findAll();
    }
 
}
