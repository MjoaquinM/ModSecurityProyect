/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

/**
 *
 * @author r3ng0
 */
import java.util.List;
 
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
 
import com.fich.wafproject.model.UserProfiles;
 
@Repository("userProfileDao")
public class UserProfileDaoImpl extends AbstractDao<Long, UserProfiles>implements UserProfileDao{
 
    @SuppressWarnings("unchecked")
    public List<UserProfiles> findAll(){
        Criteria crit = createEntityCriteria();
        crit.addOrder(Order.asc("type"));
        return (List<UserProfiles>)crit.list();
    }
     
    public UserProfiles findById(Long id) {
        return getByKey(id);
    }
     
    public UserProfiles findByType(String type) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("type", type));
        return (UserProfiles) crit.uniqueResult();
    }
}
