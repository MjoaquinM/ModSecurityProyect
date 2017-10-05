package com.fich.wafproject.service;
 
import com.fich.wafproject.model.File;
import java.util.List;
 
public interface FileService {
     
    void saveFile(File file);
    
    File findByFilePath(String fp);
    
    public List<File> findAllFiles();
     
}