/*
 Esta clase se encarga de guardar todo el log en la base de datos, haciendo las validaciones correspodientes.
 Guarda el evento y lo relaciona a la reglas y archivos.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.Event;
import com.fich.wafproject.model.EventsRules;
import com.fich.wafproject.model.Files;
import com.fich.wafproject.model.Rules;

public interface AuditLogService {
    
    void saveAuditLog (Event event, EventsRules eventRule, Rules rule, Files file);
    
    public void saveEvent(Event event);
    
    boolean isRuleRegistred(String idRule);
    
    boolean isFileRegistred(String FileName);
    
}
