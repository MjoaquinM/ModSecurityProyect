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
import com.fich.wafproject.model.UsersHistory;
import java.util.List;
 
public interface UserHistoryDao {
 
    void save(UsersHistory uh);
     
    UsersHistory findById(Long id);
     
//    UsersHistory findByName(String name);
    
    List<UsersHistory> filter(String[] targets, String[] names, String[] values, int pageNumber, String role);
    
    List<UsersHistory> findAll(int pageNumber);
    
    void update(UsersHistory uh);
    
    void delete(Long id);
         
}