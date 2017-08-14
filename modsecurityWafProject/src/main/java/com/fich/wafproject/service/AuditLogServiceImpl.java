
package com.fich.wafproject.service;

import com.fich.wafproject.dao.EventDao;
import com.fich.wafproject.model.Event;
import com.fich.wafproject.model.EventsRules;
import com.fich.wafproject.model.Files;
import com.fich.wafproject.model.Rules;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("auditLogService")
@Transactional
public class AuditLogServiceImpl implements AuditLogService {
 
    @Autowired
    private EventDao eventDao;
    
//    @Autowired
//    private EventRuleDao eventsRulesDao; 
//    
//    @Autowired
//    private RuleDao rulesDao; 
//    
//    @Autowired
//    private FileDao fileDao; 
    
    public void saveEvent(Event event) {
        eventDao.saveEvent(event);
    }
     
    public void saveAuditLog (Event event, EventsRules eventRule, Rules rule, Files file){
        
    }
    
    public boolean isRuleRegistred(String idRule){
        return true;
    }
    
    public boolean isFileRegistred(String FileName){
        return true;
    }
    
}