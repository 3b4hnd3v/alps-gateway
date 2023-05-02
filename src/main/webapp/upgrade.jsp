<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="
javax.servlet.*,
java.util.Date,
java.io.*,
java.util.*,
java.sql.Connection,
java.sql.DriverManager,
java.sql.ResultSet,
java.sql.SQLException,
java.sql.Statement,
java.sql.ResultSetMetaData,
java.util.HashMap,
java.sql.PreparedStatement,
com.alps.ComExec,
com.alps.Update,
java.io.File,
java.io.FileOutputStream,
java.io.IOException,
java.net.MalformedURLException,
java.net.URL,
java.nio.charset.Charset,
java.nio.file.*,
com.alps.Dao"
%>
   
<%!Update upd = new Update();
ComExec cex = new ComExec();
Dao dao = new Dao();
boolean dbresult = false;%>

<% 
if(request.getParameter("q")!=null && request.getParameter("q").equals("upgrade")){
	String warfile = request.getParameter("warfile");
	String dbfile = request.getParameter("dbfile");
	System.out.println(warfile);
	System.out.println(dbfile);
	if(!dbfile.equals("N/A")){
		
	try{
		Path c = upd.download(dbfile, System.getProperty("user.dir")+"/update/", "db.txt");
		System.out.println(c);
		
		dbfile = System.getProperty("user.dir")+"/update/db.txt";
		dbresult = upd.updateDb(dbfile);
	}catch(IOException ioe){System.out.println("xx"+ioe);}
		
	}else{dbresult = true;}
	
	if(!warfile.equals("N/A") && dbresult){
		try{
			Path c = upd.download(warfile, System.getProperty("user.dir"), "alps_gateway.war");
			System.out.println(c);
			cex.comExec("."+System.getProperty("user.dir")+"/restartwar.sh");
			response.sendRedirect("login.jsp?q=logout");
		}catch(MalformedURLException mue){System.out.println("xxx"+mue);}
		catch(IOException ioe){System.out.println("xxxx"+ioe);response.sendRedirect("login.jsp?q=logout");}
	}else{
		response.sendRedirect("system_update.jsp?type=error&msg=Problem Updating Your System. Please contact ALPS support if problem persist.");
	}
	
}


%>