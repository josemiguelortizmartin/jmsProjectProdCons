<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="org.apache.logging.log4j.Level" %>
<%@ page import="org.apache.logging.log4j.core.config.Configuration" %>
<%@ page import="org.apache.logging.log4j.core.LoggerContext" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.apache.logging.log4j.core.config.LoggerConfig" %>


<%
// Cambiamos el nivel
String nombreLogger = request.getParameter("logger");
String nuevoNivel = request.getParameter("nivel");
String mostrarNull = request.getParameter("null");
if (mostrarNull == null)
{
	mostrarNull = "NO";
}

if (nombreLogger != null && nuevoNivel != null)
{
	

	
    
 	Logger loggerACambiar = LogManager.getLogger (nombreLogger);
 	
    LoggerContext ctx = (LoggerContext) LogManager.getContext(false);
    Configuration conf = ctx.getConfiguration();
    conf.getLoggerConfig(nombreLogger).setLevel(Level.toLevel(nuevoNivel));
    ctx.updateLoggers(conf);	

	loggerACambiar.debug ("Traza de DEBUG");
	loggerACambiar.info("Traza de INFO");
	loggerACambiar.warn ("Traza de WARN");
	loggerACambiar.error ("Traza de ERROR");			
	
}

// Recogemos todos los appender
LoggerContext ctx = (LoggerContext) LogManager.getContext(false);
Configuration conf = ctx.getConfiguration();
Collection<LoggerConfig> a = conf.getLoggers().values();
Iterator<LoggerConfig> enum2 = a.iterator();



%>
<HTML>
<HEAD>
<%@ page 
language="java"
contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"
%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Studio">
<TITLE>log4jAdmin.jsp</TITLE>
<style type="text/css">
.titulo {
	font-size: 22px;
	font-family: Arial;
	font-weight: bold;
}
.cabecera {
	font-size: 14px;
	font-family: Arial;
	font-weight: bold;
	border-bottom: 1px solid #6699CC;
	border-left: 1px solid #6699CC;
	border-top: 1px solid #6699CC;
	border-right: 1px solid #6699CC;
	text-align: center;
}
.logger {
	font-size: 14px;
	font-family: Arial;
	border-bottom: 1px solid #6699CC;
	border-left: 1px solid #6699CC;
	border-top: 1px solid #6699CC;
	border-right: 1px solid #6699CC;
}
.DEBUG {
	font-size: 14px;
	font-family: Arial;
	font-weight: bold;
	color: #05CC60;
	border-bottom: 1px solid #6699CC;
	border-left: 1px solid #6699CC;
	border-top: 1px solid #6699CC;
	border-right: 1px solid #6699CC;	
}
A.link_debug {
	COLOR: #05CC60; 
	TEXT-DECORATION: none;
	}
A.link_menu:link_debug {
	COLOR: #05CC60; 
	TEXT-DECORATION: none;
	}
.info {
	font-size: 14px;
	font-family: Arial;
	font-weight: bold;
	color: #0532CC;
	border-bottom: 1px solid #6699CC;
	border-left: 1px solid #6699CC;
	border-top: 1px solid #6699CC;
	border-right: 1px solid #6699CC;	
}
A.link_info {
	COLOR: #0532CC; 
	TEXT-DECORATION: none;
	}
A.link_menu:link_info {
	COLOR: #0532CC; 
	TEXT-DECORATION: none;
	}
.warn {
	font-size: 14px;
	font-family: Arial;
	font-weight: bold;
	color: #FFAA29;
	border-bottom: 1px solid #6699CC;
	border-left: 1px solid #6699CC;
	border-top: 1px solid #6699CC;
	border-right: 1px solid #6699CC;
}
A.link_warn {
	color: #FFAA29; 
	TEXT-DECORATION: none;
	}
A.link_menu:link_warn {
	color: #FFAA29; 
	TEXT-DECORATION: none;
	}
.error {
	font-size: 14px;
	font-family: Arial;
	font-weight: bold;
	color: #EE2030;
	border-bottom: 1px solid #6699CC;
	border-left: 1px solid #6699CC;
	border-top: 1px solid #6699CC;
	border-right: 1px solid #6699CC;	
}
A.link_error {
	COLOR: #EE2030; 
	TEXT-DECORATION: none;
	}
A.link_menu:link_error {
	COLOR: #EE2030; 
	TEXT-DECORATION: none;
	}
.enlaces {
	border-bottom: 1px solid #6699CC;
	border-left: 1px solid #6699CC;
	border-top: 1px solid #6699CC;
	border-right: 1px solid #6699CC;	
}
.null {
	font-size: 14px;
	font-family: Arial;
	font-weight: bold;
	color: #000000;
	border-bottom: 1px solid #6699CC;
	border-left: 1px solid #6699CC;
	border-top: 1px solid #6699CC;
	border-right: 1px solid #6699CC;	
}
.tabla_menu {
    background-color:ffffff;
	border-bottom: 1px solid #6699CC;
	border-left: 1px solid #6699CC;
	border-top: 1px solid #6699CC;
	border-right: 1px solid #6699CC;    
}

	
</style>
</HEAD>
<BODY>
<br>
<center><span class="titulo">Administración logj4</span>
<br><br>
<table class="tabla_menu" cellpadding=0 cellspacing=0 >
<tr>
	<td class="cabecera">&nbsp;Logger&nbsp;&nbsp;&nbsp;</td>
	<td class="cabecera">&nbsp;Nivel&nbsp;</td>
	<td class="cabecera">&nbsp;Cambiar Nivel&nbsp;</td>
	</tr>
<%
while (enum2.hasNext())
{
	LoggerConfig log = (LoggerConfig) enum2.next();

	if ((mostrarNull.equals("NO") && log.getLevel() != null) || mostrarNull.equals("SI"))
	{
%>
<tr>
	<td class="logger">&nbsp;<%=log.getName()%>&nbsp;&nbsp;&nbsp;</td>
	<td class="<%=log.getLevel()%>">&nbsp;<%=log.getLevel()%>&nbsp;&nbsp;&nbsp;</td>
	<td class="enlaces">&nbsp;&nbsp;&nbsp; (
		<a class="link_debug" href="log4jAdmin.jsp?logger=<%=log.getName()%>&nivel=debug&null=<%=mostrarNull%>">debug</a>&nbsp;-&nbsp;
		<a class="link_info" href="log4jAdmin.jsp?logger=<%=log.getName()%>&nivel=info&null=<%=mostrarNull%>">info</a>&nbsp;-&nbsp;
		<a class="link_warn" href="log4jAdmin.jsp?logger=<%=log.getName()%>&nivel=warn&null=<%=mostrarNull%>">warn</a>&nbsp;-&nbsp;
		<a class="link_error" href="log4jAdmin.jsp?logger=<%=log.getName()%>&nivel=error&null=<%=mostrarNull%>">error</a>&nbsp;
		) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	</tr>
<%
}
}
%>
</table>
</center>
</BODY>
</HTML>
