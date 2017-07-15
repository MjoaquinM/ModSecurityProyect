/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.model;

import com.fich.wafproject.model.*;
import com.fich.wafproject.model.User;
import com.fich.wafproject.model.UserProfile;
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

/**
 *
 * @author r3ng0
 */
@Entity
@Table(name = "USERS_USER_PROFILES", catalog = "waf_project", schema = "")
@NamedQueries({
    @NamedQuery(name = "UsersUserProfiles.findAll", query = "SELECT u FROM UsersUserProfiles u")
    , @NamedQuery(name = "UsersUserProfiles.findById", query = "SELECT u FROM UsersUserProfiles u WHERE u.id = :id")})
public class UsersUserProfiles implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private User userId;
    @JoinColumn(name = "user_profile_id", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private UserProfile userProfileId;

    public UsersUserProfiles() {
    }

    public UsersUserProfiles(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public UserProfile getUserProfileId() {
        return userProfileId;
    }

    public void setUserProfileId(UserProfile userProfileId) {
        this.userProfileId = userProfileId;
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
        if (!(object instanceof UsersUserProfiles)) {
            return false;
        }
        UsersUserProfiles other = (UsersUserProfiles) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.fich.wafproject.model.UsersUserProfiles[ id=" + id + " ]";
    }
    
}
