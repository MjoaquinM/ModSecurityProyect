/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.util;

import java.util.HashMap;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.NumberUtils;
import org.springframework.util.StringUtils;

/**
 *
 * @author joaquin
 */
public class Functions {
    
    public Functions(){};
    
    public String getPrincipal(){
        String userName = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
 
        if (principal instanceof UserDetails) {
            userName = ((UserDetails)principal).getUsername();
        } else {
            userName = principal.toString();
        }
        return userName;
    }
    
    public HashMap<String,String> parseRule(String block){
        HashMap<String,String> ret = new HashMap<String,String>();
        ret.put("exist", "false");
        int idPos = block.indexOf(",");
        
        String idRule = "";
        String msg = "";
        String severity = "";
        
        if (idPos >= 0){
            String idRulePartial = block.substring(0,idPos);
            if (this.stringIsNumber(idRulePartial)){
                ret.put("exist", "true");
                //ID DE REGLA
                idRule = idRulePartial;
                //RECORTO STRING
                String blockToSeverity = block;
                block = block.substring(idPos,block.length());
                int msgPos = block.indexOf("msg:");
                if (msgPos > 0){
                    //RECORTO STRING
                    block = block.substring(msgPos+5);
                    msgPos = block.indexOf("',");
                    if (msgPos>0){
                        msg = block.substring(0,msgPos);
                        
                        block = block.substring(msgPos+2);
                    }
                }
                block = blockToSeverity;
                int severityPos = block.indexOf("severity:'");
                if (severityPos > 0){
                    block = block.substring(severityPos+10);
                    severityPos = block.indexOf("'");
                    if (severityPos>0){
                        severity = block.substring(0,severityPos);
                    }
                }
            }
        }
        
        if (msg.length()>1000){
            msg = msg.substring(0,999);
        }
        
        if (severity.length()>45){
            severity = severity.substring(0,44);
        }
        
        ret.put("id", idRule);
        ret.put("msg", msg);
        ret.put("severity", severity);
        return ret;
    }
    
    public boolean stringIsNumber(String chain){
        boolean ret = true;
        for(int i=0;i<chain.length();i++){
            if(!Character.isDigit(chain.charAt(i))){
                ret = false;
                break;
            }
        }
        return ret;
    }
    
}
