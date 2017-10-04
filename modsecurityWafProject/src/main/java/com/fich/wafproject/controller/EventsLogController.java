package com.fich.wafproject.controller;

import com.fich.wafproject.dao.UserHistoryDaoImpl;
import com.fich.wafproject.model.ConfigurationFiles;
import com.mysql.jdbc.Connection;
import com.fich.wafproject.model.Event;
import com.fich.wafproject.model.File;
import com.fich.wafproject.model.Item;
import com.fich.wafproject.model.JasperCharts;
import com.fich.wafproject.model.Rule;
import com.fich.wafproject.service.ConfigurationFileService;
import com.fich.wafproject.service.EventService;
import com.fich.wafproject.service.FileService;
import com.fich.wafproject.service.RuleService;
import com.fich.wafproject.util.MessageData;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import java.util.logging.Level;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRDataSource;;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import org.hibernate.exception.ConstraintViolationException;
import org.hibernate.exception.JDBCConnectionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
/* PARA SSE */
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyEmitter;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
/* PARA TAREAS PLANIFICADAS */
import org.springframework.scheduling.annotation.Scheduled;


@Controller
@RequestMapping("/")
public class EventsLogController{
     
    @Autowired
    EventService eventService;
    @Autowired
    FileService fileService;
    @Autowired
    RuleService ruleService;
    @Autowired
    ConfigurationFileService configurationFileService;
    
//    private static final AlertMessages PATH_PREFIX = new AlertMessages();
    private static List<MessageData> PATH_PREFIX = new ArrayList<MessageData>();// AlertMessages();
    
    @RequestMapping(value = "/jrreport", method = RequestMethod.GET)
    public ResponseEntity<byte[]> printWelcome(ModelMap model) throws JRException, FileNotFoundException {
        
        System.out.println("ENTRO AL REPORT");
        
        //Tomo la lista de eventos
        List<Event> events = eventService.findAllEvents();
        for (Event e : events){
            System.out.println("EVENT: " + e.getTransactionId());
        }
        System.out.println("ACA ARRIBA TIENE Q ESTA LA LISTA DE EVENTOS");
        //Tomo la lista de Rules
        List<Rule> rules = ruleService.findAllRules();
        
        Map<Rule, Number> atackVsAmount = new HashMap<>();
        
        //INICIALIZAR EL MAP CON TODAS LAS REGLAS, Y EL NUMBER EN 0. NO AGREGAR LA 980 Y LA 949.
        
        //DSP IR RECORRRIENDO LA LISTA DE EVENTOS Y TOMANDO LA LISTA DE REGLAS PARA CADA UNO.
        
        //+1 PARA EL VALOR DE LA REGLA EN EL MAP (YA ESTAN TODAS AGREGADAS). VERIFICAR NO AGREGAR LAS EXCLUIDAS
        
        for (Rule r : rules){
            if (!("949".equals(r.getRuleId().substring(0, 3)) || "980".equals(r.getRuleId().substring(0, 3))))
                atackVsAmount.put(r, 0);
        }
        
        for (Event e : events){
            for (Rule ruleAux : e.getEventRuleList()){
                if (!("949".equals(ruleAux.getRuleId().substring(0, 3)) || "980".equals(ruleAux.getRuleId().substring(0, 3)))){
                    atackVsAmount.put(ruleAux, atackVsAmount.get(ruleAux).intValue() + 1 );
                }
            }
        }

        System.out.println("SALIDA DEL MAPA: ");

        List<JasperCharts> listjc = new ArrayList<>();
        for (Map.Entry<Rule, Number> entry : atackVsAmount.entrySet()) {
            System.out.println("Item : " + entry.getKey() + " Count : " + entry.getValue());
            listjc.add(new JasperCharts(entry.getKey().getRuleId(),entry.getValue()));
        }
        
        JRDataSource jrDatasource = new JRBeanCollectionDataSource(listjc);
        
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("lista", listjc);
        
        for (Event e : events){
            System.out.println("EVENT: " + e.getTransactionId());
        }
        System.out.println("ACA ARRIBA TIENE Q ESTA LA LISTA DE EVENTOS");
        parameters.put("listaEvent", events);
        
        List<String> empleados = new ArrayList<>();
        empleados.add("martin");
        empleados.add("juana");
        empleados.add("pepe");
        empleados.add("maria");
        empleados.add("magali");
        
        List<String> emp2 = new ArrayList(Arrays.asList(new String[] {"String1","String2","String3","String4"}));
        
        parameters.put("empleados", empleados);
        
        JasperPrint jasperPrint = JasperFillManager.fillReport(
                "/home/martin/NetBeansProjects/ModSecurityProyect/modsecurityWafProject/src/main/java/jasperReport/newReport.jasper", 
                parameters, 
                jrDatasource);
        
//        model.addAttribute("datasource", jrDatasource);
//        model.addAttribute("format", "pdf");
        System.out.println("ENTRA AL JRREPORT. TODO BIEN");
        
//        //Guardo en el Home del usuario
//        String userHomeDirectory = System.getProperty("user.home");
//        /* Output file location */
//        String outputFile = userHomeDirectory + java.io.File.separatorChar + "JasperTableExample.pdf";
//        OutputStream outputStream = new FileOutputStream(new java.io.File(outputFile));
//        /* Write content to PDF file */
//        JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
//        
//        JasperDesign jd = JRXmlLoader.load("/home/martin/NetBeansProjects/ModSecurityProyect/modsecurityWafProject/src/main/java/jasperReport/BlankReport.jasper");
//        
//        JasperReport report = JasperCompileManager.compileReport(jd);
//        // Rellenamos el informe con la conexion creada y sus parametros establecidos
//        JasperPrint print = JasperFillManager.fillReport(report, parameters, jrDatasource);
//
//        // Exportamos el informe a formato PDF
//        JasperExportManager.exportReportToPdfFile(print, outputFile);
        
        
        byte[] fichero = JasperExportManager.exportReportToPdf(jasperPrint);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType("application/pdf"));
        String filename = "output.pdf";
        headers.add("Content-disposition", "inline; filename=" + filename + ".pdf");
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
        ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(fichero, headers, HttpStatus.OK);
        return response;
    }
    
    @RequestMapping(value = "/jasperEntitiesPDF", method = RequestMethod.GET)
    public ResponseEntity<byte[]> jasperEntitiesPDF(ModelMap model) throws ClassNotFoundException, InstantiationException, SQLException, JRException, IllegalAccessException, FileNotFoundException {
        System.out.println("ENTRO AL JASPER ENTITIES");
        /* User home directory location */
        String userHomeDirectory = System.getProperty("user.home");
        /* Output file location */
        String outputFile = userHomeDirectory + java.io.File.separatorChar + "JasperTableExample.pdf";

//        List<Event> lstEvent = eventService.findAllEvents(0);
        List<Event> lstEvent = new ArrayList<>();
        
        Event e = new Event();
        
        e.setTransactionId("SOY EL TXID");
        e.setClientIp("soy el client ip");
        
        lstEvent.add(e);

        List<Item> lstItem = new ArrayList<Item>();
        System.out.println("EVENT LIST: " + lstEvent);
        
        /* Create Items */
        Item iPhone = new Item();
        iPhone.setName("iPhone 6S");
        iPhone.setPrice(65000.00);

//        Item iPad = new Item();
//        iPad.setName("iPad Pro");
//        iPad.setPrice(70000.00);

        /* Add Items to List */
        lstItem.add(iPhone);
//        lstItem.add(iPad);

        System.out.println("ITEM LIST: " + lstItem);
        /* Convert List to JRBeanCollectionDataSource */
        JRBeanCollectionDataSource itemsJRBean = new JRBeanCollectionDataSource(lstItem);
        JRBeanCollectionDataSource eventsJRBean = new JRBeanCollectionDataSource(lstEvent);

        /* Map to hold Jasper report Parameters */
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("ItemDataSource", itemsJRBean);
        parameters.put("EventDataSource", eventsJRBean);

        /* Using compiled version(.jasper) of Jasper report to generate PDF */
        JasperPrint jasperPrint = JasperFillManager.fillReport("/home/martin/NetBeansProjects/ModSecurityProyect/modsecurityWafProject/src/main/java/jasperReport/BlankReport.jasper", parameters, new JREmptyDataSource());
        
        //Guardo en el Home del usuario
        OutputStream outputStream = new FileOutputStream(new java.io.File(outputFile));
        /* Write content to PDF file */
        JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
        
        JasperDesign jd = JRXmlLoader.load("/home/martin/NetBeansProjects/ModSecurityProyect/modsecurityWafProject/src/main/java/jasperReport/BlankReport.jasper");
        
        JasperReport report = JasperCompileManager.compileReport(jd);
        // Rellenamos el informe con la conexion creada y sus parametros establecidos
        JasperPrint print = JasperFillManager.fillReport(report, parameters, eventsJRBean);

        // Exportamos el informe a formato PDF
        JasperExportManager.exportReportToPdfFile(print, outputFile);

        
        
        
        byte[] fichero = JasperExportManager.exportReportToPdf(jasperPrint);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType("application/pdf"));
        String filename = "output.pdf";
        headers.add("Content-disposition", "inline; filename=" + filename + ".pdf");
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
        ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(fichero, headers, HttpStatus.OK);
        return response;
    }
    
    @RequestMapping(value = "/jasperDownloadPDF", method = RequestMethod.GET)
    public ResponseEntity<byte[]> jasperDownloadPDF(ModelMap model) throws ClassNotFoundException, InstantiationException, SQLException, JRException, IllegalAccessException {
        
        Connection conexion;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        conexion = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/waf_project", "root", "mcardoso27"); 
        Map parameters = new HashMap();
        //A nuestro informe de prueba le vamos a enviar la fecha de hoy
        parameters.put("fechainicio", new Date());
        
        JasperReport jasperReport;
        jasperReport= (JasperReport) JRLoader.loadObject("/home/martin/NetBeansProjects/ModSecurityProyect/modsecurityWafProject/src/main/java/jasperReport/report1.jasper");
        
        byte[] fichero = JasperRunManager.runReportToPdf("/home/martin/NetBeansProjects/ModSecurityProyect/modsecurityWafProject/src/main/java/jasperReport/report1.jasper", parameters, conexion);
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType("application/pdf"));
        String filename = "output.pdf";
        headers.setContentDispositionFormData(filename, filename);
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
        ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(fichero, headers, HttpStatus.OK);
        return response;
        
    }
    
    @RequestMapping(value = "/jasperInlinePDF", method = RequestMethod.GET)
    public ResponseEntity<byte[]> jasperInlinePDF(ModelMap model) throws ClassNotFoundException, InstantiationException, SQLException, JRException, IllegalAccessException {
        System.out.println("ENTRO AL JASPER INLINE");        
    
        Connection conexion;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        conexion = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/waf_project", "root", "mcardoso27");

        Map parameters = new HashMap();
        //A nuestro informe de prueba le vamos a enviar la fecha de hoy
        parameters.put("fechainicio", new Date());
        
        JasperReport jasperReport;
        jasperReport= (JasperReport) JRLoader.loadObject("/home/martin/NetBeansProjects/ModSecurityProyect/modsecurityWafProject/src/main/java/jasperReport/report1.jasper");
        
        byte[] fichero = JasperRunManager.runReportToPdf("/home/martin/NetBeansProjects/ModSecurityProyect/modsecurityWafProject/src/main/java/jasperReport/report1.jasper", parameters, conexion);
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType("application/pdf"));
        String filename = "output.pdf";
        headers.add("Content-disposition", "inline; filename=" + filename + ".pdf");
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
        ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(fichero, headers, HttpStatus.OK);
        return response;
    }
    
//********************************************  PARSER  ********************************//
    
    /*-------------------------- PARA LOS ALERTAS --------------------------*/
    @MessageMapping("/alertMessages")
    @SendTo("/topic/messages")
      public List<MessageData> borraresto() throws Exception{
        List<MessageData> currentAlerts = new ArrayList<MessageData>();
        for(MessageData md : PATH_PREFIX){
            currentAlerts.add(md);
        }
        PATH_PREFIX.clear();
        return currentAlerts;
    }
    /*-------------------------- PARA LOS ALERTAS END!!!!!!!!!!!!!!!!!!!!!!--------------------------*/

    @RequestMapping(value = "/put", method = RequestMethod.PUT)
    public void sayHelloAgainPut(HttpServletRequest request,
            ModelMap model,
            Event event,
            File file,
            HttpServletResponse response) throws IOException, Exception{
                
        System.out.println("ENTRO AL PUUUUUUUUUUUUUUT: " + new Date().toString());
        
        try {
            
            //Tomo las cabeceras
            Enumeration<String> e = request.getHeaderNames();
            while (e.hasMoreElements()) {
                String headerName = e.nextElement();
                String headerValue = request.getHeader(headerName);
//                writer.println(headerName + ": " + headerValue + "\n");
            }

            //Tomo el payload
            StringBuilder buffer = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
//            writer.println("PAYLOAD\n");

            String partsLetter[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "Z"};
            //Si estan activas todas las partes son 12:ABCDEFGHIJKZ 
            String parts[] = new String[12];
            int indx = -1;

            while ((line = reader.readLine()) != null) {

                if (!line.isEmpty()) {
                    //Si es una cabecera
                    if ("--".equals(line.substring(0, 2)) && "-".equals(line.substring(10, 11))
                            && "--".equals(line.substring(12, line.length()))) {
                        indx = Arrays.asList(partsLetter).indexOf(line.substring(11, 12));
                        System.out.println("Index vale: " + indx);
                        if (indx == -1) {
                            System.out.println("FORMATO NO VALIDO");
                            break;
                        }
                        parts[indx] = line + "\n";
                    } else {
                        parts[indx] = parts[indx] + line + "\n";
                    }

                }

            }

            event.setPartA(parts[0]);
            event.setPartB(parts[1]);
            event.setPartC(parts[2]);
            event.setPartD(parts[3]);
            event.setPartE(parts[4]);
            event.setPartF(parts[5]);
            event.setPartG(parts[6]);
            event.setPartH(parts[7]);
            event.setPartI(parts[8]);
            event.setPartJ(parts[9]);
            event.setPartK(parts[10]);
            event.setPartZ(parts[11]);

//            HashMap<String, String> MapPartA = this.analizerPartA(parts[0]);
            HashMap<String, Object> MapPartA = this.analizerPartA(parts[0]);
            HashMap<String, String> MapPartB = this.analizerPartB(parts[1]);
            HashMap<String, List<String>> MapPartH = this.analizerPartH(parts[7]);
            
            event.setDateEvent((Date) MapPartA.get("date"));
            event.setTransactionId((String) MapPartA.get("transactionId"));
            event.setClientIp((String)MapPartA.get("clientIp"));
            event.setClientPort((String) MapPartA.get("clientPort"));
            event.setServerIp((String) MapPartA.get("serverIp"));
            event.setServerPort((String) MapPartA.get("serverPort"));

            event.setMethod(MapPartB.get("method"));
            event.setDestinationPage(MapPartB.get("destinationPage"));
            event.setProtocol(MapPartB.get("protocol"));
            event.setIsNew("0");

            try {
                eventService.saveEvent(event);
                MessageData md = new MessageData();
                md.setTransactionId(event.getTransactionId());
                for(MessageData mdd : PATH_PREFIX){
                    System.out.println("Transaction id: " + mdd.getTransactionId());
                }
                PATH_PREFIX.add(md);
//                md.setClassAttack(event.getEventRuleList().get(0).getFileId().getFileName());
                //Unicamente muestro la alerta si se guardo exitosamente el evento
//                PATH_PREFIX.setMessages(mdl);
                System.out.println("MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA MIRA ");
                for(MessageData mdd : PATH_PREFIX){
                    System.out.println("Transaction id: " + mdd.getTransactionId());
                }
                
            } catch (ConstraintViolationException ese) {
                System.out.println("ERROR CONSTRAINT: " + ese.getMessage());
            } catch (JDBCConnectionException ese) {
                System.out.println("ERROR CONNECTION: " + ese.getMessage());
            }
            int cant = MapPartH.get("filePath").size();//cant de reglas act. filePath esta siempre presente. 
            
            List<Rule> rules = new ArrayList<Rule>();
            
            for (int i = 0; i < cant; i++) {
                System.out.println("Vuelta Nrooooooooooooooooooooooooooooooooooooooooooooooooooo: " + i);

                String filePath = MapPartH.get("filePath").get(i);
                File fileExists = fileService.findByFilePath(filePath);
                if ( fileExists == null ) {
                    file.setFilePath(MapPartH.get("filePath").get(i));
                    file.setFileName(MapPartH.get("fileName").get(i));
                    fileService.saveFile(file);
                }else{
                    file = fileExists;
                }
                
                String ruleId = MapPartH.get("id").get(i);
                System.out.println("VA A BUSCAR POR EL RULEID: " + ruleId);
                Rule ruleExists = ruleService.findByRuleId(ruleId);
                System.out.println("RuleExists? " + ruleExists == null);
                Rule rule = new Rule();
                if (ruleExists == null) {
                    rule.setFileId(file);
                    rule.setRuleId(MapPartH.get("id").get(i));
                    rule.setMessage(MapPartH.get("msg").get(i));
                    rule.setSeverity(MapPartH.get("severity").get(i));
                    System.out.println("BEFORE EXPLOTION");
                    System.out.println("Id: " + rule.getId());
                    System.out.println("ruleId: " + rule.getRuleId());
                    System.out.println(rule.getId());
                    ruleService.saveRule(rule);
                }else{
                    rule = ruleExists;
                }
                rules.add(rule);
                System.out.println("LISTO GUARDO BIEN");
            }
            
            //Asocio El evento con el conjunto de reglas corerspondientes
            event.setEventRuleList(rules);
            try {
                //Actualizo relaciones
                eventService.saveEvent(event);
            } catch (ConstraintViolationException ese) {
                System.out.println("ERROR CONSTRAINT: " + ese.getMessage());
            } catch (JDBCConnectionException ese) {
                System.out.println("ERROR CONNECTION: " + ese.getMessage());
            }
            
            System.out.println("TERMINO DE GUARDAR TODOOOOOOO");
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Date date = new Date();
            System.out.println(dateFormat.format(date));

        } catch (IOException e) {
            System.out.println("¡¡¡¡¡¡¡  NO SE PUDO ESCRIBIR  !!!!");
        }        
        
    }
    
    private HashMap<String, Object> analizerPartA(String str) {
//        HashMap<String, String> result = new HashMap<String, String>();
        HashMap<String, Object> result = new HashMap<String, Object>();
        str = str.substring(str.indexOf("\n") + 1); //Recorto el divisor de la parte.

        //Guardo la fecha y recorto el string.
        int indx = str.indexOf(']');
        result.put("date", this.parseDate(str.substring(1, indx)));
        str = str.substring(indx + 2);
        
        //Ahora quedo el transactionId, clientIp, clientPort, serverIp, serverPort
        String[] info = str.split(" ");
        result.put("transactionId", info[0]);
        result.put("clientIp", info[1]);
        result.put("clientPort", info[2]);
        result.put("serverIp", info[3]);
        result.put("serverPort", info[4]);

        return result;
    }
    
    private Date parseDate(String dateString){
        String time = dateString.substring(dateString.indexOf(':')+1,dateString.indexOf(' '));
        String date = dateString.substring(0,dateString.indexOf(':'));
        String[] dateSplitted  = date.split("/");
        String month = "";
        switch(dateSplitted[1]) {
            case "Jan" :
               month = "01";
               break; 
            case "Feb" :
               month = "02";
               break; 
            case "Mar" :
               month = "03";
               break; 
            case "Apr" :
               month = "04";
               break; 
            case "May" :
               month = "05";
               break; 
            case "Jun" :
                month = "06";
                break;
            case "Jul" :
                month = "07";
                break;
            case "Aug" :
                month = "08";
                break; 
            case "Sep" :
               month = "09";
               break; 
            case "Oct" :
               month = "10";
               break; 
            case "Nov" :
               month = "11";
               break; 
            default :
               month = "12";
         }
        date = dateSplitted[2]+"-"+month+"-"+dateSplitted[0]+" "+time;
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
        Date currentDate = new Date();
        try {
            currentDate = format.parse(date);
        } catch (ParseException ex) {
            java.util.logging.Logger.getLogger(UserHistoryDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return currentDate;
    }

    private HashMap<String, String> analizerPartB(String str) {
        HashMap<String, String> result = new HashMap<String, String>();

        //Separo en lineas
        String[] info = str.split("\n");

        //De la primer linea guardo metodo y direcccion de destino 
        String[] current_info = info[1].split(" ");
        System.out.println("current_info: " + current_info);
        result.put("method", current_info[0]);
        result.put("destinationPage", current_info[1]);
        result.put("protocol", current_info[2]);

        return result;
    }

    private HashMap<String, List<String>> analizerPartH(String str) {
        HashMap<String, List<String>> result = new HashMap<String, List<String>>();

        //Separo en lineas
        String[] info = str.split("\n");

        List<String> filePath = new ArrayList<String>(),
                fileName = new ArrayList<String>(),
                id = new ArrayList<String>(),
                msg = new ArrayList<String>(),
                severity = new ArrayList<String>();

        String filePathAux,
                fileNameAux,
                idAux,
                msgAux,
                severityAux;

        for (int i = 1; i < info.length; i++) {
            //Verifico que la linea sea un message.
            if ("Message".equals(info[i].substring(0, 7))) {

                int beginFile = info[i].indexOf("[file ");
                if (beginFile > -1) {
                    filePathAux = info[i].substring(beginFile);
                    String aux = filePathAux.substring(7, filePathAux.indexOf("]") - 1);
                    filePath.add(aux);

                    //Tomo el fileName
                    StringBuilder sb = new StringBuilder(aux);
                    aux = sb.reverse().toString();
                    String auxRev = aux.substring(0, aux.indexOf("/"));
                    sb = new StringBuilder(auxRev);
                    fileNameAux = sb.reverse().toString();
                    fileNameAux = fileNameAux.substring(0, fileNameAux.indexOf("."));
                    fileName.add(fileNameAux);

                } else {
                    filePath.add("");
                }

                int beginId = info[i].indexOf("[id ");
                if (beginId > -1) {
                    idAux = info[i].substring(beginId);
                    id.add(idAux.substring(5, idAux.indexOf("]") - 1));
                } else {
                    id.add("");
                }

                int beginMsg = info[i].indexOf("[msg ");
                if (beginMsg > -1) {
                    msgAux = info[i].substring(beginMsg);
                    msg.add(msgAux.substring(6, msgAux.indexOf("]") - 1));
                } else {
                    msg.add("");
                }

                int beginSeverity = info[i].indexOf("[severity ");
                if (beginSeverity > -1) {
                    severityAux = info[i].substring(beginSeverity);
                    severity.add(severityAux.substring(11, severityAux.indexOf("]") - 1));
                } else {
                    severity.add("");
                }

            }
        }

        result.put("filePath", filePath);
        result.put("fileName", fileName);
        result.put("id", id);
        result.put("msg", msg);
        result.put("severity", severity);
        return result;
    }

    @RequestMapping(value = "/eventList", method = RequestMethod.GET)
    public String EventList(ModelMap model,HttpServletRequest request) {
        int pageNumber = 1;
        if(request.getParameterMap().containsKey("pageNumber")){
           pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }
        
        if(pageNumber<1){
            pageNumber=1;
        }
        
        List<Event> events = eventService.findAllEvents(pageNumber, request.getParameterValues("filter-parameters-targets"), request.getParameterValues("filter-parameters-names"),request.getParameterValues("filter-parameters-values"));
        if(events.size() == 0){
            pageNumber = pageNumber-1;
            events = eventService.findAllEvents(pageNumber, request.getParameterValues("filter-parameters-targets"), request.getParameterValues("filter-parameters-names"), request.getParameterValues("filter-parameters-values"));
        }
        
        String[] n1 = request.getParameterValues("filter-parameters-values");
        String[] n2 = request.getParameterValues("filter-parameters-labels");
        HashMap hm = new HashMap<String,String>();
        
        if(n1 != null){
            int count = 0;
            for(String val: n1){
                hm.put(n2[count], val);
                count++;
            }
        }
        
        List<ConfigurationFiles> configurationFilesAll = configurationFileService.findAll();
        
        model.addAttribute("hm",hm);
        model.addAttribute("configFiles",configurationFilesAll);
        model.addAttribute("lst",events);
        model.addAttribute("pageNumber",pageNumber);
        model.addAttribute("idModal", "eventModal");
        model.addAttribute("user",this.getPrincipal());
        return "eventsList";
    }
    
    @RequestMapping(value = "/eventList/eventDetailsForm", method = RequestMethod.GET)
    public String getAddUserForm(ModelMap model, @RequestParam("transactionId") String transactionId) {
        System.out.println("ENTRO A DETAILS FORM: " + transactionId);
        model.addAttribute("idModal", "eventModal");
        Event event = eventService.findByTransactionId(transactionId);
        List<Rule> rules = event.getEventRuleList();
        List<File> files = new ArrayList<>();
        for (Rule r : rules){
            files.add(r.getFileId());
        }
        
        model.addAttribute("event",event);
        model.addAttribute("rules",rules);
        model.addAttribute("files   ",files);
        return "eventDetailsForm";
    }
    
    @RequestMapping(value = "/deleteAllEvents", method = RequestMethod.GET)
    public String deleteAllEvents(ModelMap model, HttpServletRequest request) {
        
        if(request.getParameterMap().containsKey("event")){
           Integer eventId = Integer.parseInt(request.getParameter("event"));
           eventService.delete(eventId);
        }else{
            eventService.deleteAll();
        }
        
        String[] aux = {};
        request.setAttribute("filter-parameters-targets", aux);
        request.setAttribute("filter-parameters-names", aux);
        request.setAttribute("filter-parameters-values", aux);
        return this.EventList(model, request);
    }

    private String getPrincipal(){
        String userName = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (principal instanceof UserDetails) {
            userName = ((UserDetails)principal).getUsername();
        } else {
            userName = principal.toString();
        }
        return userName;
    }
}
