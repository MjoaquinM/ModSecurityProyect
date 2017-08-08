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
<%@ page import="net.sf.jasperreports.engine.export.JRXlsExporterParameter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRXlsExporter"%>
<%@ page import="net.sf.jasperreports.engine.JRExporterParameter"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%;

            Connection conexion;
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            conexion = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/websystique", "root", "mcardoso27");

            int bit;
            Map parameters = new HashMap();
            //A nuestro informe de prueba le vamos a enviar la fecha de hoy
            parameters.put("fechainicio", new Date());

            File f;
            InputStream in;
            ServletOutputStream outter;

            JasperPrint jasperPrint;
            jasperPrint = JasperFillManager.fillReport("/home/martin/NetBeansProjects/ParserMSA/src/main/jasperreports/report3.jasper", parameters, conexion);
            String xlsFileName = "informeDemo.xls";

//Creacion del XLS
            JRXlsExporter exporter = new JRXlsExporter();
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
            exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, xlsFileName);
            exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
            exporter.exportReport();

// En este punto ya esta Creado el XLS
// Ahora leemos el fichero y forzamos al navegador a que nos descargue el fichero.
            f = new File(xlsFileName);

            response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
            response.setHeader("Content-Disposition", "attachment;filename=" + xlsFileName + ""); //Configurar cabecera http

            in = new FileInputStream(f);
            outter = response.getOutputStream();

            bit = 256;
            while ((bit) >= 0) {
                bit = in.read();
                out.write(bit);
            }

            outter.flush();
            outter.close();
            in.close();

        %>

        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello JASPER!</h1>
    </body>
</html>
