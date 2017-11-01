
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFileAttributeStates;
import java.util.List;
import com.fich.wafproject.dao.ConfigurationFileAttributeStatesDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("configurationFileAttributesStatesService")
@Transactional
public class ConfigurationFileAttributesStatesServiceImpl implements ConfigurationFileAttributesStatesService{
    
    @Autowired
    private ConfigurationFileAttributeStatesDao dao;
    
    public void save(ConfigurationFileAttributeStates cfas) {
        dao.save(cfas);
    }

    public void update(ConfigurationFileAttributeStates cfas) {
        dao.save(cfas);
    }

    public void delete(Long id) {
        dao.delete(id);
    }

    public ConfigurationFileAttributeStates findById(Long id) {
        return dao.findById(id);
    }

    public ConfigurationFileAttributeStates findByUserName(String name) {
        return dao.findByStateName(name);
    }

    public List<ConfigurationFileAttributeStates> findAll() {
        return dao.findAll();
    }
    
}
