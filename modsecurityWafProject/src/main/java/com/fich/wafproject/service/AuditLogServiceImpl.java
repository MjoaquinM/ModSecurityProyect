
package com.fich.wafproject.service;

import com.fich.wafproject.dao.EventDao;
import com.fich.wafproject.model.Event;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("auditLogService")
@Transactional
public class AuditLogServiceImpl implements AuditLogService {
 
    @Autowired
    private EventDao eventDao;
    
    public void saveEvent(Event event) {
        eventDao.saveEvent(event);
    }
     
    public boolean isRuleRegistred(String idRule){
        return true;
    }
    
    public boolean isFileRegistred(String FileName){
        return true;
    }
    
}