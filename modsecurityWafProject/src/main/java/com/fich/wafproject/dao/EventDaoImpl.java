package com.fich.wafproject.dao;
 
import java.util.List;
 
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
 
import com.fich.wafproject.model.Event;
import java.io.Serializable;
 
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

    @Override
    public List<Event> findAllEvent(int pageNumber) {
        int pageSize = 3;
        
        Criteria criteria = createEntityCriteria();
        criteria.setFirstResult((pageNumber - 1) * pageSize);
        criteria.setMaxResults(pageSize);
                
        return (List<Event>) criteria.list();        
    }
 
}