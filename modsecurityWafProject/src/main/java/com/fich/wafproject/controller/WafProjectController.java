
package com.fich.wafproject.controller;

import com.fich.wafproject.model.ConfigurationFileAttributeGroups;
import com.fich.wafproject.model.ConfigurationFileAttributeOptions;
import com.fich.wafproject.model.ConfigurationFileAttributeStates;
import com.fich.wafproject.model.ConfigurationFileAttributeType;
import com.fich.wafproject.model.ConfigurationFileStates;
import com.fich.wafproject.model.ConfigurationFiles;
import com.fich.wafproject.model.ConfigurationFilesAttributes;
import com.fich.wafproject.model.Rule;
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
import com.fich.wafproject.model.UsersHistory;
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
import com.fich.wafproject.service.RuleService;
import com.fich.wafproject.service.UsersHistoryService;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;
import org.springframework.web.bind.annotation.PathVariable;
 
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
    
    @Autowired
    UsersHistoryService userHistory;
    
    @Autowired
    UsersHistoryService userHistoryService;
    
    @Autowired
    RuleService ruleService;
    
    private boolean flagDebug = true;
    
    /******************************User Module*********************************/
    
    @RequestMapping(value = "/users/list", method = RequestMethod.GET)
    public String userListPage(ModelMap model, String message, HttpServletRequest request) {
        /*Página actual*/
        int pageNumber = 1;
        if(request.getParameterMap().containsKey("pageNumber")){
           pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }
        if(pageNumber<1){
            pageNumber=1;
        }
        /*fin*/
        
        /*Para mantener los valores ingresados del filtro cuando se recarga la páigna*/
        String[] n1 = request.getParameterValues("filter-parameters-values");
        String[] n2 = request.getParameterValues("filter-parameters-labels");
        HashMap hm = new HashMap<String,String>();        
        if(n1 != null){
            int count = 0;
            for(String val: n1){
                hm.put(n2[count], val);
                count++;
            }
        }
        /*fin*/
        List<Users> usersAux = userService.findAll(pageNumber, request.getParameterValues("filter-parameters-targets"), request.getParameterValues("filter-parameters-names"),request.getParameterValues("filter-parameters-values"),true);
        /*Me fijo si el resultado es vacío es porque estoy en la última página*/
        if(usersAux.size() == 0 && pageNumber>1){
            pageNumber = pageNumber-1;
            usersAux = userService.findAll(pageNumber, request.getParameterValues("filter-parameters-targets"), request.getParameterValues("filter-parameters-names"),request.getParameterValues("filter-parameters-values"),true);
        }
        /*fin*/
        
        if (flagDebug){
            System.out.println("Listing users...");
            System.out.println(usersAux.size());            
//            for(Users u : usersAux){
//                System.out.println(u.toString());
//            }
        }
        
        List<ConfigurationFiles> cf = configurationFileService.findAll();
        List<Users> users = userService.findAll();
        /*<Build data modal>*/
        model.addAttribute("idModal", "userModal");
        /*<Build data modal - end>*/
        model.addAttribute("users", usersAux);
        model.addAttribute("configFiles", cf);
        model.addAttribute("hm",hm);
        model.addAttribute("user", getPrincipal());
        model.addAttribute("message", message);
        model.addAttribute("pageNumber",pageNumber);
        return "listUsers";
    }
    
    @RequestMapping(value = "/historyUsers", method = RequestMethod.GET)
    public String userHistoryPage(ModelMap model, HttpServletRequest request) {
        int pageNumber = 1;
        if(request.getParameterMap().containsKey("pageNumber")){
           pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }
        if(pageNumber<1){
            pageNumber=1;
        }
        String[] values = request.getParameterValues("filter-parameters-values");
        List<UsersHistory> uh = userHistory.filer(values,request.getParameterValues("filter-parameters-names"), request.getParameterValues("filter-parameters-targets"), pageNumber);
        if(uh.size() == 0){
            pageNumber = pageNumber-1;
            uh = userHistory.filer(values,request.getParameterValues("filter-parameters-names"), request.getParameterValues("filter-parameters-targets"), pageNumber);
        }
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();
        
        String[] labels = request.getParameterValues("filter-parameters-labels");
        HashMap hm = new HashMap<String,String>();
        if(values != null){
            int count = 0;
            for(String val: values){
                hm.put(labels[count], val);
                count++;
            }
        }
        
        model.addAttribute("hm",hm);
        model.addAttribute("pageNumber",pageNumber);
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("usersActions", uh);
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
    @RequestMapping(value = "/users/addUser", method = RequestMethod.GET)
    public String getAddUserForm(ModelMap model, @RequestParam("id") Long id) {
        Users user = new Users();
        List<UserStates> userStates = userStatesService.findAll();
        String actionMessage = "";
        if (id != -1){
            user = userService.findById(id);
            model.addAttribute("messageType", "User "+user.getUserName()+" wass succefully updated.");
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
    @RequestMapping(value = "/users/deleteUser", method = RequestMethod.POST)
    public String deleteUser(ModelMap model, @RequestParam("id") Long id,HttpServletRequest request) {
        String name = userService.findById(id).getUserName();
        String message = "User "+name+" was succefully eliminated.";
        try{
            model.addAttribute("messageClass","success");
            userService.delete(id);
        }catch(Exception e){
            model.addAttribute("messageClass","danger");
            return this.userListPage(model,"There was an error deleting user "+name+".",request);
        }
        return this.userListPage(model,message,request);
    }
    
    /**
     * Save new user or update one
     */
    @RequestMapping(value = "users/saveNewUser", method = RequestMethod.POST)
    public String saveNewUser(@Valid Users user,
            BindingResult result, ModelMap model, HttpServletRequest request) {
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
        }else{
            try{
                userService.save(user);
                model.addAttribute("messageClass","success");
            }catch(Exception e){
                System.out.println(e.getMessage());
                model.addAttribute("messageClass","danger");
                return this.userListPage(model,"There was an error saving the user.", request);
            }
        }
        return this.userListPage(model,"User was saved successfully.", request);
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
            BindingResult result, ModelMap model, @RequestParam("redirectTo") String redirect) {
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
            try{
                configurationFileService.save(cf);
                model.addAttribute("messageClass","success");
                model.addAttribute("message","File configuration "+cf.getName()+" was succefully saved.");
            }catch(Exception e){
                model.addAttribute("message","There was an error saving file configuration "+cf.getName()+".");
                model.addAttribute("messageClass","danger");
            }
            
        }
        if (redirect.equals("configFileTemplate")){
            return this.configurationPageTemplate(model,cf.getName());
        }else{
            return this.configurationFilesList(model);
        }
    }
    
    /**
     * Delete a configuration file
     */
    @RequestMapping(value = "/deleteFileconfiguration")//, method = RequestMethod.POST)
    public String deleteFileconfiguration(ModelMap model, @RequestParam("id") Long id) {
        String message = "File Configuration "+configurationFileService.findById(id).getName()+" was succefully deleted.";
        try{
            model.addAttribute("messageClass","success");
            configurationFileService.delete(id);
        }catch(Exception e){
            model.addAttribute("messageClass","error");
            message = "There was an error deleting "+configurationFileService.findById(id).getName()+" configuration file.";
        }
        model.addAttribute("message",message);
        return this.configurationFilesList(model);
    }
    
    /**
     * Configuration Files Page
    **/
    @RequestMapping(value = { "/configurationFiles" }, method = RequestMethod.GET)
    public String configurationFilesList(ModelMap model) {
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
        currentConfigFile = configurationFileService.findById(currentConfigFile.getId());
        /*<Build data modal>*/
        model.addAttribute("idModal", "fileConfigurationTemplateModal");
        /*<Build data modal - end>*/
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("user",getPrincipal());
        model.addAttribute("currentFile",currentConfigFile);
//        model.addAttribute("allFileAttributes",cfaEachGroup);
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
        ConfigurationFiles currentConfigFile = new ConfigurationFiles();
        if (cfId != -1){
            currentConfigFile = configurationFileService.findById(cfId);
            cfag.setConfigurationFiles(currentConfigFile);
        }
        model.addAttribute("currentConfigFile",cfId);
        model.addAttribute("action","manageFileConfigurationAttrGroup");
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
            try{
                configurationFileAttributeGroupsService.save(cfag);
                model.addAttribute("message","Attribute Group "+cfag.getName()+" was succefully saved.");
                model.addAttribute("messageClass","success");
            }catch(Exception e){
                model.addAttribute("message","There was an error saving the file configuration.");
                model.addAttribute("messageClass","danger");
            }
        }
        String currentConfigFile = configurationFileService.findById(cfag.getConfigurationFiles().getId()).getName();
        return this.configurationPageTemplate(model,currentConfigFile);
    }
    
    /**
     * Delete configuration file attribute group
     */
    @RequestMapping(value = "/deleteFileConfigurationAttrGroup", method = RequestMethod.POST)
    public String deleteFileConfigurationAttrGroup(ModelMap model, @RequestParam("cfag-id") Long id) {
        ConfigurationFileAttributeGroups cfag = configurationFileAttributeGroupsService.findById(id);
        ConfigurationFiles currentConfigFile = cfag.getConfigurationFiles();
        currentConfigFile.getConfigurationFileAttributeGroups().remove(cfag);
        
        try{
            configurationFileAttributeGroupsService.deleteByEntity(cfag);
            model.addAttribute("message","Attribute Group "+cfag.getName()+" was succefully deleted.");
            model.addAttribute("messageClass","success");
        }catch(Exception e){
            model.addAttribute("message","There was an error deleting the attribute Group "+cfag.getName()+".");
            model.addAttribute("messageClass","danger");
        }
        
        
        return this.configurationPageTemplate(model,currentConfigFile.getName());
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
            try{
                model.addAttribute("message","Configuration Attribute "+cfa.getName()+" was succefully saved.");
                model.addAttribute("messageClass","success");
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
            }catch(Exception e){
                model.addAttribute("message","There was an error saving configuration attribute "+cfa.getName()+".");
                model.addAttribute("messageClass","danger");
            }
        }
        return this.configurationPageTemplate(model,configurationFileService.findById(cfId).getName());
    }
    
    /**
     * Delete a configuration file attribute
     */
    @RequestMapping(value = "/deleteFileconfigurationAttr")//, method = RequestMethod.POST)
    public String deleteFileconfigurationAttr(ModelMap model, @RequestParam("id") Long id) {
        ConfigurationFilesAttributes cfaToDelete = configurationFileAttributeService.findById(id);
        ConfigurationFileAttributeGroups cfag = cfaToDelete.getConfigurationFileAttributeGroups();
        cfag.getConfigurationFilesAttributes().remove(cfaToDelete);
        try{
            model.addAttribute("message","Configuration attribute "+cfaToDelete.getName()+" was succefully deleted.");
            model.addAttribute("messageClass","success");
            configurationFileAttributeService.deleteByEntity(cfaToDelete);
        }catch(Exception e){
            model.addAttribute("message","There was an error deleting configuration attribute "+cfaToDelete.getName()+".");
            model.addAttribute("messageClass","danger");
        }
        return this.configurationPageTemplate(model,cfag.getConfigurationFiles().getName());
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
                ls.add(line);
                count = count+1;
            }
            if(count>0){
                ls.add(0,"success");
            }else{
                ls.add(0,"empty");
            }
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
        
        List<String> ls = new ArrayList<String>();
        List<Boolean> lsState = new ArrayList<Boolean>();
        List<Boolean> lsStateIds = new ArrayList<Boolean>();
        List<String> ruleFiles = new ArrayList<String>();
        String value = configurationFileAttributeService.findByName("SecRuleRemoveById").getValue();//VIEW THIS -> HARDCODE
        String[] values = value.split(",");
        List<Rule> rules = ruleService.findAllRules();
        try{
            String path = "/usr/share/modsecurity-crs/rules/";
            Process p = Runtime.getRuntime().exec("ls "+path);
            BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line = null, fileToLine = "";
            Integer count = 0;
            
            while ((line = in.readLine()) != null) {
                if(line.contains("REQUEST") || line.contains("RESPONSE")){
//                    ls.add(line);
                    boolean flag = false, flagIds = false;
                    for(String val: values){
                        if(val.length()>=4 && line.contains(val.substring(0, 3)) && val.contains("-")){
                            flag = true;
                            ruleFiles.add(val);
                            break;
                        }
                    }
                    lsState.add(flag);
                    ls.add(line);
                    fileToLine += line;
                }
                count = count+1;
            }
            
            for(Rule rule : rules){
                boolean flag = false;
                for(String val: values){
                    if( val.equals(rule.getRuleId())){
                        flag = true;
                        break;
                    }
                }
                lsStateIds.add(flag);
            }
        }catch(IOException e){
            ls.add("error");
            e.printStackTrace();
        }
        
        ConfigurationFilesAttributes cf = configurationFileAttributeService.findByName("SecRuleRemoveById");
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();
        /*<Build data modal>*/
        model.addAttribute("idModal", "rulesFileConfigurationModal");
        /*<Build data modal - end>*/
        model.addAttribute("fileAttribute",cf);
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("user", getPrincipal());
        model.addAttribute("list", ls);
        model.addAttribute("states", lsState);
        model.addAttribute("values", ruleFiles);
        model.addAttribute("statesIds", lsStateIds);
        model.addAttribute("rules", rules);
        
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
    
    @RequestMapping(value = "/blockRules", method = RequestMethod.POST)
    public String blockRules(@Valid ConfigurationFilesAttributes cfa,
            BindingResult result, ModelMap model) throws IOException, InterruptedException {
        String value = cfa.getValue();
        cfa = configurationFileAttributeService.findById(cfa.getId());
        String currentValue = cfa.getValue();
        cfa.setValue(value);
        configurationFileAttributeService.save(cfa);
        try {
            String line = "";
            FileReader fr = new FileReader(cfa.getConfigurationFileAttributeGroups().getConfigurationFiles().getPathName());
            BufferedReader br = new BufferedReader(fr);
            java.io.File f = new java.io.File("/tmp/"+cfa.getConfigurationFileAttributeGroups().getConfigurationFiles().getName()); //ARGUMENT MUST BE A GOBAL VARIABLE
            FileWriter w = new FileWriter(f);
            BufferedWriter bw = new BufferedWriter(w);
            PrintWriter wr = new PrintWriter(bw);
            String msgToHistoryLog = "Rule Block";
            while ((line = br.readLine()) != null) {
                if (!line.isEmpty()) {
                    if (line.contains(cfa.getName())){
                        line = line.replaceAll("#", "");
                        if(cfa.getConfigurationFileAttributeStates().getName().equalsIgnoreCase("LOCKED")){
                            msgToHistoryLog = msgToHistoryLog+" - Disable "+cfa.getName();
                            line = "# "+line;
                        }else{
                            msgToHistoryLog = msgToHistoryLog+" - Current Values : "+ currentValue +" - New Values: "+cfa.getValue();
                            line = cfa.getName()+" "+cfa.getValue();
                        }
                    }
                }
                wr.append(line + "\n");
            }
            this.persistEvent(msgToHistoryLog);
            wr.close();
            bw.close();
            br.close();
            
            String cmd = " pkexec sudo mv /tmp/"+cfa.getConfigurationFileAttributeGroups().getConfigurationFiles().getName()+" "+cfa.getConfigurationFileAttributeGroups().getConfigurationFiles().getPathName();
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
            System.out.println(e);
            this.persistEvent("There was an error trying to blocking rules - "+e);
        }
        return this.rulesConfigurationPage(model);
    }
    
    private void persistEvent(String msg){
        String currentUsr = this.getPrincipal();
        
        Users user = userService.findByUserName(this.getPrincipal());
        UsersHistory uh = new UsersHistory();
        uh.setDescription(msg);
        uh.setUser(user);
        uh.setDateEvent(new Date());
        userHistoryService.save(uh);
    }
    
}
