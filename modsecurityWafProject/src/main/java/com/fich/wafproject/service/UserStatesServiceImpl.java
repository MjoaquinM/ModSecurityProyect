
package com.fich.wafproject.service;

import com.fich.wafproject.dao.UserStatesDao;
import com.fich.wafproject.model.UserStates;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("userStatesService")
@Transactional
public class UserStatesServiceImpl implements UserStatesService {
    
    @Autowired
    private UserStatesDao dao;
    
    public void save(UserStates userStates){
        dao.save(userStates);
    }
    
    public void update(UserStates userStates){
        dao.update(userStates);
    }
    
    public void delete(int id){
        dao.delete(id);
    }
     
    public UserStates findById(int id){
        return dao.findById(id);
    }
     
    public UserStates findByStateName(String stateName){
        return dao.findByStateName(stateName);
    }
    
    public List<UserStates> findAll(){
        return dao.findAll();
    }
    
}