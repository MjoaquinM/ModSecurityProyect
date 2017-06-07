/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFile;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 *
 * @author r3ng0
 */

@Repository("configurationFileDao")
public class ConfigurationFileDaoImpl extends AbstractDao<Integer, ConfigurationFile>implements ConfigurationFileDao{

    @SuppressWarnings("unchecked")
    public List<ConfigurationFile> findAll() {
        Criteria crit = createEntityCriteria();
        crit.addOrder(Order.asc("name"));
        return (List<ConfigurationFile>)crit.list();
    }
    
    public ConfigurationFile findByPath(String path) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("path", path));
        crit.addOrder(Order.asc("name"));
        return (ConfigurationFile) crit.uniqueResult();
    }

    
    public ConfigurationFile findById(int id) {
        return getByKey(id);
    }

    
    public ConfigurationFile findByName(String name) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("name", name));
        crit.addOrder(Order.asc("name"));
        return (ConfigurationFile) crit.uniqueResult();
    }
    
    public void save(ConfigurationFile cf){
        persist(cf);
    }
    
    public void delete(int id){
        ConfigurationFile cf = this.findById(id);
        delete(cf);
    }
}
