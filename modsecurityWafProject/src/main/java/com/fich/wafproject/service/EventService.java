package com.fich.wafproject.service;
 
import com.fich.wafproject.model.Event;
import java.util.List;
 
public interface EventService {
     
    void saveEvent(Event event);
    
    Event findByTransactionId(String transactionId);

    List<Event> findAllEvents(int pageNumber, String[] targets, String[] names, String[] values, boolean pagination);
    
    List<Event> findAllEvents();
     
}