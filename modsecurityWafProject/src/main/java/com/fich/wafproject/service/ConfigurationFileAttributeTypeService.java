/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFileAttributeType;
import java.util.List;

/**
 *
 * @author joaquin
 */
public interface ConfigurationFileAttributeTypeService {
    void save(ConfigurationFileAttributeType cfat);
    
    void update(ConfigurationFileAttributeType cfat);
    
    void delete(Long id);
     
    ConfigurationFileAttributeType findById(Long id);
     
    ConfigurationFileAttributeType findByName(String name);
    
    List<ConfigurationFileAttributeType> findAll();
    
}
