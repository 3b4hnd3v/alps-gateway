<%@page import="
com.alps.AlpsLog,
java.nio.file.*
"%>
<%! AlpsLog al = new AlpsLog(); 
public String filename="", filepath="";
%>
<%
if(request.getParameter("qdown")!=null){
	String logfile = request.getParameter("qdown");
	String filename = request.getParameter("fn");
	response.setContentType("APPLICATION/OCTET-STREAM");   
	response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
	
	java.io.FileInputStream fileInputStream=new java.io.FileInputStream(logfile);  
	          
	int i;   
	while ((i=fileInputStream.read()) != -1) {  
	  out.write(i);   
	}   
	fileInputStream.close();   
	
	String logact = "Log Downloaded By "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
	al.addLog(logact);
}else{
	if(request.getParameter("download")!=null){
		String fn = request.getParameter("fn").toString();
		filename = "AlpsLog "+fn.replace("-", "-")+".txt";   
		filename = filename.trim();
		filepath = request.getParameter("fd").toString().trim();
	}else if (request.getParameter("q")!=null){
		filename = request.getParameter("fn");   
		filepath = request.getParameter("fd");
	}
	System.out.println(filename+"="+filepath);
	
	response.setContentType("APPLICATION/OCTET-STREAM");   
	response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
	
	java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath + filename);  
	          
	int i;   
	while ((i=fileInputStream.read()) != -1) {  
	  out.write(i);   
	}   
	fileInputStream.close();   
	
	String logact = "Log Downloaded By "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
	al.addLog(logact);
}
%>
