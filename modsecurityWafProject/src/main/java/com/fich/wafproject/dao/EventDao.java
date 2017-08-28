package com.fich.wafproject.dao;
 
import com.fich.wafproject.model.Event;
import java.util.List;
 
public interface EventDao {
 
    void saveEvent(Event event);
    
    Event findByTransactionId(String transactionId);
    
    List<Event> findAllEvent(int pageNumber);
    
    Event findById(Integer id);
     
}