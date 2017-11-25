
package com.fich.wafproject.service;

import com.fich.wafproject.dao.ConfigurationFileDao;
import com.fich.wafproject.model.ConfigurationFiles;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("configurationFileService")
@Transactional
public class ConfigurationFileServiceImpl implements ConfigurationFileService {
    
    @Autowired
    private ConfigurationFileDao dao;
    
    public List<ConfigurationFiles> findAll() {
        return dao.findAll();
    }
    
    public ConfigurationFiles findByPath(String path) {
        return dao.findByPath(path);
    }
    
    public ConfigurationFiles findById(Long id) {
        return dao.findById(id);
    }
    
    public ConfigurationFiles findByName(String name) {
        return dao.findByName(name);
    }

    public void save(ConfigurationFiles cf) {
        dao.save(cf);
    }
    
    public void delete(Long id){
        dao.delete(id);
    }
    
}
