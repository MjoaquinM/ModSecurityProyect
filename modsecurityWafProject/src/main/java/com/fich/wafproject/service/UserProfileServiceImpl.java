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
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
 
import com.fich.wafproject.dao.UserProfileDao;
import com.fich.wafproject.model.UserProfiles;
 
@Service("userProfileService")
@Transactional
public class UserProfileServiceImpl implements UserProfileService{
     
    @Autowired
    UserProfileDao dao;
     
    public List<UserProfiles> findAll() {
        return dao.findAll();
    }
 
    public UserProfiles findByType(String type){
        System.out.println("ESTOY EN LA LONA 1");
        return dao.findByType(type);
    }
 
    public UserProfiles findById(Long id) {
        return dao.findById(id);
    }
}
