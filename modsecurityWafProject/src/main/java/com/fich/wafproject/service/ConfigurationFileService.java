/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFiles;
import java.util.List;

/**
 *
 * @author r3ng0
 */
public interface ConfigurationFileService {
    
    List<ConfigurationFiles> findAll();
     
    ConfigurationFiles findByPath(String path);
     
    ConfigurationFiles findById(Long id);
    
    ConfigurationFiles findByName(String name);
    
    void delete(Long id);
    
    void save(ConfigurationFiles cf);
    
}
