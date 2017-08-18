/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.ConfigurationFileAttributeOptions;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
/**
 *
 * @author joaquin
 */
@Repository("configurationFileAttributeOptionsDao")
public class ConfigurationFileAttributeOptionsDaoImpl extends AbstractDao<Long, ConfigurationFileAttributeOptions> implements ConfigurationFileAttributeOptionsDao{

    public void save(ConfigurationFileAttributeOptions cfao) {
        persist(cfao);
    }

    public ConfigurationFileAttributeOptions findById(Long cfaoId) {
        return getByKey(cfaoId);
    }
    
    public ConfigurationFileAttributeOptions findByName(String name) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("name", name));
        return (ConfigurationFileAttributeOptions) crit.uniqueResult();
    }

    public List<ConfigurationFileAttributeOptions> findAll() {
        Criteria crit = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        crit.addOrder(Order.asc("name"));
        return (List<ConfigurationFileAttributeOptions>)crit.list();
    }

    public void update(ConfigurationFileAttributeOptions cfao) {
        update(cfao);
    }

    public void delete(Long cfaoId) {
        ConfigurationFileAttributeOptions cfao = this.findById(cfaoId);
        delete(cfao);
    }

    public List<ConfigurationFileAttributeOptions> findByCfAttr(Long cfaId) {
        Criteria crit = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        crit.add(Restrictions.eq("configurationFilesAttributes.id", cfaId));
        crit.addOrder(Order.asc("group"));
        return (List<ConfigurationFileAttributeOptions>)crit.list();
    }
    
    public void deletOptsByFile(Long cfaId){
        for(ConfigurationFileAttributeOptions opt: this.findByCfAttr(cfaId)){
            this.delete(opt.getId());
        }
    }
    
}
