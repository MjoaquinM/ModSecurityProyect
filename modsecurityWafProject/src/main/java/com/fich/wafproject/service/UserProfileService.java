/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

/**
 *
 * @author r3ng0
 */
import java.util.List;
 
import com.fich.wafproject.model.UserProfiles;
 
public interface UserProfileService {
 
    List<UserProfiles> findAll();
     
    UserProfiles findByType(String type);
     
    UserProfiles findById(Long id);
}