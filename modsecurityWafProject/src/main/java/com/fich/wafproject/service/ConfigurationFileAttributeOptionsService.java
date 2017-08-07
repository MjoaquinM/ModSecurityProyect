/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFileAttributeOptions;
import java.util.List;

/**
 *
 * @author joaquin
 */
public interface ConfigurationFileAttributeOptionsService {
    
    void save(ConfigurationFileAttributeOptions cfao);
    
    void update(ConfigurationFileAttributeOptions cfao);
    
    void delete(Long id);
     
    ConfigurationFileAttributeOptions findById(Long id);
     
    ConfigurationFileAttributeOptions findByName(String name);
    
    List<ConfigurationFileAttributeOptions> findByCfAttr(Long cfaId);
    
    public void deletOptsByFile(Long cfaId);
    
    List<ConfigurationFileAttributeOptions> findAll();
    
}
