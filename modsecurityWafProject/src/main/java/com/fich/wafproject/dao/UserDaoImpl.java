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
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
 
import com.fich.wafproject.model.Users;
import java.util.List;
import org.hibernate.criterion.Order;
 
@Repository("userDao")
public class UserDaoImpl extends AbstractDao<Long, Users> implements UserDao {
 
    public void save(Users user) {
        persist(user);
    }
    
    public void update(Users user) {
        update(user);
    }
    
    public void delete(Long id){
        Users user = this.findById(id);
        delete(user);
    }
     
    public Users findById(Long id) {
        return getByKey(id);
    }
 
    public Users findByUserName(String user_name) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("userName", user_name));
        return (Users) crit.uniqueResult();
    }
    
    @SuppressWarnings("unchecked")
    public List<Users> findAll(){
        Criteria crit = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        crit.addOrder(Order.asc("userName"));
        return (List<Users>)crit.list();
    }
    
}