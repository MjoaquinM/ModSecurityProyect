/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.util;

/**
 *
 * @author joaquin
 */
public class MessageData {
    
    private String message;
    private String author;
    private String transactionId;
    private String classAttack;
//    private long time;

    public MessageData() {
        this("","","","");
    }

    public MessageData(String author, String message, String transId, String classAtt) {
        this.author = author;
        this.message = message;
        this.transactionId = transId;
        this.classAttack = classAtt;
//        this.time = new MessageData().getTime();
    }

    public String getTransactionId(){
        return this.transactionId;
    }
    
    public void setTransactionId(String ti){
        this.transactionId = ti;
    }
    
    public String getClassAttack(){
        return this.classAttack;
    }
    
    public void setClassAttack(String ca){
        this.classAttack = ca;
    }
        
    public String getMessage() {
        return message;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setMessage(String message) {
        this.message = message;
    }

//    public long getTime() {
//        return time;
//    }
//
//    public void setTime(long time) {
//        this.time = time;
//    }
    
}
