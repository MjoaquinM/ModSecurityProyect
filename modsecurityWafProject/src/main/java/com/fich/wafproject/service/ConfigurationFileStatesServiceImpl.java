/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.dao.ConfigurationFileStatesDao;
import com.fich.wafproject.model.ConfigurationFileStates;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author joaquin
 */
@Service("configurationFileStatesService")
@Transactional
public class ConfigurationFileStatesServiceImpl implements ConfigurationFileStatesService{
    
    @Autowired
    private ConfigurationFileStatesDao dao;

    public void save(ConfigurationFileStates configFileStates) {
        dao.save(configFileStates);
    }

    public void update(ConfigurationFileStates configFileStates) {
        dao.update(configFileStates);
    }

    public void delete(Long configFileStatesId) {
        dao.delete(configFileStatesId);
    }
    
    public ConfigurationFileStates findById(Long configFileStatesId) {
        return dao.findById(configFileStatesId);
    }

    public ConfigurationFileStates findByStateName(String stateName) {
        return dao.findByStateName(stateName);
    }

    public List<ConfigurationFileStates> findAll() {
        return dao.findAll();
    }
    
}
