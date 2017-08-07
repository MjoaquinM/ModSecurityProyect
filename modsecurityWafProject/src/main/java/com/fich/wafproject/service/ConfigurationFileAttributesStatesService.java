/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFileAttributeStates;
import java.util.List;

/**
 *
 * @author joaquin
 */
public interface ConfigurationFileAttributesStatesService {
    
    void save(ConfigurationFileAttributeStates cfas);
    
    void update(ConfigurationFileAttributeStates cfas);
    
    void delete(Long id);
     
    ConfigurationFileAttributeStates findById(Long id);
     
    ConfigurationFileAttributeStates findByUserName(String user_name);
    
    List<ConfigurationFileAttributeStates> findAll();
    
}
