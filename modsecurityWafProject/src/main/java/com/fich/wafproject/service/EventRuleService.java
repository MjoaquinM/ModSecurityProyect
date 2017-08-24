package com.fich.wafproject.service;
 
import com.fich.wafproject.model.EventRule;
import java.util.List;
 
public interface EventRuleService {
     
    void saveEventRule(EventRule eventRule);
    
    List<EventRule> findAll();
    
}