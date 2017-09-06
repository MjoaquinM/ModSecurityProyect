/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

/**
 *
 * @author joaquin
 */

import com.fich.wafproject.model.UsersHistory;
import java.util.List;

public interface UsersHistoryService {
    
    void save(UsersHistory uh);
     
    UsersHistory findById(Long id);
     
//    UsersHistory findByName(String name);
    
    List<UsersHistory> findAll(int pageNumber);
    
    void update(UsersHistory uh);
    
    void delete(Long id);
         
    List<UsersHistory> filer(String[] targets, String[] names, String[] values, int pageNumber);
}