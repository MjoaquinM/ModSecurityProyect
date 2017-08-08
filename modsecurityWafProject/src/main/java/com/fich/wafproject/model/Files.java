/*
 * Historia Clinica Digital Laboral
 * @author Martin Cardoso
 */
package com.fich.wafproject.model;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Martin Cardoso
 */
@Entity
@Table(name = "Files")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Files.findAll", query = "SELECT f FROM Files f")
    , @NamedQuery(name = "Files.findByFileName", query = "SELECT f FROM Files f WHERE f.fileName = :fileName")
    , @NamedQuery(name = "Files.findByFilePath", query = "SELECT f FROM Files f WHERE f.filePath = :filePath")})
public class Files implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "fileName")
    private String fileName;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "filePath")
    private String filePath;
    @OneToMany(mappedBy = "file")
    private List<Rules> rulesList;

    public Files() {
    }

    public Files(String filePath) {
        this.filePath = filePath;
    }

    public Files(String filePath, String fileName) {
        this.filePath = filePath;
        this.fileName = fileName;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    @XmlTransient
    public List<Rules> getRulesList() {
        return rulesList;
    }

    public void setRulesList(List<Rules> rulesList) {
        this.rulesList = rulesList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (filePath != null ? filePath.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Files)) {
            return false;
        }
        Files other = (Files) object;
        if ((this.filePath == null && other.filePath != null) || (this.filePath != null && !this.filePath.equals(other.filePath))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.websystique.springmvc.model.Files[ filePath=" + filePath + " ]";
    }
    
}
