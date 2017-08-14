/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

/**
 *
 * @author joaquin
 */
@Entity
@Table(name = "CONFIGURATION_FILE_ATTRIBUTE_GROUPS", catalog = "waf_project", schema = "")
@NamedQueries({
    @NamedQuery(name = "ConfigurationFileAttributeGroups.findAll", query = "SELECT c FROM ConfigurationFileAttributeGroups c")
    , @NamedQuery(name = "ConfigurationFileAttributeGroups.findById", query = "SELECT c FROM ConfigurationFileAttributeGroups c WHERE c.id = :id")
    , @NamedQuery(name = "ConfigurationFileAttributeGroups.findByName", query = "SELECT c FROM ConfigurationFileAttributeGroups c WHERE c.name = :name")
    , @NamedQuery(name = "ConfigurationFileAttributeGroups.findByDescription", query = "SELECT c FROM ConfigurationFileAttributeGroups c WHERE c.description = :description")})
public class ConfigurationFileAttributeGroups implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "name")
    private String name;
    @Size(max = 200)
    @Column(name = "description")
    private String description;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "configurationFileAttributeGroups", fetch = FetchType.EAGER)
    @Fetch (FetchMode.SELECT)
    private List<ConfigurationFilesAttributes> configurationFilesAttributes;
    
    @JoinColumn(name = "configuration_files_id", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private ConfigurationFiles configurationFiles;

    public ConfigurationFileAttributeGroups() {
    }

    public ConfigurationFileAttributeGroups(Long id) {
        this.id = id;
    }

    public ConfigurationFileAttributeGroups(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<ConfigurationFilesAttributes> getConfigurationFilesAttributes() {
        return configurationFilesAttributes;
    }

    public void setConfigurationFilesAttributes(List<ConfigurationFilesAttributes> configurationFilesAttributes) {
        this.configurationFilesAttributes = configurationFilesAttributes;
    }
    
    public List<ConfigurationFilesAttributes> getConfigurationFilesAttributesAsList(){
        return new ArrayList<ConfigurationFilesAttributes>(this.configurationFilesAttributes);
    }

    public ConfigurationFiles getConfigurationFiles() {
        return configurationFiles;
    }

    public void setConfigurationFiles(ConfigurationFiles configurationFiles) {
        this.configurationFiles = configurationFiles;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ConfigurationFileAttributeGroups)) {
            return false;
        }
        ConfigurationFileAttributeGroups other = (ConfigurationFileAttributeGroups) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.fich.wafproject.model.ConfigurationFileAttributeGroups[ id=" + id + " ]";
    }
    
}
