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
 
import com.fich.wafproject.model.Users;
import java.util.List;
 
public interface UserService {
 
    void save(Users user);
    
    void update(Users user);
    
    void delete(Long id);
     
    Users findById(Long id);
     
    Users findByUserName(String user_name);
    
    List<Users> findAll();
    
    public List<Users> findAll(int pageNumber, String[] targets, String[] names, String[] values, boolean pagination);
     
}