/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.model;

import java.io.Serializable;
import java.util.List;
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

/**
 *
 * @author joaquin
 */
@Entity
@Table(name = "CONFIGURATION_FILES", catalog = "waf_project", schema = "")
@NamedQueries({
    @NamedQuery(name = "ConfigurationFiles.findAll", query = "SELECT c FROM ConfigurationFiles c")
    , @NamedQuery(name = "ConfigurationFiles.findById", query = "SELECT c FROM ConfigurationFiles c WHERE c.id = :id")
    , @NamedQuery(name = "ConfigurationFiles.findByName", query = "SELECT c FROM ConfigurationFiles c WHERE c.name = :name")
    , @NamedQuery(name = "ConfigurationFiles.findByPathName", query = "SELECT c FROM ConfigurationFiles c WHERE c.pathName = :pathName")
    , @NamedQuery(name = "ConfigurationFiles.findByDescription", query = "SELECT c FROM ConfigurationFiles c WHERE c.description = :description")})
public class ConfigurationFiles implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "path_name")
    private String pathName;
    @Size(max = 100)
    @Column(name = "description")
    private String description;
    
    @JoinColumn(name = "configuration_file_states_id", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private ConfigurationFileStates configurationFileStates;
    
    @OneToMany(cascade = CascadeType.DETACH, mappedBy = "configurationFiles", fetch = FetchType.EAGER)
    private List<ConfigurationFileAttributeGroups> configurationFileAttributeGroups;

    public ConfigurationFiles() {
    }

    public ConfigurationFiles(Long id) {
        this.id = id;
    }

    public ConfigurationFiles(Long id, String name, String pathName) {
        this.id = id;
        this.name = name;
        this.pathName = pathName;
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

    public String getPathName() {
        return pathName;
    }

    public void setPathName(String pathName) {
        this.pathName = pathName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ConfigurationFileStates getConfigurationFileStates() {
        return configurationFileStates;
    }

    public void setConfigurationFileStates(ConfigurationFileStates configurationFileStates) {
        this.configurationFileStates = configurationFileStates;
    }

    public List<ConfigurationFileAttributeGroups> getConfigurationFileAttributeGroups() {
        return configurationFileAttributeGroups;
    }

    public void setConfigurationFileAttributeGroups(List<ConfigurationFileAttributeGroups> configurationFileAttributeGroups) {
        this.configurationFileAttributeGroups = configurationFileAttributeGroups;
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
        if (!(object instanceof ConfigurationFiles)) {
            return false;
        }
        ConfigurationFiles other = (ConfigurationFiles) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.fich.wafproject.model.ConfigurationFiles[ id=" + id + " ]";
    }
    
}
