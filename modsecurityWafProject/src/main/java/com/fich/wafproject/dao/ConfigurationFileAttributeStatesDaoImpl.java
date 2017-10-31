/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileAttributeStates;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
/**
 *
 * @author joaquin
 */
@Repository("configurationFileAttributeStatesDao")
public class ConfigurationFileAttributeStatesDaoImpl extends AbstractDao<Long, ConfigurationFileAttributeStates>   implements ConfigurationFileAttributeStatesDao {

    public void save(ConfigurationFileAttributeStates configurationFileAttrState) {
        persist(configurationFileAttrState);
    }

    public void update(ConfigurationFileAttributeStates configurationFileAttrState) {
        update(configurationFileAttrState);
    }
    
    public void delete(Long id){
        ConfigurationFileAttributeStates configurationFileAttrState = this.findById(id);
        delete(configurationFileAttrState);
    }
     
    public ConfigurationFileAttributeStates findById(Long id) {
        return getByKey(id);
    }
 
    public ConfigurationFileAttributeStates findByStateName(String name) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("name", name));
        return (ConfigurationFileAttributeStates) crit.uniqueResult();
    }
    
    @SuppressWarnings("unchecked")
    public List<ConfigurationFileAttributeStates> findAll(){
        Criteria crit = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        crit.addOrder(Order.asc("name"));
        return (List<ConfigurationFileAttributeStates>)crit.list();
    }
    
}
