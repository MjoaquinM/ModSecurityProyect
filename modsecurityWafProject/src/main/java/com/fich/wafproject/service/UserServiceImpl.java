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
import com.fich.wafproject.model.User;
import java.util.List;
 
@Service("userService")
@Transactional
public class UserServiceImpl implements UserService{
 
    @Autowired
    private UserDao dao;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    public void save(User user){
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        dao.save(user);
    }
    
    public void update(User user){
        dao.update(user);
    }
    
    public void delete(int id){
        dao.delete(id);
    }
 
    public User findById(int id) {
        return dao.findById(id);
    }
 
    public User findBySso(String sso) {
        return dao.findBySSO(sso);
    }
    
    public List<User> findAll(){
        return dao.findAll();
    }
 
}