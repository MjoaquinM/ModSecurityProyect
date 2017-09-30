/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fich.wafproject.model;

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author martin
 */
@Entity
@Table(name = "Event")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Event.findAll", query = "SELECT e FROM Event e")
    , @NamedQuery(name = "Event.findById", query = "SELECT e FROM Event e WHERE e.id = :id")
    , @NamedQuery(name = "Event.findByDateEvent", query = "SELECT e FROM Event e WHERE e.dateEvent = :dateEvent")
    , @NamedQuery(name = "Event.findByTransactionId", query = "SELECT e FROM Event e WHERE e.transactionId = :transactionId")
    , @NamedQuery(name = "Event.findByClientIp", query = "SELECT e FROM Event e WHERE e.clientIp = :clientIp")
    , @NamedQuery(name = "Event.findByClientPort", query = "SELECT e FROM Event e WHERE e.clientPort = :clientPort")
    , @NamedQuery(name = "Event.findByServerIp", query = "SELECT e FROM Event e WHERE e.serverIp = :serverIp")
    , @NamedQuery(name = "Event.findByServerPort", query = "SELECT e FROM Event e WHERE e.serverPort = :serverPort")
    , @NamedQuery(name = "Event.findByMethod", query = "SELECT e FROM Event e WHERE e.method = :method")
    , @NamedQuery(name = "Event.findByProtocol", query = "SELECT e FROM Event e WHERE e.protocol = :protocol")})
public class Event implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 2147483647)
    @Column(name = "PartA")
    private String partA;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "PartB")
    private String partB;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "PartC")
    private String partC;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "PartD")
    private String partD;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "PartE")
    private String partE;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "PartF")
    private String partF;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "PartG")
    private String partG;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "PartH")
    private String partH;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "PartI")
    private String partI;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "PartJ")
    private String partJ;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "PartK")
    private String partK;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 2147483647)
    @Column(name = "PartZ")
    private String partZ;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateEvent")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateEvent;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "transactionId")
    private String transactionId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "clientIp")
    private String clientIp;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "clientPort")
    private String clientPort;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "serverIp")
    private String serverIp;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "serverPort")
    private String serverPort;
    @Size(max = 255)
    @Column(name = "method")
    private String method;
    @Lob
    @Size(max = 16777215)
    @Column(name = "destinationPage")
    private String destinationPage;
    @Size(max = 255)
    @Column(name = "protocol")
    private String protocol;
       
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "EventRule",
             joinColumns = { @JoinColumn(name = "eventId") },
             inverseJoinColumns = { @JoinColumn(name = "ruleId") })
    private List<Rule> rules;
    
    @Column(name = "is_new")
    private String isNew;
    
    public Event() {
    }

    public Event(Integer id) {
        this.id = id;
    }

    public Event(Integer id, String partA, String partZ, Date dateEvent, String transactionId, String clientIp, String clientPort, String serverIp, String serverPort) {
        this.id = id;
        this.partA = partA;
        this.partZ = partZ;
        this.dateEvent = dateEvent;
        this.transactionId = transactionId;
        this.clientIp = clientIp;
        this.clientPort = clientPort;
        this.serverIp = serverIp;
        this.serverPort = serverPort;
    }
    
    public String getIsNew() {
        return this.isNew;
    }
    public void setIsNew(String isNew) {
        this.isNew = isNew;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPartA() {
        return partA;
    }

    public void setPartA(String partA) {
        this.partA = partA;
    }

    public String getPartB() {
        return partB;
    }

    public void setPartB(String partB) {
        this.partB = partB;
    }

    public String getPartC() {
        return partC;
    }

    public void setPartC(String partC) {
        this.partC = partC;
    }

    public String getPartD() {
        return partD;
    }

    public void setPartD(String partD) {
        this.partD = partD;
    }

    public String getPartE() {
        return partE;
    }

    public void setPartE(String partE) {
        this.partE = partE;
    }

    public String getPartF() {
        return partF;
    }

    public void setPartF(String partF) {
        this.partF = partF;
    }

    public String getPartG() {
        return partG;
    }

    public void setPartG(String partG) {
        this.partG = partG;
    }

    public String getPartH() {
        return partH;
    }

    public void setPartH(String partH) {
        this.partH = partH;
    }

    public String getPartI() {
        return partI;
    }

    public void setPartI(String partI) {
        this.partI = partI;
    }

    public String getPartJ() {
        return partJ;
    }

    public void setPartJ(String partJ) {
        this.partJ = partJ;
    }

    public String getPartK() {
        return partK;
    }

    public void setPartK(String partK) {
        this.partK = partK;
    }

    public String getPartZ() {
        return partZ;
    }

    public void setPartZ(String partZ) {
        this.partZ = partZ;
    }

    public Date getDateEvent() {
        return dateEvent;
    }

    public void setDateEvent(Date dateEvent) {
        this.dateEvent = dateEvent;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getClientIp() {
        return clientIp;
    }

    public void setClientIp(String clientIp) {
        this.clientIp = clientIp;
    }

    public String getClientPort() {
        return clientPort;
    }

    public void setClientPort(String clientPort) {
        this.clientPort = clientPort;
    }

    public String getServerIp() {
        return serverIp;
    }

    public void setServerIp(String serverIp) {
        this.serverIp = serverIp;
    }

    public String getServerPort() {
        return serverPort;
    }

    public void setServerPort(String serverPort) {
        this.serverPort = serverPort;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getDestinationPage() {
        return destinationPage;
    }

    public void setDestinationPage(String destinationPage) {
        this.destinationPage = destinationPage;
    }

    public String getProtocol() {
        return protocol;
    }

    public void setProtocol(String protocol) {
        this.protocol = protocol;
    }

    public List<Rule> getEventRuleList() {
        return rules;
    }

    public void setEventRuleList(List<Rule> rules) {
        this.rules = rules;
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
        if (!(object instanceof Event)) {
            return false;
        }
        Event other = (Event) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.websystique.springmvc.model.Event[ id=" + id + " ]";
    }
    
}
