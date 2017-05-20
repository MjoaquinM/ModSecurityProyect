/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

/**
 *
 * @author r3ng0
 */
import com.fich.wafproject.model.User;
import java.util.List;
 
public interface UserDao {
 
    void save(User user);
     
    User findById(int id);
     
    User findBySSO(String sso);
    
    List<User> findAll();
     
}