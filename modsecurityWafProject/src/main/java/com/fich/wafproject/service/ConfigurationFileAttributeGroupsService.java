/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFileAttributeGroups;
import com.fich.wafproject.model.ConfigurationFilesAttributes;
import java.util.List;

/**
 *
 * @author joaquin
 */
public interface ConfigurationFileAttributeGroupsService {
    
    void save(ConfigurationFileAttributeGroups cfag);
    
    void update(ConfigurationFileAttributeGroups cfag);
    
    void delete (Long cfagId);
    
    ConfigurationFileAttributeGroups findById(Long id);
    
    ConfigurationFileAttributeGroups findByName(String name);
    
    List<ConfigurationFileAttributeGroups> findAll();
    
    List<ConfigurationFilesAttributes> getConfigurationFileAttributes(Long cfagId);
}