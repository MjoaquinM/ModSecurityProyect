/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.util;

import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author joaquin
 */
public class AlertMessages {
    private List<MessageData> messages;

    public AlertMessages(){
        this.messages = new ArrayList<MessageData>();
    }
    
    public AlertMessages(ArrayList<MessageData> mds) {
        this.messages = mds;
    }
    
    public void addMessages(MessageData md){
        this.messages.add(md);
    }
    
    public void setMessages(List<MessageData> mds){
        this.messages = mds;
    }
    
    public List<MessageData> getMessages(){
        return this.messages;
    }
    
}
