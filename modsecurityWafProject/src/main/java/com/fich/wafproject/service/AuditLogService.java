/*
 Esta clase se encarga de guardar todo el log en la base de datos, haciendo las validaciones correspodientes.
 Guarda el evento y lo relaciona a la reglas y archivos.
 */
package com.fich.wafproject.service;

import com.fich.wafproject.model.Event;
import com.fich.wafproject.model.EventRule;
import com.fich.wafproject.model.File;
import com.fich.wafproject.model.Rule;

public interface AuditLogService {
    
    void saveAuditLog (Event event, EventRule eventRule, Rule rule, File file);
    
    public void saveEvent(Event event);
    
    boolean isRuleRegistred(String idRule);
    
    boolean isFileRegistred(String FileName);
    
}
