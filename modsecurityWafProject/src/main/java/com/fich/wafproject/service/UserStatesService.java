/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.UserStates;
import java.util.List;

/**
 *
 * @author joaquin
 */
public interface UserStatesService {
    
    void save(UserStates userStates);
    
    void update(UserStates userStates);
    
    void delete(int id);
     
    UserStates findById(int id);
     
    UserStates findByStateName(String stateName);
    
    List<UserStates> findAll();
    
}