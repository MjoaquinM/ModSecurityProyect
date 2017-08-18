/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.model;

import java.io.Serializable;
import javax.persistence.Basic;
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
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author joaquin
 */
@Entity
@Table(name = "CONFIGURATION_FILE_ATTRIBUTE_OPTIONS", catalog = "waf_project", schema = "")
@NamedQueries({
    @NamedQuery(name = "ConfigurationFileAttributeOptions.findAll", query = "SELECT c FROM ConfigurationFileAttributeOptions c")
    , @NamedQuery(name = "ConfigurationFileAttributeOptions.findById", query = "SELECT c FROM ConfigurationFileAttributeOptions c WHERE c.id = :id")
    , @NamedQuery(name = "ConfigurationFileAttributeOptions.findByName", query = "SELECT c FROM ConfigurationFileAttributeOptions c WHERE c.name = :name")
    , @NamedQuery(name = "ConfigurationFileAttributeOptions.findByDescription", query = "SELECT c FROM ConfigurationFileAttributeOptions c WHERE c.description = :description")})
public class ConfigurationFileAttributeOptions implements Serializable {

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
    @Column(name = "description")
    private String description;
    @Basic(optional = false)
    @Column(name = "group_option")
    private Integer group;
    
    @JoinColumn(name = "configuration_files_attributes_id", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private ConfigurationFilesAttributes configurationFilesAttributes;
    
    public void setGroup(Integer group){
        this.group=group;
    }
    
    public Integer getGroup(){
        return this.group;
    }

    public ConfigurationFileAttributeOptions() {
    }

    public ConfigurationFileAttributeOptions(Long id) {
        this.id = id;
    }

    public ConfigurationFileAttributeOptions(Long id, String name) {
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

    public ConfigurationFilesAttributes getConfigurationFilesAttributes() {
        return configurationFilesAttributes;
    }

    public void setConfigurationFilesAttributes(ConfigurationFilesAttributes configurationFilesAttributes) {
        this.configurationFilesAttributes = configurationFilesAttributes;
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
        if (!(object instanceof ConfigurationFileAttributeOptions)) {
            return false;
        }
        ConfigurationFileAttributeOptions other = (ConfigurationFileAttributeOptions) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.fich.wafproject.model.ConfigurationFileAttributeOptions[ id=" + id + " ]";
    }
    
}
