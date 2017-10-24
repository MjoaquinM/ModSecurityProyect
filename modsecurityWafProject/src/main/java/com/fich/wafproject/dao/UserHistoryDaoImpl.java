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
import com.fich.wafproject.model.UsersHistory;
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
 
@Repository("userHistoryDao")
public class UserHistoryDaoImpl extends AbstractDao<Long, UsersHistory> implements UserHistoryDao {
 
    public void save(UsersHistory uh) {
        persist(uh);
    }
    
    public void update(UsersHistory uh) {
        update(uh);
    }
    
    public void delete(Long id){
        UsersHistory uh = this.findById(id);
        delete(uh);
    }
     
    public UsersHistory findById(Long id) {
        return getByKey(id);
    }
    
    @SuppressWarnings("unchecked")
    public List<UsersHistory> findAll(int pageNumber){
        int pageSize = 6;
        Criteria crit = createEntityCriteria();
        crit.setProjection(Projections.distinct(Projections.property("id")));
        crit.setFirstResult((pageNumber-1)*pageSize);
        crit.setMaxResults(pageSize);
        
        List<UsersHistory> events = new ArrayList<UsersHistory>();
        for(Object idUsersHistory : crit.list()){
//            System.out.println(idUsersHistory);
            events.add(this.findById((Long) idUsersHistory));
        }
        return events;
    }

    public List<UsersHistory> filter(String[] values, String[] names, String[] targets, int pageNumber, String role) {
        int pageSize = 6;
        int count = 0;
        boolean filterByUserProperty = false, filterByUserName = false;
        Criteria crit = this.createEntityCriteria();//.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        crit.setProjection(Projections.distinct(Projections.property("id")));
        String dateFrom="",dateTo="",targetDate="";
        if(names != null){
            for(String alias:names){
                crit.createAlias(alias, alias);
                if (alias.equals("user")) filterByUserProperty = true;
            }
        }
        if (!filterByUserProperty && !role.equals("")) crit.createAlias("user", "user");
        if (values != null){
            for(String value : values){
                if (!value.equals("") && value!=null){    
                    if(targets[count].contains("date")){
                        if(dateFrom!=""){
                            dateTo=value;
                        }else{
                            dateFrom=value;
                            targetDate=targets[count];
                        }
                    }else{
                        if(targets[count].contains("userName")) filterByUserName = true;
                        crit.add(Restrictions.like(targets[count],"%"+value+"%"));
                    }
                }
                count++;
            }
            if (targetDate!=""){
                if(dateFrom!="" && dateTo==""){
                    dateTo=dateFrom;
                }
                DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
                try {
                    Date dateF = format.parse(dateFrom);
                    Date dateT = format.parse(dateTo);
                    crit.add(Restrictions.between(targetDate,dateF,dateT));
                } catch (ParseException ex) {
                    Logger.getLogger(UserHistoryDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        if (!filterByUserName && !role.equals("")) crit.add(Restrictions.like("user.userName",role));
        crit.setFirstResult((pageNumber-1)*pageSize);
        crit.setMaxResults(pageSize);
        List<UsersHistory> events = new ArrayList<UsersHistory>();
        for(Object idEvent : crit.list()){
            events.add(this.findById((Long) idEvent));
        }
        return (List<UsersHistory>) events;
    }
    
}