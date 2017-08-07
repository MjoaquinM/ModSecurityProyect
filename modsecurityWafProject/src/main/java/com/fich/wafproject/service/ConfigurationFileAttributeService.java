/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFilesAttributes;
import java.util.List;

/**
 *
 * @author r3ng0
 */

public interface ConfigurationFileAttributeService {
 
    List<ConfigurationFilesAttributes> findAll();
     
    ConfigurationFilesAttributes findById(Long id);
    
    void delete(Long id);
    
    void save(ConfigurationFilesAttributes cfa);
    
    void update(ConfigurationFilesAttributes cfa);
    
    ConfigurationFilesAttributes findByName(String name);
    
    List<ConfigurationFilesAttributes> findByFileConfiguration(Long idFc);
    
}