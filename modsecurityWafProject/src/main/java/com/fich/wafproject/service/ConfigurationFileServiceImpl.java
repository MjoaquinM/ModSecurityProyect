/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.dao.ConfigurationFileDao;
import com.fich.wafproject.model.ConfigurationFile;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author r3ng0
 */
@Service("configurationFileService")
@Transactional
public class ConfigurationFileServiceImpl implements ConfigurationFileService {
    
    @Autowired
    private ConfigurationFileDao dao;
    
    public List<ConfigurationFile> findAll() {
        return dao.findAll();
    }
    
    public ConfigurationFile findByPath(String path) {
        return dao.findByPath(path);
    }
    
    public ConfigurationFile findById(int id) {
        return dao.findById(id);
    }
    
    public ConfigurationFile findByName(String name) {
        return dao.findByName(name);
    }

    @Override
    public void save(ConfigurationFile cf) {
        dao.save(cf);
    }
    
    public void delete(int id){
        dao.delete(id);
    }
    
}
