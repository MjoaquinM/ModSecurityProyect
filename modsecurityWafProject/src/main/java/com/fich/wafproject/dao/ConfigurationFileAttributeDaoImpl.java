/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFilesAttributes;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 *
 * @author r3ng0
 */

@Repository("configurationFileAttributeDao")
public class ConfigurationFileAttributeDaoImpl extends AbstractDao<Long, ConfigurationFilesAttributes> implements ConfigurationFileAttributeDao {
    
    public void save(ConfigurationFilesAttributes cfa){
        persist(cfa);
    };
     
    public ConfigurationFilesAttributes findById(Long id){
        return getByKey(id);
    };
     
    public ConfigurationFilesAttributes findByName(String name){
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("name", name));
        return (ConfigurationFilesAttributes) crit.uniqueResult();
    };
    
    
    public List<ConfigurationFilesAttributes> findByFileConfiguration(Long idFc){
        Criteria crit = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        crit.add(Restrictions.eq("configurationFileAttributeGroups.id", idFc));
        return (List<ConfigurationFilesAttributes>) crit.list();
    };
    
    @SuppressWarnings("unchecked")
    public List<ConfigurationFilesAttributes> findAll(){
        Criteria crit = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        crit.addOrder(Order.asc("name"));
        return (List<ConfigurationFilesAttributes>)crit.list();
    }
    
    public void update(ConfigurationFilesAttributes cfa) {
        update(cfa);
    }
    
    public void delete(Long id){
        ConfigurationFilesAttributes cfa = this.findById(id);
        delete(cfa);
    }
    
}
