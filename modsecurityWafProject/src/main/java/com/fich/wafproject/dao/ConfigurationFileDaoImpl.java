/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFiles;
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
public class ConfigurationFileDaoImpl extends AbstractDao<Long, ConfigurationFiles>implements ConfigurationFileDao{

    @SuppressWarnings("unchecked")
    public List<ConfigurationFiles> findAll() {
        Criteria crit = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        crit.addOrder(Order.asc("name"));
        return (List<ConfigurationFiles>)crit.list();
    }
    
    public ConfigurationFiles findByPath(String path) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("path", path));
        crit.addOrder(Order.asc("name"));
        return (ConfigurationFiles) crit.uniqueResult();
    }

    
    public ConfigurationFiles findById(Long id) {
        return getByKey(id);
    }

    
    public ConfigurationFiles findByName(String name) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("name", name));
        crit.addOrder(Order.asc("name"));
        return (ConfigurationFiles) crit.uniqueResult();
    }
    
    public void save(ConfigurationFiles cf){
        persist(cf);
    }
    
    public void delete(Long id){
        ConfigurationFiles cf = this.findById(id);
        delete(cf);
    }
}
