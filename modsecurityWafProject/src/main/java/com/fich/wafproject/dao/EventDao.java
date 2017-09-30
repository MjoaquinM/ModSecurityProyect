package com.fich.wafproject.dao;
 
import com.fich.wafproject.model.Event;
import java.util.List;
 
public interface EventDao {
 
    void saveEvent(Event event);
    
    Event findByTransactionId(String transactionId);
    
    List<Event> findAllEvent(int pageNumber, String[] targets, String[] names, String[] values);
    
    List<Event> findAllEvent();
    
    Event findById(Integer id);
    
    List<Event> findEventsByProperties(String[] properties, String[] values);
    
    public void delete(Integer id);
    
    public void deletAll();
     
}