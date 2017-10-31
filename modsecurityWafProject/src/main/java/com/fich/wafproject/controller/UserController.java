package com.fich.wafproject.controller;

import com.fich.wafproject.util.Functions;
import com.fich.wafproject.model.ConfigurationFiles;
import com.fich.wafproject.model.UserProfiles;
import com.fich.wafproject.model.UserStates;
import com.fich.wafproject.model.Users;
import com.fich.wafproject.model.UsersHistory;
import com.fich.wafproject.service.ConfigurationFileService;
import com.fich.wafproject.service.UserProfileService;
import com.fich.wafproject.service.UserService;
import com.fich.wafproject.service.UserStatesService;
import com.fich.wafproject.service.UsersHistoryService;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 *
 * @author joaquin
 */
@Controller
@RequestMapping("/")
@SessionAttributes("roles")
public class UserController {
    
    @Autowired
    UserService userService;
    
    @Autowired
    ConfigurationFileService configurationFileService;
    
    @Autowired
    UsersHistoryService userHistory;
    
    @Autowired        
    UserStatesService userStatesService;
    
    @Autowired
    UserProfileService userProfileService;
    
    private boolean flagDebug = true;
    
    private Functions customFunctions = new Functions();
    
    /**
     * 
     * @param model
     * @param message: Message Status on delete/modify/create user action
     * @param request
     * @return: User List View
     */
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
        String[] values = request.getParameterValues("filter-parameters-values");
        String[] n2 = request.getParameterValues("filter-parameters-labels");
        HashMap hm = new HashMap<String,String>();        
        if(values != null){
            int count = 0;
            for(String val: values){
                hm.put(n2[count], val);
                count++;
            }
        }
        /*fin*/
        List<Users> usersAux = userService.findAll(pageNumber, request.getParameterValues("filter-parameters-targets"), request.getParameterValues("filter-parameters-names"),values,true);
        /*Me fijo si el resultado es vacío es porque estoy en la última página*/
        if(usersAux.size() == 0 && pageNumber>1){
            pageNumber = pageNumber-1;
            usersAux = userService.findAll(pageNumber, request.getParameterValues("filter-parameters-targets"), request.getParameterValues("filter-parameters-names"),values,true);
        }
        /*fin*/
        
        if (flagDebug){
            System.out.println("Listing users...");
            System.out.println("Number of users: " + usersAux.size());
            for(Users u : usersAux){
//                System.out.println(u.toString());
            }
        }
        
        List<ConfigurationFiles> cf = configurationFileService.findAll();
        
        /*<Build data modal>*/
        model.addAttribute("idModal", "userModal");
        /*<Build data modal - end>*/
        model.addAttribute("users", usersAux);
        model.addAttribute("configFiles", cf);
        model.addAttribute("hm",hm);
        model.addAttribute("user", this.customFunctions.getPrincipal());
        model.addAttribute("message", message);
        model.addAttribute("pageNumber",pageNumber);
        return "listUsers";
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return Histroy Users View
     */
    @RequestMapping(value = "/users/history", method = RequestMethod.GET)
    public String userHistoryPage(ModelMap model, HttpServletRequest request) {
        /*Página actual*/
        int pageNumber = 1;
        if(request.getParameterMap().containsKey("pageNumber")){
           pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }
        if(pageNumber<1){
            pageNumber=1;
        }
        /*fin*/
        String[] values = request.getParameterValues("filter-parameters-values");
        
        /*Solo el admin puede ver el historial de todos los usuarios, los demás solo pueden ver solo los suyos*/
        Users currentUser = userService.findByUserName(customFunctions.getPrincipal());
        String role = "";
        if (!currentUser.isAdmin()) role = currentUser.getUserName();
        List<UsersHistory> uh = userHistory.filer(values,request.getParameterValues("filter-parameters-names"), request.getParameterValues("filter-parameters-targets"), pageNumber, role);

        /*Me fijo si el resultado es vacío es porque estoy en la última página*/
        if(uh.size() == 0 && pageNumber>1){
            pageNumber = pageNumber-1;
            uh = userHistory.filer(values,request.getParameterValues("filter-parameters-names"), request.getParameterValues("filter-parameters-targets"), pageNumber, role);
        }
        /*fin*/
        
        /*Para mantener los valores ingresados del filtro cuando se recarga la páigna*/
        String[] labels = request.getParameterValues("filter-parameters-labels");
        HashMap hm = new HashMap<String,String>();
        if(values != null){
            int count = 0;
            for(String val: values){
                hm.put(labels[count], val);
                count++;
            }
        }
        /*fin*/
        
        if (flagDebug){
//            System.out.println("Listing user histories...");
//            System.out.println("Number of histories: " + uh.size());
            for(UsersHistory u : uh){
//                System.out.println(u.toString());
            }
        }
        
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();
        
        model.addAttribute("hm",hm);
        model.addAttribute("pageNumber",pageNumber);
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("usersActions", uh);
        model.addAttribute("user", this.customFunctions.getPrincipal());
        model.addAttribute("isAdmin", role);
        return "historyUsers";
    }

    /**
     * 
     * @param model
     * @param id
     * @return New/edit user form - using on ajax request
     */
    @RequestMapping(value = "/users/addUser", method = RequestMethod.GET)
    public String getAddUserForm(ModelMap model, @RequestParam("id") Long id) {
        Users user = new Users();
        List<UserStates> userStates = userStatesService.findAll();
        String actionMessage = "";
        if (id != -1){
            user = userService.findById(id);
            actionMessage = "--- Editing User Form: "+user.getUserName();
            for(UserProfiles up : user.getProfiles()){
//                System.out.println(up.getType());
            }
        }else{
            actionMessage = "--- Creating User Form";
        }
//        if(flagDebug) System.out.println("Action Message on User Form: " + actionMessage);
        model.addAttribute("user", user);
        model.addAttribute("userStates", userStates);
        model.addAttribute("action","saveNewUser");
        return "addUserForm";
    }
    
    /**
     * 
     * @param model
     * @param id: user to delete
     * @param request
     * @return list user view with message action status
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
     * 
     * @param user: user model to edit (null on new user action)
     * @param result
     * @param model
     * @param request
     * @return list user view with message action status
     */
    @RequestMapping(value = "/users/saveNewUser", method = RequestMethod.POST)
    public String saveNewUser(@Valid Users user,
            BindingResult result, ModelMap model, HttpServletRequest request) {
        if (result.hasErrors() && flagDebug) {
//            System.out.println("There was errors saving user: ");
            for (Object object : result.getAllErrors()) {
                if(object instanceof FieldError) {
                    FieldError fieldError = (FieldError) object;
//                    System.out.println(fieldError.getCode());
                }
                if(object instanceof ObjectError) {
                    ObjectError objectError = (ObjectError) object;
//                    System.out.println(objectError.getCode());
                }
            }
        }else{
            try{
                userService.save(user);
                model.addAttribute("messageClass","success");
            }catch(Exception e){
//                if(flagDebug) System.out.println(e.getMessage());
                model.addAttribute("messageClass","danger");
                return this.userListPage(model,"There was an error saving the user.", request);
            }
        }
        return this.userListPage(model,"User was saved successfully.", request);
    }
    
    @ModelAttribute("roles")
    public List<UserProfiles> initializeProfiles() {
        return userProfileService.findAll();
    }
    
}
