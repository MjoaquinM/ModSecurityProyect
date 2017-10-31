/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFileStates;
import java.util.List;

/**
 *
 * @author joaquin
 */
public interface ConfigurationFileStatesService {
    
    void save(ConfigurationFileStates configFileStates);
    
    void update(ConfigurationFileStates configFileStates);
    
    void delete(Long configFileStatesId);
     
    ConfigurationFileStates findById(Long configFileStatesId);
     
    ConfigurationFileStates findByStateName(String stateName);
    
    List<ConfigurationFileStates> findAll();
}
