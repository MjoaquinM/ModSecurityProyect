/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

/**
 *
 * @author joaquin
 */
import com.fich.wafproject.model.UserStates;
import java.util.List;

public interface UserStatesDao {
    
    void save(UserStates userState);
     
    UserStates findById(Integer id);
     
    UserStates findByStateName(String state_name);
    
    List<UserStates> findAll();
    
    void update(UserStates user_state);
    
    void delete(int user_state);
    
    
}
