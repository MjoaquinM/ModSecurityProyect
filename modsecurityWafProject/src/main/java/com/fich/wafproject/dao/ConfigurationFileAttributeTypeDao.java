/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileAttributeType;
import java.util.List;

/**
 *
 * @author joaquin
 */
public interface ConfigurationFileAttributeTypeDao {
    
    void save(ConfigurationFileAttributeType cfat);
     
    ConfigurationFileAttributeType findById(Long cfatId);
     
    ConfigurationFileAttributeType findByName(String name);
    
    List<ConfigurationFileAttributeType> findAll();
    
    void update(ConfigurationFileAttributeType cfat);
    
    void delete(Long cfatId);
}
