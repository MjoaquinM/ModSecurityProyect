/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.dao.ConfigurationFileAttributeDao;
import com.fich.wafproject.model.ConfigurationFilesAttributes;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author r3ng0
 */
@Service("configurationFileAttributeService")
@Transactional
public class ConfigurationFileAttributeServiceImpl implements ConfigurationFileAttributeService{

    @Autowired
    private ConfigurationFileAttributeDao dao;
    
    public List<ConfigurationFilesAttributes> findAll() {
        return dao.findAll();
    }
    
    public ConfigurationFilesAttributes findById(Long id) {
        return dao.findById(id);
    }

    public void save(ConfigurationFilesAttributes cfa) {
        dao.save(cfa);
    }

    public ConfigurationFilesAttributes findByName(String name) {
        return dao.findByName(name);
    }
    
    public void update(ConfigurationFilesAttributes cfa){
        dao.update(cfa);
    }

    public List<ConfigurationFilesAttributes> findByFileConfiguration(Long idFc) {
        return dao.findByFileConfiguration(idFc);
    }
    
    public void delete(Long id){
        dao.delete(id);
    }
    
}
