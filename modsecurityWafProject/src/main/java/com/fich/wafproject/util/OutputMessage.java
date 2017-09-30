package com.fich.wafproject.util;

public class OutputMessage extends Message {

    private String time;

    public OutputMessage() {
        setFrom("a");
        setText("v");
        this.time = "hola";
    }

    public String getTime() {
        return time;
    }
    public void setTime(String time) { this.time = time; }
}
