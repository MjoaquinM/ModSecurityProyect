/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFileAttributeOptions;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.fich.wafproject.dao.ConfigurationFileAttributeOptionsDao;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author joaquin
 */
@Service("configurationFileAttributeOptionsService")
@Transactional
public class ConfigurationFileAttributeOptionsServiceImpl implements ConfigurationFileAttributeOptionsService {

    @Autowired
    private ConfigurationFileAttributeOptionsDao dao;
    
    public void save(ConfigurationFileAttributeOptions cfao) {
        dao.save(cfao);
    }

    public void update(ConfigurationFileAttributeOptions cfao) {
        dao.update(cfao);
    }

    public void delete(Long id) {
        dao.delete(id);
    }

    public ConfigurationFileAttributeOptions findById(Long id) {
        return dao.findById(id);
    }

    public ConfigurationFileAttributeOptions findByName(String name) {
        return dao.findByName(name);
    }

    public List<ConfigurationFileAttributeOptions> findAll() {
        return dao.findAll();
    }

    public List<ConfigurationFileAttributeOptions> findByCfAttr(Long cfaId) {
        return dao.findByCfAttr(cfaId);
    }

    public void deletOptsByFile(Long cfaId) {
        dao.deletOptsByFile(cfaId);
    }
    
}
