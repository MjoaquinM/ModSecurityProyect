/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileAttributeGroups;
import com.fich.wafproject.model.ConfigurationFilesAttributes;
import java.util.List;

/**
 *
 * @author joaquin
 */
public interface ConfigurationFileAttributeGroupsDao {
    
    void save(ConfigurationFileAttributeGroups cfag);
     
    ConfigurationFileAttributeGroups findById(Long cfagId);
     
    ConfigurationFileAttributeGroups findByName(String name);
    
    List<ConfigurationFileAttributeGroups> findAll();
    
    void update(ConfigurationFileAttributeGroups cfag);
    
    void delete(Long cfagId);
    
    List<ConfigurationFilesAttributes> getConfigurationFileAttributes(Long cfagId);
}
