package com.fich.wafproject.controller;

import com.mysql.jdbc.Connection;
import com.fich.wafproject.model.Event;
import com.fich.wafproject.model.EventRule;
import com.fich.wafproject.model.File;
import com.fich.wafproject.model.Rule;
import com.fich.wafproject.service.EventService;
import com.fich.wafproject.service.EventRuleService;
import com.fich.wafproject.service.FileService;
import com.fich.wafproject.service.RuleService;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import org.hibernate.exception.ConstraintViolationException;
import org.hibernate.exception.JDBCConnectionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/")
public class EventsLogController {
    
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
        jasperReport= (JasperReport) JRLoader.loadObject("/home/martin/NetBeansProjects/ModSecurityProyect/modsecurityWafProject/src/main/java/jasperReport/GraphReport.jasper");
        
        byte[] fichero = JasperRunManager.runReportToPdf("/home/martin/NetBeansProjects/ModSecurityProyect/modsecurityWafProject/src/main/java/jasperReport/GraphReport.jasper", parameters, conexion);
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType("application/pdf"));
        String filename = "output.pdf";
        headers.add("Content-disposition", "inline; filename=" + filename + ".pdf");
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
        ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(fichero, headers, HttpStatus.OK);
        System.out.println("RESPONSE ENTITY: " + response.getHeaders());
        return response;
    }
    
//********************************************  PARSER  ********************************//
    @Autowired
    EventService eventService;
    @Autowired
    FileService fileService;
    @Autowired
    RuleService ruleService;
    @Autowired
    EventRuleService eventRuleService;
    
    @RequestMapping(value = "/put", method = RequestMethod.PUT)
    public String sayHelloAgainPut(HttpServletRequest request,
            ModelMap model,
            Event event,
            EventRule eventRule,
            Rule rule,
            File file) {

        System.out.println("ENTRO AL PUUUUUUUUUUUUUUT: " + new Date().toString());

        try {

//            PrintWriter writer = new PrintWriter("/home/martin/Desktop/salidaJava.txt", "UTF-8");
            //Tomo las cabeceras
//            writer.println("Nombre y valores de los headers\n");
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

//                    buffer.append(line);
//                    writer.println(line);
                } else {
//                    buffer.append(line);
//                    writer.println(line);
                }

            }

//            writer.println("\n Aca abajo viene las partes separadas.\n");
//            for (int i = 0; i < parts.length; i++) {
//                System.out.println("Parte " + partsLetter[i]);
//                System.out.println(parts[i]);
//                writer.println("\nParte " + partsLetter[i] + "\n");
//                writer.println(parts[i]);
//            }
//            String data = buffer.toString();
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

            HashMap<String, String> MapPartA = this.analizerPartA(parts[0]);
            HashMap<String, String> MapPartB = this.analizerPartB(parts[1]);
            HashMap<String, List<String>> MapPartH = this.analizerPartH(parts[7]);

            event.setDateEvent(MapPartA.get("date"));
            event.setTransactionId(MapPartA.get("transactionId"));
            event.setClientIp(MapPartA.get("clientIp"));
            event.setClientPort(MapPartA.get("clientPort"));
            event.setServerIp(MapPartA.get("serverIp"));
            event.setServerPort(MapPartA.get("serverPort"));

            event.setMethod(MapPartB.get("method"));
            event.setMethod(MapPartB.get("destinationPage"));
            event.setMethod(MapPartB.get("protocol"));

            System.out.println("ANTES DE GUARDAR EL EVENTO ID: " + event.getId());
            try {
                eventService.saveEvent(event);
            } catch (ConstraintViolationException ese) {
                System.out.println("ERROR CONSTRAINT: " + ese.getMessage());
            } catch (JDBCConnectionException ese) {
                System.out.println("ERROR CONNECTION: " + ese.getMessage());
            }
            System.out.println("DESPUES DE GUARDAR EL EVENTO ID: " + event.getId());
            int cant = MapPartH.get("filePath").size();//cant de reglas act. filePath esta siempre presente.
            
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
                Rule ruleExists = ruleService.findByRuleId(ruleId);
                if (ruleExists == null) {
                    rule.setFileId(file);
                    rule.setRuleId(MapPartH.get("id").get(i));
                    rule.setMessage(MapPartH.get("msg").get(i));
                    rule.setSeverity(MapPartH.get("severity").get(i));
                    ruleService.saveRule(rule);
                }else{
                    rule = ruleExists;
                }
                
                eventRule.setTransactionId(event);
                eventRule.setRuleId(rule);
                eventRuleService.saveEventRule(eventRule);

                System.out.println("LISTO GUARDO BIEN");

                //LIMPIO LAS VARIABLES
                file.setFilePath("");
                file.setFileName("");
                rule.setRuleId("");
                rule.setMessage("");
                rule.setSeverity("");
                rule.setFileId(file);
                eventRule.setRuleId(rule);
                eventRule.setId(null);
            }

            System.out.println("TERMINO DE GUARDAR TODOOOOOOO");

//            writer.close();
        } catch (IOException e) {
            System.out.println("¡¡¡¡¡¡¡  NO SE PUDO ESCRIBIR  !!!!");
        }
        return "welcome";
    }

    private HashMap<String, String> analizerPartA(String str) {
        HashMap<String, String> result = new HashMap<String, String>();

        str = str.substring(str.indexOf("\n") + 1); //Recorto el divisor de la parte.

        //Guardo la fecha y recorto el string.
        int indx = str.indexOf(']');
        result.put("date", str.substring(1, indx));
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

    @RequestMapping(value = "/eventList/{pageNumber}", method = RequestMethod.GET)
    public String EventList(@PathVariable int pageNumber, ModelMap model) {
        if(pageNumber<1){
            pageNumber=1;
        }
        List<Event> events = eventService.findAllEvents(pageNumber);
        if(events.size() == 0){
            pageNumber = pageNumber-1;
            events = eventService.findAllEvents(pageNumber);
        }
        model.addAttribute("lst",events);
        model.addAttribute("pageNumber",pageNumber);
        model.addAttribute("idModal", "eventModal");
        return "eventsList";
    }
    
     @RequestMapping(value = "/eventList/eventDetailsForm", method = RequestMethod.GET)
    public String getAddUserForm(ModelMap model, @RequestParam("transactionId") String transactionId) {
        System.out.println("ENTRO A DETAILS FORM: " + transactionId);
        model.addAttribute("idModal", "eventModal");
//        Users user = new Users();
//        List<UserStates> userStates = userStatesService.findAll();
//        String actionMessage = "";
//        if (id != -1){
//            user = userService.findById(id);
//            model.addAttribute("messageType", "User "+user.getUserName()+" wass succefully updated.");
//            actionMessage = "--- Editing User Form: "+user.getUserName();
//        }else{
//            actionMessage = "--- Creating User Form";
//        }
//        if(flagDebug) System.out.println(actionMessage);
//        model.addAttribute("user", user);
//        model.addAttribute("userStates", userStates);
//        model.addAttribute("action","saveNewUser");
        return "eventDetailsForm";
    }
    
}
