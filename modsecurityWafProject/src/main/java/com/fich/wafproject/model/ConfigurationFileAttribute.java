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
import java.util.Objects;
import java.util.Set;
 
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
 
import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="CONFIGURATION_FILES_ATTRIBUTES",
       uniqueConstraints = {
       @UniqueConstraint(columnNames = "ID")})
public class ConfigurationFileAttribute {
 
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
 
    @Column(name = "NAME", unique = true, nullable = false)
    private String name;
    
    @Column(name = "ELEMENT_TYPE", unique = true, nullable = false)
    private String element_type;
     
    @Column(name = "DESCRIPTION", nullable = true)
    private String description;
    
    @Column(name = "STATE", nullable = false, columnDefinition = "bool default true")
    private Boolean state;
 
//    @ManyToOne
//    private ConfigurationFile configuration_file_id;
    
    @ManyToOne
    @JoinColumn(name = "CONFIGURATION_FILE_ID")
    private ConfigurationFile confFile;
    
    public ConfigurationFile getConfFile() {
        return confFile;
    }
    
    public void setConfFile(ConfigurationFile cf){
        this.confFile = cf;
    }
    
    //@JoinColumn(name="configuration_file_id")
//             joinColumns = { @JoinColumn(name = "USER_ID") },
//             inverseJoinColumns = { @JoinColumn(name = "USER_PROFILE_ID") })
//    private Set<UserProfile> userProfiles = new HashSet<UserProfile>();
 
    public int getId() {
        return id;
    }
     
    public void setId(int id) {
        this.id = id;
    }
    
    public String getElementType() {
        return element_type;
    }
 
    public void setElementType(String et) {
        this.element_type = et;
    }
 
    public String getName() {
        return this.name;
    }
 
    public void setName(String name) {
        this.name = name;
    }
    
    public Boolean getConfigurableState() {
        return state;
    }
 
    public void setConfigurableState(Boolean state) {
        this.state = state;
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
        if (!(obj instanceof ConfigurationFileAttribute))
            return false;
        ConfigurationFileAttribute other = (ConfigurationFileAttribute) obj;
        if (!Objects.equals(state, other.state))
            return false;
        if (!description.equals(other.description))
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
        return "ConfigurationFile [id=" + id + ", Name=" + name + ", State = " + state + "]";
    }
    
}
