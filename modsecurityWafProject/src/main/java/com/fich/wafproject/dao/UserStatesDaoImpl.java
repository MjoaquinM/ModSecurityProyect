/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.dao;

import com.fich.wafproject.model.UserStates;
import com.fich.wafproject.model.Users;
import java.util.LinkedHashSet;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 *
 * @author joaquin
 */
@Repository("userStatesDao")
public class UserStatesDaoImpl extends AbstractDao<Integer, UserStates> implements UserStatesDao{

    @Override
    public void save(UserStates userState) {
        persist(userState);
    }

    @Override
    public UserStates findById(Integer id) {
        return getByKey(id);
    }

    @Override
    public UserStates findByStateName(String state_name) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("name", state_name));
        return (UserStates) crit.uniqueResult();
    }

    @Override
    public List<UserStates> findAll() {
        Criteria crit = createEntityCriteria();
        crit.addOrder(Order.asc("name"));
        return (List<UserStates>)crit.list();
    }

    @Override
    public void update(UserStates user_state) {
        update(user_state);
    }

    @Override
    public void delete(int user_state) {
        UserStates userState = this.findById(user_state);
        delete(userState);
    }
    
    
}
