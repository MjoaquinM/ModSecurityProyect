package com.fich.wafproject.service;
 
import com.fich.wafproject.model.Event;
import java.util.List;
 
public interface EventService {
     
    void saveEvent(Event event);
    
    Event findByTransactionId(String transactionId);
    
    List<Event> findAllEvents(int pageNumber, String[] targets, String[] names, String[] values);

    List<Event> findAllEvents();
    
    List<Event> findEventsByProperties(String[] properties, String[] values);
    
    Event findById(Integer id);
    
    void delete(Integer id);
    
    void deleteAll();
     
}