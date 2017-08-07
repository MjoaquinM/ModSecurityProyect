/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileAttributeType;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 *
 * @author joaquin
 */
@Repository("configurationFileAttributeTypeDao")
public class ConfigurationFileAttributeTypeDaoImpl extends AbstractDao<Long, ConfigurationFileAttributeType> implements ConfigurationFileAttributeTypeDao  {

    public void save(ConfigurationFileAttributeType cfat) {
        persist(cfat);
    }
    
    public void update(ConfigurationFileAttributeType cfat) {
        update(cfat);
    }
    
    public void delete(Long id){
        ConfigurationFileAttributeType cfat = this.findById(id);
        delete(cfat);
    }
     
    public ConfigurationFileAttributeType findById(Long id) {
        return getByKey(id);
    }
 
    public ConfigurationFileAttributeType findByName(String name) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("name", name));
        return (ConfigurationFileAttributeType) crit.uniqueResult();
    }
    
    @SuppressWarnings("unchecked")
    public List<ConfigurationFileAttributeType> findAll(){
        Criteria crit = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        crit.addOrder(Order.asc("name"));
        return (List<ConfigurationFileAttributeType>)crit.list();
    }
    
}
