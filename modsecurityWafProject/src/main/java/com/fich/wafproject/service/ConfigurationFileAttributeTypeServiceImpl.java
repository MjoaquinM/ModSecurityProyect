
package com.fich.wafproject.service;

import com.fich.wafproject.model.ConfigurationFileAttributeType;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.fich.wafproject.dao.ConfigurationFileAttributeTypeDao;
import org.springframework.beans.factory.annotation.Autowired;

@Service("configurationFileAttributeTypeServiceImpl")
@Transactional
public class ConfigurationFileAttributeTypeServiceImpl implements ConfigurationFileAttributeTypeService {
    
    @Autowired
    private ConfigurationFileAttributeTypeDao dao;
    
    public void save(ConfigurationFileAttributeType cfat) {
        dao.save(cfat);
    }

    public void update(ConfigurationFileAttributeType cfat) {
        dao.update(cfat);
    }

    public void delete(Long id) {
        dao.delete(id);
    }

    public ConfigurationFileAttributeType findById(Long id) {
        return dao.findById(id);
    }

    public ConfigurationFileAttributeType findByName(String name) {
        return dao.findByName(name);
    }

    public List<ConfigurationFileAttributeType> findAll() {
        return dao.findAll();
    }
    
    
}
