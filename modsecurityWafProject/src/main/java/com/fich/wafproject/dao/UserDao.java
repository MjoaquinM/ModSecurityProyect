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
import com.fich.wafproject.model.Users;
import java.util.List;
 
public interface UserDao {
 
    void save(Users user);
     
    Users findById(Long id);
     
    Users findByUserName(String user_name);
    
    List<Users> findAll();
    
    void update(Users user);
    
    void delete(Long user);
         
}