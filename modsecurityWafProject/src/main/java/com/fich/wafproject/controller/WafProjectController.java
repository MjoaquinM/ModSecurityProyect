
package com.fich.wafproject.controller;

import com.fich.wafproject.model.ConfigurationFile;
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
import com.fich.wafproject.service.ConfigurationFileService;
import com.fich.wafproject.service.UserProfileService;
import com.fich.wafproject.service.UserService;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestParam;
 
@Controller
public class WafProjectController {
    
    @Autowired
    UserProfileService userProfileService;
    
    @Autowired
    UserService userService;
    
    @Autowired
    ConfigurationFileService configurationFileService;
    
    
    /******************************User Module*********************************/
    
    @RequestMapping(value = "/listUsers", method = RequestMethod.GET)
    public String userListPage(ModelMap model) {
        List<User> users = userService.findAll();
        model.addAttribute("users", users);
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
        model.addAttribute("user", getPrincipal());
        return "chronHistoryUsers";
    }

    /**
     * Get add user form
     */
    @RequestMapping(value = "/addUserForm", method = RequestMethod.GET)
    public String getAddUserForm(ModelMap model, @RequestParam("id") int id) {
        
        User user = new User();
        boolean update = false;
        if (id != -1){
            user = userService.findById(id);
            update = true;
        }
        model.addAttribute("user", user);
        model.addAttribute("update", user);
        model.addAttribute("action","saveNewUser");
        return "addUserForm";
    }
    
    /**
     * Delete a user
     */
    @RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
    public String deleteUser(ModelMap model, @RequestParam("id") int id) {
        System.out.println("ESTE ES EL OBJETO A ELIMINAR");
        userService.delete(id);
        
        List<User> users = userService.findAll();
        model.addAttribute("users", users);
        model.addAttribute("user", getPrincipal());
        return "listUsers";
    }
    
    /**
     * Save new user or update one
     */
    @RequestMapping(value = "/saveNewUser", method = RequestMethod.POST)
    public String saveNewUser(@Valid User user,
            BindingResult result, ModelMap model) {
        String messageSatus = "User "+user.getFirstName()+", "+user.getLastName()+" was succefully added to the system.";
        
        if (result.hasErrors()) {
            System.out.println("There are errors");
            System.out.print(result.getAllErrors());
            for (Object object : result.getAllErrors()) {
                if(object instanceof FieldError) {
                    FieldError fieldError = (FieldError) object;
                    System.out.println(fieldError.getCode());
                }

                if(object instanceof ObjectError) {
                    ObjectError objectError = (ObjectError) object;
                    System.out.println(objectError.getCode());
                }
            }
            messageSatus = "There was an error.";
        }else{
            userService.save(user);
        }
        List<User> users = userService.findAll();
        model.addAttribute("users", users);
        model.addAttribute("user", getPrincipal());
        return "listUsers";
    }
    
    /******************************User Module - END*********************************/

    /******************************Files Configuration Module*********************************/
    /**
     * Return configuration file form
    **/
    @RequestMapping(value = "/addFileConfigurationForm", method = RequestMethod.GET)
    public String getAddFileConfigurationForm(ModelMap model, @RequestParam("id") int id) {
        ConfigurationFile cf = new ConfigurationFile();
        String title = "Add File Configuration";
        if (id != -1){
            cf = configurationFileService.findById(id);
            title = "Update File Configuration";
        }
        model.addAttribute("configFiles", cf);
        model.addAttribute("title", title);
        model.addAttribute("action","saveNewFileConfiguration");
        return "addConfigurationFileForm";
//>>>>>>> 94e63832bf36fb4d376518334dfe9a13cfcab81d
    }
    
    /**
     * Save new configuration file or update one
     */
    @RequestMapping(value = "/saveNewFileConfiguration", method = RequestMethod.POST)
    public String saveNewFileConfiguration(@Valid ConfigurationFile cf,
            BindingResult result, ModelMap model) {
        if (result.hasErrors()) {
            System.out.println("There are errors tipona");
            System.out.print(result.getAllErrors());
            for (Object object : result.getAllErrors()) {
                if(object instanceof FieldError) {
                    FieldError fieldError = (FieldError) object;
                    System.out.println(fieldError.getCode());
                }

                if(object instanceof ObjectError) {
                    ObjectError objectError = (ObjectError) object;
                    System.out.println(objectError.getCode());
                }
            }
            
            
        }else{
            configurationFileService.save(cf);
        }
        List<ConfigurationFile> cfs = configurationFileService.findAll();
        model.addAttribute("configFiles", cfs);
        model.addAttribute("user", getPrincipal());
        return "configurationFilesPage";
    }
    
    /**
     * Delete a configuration file
     */
    @RequestMapping(value = "/deleteFileconfiguration", method = RequestMethod.POST)
    public String deleteFileconfiguration(ModelMap model, @RequestParam("id") int id) {
        
        configurationFileService.delete(id);
        
        List<ConfigurationFile> cfs = configurationFileService.findAll();
        model.addAttribute("configFiles", cfs);
        model.addAttribute("user", getPrincipal());
        return "configurationFilesPage";
    }
    /**
     * Configuration Files Page
    **/
    @RequestMapping(value = { "/configurationFiles" }, method = RequestMethod.GET)
    public String modSecFileConfig(ModelMap model) {
        List<ConfigurationFile> configurationFilesAll = configurationFileService.findAll();
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("user",getPrincipal());
        return "configurationFilesPage";
    }
    
    /**
     * Configuration Files Template
    **/
    @RequestMapping(value = { "/confFileTemp" }, method = RequestMethod.GET)
    public String configurationPageTemplate(ModelMap model, @RequestParam("currentFile") String currentFile) {
        List<ConfigurationFile> configurationFilesAll = configurationFileService.findAll();
        ConfigurationFile currentConfigFile = configurationFileService.findByName(currentFile);
        System.out.println(currentConfigFile);
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("user",getPrincipal());
        model.addAttribute("currentFile",currentConfigFile);
        return "configurationFilesTemplate";
    }
    
    /******************************Files Configuration Module - END*********************************/
    
    
    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String adminPage(ModelMap model) {
        model.addAttribute("user",getPrincipal());
        List<ConfigurationFile> cfs = configurationFileService.findAll();
        String user = getPrincipal();
        model.addAttribute("configFiles",cfs);
        model.addAttribute("user",user);
        return "adminHome";
    }
    
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
