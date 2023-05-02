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
java.sql.PreparedStatement, 
java.io.* 
"%>  
<%! String name = "", filename="", filedir = ""; %>
<%! 
public String dbhost="127.0.0.1", dbport="3306", dbname="alpsgateway", dbuser="ebahn", dbpass="ebahn";
public static Connection cn = null;
AlpsLog al = new AlpsLog();
Dao dao = new Dao();
%>

<%! 
public Connection connect() {
	Properties prop = new Properties();
	
	try { Class.forName("com.mysql.jdbc.Driver");
	cn = DriverManager.getConnection("jdbc:mysql://"+dbhost+":"+dbport+"/"+dbname, dbuser, dbpass);
	} catch(Exception e) { System.out.println(e); }
	return cn;
}
%>

<%  
String UPLOAD_PATH1 = request.getParameter("imgloc");
System.out.print(UPLOAD_PATH1);
ServletContext context = pageContext.getServletContext();
String UPLOAD_PATH = context.getInitParameter("file-upload");
MultipartRequest m = new MultipartRequest(request, UPLOAD_PATH, 1024 * 1024 * 1024);
String cid = m.getParameter("cid");  
String cname = m.getParameter("cname");  
String ctype = m.getParameter("ctype");  
String cvalue = m.getParameter("cval");  
Enumeration files = m.getFileNames();
while (files.hasMoreElements()) {
    name = (String) files.nextElement();
    filename = m.getFilesystemName(name);
}
String imgdir = dao.getlpimg();
filedir = imgdir + filename;

connect();

cn.createStatement().execute("UPDATE `ldpage` SET `value`='"+filedir+"' where name='"+cname+"'");

String logact = "Landing page Conent "+cname+" has been changed to "+filedir+" By "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
al.addLog(logact);
cn.close();
response.sendRedirect("content_mgt.jsp?msg=Content Updated Successfully!&type=success"); 


out.print("successfully uploaded "+filename+""+cid+""+cname+""+ctype+""+filedir);  
  
%>  