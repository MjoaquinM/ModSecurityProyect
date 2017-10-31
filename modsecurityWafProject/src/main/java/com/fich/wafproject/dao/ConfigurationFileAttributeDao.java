/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

/**
 *
 * @author r3ng0
 */
import com.fich.wafproject.model.ConfigurationFilesAttributes;
import java.util.List;
 
public interface ConfigurationFileAttributeDao {
 
    void save(ConfigurationFilesAttributes cfa);
     
    ConfigurationFilesAttributes findById(Long id);
    
    void delete(Long id);
    
    void deleteByEntity(ConfigurationFilesAttributes cfa);
    
    List<ConfigurationFilesAttributes> findByFileConfigurationGroup(Long idFc);
    
    public List<ConfigurationFilesAttributes> findByFileConfiguration(Long id);
     
    ConfigurationFilesAttributes findByName(String name);
    
    List<ConfigurationFilesAttributes> findAll();
    
    void update(ConfigurationFilesAttributes cfa);
     
}
