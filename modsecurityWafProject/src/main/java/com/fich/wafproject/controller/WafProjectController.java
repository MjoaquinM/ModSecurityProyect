package com.fich.wafproject.controller;

import com.fich.wafproject.model.ConfigurationFiles;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.fich.wafproject.service.ConfigurationFileAttributeGroupsService;
import com.fich.wafproject.service.ConfigurationFileService;
import com.fich.wafproject.service.ConfigurationFileStatesService;
import com.fich.wafproject.service.UserProfileService;
import com.fich.wafproject.service.ConfigurationFileAttributesStatesService;
import com.fich.wafproject.service.UserStatesService;
import com.fich.wafproject.service.ConfigurationFileAttributeTypeService;
import com.fich.wafproject.service.ConfigurationFileAttributeService;
import com.fich.wafproject.service.ConfigurationFileAttributeOptionsService;
import com.fich.wafproject.service.UsersHistoryService;
import com.fich.wafproject.util.Functions;
import javax.servlet.ServletException;
import org.springframework.security.web.authentication.logout.CookieClearingLogoutHandler;
import org.springframework.security.web.authentication.rememberme.AbstractRememberMeServices;
 
@Controller
@RequestMapping("/")
//@SessionAttributes("roles")
public class WafProjectController {
    
    @Autowired
    UserProfileService userProfileService;
    
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
    
    private boolean flagDebug = true;
    
    private Functions customFunctions = new Functions();
    
    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String adminPage(ModelMap model) {
        model.addAttribute("user",this.customFunctions.getPrincipal());
        List<ConfigurationFiles> cfs = configurationFileService.findAll();
        String user = this.customFunctions.getPrincipal();
        model.addAttribute("configFiles",cfs);
        model.addAttribute("user",user);
        return "redirect:/control/eventList";
    }
    
    @RequestMapping(value = "/Access_Denied", method = RequestMethod.GET)
    public String accessDeniedPage(ModelMap model) {
        model.addAttribute("user", this.customFunctions.getPrincipal());
        return "accessDenied";
    }
 
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage() {
        return "login";
    }
    
    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logoutPage (HttpServletRequest request, HttpServletResponse response) throws ServletException{
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//        System.out.println("aca estoy en el logout 1");
        if (auth != null){    
//            System.out.println("aca estoy en el logout 2");
            new SecurityContextLogoutHandler().logout(request, response, auth);
            new CookieClearingLogoutHandler(AbstractRememberMeServices.SPRING_SECURITY_REMEMBER_ME_COOKIE_KEY).logout(request, response, null);
        }
        request.logout();
        
        return "redirect:/login?logout";
    }
}
