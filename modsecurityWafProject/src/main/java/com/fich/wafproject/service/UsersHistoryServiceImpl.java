
package com.fich.wafproject.service;

import com.fich.wafproject.dao.UserHistoryDao;
import com.fich.wafproject.model.UsersHistory;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("usersHistoryService")
@Transactional
public class UsersHistoryServiceImpl implements UsersHistoryService{
    @Autowired
    private UserHistoryDao dao;

    public void save(UsersHistory uh) {
        dao.save(uh);
    }

    public UsersHistory findById(Long id) {
        return dao.findById(id);
    }

    public List<UsersHistory> findAll(int pageNumber) {
        return dao.findAll(pageNumber);
    }

    public void update(UsersHistory uh) {
        dao.update(uh);
    }

    public void delete(Long id) {
        dao.delete(id);
    }
    
    public List<UsersHistory> filer(String[] targets, String[] names, String[] values, int pageNumber, String role) {
        return dao.filter(targets, names, values, pageNumber, role);
    }
}