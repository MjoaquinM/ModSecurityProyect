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
import com.fich.wafproject.model.UsersUserProfiles;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
 
@Entity
@Table(name="USER_PROFILES")
public class UserProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private int id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "type")
    private String type;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "userProfileId", fetch = FetchType.LAZY)
    private List<UsersUserProfiles> usersUserProfilesList;
 
//    @Id @GeneratedValue(strategy=GenerationType.IDENTITY)
//    private int id; 
// 
//    @Column(name="TYPE", length=15, unique=true, nullable=false)
//    private String type = UserProfileType.USER.getUserProfileType();
     
    public int getId() {
        return id;
    }
 
    public void setId(int id) {
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
        final int prime = 31;
        int result = 1;
        result = prime * result + id;
        result = prime * result + ((type == null) ? 0 : type.hashCode());
        return result;
    }
 
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (!(obj instanceof UserProfile))
            return false;
        UserProfile other = (UserProfile) obj;
        if (id != other.id)
            return false;
        if (type == null) {
            if (other.type != null)
                return false;
        } else if (!type.equals(other.type))
            return false;
        return true;
    }
 
    @Override
    public String toString() {
        return "UserProfile [id=" + id + ",  type=" + type  + "]";
    }

    public UserProfile() {
    }

    public UserProfile(int id) {
        this.id = id;
    }

    public UserProfile(int id, String type) {
        this.id = id;
        this.type = type;
    }

    public List<UsersUserProfiles> getUsersUserProfilesList() {
        return usersUserProfilesList;
    }

    public void setUsersUserProfilesList(List<UsersUserProfiles> usersUserProfilesList) {
        this.usersUserProfilesList = usersUserProfilesList;
    } 
 
}