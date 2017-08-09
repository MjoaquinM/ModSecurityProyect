
package com.fich.wafproject.service;

import com.fich.wafproject.dao.EventDao;
import com.fich.wafproject.model.Event;
import com.fich.wafproject.model.EventRule;
import com.fich.wafproject.model.File;
import com.fich.wafproject.model.Rule;
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
     
    public void saveAuditLog (Event event, EventRule eventRule, Rule rule, File file){
        
    }
    
    public boolean isRuleRegistred(String idRule){
        return true;
    }
    
    public boolean isFileRegistred(String FileName){
        return true;
    }
    
}