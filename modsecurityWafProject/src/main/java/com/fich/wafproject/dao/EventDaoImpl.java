package com.fich.wafproject.dao;
 
import java.util.List;
 
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
 
import com.fich.wafproject.model.Event;
import java.util.ArrayList;
import org.hibernate.criterion.Projections;
 
@Repository("EventDao")
public class EventDaoImpl extends AbstractDao<Integer, Event> implements EventDao {
 
    public void saveEvent(Event event) {
        persist(event);
    }
    
    @Override
    public Event findByTransactionId(String transactionId){
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("transactionId", transactionId));
        Event event = (Event) crit.uniqueResult();
        return event;
    }
    
    public Event findById(Integer id) {
        return getByKey(id);
    }

    @Override
    public List<Event> findAllEvent(int pageNumber) {
        int pageSize = 10;
        Criteria crit = this.createEntityCriteria();//.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        crit.setProjection(Projections.distinct(Projections.property("id")));
        crit.setFirstResult((pageNumber-1)*pageSize);
        crit.setMaxResults(pageSize);
        List<Event> events = new ArrayList<Event>();
        for(Object idEvent : crit.list()){
            System.out.println(idEvent);
            events.add(this.findById((Integer) idEvent));
        }
        
        return (List<Event>) events;
    }
    
    @Override
    public List<Event> findAllEvent() {
        Criteria crit = this.createEntityCriteria();//.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        crit.setProjection(Projections.distinct(Projections.property("id")));
        List<Event> events = new ArrayList<Event>();
        for(Object idEvent : crit.list()){
            events.add(this.findById((Integer) idEvent));
        }
        return (List<Event>) events;
    }
}