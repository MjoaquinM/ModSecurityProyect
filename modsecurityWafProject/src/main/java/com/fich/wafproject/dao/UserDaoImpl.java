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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
 
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
    
    public List<Users> findAll(int pageNumber, String[] targets, String[] names, String[] values, boolean pagination){
        int pageSize = 4;
        Criteria crit = this.createEntityCriteria();
        crit.setProjection(Projections.distinct(Projections.property("id")));
        String dateFrom = "", dateTo = "", targetDate = "";
        if (names != null) {
            for (String alias : names) {
                crit.createAlias(alias, alias);
            }
        }
        int count = 0;
        if (values != null) {
            for (String value : values) {
                if (!value.equals("") && value != null) {
                    if (targets[count].contains("date")) {
                        if (dateFrom != "") {
                            dateTo = value;
                        } else {
                            dateFrom = value;
                            targetDate = targets[count];
                        }
                    } else {
                        crit.add(Restrictions.like(targets[count], "%" + value + "%"));
                    }
                }
                count++;
            }
            if (targetDate != "") {
                if (dateFrom != "" && dateTo == "") {
                    dateTo = dateFrom;
                }
                DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
                try {
                    Date dateF = format.parse(dateFrom);
                    Date dateT = format.parse(dateTo);
                    crit.add(Restrictions.between(targetDate, dateF, dateT));
                } catch (ParseException ex) {
                    Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (pagination) {
            crit.setFirstResult((pageNumber - 1) * pageSize);
            crit.setMaxResults(pageSize);
        }
        List<Users> users = new ArrayList<Users>();
        for (Object idEvent : crit.list()) {
            System.out.println(idEvent);
            users.add(this.findById((Long) idEvent));
        }
        return (List<Users>) users;
    }
}