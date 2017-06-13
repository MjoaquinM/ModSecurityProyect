/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFile;
import java.util.List;

/**
 *
 * @author r3ng0
 */
public interface ConfigurationFileService {
    
    List<ConfigurationFile> findAll();
     
    ConfigurationFile findByPath(String path);
     
    ConfigurationFile findById(int id);
    
    ConfigurationFile findByName(String name);
    
    void delete(int id);
    
    void save(ConfigurationFile cf);
    
}
