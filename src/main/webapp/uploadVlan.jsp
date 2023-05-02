<%@include file="header.jsp" %>
<%@page import="
com.oreilly.servlet.MultipartRequest, 
java.io.File,
javax.servlet.*, 
javax.servlet.http.*, 
java.util.*,
java.io.*,
com.alps.VlanUpload
"%>
<%! String name="",filename="",filedir=""; String os = "1";%>
<%
System.out.println("Vlan Upload");
//if(request.getParameter("submit") != null && request.getParameter("submit").equals("Upload Vlans")) {
	//String excelFilePath = request.getParameter("cfile").toString();
	//String loc = request.getParameter("location").toString();
	System.out.println("Vlan Upload");
	try{
		ServletContext context = pageContext.getServletContext();
		String UPLOAD_PATH = context.getInitParameter("vlan-upload");
		MultipartRequest m = new MultipartRequest(request, UPLOAD_PATH, 1024 * 1024 * 1024);
		String loc = m.getParameter("location");  
		Enumeration files = m.getFileNames();
		while (files.hasMoreElements()) {
		    name = (String) files.nextElement();
		    filename = m.getFilesystemName(name);
		}
		filedir = UPLOAD_PATH + filename;
		System.out.println(filedir);
		VlanUpload vu = new VlanUpload();
		vu.setLocation(loc);
		vu.setFiledir(filedir);
		vu.vlanFromExcel(filedir);
		
		response.sendRedirect("add_vlan.jsp?msg=Succesfully Uploaded&type=success");
	}catch(Exception e){
		System.out.println(e);
		response.sendRedirect("add_vlan.jsp?msg=Upload has failed. Vlans might be already existing. Please confirm and try again&type=error");
	}

//}
%>