package com.fich.wafproject.dao;

import com.fich.wafproject.model.File;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Projections;
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
    
    @Override
    public File findById(Integer id) {
        return getByKey(id);
    }
    
    @Override
    public List<File> findAllEvent() {
        Criteria crit = this.createEntityCriteria();//.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        crit.setProjection(Projections.distinct(Projections.property("id")));
        List<File> files = new ArrayList<File>();
        for(Object idFile : crit.list()){
            files.add(this.findById((Integer) idFile));
        }
        return (List<File>) files;
    }

}
