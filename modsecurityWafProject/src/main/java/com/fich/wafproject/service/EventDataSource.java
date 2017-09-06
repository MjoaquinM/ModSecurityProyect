package com.fich.wafproject.service;

import com.fich.wafproject.model.Event;
import com.fich.wafproject.service.EventService;
import java.util.ArrayList;
import java.util.List;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRAbstractBeanDataSourceProvider;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.springframework.beans.factory.annotation.Autowired;

public class EventDataSource extends JRAbstractBeanDataSourceProvider {

    @Autowired
    EventService eventService;

    private List<Event> listEvent;

    public EventDataSource() {
        super(Event.class);
    }

    @Override
    public JRDataSource create(JasperReport jr) throws JRException {
        listEvent = eventService.findAllEvents(0);
        return new JRBeanCollectionDataSource(listEvent);
    }

    @Override
    public void dispose(JRDataSource jrds) throws JRException {
        listEvent.clear();
        listEvent = null;
    }

}
