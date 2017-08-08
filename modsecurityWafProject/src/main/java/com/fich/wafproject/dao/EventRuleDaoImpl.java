package com.fich.wafproject.dao;
 
import org.springframework.stereotype.Repository;
 
import com.fich.wafproject.model.EventRule;
 
@Repository("EventRuleDao")
public class EventRuleDaoImpl extends AbstractDao<Integer, EventRule> implements EventRuleDao {
 
    public void saveEventRule(EventRule eventRule) {
        persist(eventRule);
    }
 
}