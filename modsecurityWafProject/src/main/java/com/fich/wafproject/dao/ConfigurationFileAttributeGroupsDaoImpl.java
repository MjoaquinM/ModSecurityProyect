/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileAttributeGroups;
import com.fich.wafproject.model.ConfigurationFilesAttributes;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 *
 * @author joaquin
 */
@Repository("ConfigurationFileAttributeGroups")
public class ConfigurationFileAttributeGroupsDaoImpl extends AbstractDao<Long, ConfigurationFileAttributeGroups> implements ConfigurationFileAttributeGroupsDao {
    public void save(ConfigurationFileAttributeGroups cfag) {
        persist(cfag);
    }
    
    public void update(ConfigurationFileAttributeGroups cfag) {
        update(cfag);
    }
    
    public void delete(Long cfagId){
        ConfigurationFileAttributeGroups cfag = this.findById(cfagId);
        delete(cfag);
    }
    
    public void deleteByEntity(ConfigurationFileAttributeGroups cfag){
        delete(cfag);
    }
     
    public ConfigurationFileAttributeGroups findById(Long id) {
        return getByKey(id);
    }
 
    public ConfigurationFileAttributeGroups findByName(String name) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("name", name));
        return (ConfigurationFileAttributeGroups) crit.uniqueResult();
    }
    
    @SuppressWarnings("unchecked")
    public List<ConfigurationFileAttributeGroups> findAll(){
        Criteria crit = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        crit.addOrder(Order.asc("name"));
        return (List<ConfigurationFileAttributeGroups>)crit.list();
    }

    public List<ConfigurationFilesAttributes> getConfigurationFileAttributes(Long cfagId) {
        
        return (List<ConfigurationFilesAttributes>) this.getSession().createCriteria(ConfigurationFilesAttributes.class).add(Restrictions.eq("configurationFileAttributeGroups.id", cfagId)).list();
    }
    
    
}
