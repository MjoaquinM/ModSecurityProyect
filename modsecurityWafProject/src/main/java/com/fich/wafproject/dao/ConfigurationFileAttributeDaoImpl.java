/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileAttribute;
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
public class ConfigurationFileAttributeDaoImpl extends AbstractDao<Integer, ConfigurationFileAttribute> implements ConfigurationFileAttributeDao {
    
    public void save(ConfigurationFileAttribute cfa){
        persist(cfa);
    };
     
    public ConfigurationFileAttribute findById(int id){
        return getByKey(id);
    };
     
    public ConfigurationFileAttribute findByName(String name){
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("name", name));
        return (ConfigurationFileAttribute) crit.uniqueResult();
    };
    
    
    public ConfigurationFileAttribute findByFileConfiguration(int idFc){
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("confFile", idFc));
        return (ConfigurationFileAttribute) crit.uniqueResult();
    };
    
    @SuppressWarnings("unchecked")
    public List<ConfigurationFileAttribute> findAll(){
        Criteria crit = createEntityCriteria();
        crit.addOrder(Order.asc("name"));
        return (List<ConfigurationFileAttribute>)crit.list();
    }
}
