/*
 * Historia Clinica Digital Laboral
 * @author Martin Cardoso
 */
package com.fich.wafproject.model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Martin Cardoso
 */
@Entity
@Table(name = "EventsRules")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "EventsRules.findAll", query = "SELECT e FROM EventsRules e")
    , @NamedQuery(name = "EventsRules.findById", query = "SELECT e FROM EventsRules e WHERE e.id = :id")})
public class EventsRules implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @JoinColumn(name = "transactionId", referencedColumnName = "transactionId")
    @ManyToOne(optional = false)
    private Events transactionId;
    @JoinColumn(name = "ruleId", referencedColumnName = "ruleId")
    @ManyToOne(optional = false)
    private Rules ruleId;

    public EventsRules() {
    }

    public EventsRules(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Events getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(Events transactionId) {
        this.transactionId = transactionId;
    }

    public Rules getRuleId() {
        return ruleId;
    }

    public void setRuleId(Rules ruleId) {
        this.ruleId = ruleId;
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
        if (!(object instanceof EventsRules)) {
            return false;
        }
        EventsRules other = (EventsRules) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.websystique.springmvc.model.EventsRules[ id=" + id + " ]";
    }
    
}
