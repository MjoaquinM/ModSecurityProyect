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
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author martin
 */
@Entity
@Table(name = "Rule")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Rule.findAll", query = "SELECT r FROM Rule r")
    , @NamedQuery(name = "Rule.findById", query = "SELECT r FROM Rule r WHERE r.id = :id")
    , @NamedQuery(name = "Rule.findByRuleId", query = "SELECT r FROM Rule r WHERE r.ruleId = :ruleId")
    , @NamedQuery(name = "Rule.findByMessage", query = "SELECT r FROM Rule r WHERE r.message = :message")
    , @NamedQuery(name = "Rule.findBySeverity", query = "SELECT r FROM Rule r WHERE r.severity = :severity")})
public class Rule implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "ruleId")
    private String ruleId;
    @Size(max = 255)
    @Column(name = "message")
    private String message;
    @Size(max = 45)
    @Column(name = "severity")
    private String severity;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "ruleId", fetch=FetchType.EAGER)
    private List<EventRule> eventRuleList;
    @JoinColumn(name = "fileId", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private File fileId;

    public Rule() {
    }

    public Rule(Integer id) {
        this.id = id;
    }

    public Rule(Integer id, String ruleId) {
        this.id = id;
        this.ruleId = ruleId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRuleId() {
        return ruleId;
    }

    public void setRuleId(String ruleId) {
        this.ruleId = ruleId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    @XmlTransient
    public List<EventRule> getEventRuleList() {
        return eventRuleList;
    }

    public void setEventRuleList(List<EventRule> eventRuleList) {
        this.eventRuleList = eventRuleList;
    }

    public File getFileId() {
        return fileId;
    }

    public void setFileId(File fileId) {
        this.fileId = fileId;
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
        if (!(object instanceof Rule)) {
            return false;
        }
        Rule other = (Rule) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.websystique.springmvc.model.Rule[ id=" + id + " ]";
    }
    
}
