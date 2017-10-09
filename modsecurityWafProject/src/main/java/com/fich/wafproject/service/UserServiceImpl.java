/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.service;

/**
 *
 * @author r3ng0
 */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
 
import com.fich.wafproject.dao.UserDao;
import com.fich.wafproject.model.Users;
import java.io.IOException;
import java.util.List;
import org.springframework.dao.DataIntegrityViolationException;
 
@Service("userService")
@Transactional
public class UserServiceImpl implements UserService{
 
    @Autowired
    private UserDao dao;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    public void save(Users user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        dao.save(user);
    }
    
    public void update(Users user){
        dao.update(user);
    }
    
    public void delete(Long id){
        dao.delete(id);
    }
 
    public Users findById(Long id) {
        return dao.findById(id);
    }
 
    public Users findByUserName(String user_name) {
        return dao.findByUserName(user_name);
    }
    
    public List<Users> findAll(){
        return dao.findAll();
    }
    
    public List<Users> findAll(int pageNumber, String[] targets, String[] names, String[] values, boolean pagination){
        return this.dao.findAll(pageNumber, targets, names, values, pagination);
    }
 
}