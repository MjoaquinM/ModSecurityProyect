package com.fich.wafproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fich.wafproject.dao.FileDao;
import com.fich.wafproject.model.File;
import java.util.List;

@Service("fileService")
@Transactional
public class FileServiceImpl implements FileService {

    @Autowired
    private FileDao dao;

    @Override
    public void saveFile(File file) {
        dao.saveFile(file);
    }

    @Override
    public File findByFilePath(String fp) {
        File file = dao.findByPath(fp);
        return file;
    }
    
    @Override
    public List<File> findAllEvents() {
        return dao.findAllEvent();
    }
}
