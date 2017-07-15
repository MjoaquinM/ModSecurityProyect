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
 
import com.fich.wafproject.model.User;
import java.util.List;
import org.hibernate.criterion.Order;
 
@Repository("userDao")
public class UserDaoImpl extends AbstractDao<Integer, User> implements UserDao {
 
    public void save(User user) {
        persist(user);
    }
    
    public void update(User user) {
        update(user);
    }
    
    public void delete(int id){
        User user = this.findById(id);
        delete(user);
    }
     
    public User findById(int id) {
        return getByKey(id);
    }
 
    public User findByUserName(String user_name) {
        System.out.println("1");
        Criteria crit = createEntityCriteria();
        System.out.println("2");
        crit.add(Restrictions.eq("user_name", user_name));
        System.out.println("3");
        System.out.println(crit.uniqueResult());
        User u = (User) crit.uniqueResult();
        System.out.println("4");
        System.out.println(u);
        //return (User) crit.uniqueResult();
        return u;
    }
    
    @SuppressWarnings("unchecked")
    public List<User> findAll(){
        Criteria crit = createEntityCriteria();
        crit.addOrder(Order.asc("user_name"));
        return (List<User>)crit.list();
    }
    
}