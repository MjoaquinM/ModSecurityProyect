
package com.fich.wafproject.service;

import java.util.List;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
 
import com.fich.wafproject.dao.UserProfileDao;
import com.fich.wafproject.model.UserProfiles;
 
@Service("userProfileService")
@Transactional
public class UserProfileServiceImpl implements UserProfileService{
     
    @Autowired
    UserProfileDao dao;
     
    public List<UserProfiles> findAll() {
        return dao.findAll();
    }
 
    public UserProfiles findByType(String type){
        return dao.findByType(type);
    }
 
    public UserProfiles findById(Long id) {
        return dao.findById(id);
    }
}
