
package com.fich.wafproject.dao;

import com.fich.wafproject.model.File;
import java.util.List;

public interface FileDao {
    
    void saveFile(File file);
    
    public File findByPath(String path);
    
    public File findByFileName(String name);
    
    public File findById(Integer id);
    
    public List<File> findAllFiles();
    
}
