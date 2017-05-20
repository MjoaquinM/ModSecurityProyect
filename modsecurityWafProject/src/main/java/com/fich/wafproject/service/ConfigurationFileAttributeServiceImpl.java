/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.dao.ConfigurationFileAttributeDao;
import com.fich.wafproject.model.ConfigurationFileAttribute;
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
    
    public List<ConfigurationFileAttribute> findAll() {
        return dao.findAll();
    }
    
    public ConfigurationFileAttribute findById(int id) {
        return dao.findById(id);
    }

    public void save(ConfigurationFileAttribute cfa) {
        dao.save(cfa);
    }

    public ConfigurationFileAttribute findByName(String name) {
        return dao.findByName(name);
    }
    
    public ConfigurationFileAttribute findByFileConfiguration(int idFc){
        return dao.findByFileConfiguration(idFc);
    }
    
}
