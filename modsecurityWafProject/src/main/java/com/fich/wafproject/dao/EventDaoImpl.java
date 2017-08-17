package com.fich.wafproject.dao;
 
import java.util.List;
 
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
 
import com.fich.wafproject.model.Event;
import com.fich.wafproject.model.EventRule;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Root;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaQuery;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Subqueries;
import org.hibernate.transform.DistinctRootEntityResultTransformer;
//import org.hibernate.criterion.CriteriaQuery;
//import org.hibernate.criterion.CriteriaSpecification;
//import org.hibernate.criterion.DetachedCriteria;
//import org.hibernate.criterion.Projections;
//import org.hibernate.criterion.Subqueries;
 
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
    
    protected EntityManager em;
    @Override
    public List<Event> findAllEvent(int pageNumber) {
//        DetachedCriteria dc = DetachedCriteria.forClass(Event.class);
//        dc.createAlias("Event" , "e");
//        dc.add(Restrictions.in( "e.transactionId" , new Object[]{ "red" , "green" , "blue" }));
//        dc.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
//        dc.setProjection(Projections.distinct(Projections.property("transactionId")));
//        criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
//        criteria.setProjection(Projections.distinct(Projections.id()));
//        criteria.add(Subqueries.("transactionId", dc));
//        criteria.setFirstResult(0);
//        criteria.setMaxResults(150);
        
        Criteria criteria = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        List<Event> lst = criteria.list();
        
        int pageSize = 5;
        int firstResult = (pageNumber-1) * pageSize;//Inclusive
        int lastResult = firstResult + pageSize;    //Exclusive
        int indx = firstResult;
        Set<Event> setEvent = new HashSet<>();
        while (indx<=lastResult && indx<lst.size() && setEvent.size()<=pageSize){
            setEvent.add(lst.get(indx));
        }
        List<Event> rta = new ArrayList<>(setEvent);
        return rta;  
    }
}