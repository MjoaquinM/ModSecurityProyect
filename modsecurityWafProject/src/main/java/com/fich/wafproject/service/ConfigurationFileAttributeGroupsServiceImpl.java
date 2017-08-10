/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.dao.ConfigurationFileAttributeGroupsDao;
import com.fich.wafproject.model.ConfigurationFileAttributeGroups;
import com.fich.wafproject.model.ConfigurationFilesAttributes;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author joaquin
 */
@Service("configurationFileAttributeGroupsService")
@Transactional
public class ConfigurationFileAttributeGroupsServiceImpl implements ConfigurationFileAttributeGroupsService {

    @Autowired
    private ConfigurationFileAttributeGroupsDao dao;
    
    public void save(ConfigurationFileAttributeGroups cfag) {
        dao.save(cfag);
    }

    public void update(ConfigurationFileAttributeGroups cfag) {
        dao.update(cfag);
    }

    public void delete(Long cfagId) {
        dao.delete(cfagId);
    }
    
    public void deleteByEntity(ConfigurationFileAttributeGroups cfag){
        dao.deleteByEntity(cfag);
    }

    public ConfigurationFileAttributeGroups findById(Long id) {
        return dao.findById(id);
    }

    public ConfigurationFileAttributeGroups findByName(String name) {
        return dao.findByName(name);
    }

    public List<ConfigurationFileAttributeGroups> findAll() {
        return dao.findAll();
    }
    
    public List<ConfigurationFilesAttributes> getConfigurationFileAttributes(Long cfagId){
        return dao.getConfigurationFileAttributes(cfagId);
    }
    
}
