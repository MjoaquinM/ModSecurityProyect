/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileAttributeStates;
import java.util.List;

/**
 *
 * @author joaquin
 */
public interface ConfigurationFileAttributeStatesDao {
    void save(ConfigurationFileAttributeStates configurationFileAttrState);
     
    ConfigurationFileAttributeStates findById(Long id);
     
    ConfigurationFileAttributeStates findByStateName(String stateName);
    
    List<ConfigurationFileAttributeStates> findAll();
    
    void update(ConfigurationFileAttributeStates user_state);
    
    void delete(Long configurationFileAttrStates);
    
}
