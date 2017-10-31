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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
 
import com.fich.wafproject.model.UserProfiles;
import com.fich.wafproject.service.UserProfileService;
 
@Component
public class RoleToUserProfileConverter implements Converter<Object, UserProfiles>{
 
    @Autowired
    UserProfileService userProfileService;
 
    /*
     * Gets UserProfile by Id
     * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
     */
    public UserProfiles convert(Object element) {
//        Integer id = Integer.parseInt((String)element);
        Long id = Long.parseLong((String)element);
        UserProfiles profile= userProfileService.findById(id);
        return profile;
    }
     
    /*
     * Gets UserProfile by type
     * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
     */
    /*
    public UserProfile convert(Object element) {
        String type = (String)element;
        UserProfile profile= userProfileService.findByType(type);
        System.out.println("Profile ... : "+profile);
        return profile;
    }
    */
 
}