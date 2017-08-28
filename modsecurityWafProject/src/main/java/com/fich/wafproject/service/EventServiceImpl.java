package com.fich.wafproject.service;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
 
import com.fich.wafproject.dao.EventDao;
import com.fich.wafproject.model.Event;
import java.util.List;
 
@Service("eventService")
@Transactional
public class EventServiceImpl implements EventService {
 
    @Autowired
    private EventDao dao;
 
    @Override
    public void saveEvent(Event event) {
        dao.saveEvent(event);
    }
    
    @Override
    public Event findByTransactionId(String transactionId) {
        Event event = dao.findByTransactionId(transactionId);
        return event;
    }

    @Override
    public List<Event> findAllEvents(int pageNumber) {
        return dao.findAllEvent(pageNumber);
    }
     
}