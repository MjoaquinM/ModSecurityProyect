/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.util;

import com.fich.wafproject.model.File;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author joaquin
 */
public class MessageData {
    
    private String message;
    private String author;
    private String transactionId;
    private String classAttack;
    private List<File> files;
//    private long time;

    public MessageData() {
        List<File> fileList = new ArrayList<File>();
        this.files = fileList;
    }

    public MessageData(String author, String message, String transId, String classAtt, List<File> f) {
        this.author = author;
        this.message = message;
        this.transactionId = transId;
        this.classAttack = classAtt;
        this.files = f;
    }
    
    public List<File> getFiles(){
        return this.files;
    }
    
    public void setFiles(List<File> f){
        this.files = f;
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
    
    public void setMessage(String message) {
        this.message = message;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

}
