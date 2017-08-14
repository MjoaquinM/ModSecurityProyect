/*
 * Historia Clinica Digital Laboral
 * @author Martin Cardoso
 */
package com.fich.wafproject.model;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
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
 * @author Martin Cardoso
 */
@Entity
@Table(name = "Rules")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Rules.findAll", query = "SELECT r FROM Rules r")
    , @NamedQuery(name = "Rules.findByRuleId", query = "SELECT r FROM Rules r WHERE r.ruleId = :ruleId")
    , @NamedQuery(name = "Rules.findByMessage", query = "SELECT r FROM Rules r WHERE r.message = :message")
    , @NamedQuery(name = "Rules.findBySeverity", query = "SELECT r FROM Rules r WHERE r.severity = :severity")})
public class Rules implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
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
    @OneToMany(mappedBy = "ruleId")
    private List<EventsRules> eventsRulesList;
    @JoinColumn(name = "file", referencedColumnName = "filePath")
    @ManyToOne(optional = false)
    private Files file;

    public Rules() {
    }

    public Rules(String ruleId) {
        this.ruleId = ruleId;
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
    public List<EventsRules> getEventsRulesList() {
        return eventsRulesList;
    }

    public void setEventsRulesList(List<EventsRules> eventsRulesList) {
        this.eventsRulesList = eventsRulesList;
    }

    public Files getFile() {
        return file;
    }

    public void setFile(Files file) {
        this.file = file;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (ruleId != null ? ruleId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Rules)) {
            return false;
        }
        Rules other = (Rules) object;
        if ((this.ruleId == null && other.ruleId != null) || (this.ruleId != null && !this.ruleId.equals(other.ruleId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.websystique.springmvc.model.Rules[ ruleId=" + ruleId + " ]";
    }
    
}
