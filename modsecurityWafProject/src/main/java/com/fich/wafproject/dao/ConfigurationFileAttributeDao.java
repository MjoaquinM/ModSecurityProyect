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
import com.fich.wafproject.model.ConfigurationFileAttribute;
import java.util.List;
 
public interface ConfigurationFileAttributeDao {
 
    void save(ConfigurationFileAttribute cfa);
     
    ConfigurationFileAttribute findById(int id);
    
    ConfigurationFileAttribute findByFileConfiguration(int idFc);
     
    ConfigurationFileAttribute findByName(String name);
    
    List<ConfigurationFileAttribute> findAll();
     
}
