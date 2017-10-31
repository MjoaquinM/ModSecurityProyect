/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.util;


/**
 *
 * @author r3ng0
 */
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
 
public class QuickPasswordEncodingGenerator {
 
    /**
     * @param args
     */
    public static void main(String[] args) {
            String password = "abc125";
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//            System.out.println(passwordEncoder.encode(password));
    }
 
}
