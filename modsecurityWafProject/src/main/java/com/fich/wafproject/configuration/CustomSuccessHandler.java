/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.configuration;

/**
 *
 * @author r3ng0
 */
import com.fich.wafproject.model.Users;
import com.fich.wafproject.model.UsersHistory;
import com.fich.wafproject.service.UserService;
import com.fich.wafproject.service.UsersHistoryService;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
 
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
 
@Component
public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler{
 
    @Autowired
    private UserService userService;
    
    @Autowired
    private UsersHistoryService userHistoryService;
    
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
     
    @Override
    protected void handle(HttpServletRequest request, 
      HttpServletResponse response, Authentication authentication) throws IOException {
        String targetUrl = determineTargetUrl(authentication);
  
        if (response.isCommitted()) {
            System.out.println("Can't redirect");
            return;
        }
  
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
     
    protected String determineTargetUrl(Authentication authentication) {
        
        String userName = null;
        Object principal = authentication.getPrincipal();
        if (principal instanceof UserDetails) {
            userName = ((UserDetails)principal).getUsername();
        } else {
            userName = principal.toString();
        }
        
        Users user = userService.findByUserName(userName);
        UsersHistory uh = new UsersHistory();
        uh.setDescription("User Loggin");
        uh.setUser(user);
        Date d = new Date();
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date date = new Date();
        uh.setDateEvent(new Date());
        userHistoryService.save(uh);

        String url="";
         
        Collection<? extends GrantedAuthority> authorities =  authentication.getAuthorities();
        
        List<String> roles = new ArrayList<String>();
 
        for (GrantedAuthority a : authorities) {
            roles.add(a.getAuthority());
        }
 
        if (isAdmin(roles)) {
            url = "/admin";
        } else if (isDba(roles)) {
            url = "/admin";
        } else if (isUser(roles)) {
            url = "/admin";
        } else {
            url="/accessDenied";
        }
 
        return url;
    }
  
    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }
    protected RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }
     
    private boolean isUser(List<String> roles) {
        if (roles.contains("ROLE_USER")) {
            return true;
        }
        return false;
    }
 
    private boolean isAdmin(List<String> roles) {
        if (roles.contains("ROLE_ADMIN")) {
            return true;
        }
        return false;
    }
 
    private boolean isDba(List<String> roles) {
        if (roles.contains("ROLE_DBA")) {
            return true;
        }
        return false;
    }
    
    
    private void persistEvent(String msg){
        String currentUsr = this.getPrincipal();
        
        Users user = userService.findByUserName(this.getPrincipal());
        UsersHistory uh = new UsersHistory();
        uh.setDescription(msg);
        uh.setUser(user);
        uh.setDateEvent(new Date());
        userHistoryService.save(uh);
//        System.out.println("MSG: " + msg + " -- " + "CURRENT USER: " + currentUsr);
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
