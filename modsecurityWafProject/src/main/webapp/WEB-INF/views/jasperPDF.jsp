<%@ page import="com.mysql.jdbc.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Date" %>
<%@ page import="net.sf.jasperreports.engine.JRException" %>
<%@ page import="net.sf.jasperreports.engine.JasperReport" %>
<%@ page import="net.sf.jasperreports.engine.JasperRunManager" %>
<%@ page import="net.sf.jasperreports.engine.util.JRLoader" %>
<%@ page import="javax.servlet.ServletOutputStream" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%;
            
        Connection conexion;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        conexion = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Empleados", "root", "mcardoso27");

        Map parameters = new HashMap();
        //A nuestro informe de prueba le vamos a enviar la fecha de hoy
        parameters.put("fechainicio", new Date());
        
        JasperReport jasperReport;
        jasperReport= (JasperReport) JRLoader.loadObject("/home/martin/NetBeansProjects/ParserMSA/src/main/jasperreports/graficos.jasper");
        
        byte[] fichero = JasperRunManager.runReportToPdf("/home/martin/NetBeansProjects/ParserMSA/src/main/jasperreports/graficos.jasper", parameters, conexion);
        
        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "inline; filename=informeDemo.pdf");
        response.setHeader("Cache-Control", "max-age=30");
        response.setHeader("Pragma", "No-cache");
        response.setDateHeader("Expires", 0);
        response.setContentLength(fichero.length);
        
        ServletOutputStream outter;
        
        outter = response.getOutputStream();
        outter.write(fichero, 0, fichero.length);
        outter.flush();
        outter.close();

        %>

        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello JASPER!</h1>
    </body>
</html>
