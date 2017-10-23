/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.util;

import com.fich.wafproject.model.File;
import com.fich.wafproject.model.Rule;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author joaquin
 */
public class MessageData {
    private String transactionId;
    private String clientIp;
    private String destinationPage;
    private List<String> rules;
//    private long time;

    public MessageData() {
        this.rules = new ArrayList<String>();
    }

    public MessageData(String transId, String cip, String destPage) {
        this.transactionId = transId;
        this.clientIp = cip;
        this.destinationPage = destPage;
        this.rules = new ArrayList<String>();
    }
    
    public void addRule(String r){
        this.rules.add(r);
    }
    
    public List<String> getRules(){
        return this.rules;
    }
    
    public void setRule(List<String> rules){
        this.rules = rules;
    }
    
    public String getDestinationPage(){
        return this.destinationPage;
    }
    
    public void setDestinationPage(String destPage){
        this.destinationPage = destPage;
    }
    
    public String getClientIp(){
        return this.clientIp;
    }
    
    public void setClientIp(String cip){
        this.clientIp = cip;
    }
    
    public String getTransactionId(){
        return this.transactionId;
    }
    
    public void setTransactionId(String ti){
        this.transactionId = ti;
    }

}
