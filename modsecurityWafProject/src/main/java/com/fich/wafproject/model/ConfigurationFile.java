/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.model;

/**
 *
 * @author r3ng0
 */
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.persistence.CascadeType;
 
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
 
import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="CONFIGURATION_FILES", uniqueConstraints = {
@UniqueConstraint(columnNames = "ID"),
@UniqueConstraint(columnNames = "PATH_NAME") })
public class ConfigurationFile {
 
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
 
    @Column(name = "NAME", nullable = false)
    private String name;
     
    @Column(name = "PATH_NAME", unique = true, nullable = false)
    private String pathName;
    
    @Column(name = "DESCRIPTION", nullable = true)
    private String description;
    
    @Column(name = "STATE", nullable = false)
    private Boolean state;
 
    @OneToMany//(mappedBy = "ConfigurationFileAttribute",cascade=CascadeType.ALL)
    @JoinColumn(name="CONFIGURATION_FILE_ID")
    private List<ConfigurationFileAttribute> configurationAttributes;
 
    public int getId() {
        return id;
    }
 
    public void setId(int id) {
        this.id = id;
    }
 
    public String getName() {
        return this.name;
    }
 
    public void setName(String name) {
        this.name = name;
    }
    
    public Boolean getState() {
        return state;
    }
 
    public void setState(Boolean state) {
        this.state = state;
    }
    
    public String getPath() {
        return pathName;
    }
 
    public void setPath(String path) {
        this.pathName = path;
    }
    
    public String getDescription() {
        return description;
    }
 
    public void setDescription(String description) {
        this.description = description;
    }
    
    public List<ConfigurationFileAttribute> getConfigurationAttributes(){
        return this.configurationAttributes;
    }
    
    public void setConfigurationAttributes(List<ConfigurationFileAttribute> cfa){
        this.configurationAttributes = cfa;
    }
    
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + id;
        result = prime * result + ((name == null) ? 0 : name.hashCode());
        return result;
    }
 
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (!(obj instanceof ConfigurationFile))
            return false;
        ConfigurationFile other = (ConfigurationFile) obj;
        if (description != other.description)
            return false;
        if (pathName != other.pathName)
            return false;
        if (id != other.id)
            return false;
        if (name == null) {
            if (other.name != null)
                return false;
        } else if (!name.equals(other.name))
            return false;
        return true;
    }
 
    @Override
    public String toString() {
        return "ConfigurationFile [id=" + id + ", Name=" + name + ", State = " + state + 
                ", Path = " + pathName + ", Description = " + description + "]";
    }
    
}
