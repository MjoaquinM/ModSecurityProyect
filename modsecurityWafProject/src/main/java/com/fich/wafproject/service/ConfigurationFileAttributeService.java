/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFileAttribute;
import java.util.List;

/**
 *
 * @author r3ng0
 */

public interface ConfigurationFileAttributeService {
 
    List<ConfigurationFileAttribute> findAll();
     
    ConfigurationFileAttribute findById(int id);
    
    ConfigurationFileAttribute findByFileConfiguration(int idFc);
    
    void save(ConfigurationFileAttribute cfa);
    
    ConfigurationFileAttribute findByName(String name);
    
}