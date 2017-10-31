/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileAttributeOptions;
import java.util.List;
/**
 *
 * @author joaquin
 */
public interface ConfigurationFileAttributeOptionsDao {
    
    void save(ConfigurationFileAttributeOptions cfao);
     
    ConfigurationFileAttributeOptions findById(Long cfaoId);
     
    ConfigurationFileAttributeOptions findByName(String name);
    
    List<ConfigurationFileAttributeOptions> findAll();
    
    void update(ConfigurationFileAttributeOptions cfao);
    
    List<ConfigurationFileAttributeOptions> findByCfAttr(Long cfaId);
    
    void delete(Long cfaoId);
    
    public void deletOptsByFile(Long cfaId);
    
}
