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
@Table(name = "CONFIGURATION_FILES_ATTRIBUTES", catalog = "waf_project", schema = "")
@NamedQueries({
    @NamedQuery(name = "ConfigurationFilesAttributes.findAll", query = "SELECT c FROM ConfigurationFilesAttributes c")
    , @NamedQuery(name = "ConfigurationFilesAttributes.findById", query = "SELECT c FROM ConfigurationFilesAttributes c WHERE c.id = :id")
    , @NamedQuery(name = "ConfigurationFilesAttributes.findByName", query = "SELECT c FROM ConfigurationFilesAttributes c WHERE c.name = :name")
    , @NamedQuery(name = "ConfigurationFilesAttributes.findByDescription", query = "SELECT c FROM ConfigurationFilesAttributes c WHERE c.description = :description")
    , @NamedQuery(name = "ConfigurationFilesAttributes.findByConfigurationFileAttributeTypeId", query = "SELECT c FROM ConfigurationFilesAttributes c WHERE c.configurationFileAttributeType = :configurationFileAttributeType")})
public class ConfigurationFilesAttributes implements Serializable {

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
    @Size(max = 100)
    @Column(name = "value")
    private String value;
    @Size(max = 2000)
    @Column(name = "description")
    private String description;
    
    @JoinColumn(name = "configuration_file_attribute_type_id", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private ConfigurationFileAttributeType configurationFileAttributeType;
    
    @JoinColumn(name = "configuration_file_attribute_groups_id", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private ConfigurationFileAttributeGroups configurationFileAttributeGroups;
    
    @JoinColumn(name = "configuration_file_attribute_states_id", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private ConfigurationFileAttributeStates configurationFileAttributeStates;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "configurationFilesAttributes", fetch = FetchType.EAGER)
    private List<ConfigurationFileAttributeOptions> configurationFileAttributeOptions;

    public ConfigurationFilesAttributes() {
    }

    public ConfigurationFilesAttributes(Long id) {
        this.id = id;
    }

    public ConfigurationFilesAttributes(Long id, String name, ConfigurationFileAttributeType configurationFileAttributeType) {
        this.id = id;
        this.name = name;
        this.configurationFileAttributeType = configurationFileAttributeType;
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

    public ConfigurationFileAttributeType getConfigurationFileAttributeType() {
        return configurationFileAttributeType;
    }

    public void setConfigurationFileAttributeType(ConfigurationFileAttributeType configurationFileAttributeType) {
        this.configurationFileAttributeType = configurationFileAttributeType;
    }

    public ConfigurationFileAttributeGroups getConfigurationFileAttributeGroups() {
        return configurationFileAttributeGroups;
    }

    public void setConfigurationFileAttributeGroups(ConfigurationFileAttributeGroups configurationFileAttributeGroups) {
        this.configurationFileAttributeGroups = configurationFileAttributeGroups;
    }

    public ConfigurationFileAttributeStates getConfigurationFileAttributeStates() {
        return configurationFileAttributeStates;
    }

    public void setConfigurationFileAttributeStates(ConfigurationFileAttributeStates configurationFileAttributeStates) {
        this.configurationFileAttributeStates = configurationFileAttributeStates;
    }

    public List<ConfigurationFileAttributeOptions> getConfigurationFileAttributeOptions() {
        return configurationFileAttributeOptions;
    }

    public void setConfigurationFileAttributeOptions(List<ConfigurationFileAttributeOptions> configurationFileAttributeOptions) {
        this.configurationFileAttributeOptions = configurationFileAttributeOptions;
    }
    
    public void setValue(String value){
        this.value = value;
    }
    
    public String getValue(){
        return value;
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
        if (!(object instanceof ConfigurationFilesAttributes)) {
            return false;
        }
        ConfigurationFilesAttributes other = (ConfigurationFilesAttributes) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.fich.wafproject.model.ConfigurationFilesAttributes[ id=" + id + " ]";
    }
    
}
