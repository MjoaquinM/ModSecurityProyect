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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name = "USER_PROFILES", catalog = "waf_project", schema = "")
@NamedQueries({
    @NamedQuery(name = "UserProfiles.findAll", query = "SELECT u FROM UserProfiles u")
    , @NamedQuery(name = "UserProfiles.findById", query = "SELECT u FROM UserProfiles u WHERE u.id = :id")
    , @NamedQuery(name = "UserProfiles.findByType", query = "SELECT u FROM UserProfiles u WHERE u.type = :type")})
public class UserProfiles implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "type")
    private String type;

    public UserProfiles() {
    }

    public UserProfiles(Long id) {
        this.id = id;
    }

    public UserProfiles(Long id, String type) {
        this.id = id;
        this.type = type;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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
        if (!(object instanceof UserProfiles)) {
            return false;
        }
        UserProfiles other = (UserProfiles) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.fich.wafproject.model.UserProfiles[ id=" + id + " ]";
    }
    
}
