package com.fich.wafproject.dao;

import com.fich.wafproject.model.File;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

@Repository("FileDao")
public class FileDaoImpl extends AbstractDao<Integer, File> implements FileDao {

    @Override
    public void saveFile(File file) {
        persist(file);
    }

    @Override
    public File findByPath(String path) {
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("filePath", path));
        File file = (File) crit.uniqueResult();
        return file;
    }

}
