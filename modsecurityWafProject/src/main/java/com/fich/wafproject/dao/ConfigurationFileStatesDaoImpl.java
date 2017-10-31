/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileStates;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 *
 * @author joaquin
 */
@Repository("configurationFileStatesDao")
public class ConfigurationFileStatesDaoImpl extends AbstractDao<Long, ConfigurationFileStates> implements ConfigurationFileStatesDao{
    
    public void save(ConfigurationFileStates configFileState) {
        persist(configFileState);
    }

    public ConfigurationFileStates findById(Long configFileStateId) {
        return getByKey(configFileStateId);
    }

    public ConfigurationFileStates findByStateName(String stateName) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("name", stateName));
        return (ConfigurationFileStates) crit.uniqueResult();
    }

    public List<ConfigurationFileStates> findAll() {
        Criteria crit = createEntityCriteria();
        crit.addOrder(Order.asc("name"));
        return (List<ConfigurationFileStates>)crit.list();
    }

    public void update(ConfigurationFileStates configFileState) {
        update(configFileState);
    }

    public void delete(Long configFileStateId) {
        ConfigurationFileStates configFileState = this.findById(configFileStateId);
        delete(configFileState);
    }
    
}
