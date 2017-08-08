
package com.fich.wafproject.dao;

import com.fich.wafproject.model.File;

public interface FileDao {
    
    void saveFile(File file);
    
    public File findByPath(String path);
    
}
