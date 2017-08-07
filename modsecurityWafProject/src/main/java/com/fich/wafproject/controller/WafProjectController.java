
package com.fich.wafproject.controller;

import com.fich.wafproject.model.ConfigurationFileAttributeGroups;
import com.fich.wafproject.model.ConfigurationFileAttributeOptions;
import com.fich.wafproject.model.ConfigurationFileAttributeStates;
import com.fich.wafproject.model.ConfigurationFileAttributeType;
import com.fich.wafproject.model.ConfigurationFileStates;
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
import com.fich.wafproject.model.UserStates;
import com.fich.wafproject.service.ConfigurationFileAttributeGroupsService;
import com.fich.wafproject.service.ConfigurationFileService;
import com.fich.wafproject.service.ConfigurationFileStatesService;
import com.fich.wafproject.service.UserProfileService;
import com.fich.wafproject.service.UserService;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestParam;
import com.fich.wafproject.service.ConfigurationFileAttributesStatesService;
import com.fich.wafproject.service.UserStatesService;
import com.fich.wafproject.service.ConfigurationFileAttributeTypeService;
import java.util.ArrayList;
import org.hibernate.SessionFactory;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.fich.wafproject.service.ConfigurationFileAttributeService;
import com.fich.wafproject.service.ConfigurationFileAttributeOptionsService;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import org.springframework.web.bind.annotation.ResponseBody;
 
@Controller
@RequestMapping("/")
@SessionAttributes("roles")
public class WafProjectController {
    
    @Autowired
    UserProfileService userProfileService;
    
    @Autowired
    UserService userService;
    
    @Autowired        
    UserStatesService userStatesService;
    
    @Autowired
    ConfigurationFileService configurationFileService;
    
    @Autowired
    ConfigurationFileStatesService configurationFileStatesService;
    
    @Autowired
    ConfigurationFileAttributeGroupsService configurationFileAttributeGroupsService;
    
    @Autowired
    ConfigurationFileAttributesStatesService configurationFileAttributesStatesService;
    
    @Autowired
    ConfigurationFileAttributeTypeService configurationFileAttributeTypeService;
    
    @Autowired
    ConfigurationFileAttributeService configurationFileAttributeService;
    
    @Autowired
    ConfigurationFileAttributeOptionsService configurationFileAttributeOptionsService;
    
    
    private boolean flagDebug = true;

    @Autowired
    private SessionFactory sessionFactory;
    
    /******************************User Module*********************************/
    
    @RequestMapping(value = "/listUsers", method = RequestMethod.GET)
    public String userListPage(ModelMap model) {
        List<Users> users = userService.findAll();
        if (flagDebug){
            System.out.println("Listing users...");
        }
        /*<Build data modal>*/
        model.addAttribute("idModal", "userModal");
        /*<Build data modal - end>*/
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
    public String getAddUserForm(ModelMap model, @RequestParam("id") Long id) {
        Users user = new Users();
        List<UserStates> userStates = userStatesService.findAll();
        String actionMessage = "";
        if (id != -1){
            user = userService.findById(id);
            actionMessage = "--- Editing User Form: "+user.getUserName();
        }else{
            actionMessage = "--- Creating User Form";
        }
        if(flagDebug) System.out.println(actionMessage);
        
        model.addAttribute("user", user);
        model.addAttribute("userStates", userStates);
        model.addAttribute("action","saveNewUser");
        return "addUserForm";
    }
    
    /**
     * Delete a user
     */
    @RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
    public String deleteUser(ModelMap model, @RequestParam("id") Long id) {
        
        userService.delete(id);
        
        List<Users> users = userService.findAll();
        /*<Build data modal>*/
        model.addAttribute("idModal", "userModal");
        /*<Build data modal - end>*/
        model.addAttribute("users", users);
        model.addAttribute("user", getPrincipal());
        return "listUsers";
    }
    
    /**
     * Save new user or update one
     */
    @RequestMapping(value = "/saveNewUser", method = RequestMethod.POST)
    public String saveNewUser(@Valid Users user,
            BindingResult result, ModelMap model) {
        String messageSatus = "User "+user.getFirstName()+", "+user.getLastName()+" was succefully added to the system.";
        if (result.hasErrors()) {
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
        List<Users> users = userService.findAll();
        /*<Build data modal>*/
        model.addAttribute("idModal", "userModal");
        /*<Build data modal - end>*/
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
    public String getAddFileConfigurationForm(ModelMap model, @RequestParam("id") Long id) {
        ConfigurationFiles cf = new ConfigurationFiles();
        cf.setConfigurationFileStates(new ConfigurationFileStates());
        List<ConfigurationFileStates> cfs = configurationFileStatesService.findAll();
        if (id != -1){
            cf = configurationFileService.findById(id);
        }
        model.addAttribute("configFiles", cf);
        model.addAttribute("configFilesStates", cfs);
        model.addAttribute("action","saveNewFileConfiguration");
        return "addConfigurationFileForm";
    }
    
    /**
     * Save new configuration file or update one
     */
    @RequestMapping(value = "/saveNewFileConfiguration", method = RequestMethod.POST)
    public String saveNewFileConfiguration(@Valid ConfigurationFiles cf,
            BindingResult result, ModelMap model) {
        if (result.hasErrors()) {
            for (Object object : result.getAllErrors()) {
                if(object instanceof FieldError) {
                    FieldError fieldError = (FieldError) object;
                    System.out.println(object.toString());
                }
                if(object instanceof ObjectError) {
                    ObjectError objectError = (ObjectError) object;
                }
            }
        }else{
            configurationFileService.save(cf);
        }
        List<ConfigurationFiles> cfs = configurationFileService.findAll();
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationModal");
        /*<Build data modal - end>*/
        model.addAttribute("configFiles", cfs);
        model.addAttribute("user", getPrincipal());
        return "configurationFilesPage";
    }
    
    /**
     * Delete a configuration file
     */
    @RequestMapping(value = "/deleteFileconfiguration")//, method = RequestMethod.POST)
    public String deleteFileconfiguration(ModelMap model, @RequestParam("id") Long id) {
        configurationFileService.delete(id);        
        List<ConfigurationFiles> cfs = configurationFileService.findAll();
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationModal");
        /*<Build data modal - end>*/
        model.addAttribute("configFiles", cfs);
        model.addAttribute("user", getPrincipal());
        return "configurationFilesPage";
    }
    /**
     * Configuration Files Page
    **/
    @RequestMapping(value = { "/configurationFiles" }, method = RequestMethod.GET)
    public String modSecFileConfig(ModelMap model) {
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();
        
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationModal");
        /*<Build data modal - end>*/
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("user",getPrincipal());
        return "configurationFilesPage";
    }
    
    /**
     * Configuration Files Template
    **/
    @RequestMapping(value = { "/confFileTemp" }, method = RequestMethod.GET)
    public String configurationPageTemplate(ModelMap model, @RequestParam("currentFile") String currentFile) {
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();
        ConfigurationFiles currentConfigFile = configurationFileService.findByName(currentFile);
        
        List<ConfigurationFileAttributeGroups> cfags = currentConfigFile.getConfigurationFileAttributeGroups();
        List<List<ConfigurationFilesAttributes>> cfaEachGroup = new ArrayList<List<ConfigurationFilesAttributes>>();
        for(ConfigurationFileAttributeGroups cfag : cfags){
            cfaEachGroup.add(configurationFileAttributeService.findByFileConfiguration(cfag.getId()));
        }
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationTemplateModal");
        /*<Build data modal - end>*/
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("user",getPrincipal());
        model.addAttribute("currentFile",currentConfigFile);
        model.addAttribute("allFileAttributes",cfaEachGroup);
        return "configurationFilesTemplate";
    }
    
    /**
     * Configuration Files Attribute Group Form
    **/
    @RequestMapping(value = { "/addFileConfigurationAttrGroupForm" }, method = RequestMethod.GET)
    public String addFileConfigurationAttrGroupForm(ModelMap model, @RequestParam("cfag-id") Long cfagId, @RequestParam("cfa-id") Long cfId) {
        ConfigurationFileAttributeGroups cfag = new ConfigurationFileAttributeGroups();
        if (cfagId != -1){
            cfag = configurationFileAttributeGroupsService.findById(cfagId);
        }
        boolean flagRender = true;
        ConfigurationFiles currentConfigFile = new ConfigurationFiles();
        if (cfId != -1){
            currentConfigFile = configurationFileService.findById(cfId);
            cfag.setConfigurationFiles(currentConfigFile);
        }else{
            flagRender = false;
        }
        model.addAttribute("currentConfigFile",cfId);
        model.addAttribute("action","manageFileConfigurationAttrGroup");
        model.addAttribute("isDrawable",flagRender);
        model.addAttribute("configFileAttrGroup",cfag);
        return "addFileConfigurationAttrGroupForm";
    }
    
    /**
     * Save new configuration file attribute group or update one
     */
    @RequestMapping(value = "/manageFileConfigurationAttrGroup", method = RequestMethod.POST)
    public String manageConfigurationAttrGroup(@Valid ConfigurationFileAttributeGroups cfag,
            BindingResult result, ModelMap model, @RequestParam("action") String action, @RequestParam("cfag-id") Long id, @RequestParam("cf-id") Long cfid) {
        if (result.hasErrors()) {
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
            switch (action) {
                case "edit":
                case "add":
                    configurationFileAttributeGroupsService.save(cfag);
                break;
                default:
            }
        }
        ConfigurationFiles currentConfigFile = configurationFileService.findById(cfag.getConfigurationFiles().getId());
        List<ConfigurationFileAttributeGroups> cfags = currentConfigFile.getConfigurationFileAttributeGroups();
        List<List<ConfigurationFilesAttributes>> cfaEachGroup = new ArrayList<List<ConfigurationFilesAttributes>>();
        
        for(ConfigurationFileAttributeGroups cfagg : cfags){
            cfaEachGroup.add(configurationFileAttributeService.findByFileConfiguration(cfagg.getId()));
        }
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationTemplateModal");
        /*<Build data modal - end>*/
        model.addAttribute("allFileAttributes",cfaEachGroup);
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("user",getPrincipal());
        model.addAttribute("currentFile",currentConfigFile);
        return "configurationFilesTemplate";
    }
    
    /**
     * Delete configuration file attribute group
     */
    @RequestMapping(value = "/deleteFileConfigurationAttrGroup", method = RequestMethod.POST)
    public String deleteFileConfigurationAttrGroup(ModelMap model, @RequestParam("cfag-id") Long id) {
        Long ccf = configurationFileAttributeGroupsService.findById(id).getConfigurationFiles().getId();
        configurationFileAttributeGroupsService.delete(id);
        ConfigurationFiles currentConfigFile = configurationFileService.findById(ccf);
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();        
        List<ConfigurationFileAttributeGroups> cfags = currentConfigFile.getConfigurationFileAttributeGroups();
        List<List<ConfigurationFilesAttributes>> cfaEachGroup = new ArrayList<List<ConfigurationFilesAttributes>>();
        for(ConfigurationFileAttributeGroups cfag : cfags){
            cfaEachGroup.add(configurationFileAttributeService.findByFileConfiguration(cfag.getId()));
        }
        
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationTemplateModal");
        /*<Build data modal - end>*/
        
        model.addAttribute("allFileAttributes",cfaEachGroup);
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("user",getPrincipal());
        model.addAttribute("currentFile",currentConfigFile);
        return "configurationFilesTemplate";
    }
    
    /**
     * Configuration Files Attribute Form
    **/
    @RequestMapping(value = { "/addFileConfigurationAttrForm" }, method = RequestMethod.GET)
    public String addFileConfigurationAttrForm(ModelMap model, @RequestParam("cfag-id") Long cfagId, @RequestParam("cfa-id") Long cfaId) {
        ConfigurationFilesAttributes cfa = new ConfigurationFilesAttributes();
        ConfigurationFileAttributeGroups currentCfag = configurationFileAttributeGroupsService.findById(cfagId);
        List<ConfigurationFileAttributeStates> cfaStates = configurationFileAttributesStatesService.findAll();
        List<ConfigurationFileAttributeType> cfaTypes = configurationFileAttributeTypeService.findAll();
        if (cfaId != -1){
            cfa = configurationFileAttributeService.findById(cfaId);
        }
        List<ConfigurationFileAttributeOptions> opts = configurationFileAttributeOptionsService.findByCfAttr(cfaId);
        model.addAttribute("configFileAttr",cfa);
        model.addAttribute("currentConfigFileAttrGroupId",cfagId);
        model.addAttribute("currentConfigFile",currentCfag.getConfigurationFiles().getId());
        model.addAttribute("cfaStates",cfaStates);
        model.addAttribute("cfaTypes",cfaTypes);
        model.addAttribute("options",opts);
        model.addAttribute("action","saveNewFileConfigurationAttr");
        return "addFileConfigurationAttrForm";
    }
    
    /**
     * Save new configuration file attribute or update one
     */
    @RequestMapping(value = "/saveNewFileConfigurationAttr", method = RequestMethod.POST)
    public String saveNewFileConfigurationAttr(@Valid ConfigurationFilesAttributes cfa,
            BindingResult result, ModelMap model, @RequestParam("currentConfigFile") Long cfId){
//        System.out.println(cfa.getConfigurationFileAttributeGroups());
//        System.out.println(cfa.getConfigurationFileAttributeStates());
//        System.out.println(cfa.getConfigurationFileAttributeType());
//        System.out.println(cfa.getDescription());
//        System.out.println(cfa.getName());
//        System.out.println(cfa.getValue());
        if (result.hasErrors()) {
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
            List<ConfigurationFileAttributeOptions> opts = cfa.getConfigurationFileAttributeOptions();
            cfa.setConfigurationFileAttributeOptions(new ArrayList<ConfigurationFileAttributeOptions>());
            configurationFileAttributeService.save(cfa);
            if(cfa.getId() != null){
                //Editing attribute
                configurationFileAttributeOptionsService.deletOptsByFile(cfa.getId());
                if (opts != null && opts.size() > 0) {
                    for(ConfigurationFileAttributeOptions opt : opts){
                        opt.setConfigurationFilesAttributes(cfa);
                        configurationFileAttributeOptionsService.save(opt);
                    }
                }
            }
        }
        
        ConfigurationFiles currentConfigFile = configurationFileService.findById(cfId);
        List<ConfigurationFileAttributeGroups> cfags = currentConfigFile.getConfigurationFileAttributeGroups();
        List<List<ConfigurationFilesAttributes>> cfaEachGroup = new ArrayList<List<ConfigurationFilesAttributes>>();
        for(ConfigurationFileAttributeGroups cfag : cfags){
            cfaEachGroup.add(configurationFileAttributeService.findByFileConfiguration(cfag.getId()));
        }
        
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationTemplateModal");
        /*<Build data modal - end>*/
        model.addAttribute("allFileAttributes",cfaEachGroup);
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("user",getPrincipal());
        model.addAttribute("currentFile",currentConfigFile);
        return "configurationFilesTemplate";
    }
    
    /**
     * Delete a configuration file attribute
     */
    @RequestMapping(value = "/deleteFileconfigurationAttr")//, method = RequestMethod.POST)
    public String deleteFileconfigurationAttr(ModelMap model, @RequestParam("id") Long id) {
        ConfigurationFiles currentConfigFile = configurationFileAttributeService.findById(id).getConfigurationFileAttributeGroups().getConfigurationFiles();
        configurationFileAttributeService.delete(id);
        List<ConfigurationFiles> cfs = configurationFileService.findAll();
        List<ConfigurationFileAttributeGroups> cfags = currentConfigFile.getConfigurationFileAttributeGroups();
        List<List<ConfigurationFilesAttributes>> cfaEachGroup = new ArrayList<List<ConfigurationFilesAttributes>>();
        for(ConfigurationFileAttributeGroups cfag : cfags){
            cfaEachGroup.add(configurationFileAttributeService.findByFileConfiguration(cfag.getId()));
        }
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationTemplateModal");
        /*<Build data modal - end>*/
        model.addAttribute("configFiles",cfs);
        model.addAttribute("user",getPrincipal());
        model.addAttribute("currentFile",currentConfigFile);
        model.addAttribute("allFileAttributes",cfaEachGroup);
        return "configurationFilesTemplate";
    }
    
    /**
     * Check file uploaded
     */
    @RequestMapping(value = "/checkFile", method = RequestMethod.POST)
    @ResponseBody public List<String> checkFile(@RequestParam("path") String path){
        //logic
        List<String> ls = new ArrayList<String>();
        try{
            Process p = Runtime.getRuntime().exec("ls "+path);
            BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line = null;
            Integer count = 0;
            while ((line = in.readLine()) != null) {
                System.out.println(line);
                ls.add(line);
                count = count+1;
            }
            if(count>0){
                ls.add(0,"success");
            }else{
                ls.add(0,"empty");
            }
            System.out.println(count);
        }catch(IOException e){
            ls.add("error");
            e.printStackTrace();
        }

        return ls;
    }
    
    /******************************Files Configuration Module - END*********************************/
    
    
    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String adminPage(ModelMap model) {
        model.addAttribute("user",getPrincipal());
        List<ConfigurationFiles> cfs = configurationFileService.findAll();
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
        Users user = new Users();
        model.addAttribute("user", user);
        return "newuser";
    }
 
    /*
     * This method will be called on form submission, handling POST request It
     * also validates the user input
     */
    @RequestMapping(value = "/newUser", method = RequestMethod.POST)
    public String saveRegistration(@Valid Users user,
            BindingResult result, ModelMap model) {
 
        if (result.hasErrors()) {
            return "newuser";
        }
        userService.save(user);
        
        if(flagDebug){
            System.out.println("First Name : "+user.getFirstName());
            System.out.println("Last Name : "+user.getLastName());
            System.out.println("SSO ID : "+user.getUserName());
            System.out.println("Password : "+user.getPassword());
            System.out.println("Email : "+user.getEmail());
            System.out.println("Checking UsrProfiles....");
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
    public List<UserProfiles> initializeProfiles() {
        return userProfileService.findAll();
    }
 
}
