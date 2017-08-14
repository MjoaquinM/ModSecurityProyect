<%@ page import="javax.servlet.ServletOutputStream" %>
<%@ page import="com.mysql.jdbc.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="net.sf.jasperreports.engine.JRException" %>
<%@ page import="net.sf.jasperreports.engine.JasperReport" %>
<%@ page import="net.sf.jasperreports.engine.JasperRunManager" %>
<%@ page import="net.sf.jasperreports.engine.util.JRLoader" %>
<%@ page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@ page import="net.sf.jasperreports.engine.JRExporter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRHtmlExporter"%>
<%@ page import="net.sf.jasperreports.engine.JRExporterParameter"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%;

            response.setContentType("text/html");
            JRExporter exporter = null;
            ServletOutputStream servletOutputStream = response.getOutputStream();

            Connection connection;
            Map parameters = new HashMap();

            Class.forName("com.mysql.jdbc.Driver").newInstance();
            connection = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/websystique", "root", "mcardoso27");

            String path = (String) getServletConfig().getServletContext().getRealPath("/");
            path = path + "/home/martin/NetBeansProjects/ParserMSA/src/main/jasperreports/report3.jasper";
            JasperPrint jasperPrint = JasperFillManager.fillReport("/home/martin/NetBeansProjects/ParserMSA/src/main/jasperreports/report3.jasper", parameters, connection);
            response.setContentType("text/html");
            exporter = new JRHtmlExporter();
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
            exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, servletOutputStream);
            exporter.setParameter(JRExporterParameter.INPUT_FILE, path);

            exporter.exportReport();

            connection.close();

            servletOutputStream.flush();
            servletOutputStream.close();


        %>

        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello JASPER!</h1>
    </body>
</html>
