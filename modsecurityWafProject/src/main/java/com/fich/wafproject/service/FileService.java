package com.fich.wafproject.service;
 
import com.fich.wafproject.model.File;
 
public interface FileService {
     
    void saveFile(File file);
    
    File findByFilePath(String fp);
     
}