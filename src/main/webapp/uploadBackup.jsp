<%@ page import="com.oreilly.servlet.MultipartRequest, 
javax.servlet.*, 
javax.servlet.http.*, 
java.util.*,
java.sql.Connection,
java.sql.DriverManager,
java.sql.ResultSet,
java.sql.SQLException,
java.sql.Statement,
java.sql.ResultSetMetaData,
com.alps.AlpsLog,
com.alps.Dao,
com.alps.GwBackUp,
java.sql.PreparedStatement, 
java.io.* 
"%>  
<%! GwBackUp gb = new GwBackUp(); String name = "", filename="", filedir = ""; %>

<%  
ServletContext context = pageContext.getServletContext();
String UPLOAD_PATH = context.getInitParameter("backup-upload");
MultipartRequest m = new MultipartRequest(request, UPLOAD_PATH, 1024 * 1024 * 1024);
Enumeration files = m.getFileNames();
while (files.hasMoreElements()) {
    name = (String) files.nextElement();
    filename = m.getFilesystemName(name);
}
filedir = UPLOAD_PATH + filename;
try{
	gb.upload(filedir, filename);
}catch(Exception e){}

%>  