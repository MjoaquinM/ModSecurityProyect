package com.fich.wafproject.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.fich.wafproject.model.Event;
import com.fich.wafproject.model.Users;
import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Subqueries;
 
@Repository("EventDao")
public class EventDaoImpl extends AbstractDao<Integer, Event> implements EventDao {

    public void saveEvent(Event event) {
        persist(event);
    }

    @Override
    public Event findByTransactionId(String transactionId) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("transactionId", transactionId));
        Event event = (Event) crit.uniqueResult();
        return event;
    }

    public Event findById(Integer id) {
        return getByKey(id);
    }

    @Override
    public List<Event> findAllEvent(int pageNumber, String[] targets, String[] names, String[] values, boolean pagination) {
        int pageSize = 50;
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
                    Logger.getLogger(UserHistoryDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (pagination) {
            crit.setFirstResult((pageNumber - 1) * pageSize);
            crit.setMaxResults(pageSize);
        }
        List<Event> events = new ArrayList<>();
        for (Object idEvent : crit.list()) {
            System.out.println(idEvent);
            events.add(this.findById((Integer) idEvent));
        }
        
        HashMap<Date, Event> dateEvent = new HashMap<>();
        for (Event e : events){
            dateEvent.put(e.getDateEvent(), e);
        }
        List<Event> ordEvent = new ArrayList<>();
        SortedSet<Date> keys = new TreeSet<>(dateEvent.keySet());
        for (Date key : keys){
            ordEvent.add(dateEvent.get(key));
        }
        return (List<Event>) ordEvent;
    }
    
    @Override
    public List<Event> findAllEvent() {
        Criteria crit = this.createEntityCriteria().setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        return (List<Event>) crit.list();
    }

    @Override
    public void delete(Integer id){
        Event e = this.findById(id);
        if(e!=null){
            delete(e);
        }
    }

    @Override
    public void deletAll() {
        List<Event> events = this.findAllEvent();
        for(Event e : events){
            delete(e);
        }
    }

    @Override
    public List<Event> findEventsByProperties(String[] properties, String[] values) {
        Criteria crit = this.createEntityCriteria().setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        int indx = 0;
        for(String property : properties){
            crit.add(Restrictions.like(property,"%"+values[indx++]+"%"));
        }
        
        return (List<Event>) crit.list();
    }
}