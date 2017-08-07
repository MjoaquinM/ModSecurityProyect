/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileStates;
import java.util.List;

/**
 *
 * @author joaquin
 */
public interface ConfigurationFileStatesDao {
    
    void save(ConfigurationFileStates configFileState);
     
    ConfigurationFileStates findById(Long configFileStateId);
     
    ConfigurationFileStates findByStateName(String stateName);
    
    List<ConfigurationFileStates> findAll();
    
    void update(ConfigurationFileStates configFileState);
    
    void delete(Long configFileStateId);
}
