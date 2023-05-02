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
com.alps.AlpsLog,
com.alps.Dao,
com.alps.ComExec,
java.sql.PreparedStatement

"%>

<%! 
public String dbhost="127.0.0.1", dbport="3306", dbname="alpsgateway", dbuser="ebahn", dbpass="ebahn";
public static Connection cn = null;
AlpsLog al = new AlpsLog();
Dao dao = new Dao();
ComExec cex = new ComExec();
%>

<%
try{
	if(dao.getInstallStatus().equals("New")){
		response.sendRedirect("home.jsp?type=success&msg=Lets get through some installation process!"); 
	}
}catch(Exception e) { System.out.println(e); }

%>

<%! 
public Connection connect() {	
	try { Class.forName("com.mysql.jdbc.Driver");
	cn = DriverManager.getConnection("jdbc:mysql://"+dbhost+":"+dbport+"/"+dbname, dbuser, dbpass);
	} catch(Exception e) { System.out.println(e); }
	return cn;
}
%>

<%
if(request.getParameter("login") != null) {
	String user="", pass="", user2="", pass2="", role="", name="", dept="";
	user = request.getParameter("username");
	pass = request.getParameter("password");
	
	connect();
	try { ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM users WHERE username='"+user+"' AND password='"+pass+"'"); rs.next();
		user2 = rs.getString("username");
		pass2 = rs.getString("password");
		name = rs.getString("name");
		dept = rs.getString("department");
		role = rs.getString("role");
		
		//cn.close();
		if(user.equals(user2) && pass.equals(pass2) && !user.equals("") && !pass.equals("")) {
			
			session.setAttribute("user_id", rs.getString("user_id"));
			session.setAttribute("email", rs.getString("email"));
			session.setAttribute("name", name);
			session.setAttribute("username", user);
			session.setAttribute("password", pass);
			session.setAttribute("dept", dept);
			session.setAttribute("role", role);
			session.setAttribute("logged", "true");
			String license = dao.checklicense();
			if(license.equals("valid")){
				String logact = "Valid Login By = "+name+" from "+dept+". Username: "+user;
				al.addLog(logact);
				String logact1 = "License check = "+license;
				al.addLog(logact1);
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", "index.jsp");
			}else if(license.equals("invalid")){
				String logact = "Invalid Login By = Username: "+user+"  & Password: "+user;
				al.addLog(logact);
				String logact1 = "License check = "+license;
				al.addLog(logact1);
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", "end_license.jsp");
			}
		}else { 
			String logact = "Invalid Login By = "+user+".";
			al.addLog(logact);
			response.sendRedirect("login.jsp?msg=Invalid username or password!"); }
	} catch(Exception e4) { System.out.println("adda"+e4); }
	
}

if(request.getParameter("q") != null && request.getParameter("q").equals("logout")) {
	System.out.print("logout");
	
	String logact = "Valid Login By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
	al.addLog(logact);

	session.setAttribute("name", null);
	session.setAttribute("username", null);
	session.setAttribute("password", null);
	session.setAttribute("dept", null);
	session.setAttribute("role", null);
	session.setAttribute("logged", null);
	
}

if(request.getParameter("q") != null && request.getParameter("q").equals("restart")) {
	System.out.print("restarting...");
	
	String logact = "System Restarted By: "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
	al.addLog(logact);

	cex.comExec("./home/ALPS/restartwar.sh");
	
}
%>
<!DOCTYPE html>
<html >
<head>
  <meta charset="UTF-8">
  <title>Alps Gateway | Log in</title>
  
  
  <link rel='stylesheet prefetch' href='http://fonts.googleapis.com/css?family=Open+Sans:600'>
  <link rel="stylesheet" href="stylesheets/style.css">
  <link rel="shortcut icon" href="dist/ico/favicon.png">
  <link rel="apple-touch-icon-precomposed" sizes="144x144" href="dist/ico/apple-touch-icon-144-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="114x114" href="dist/ico/apple-touch-icon-114-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="72x72" href="dist/ico/apple-touch-icon-72-precomposed.png">
  <link rel="apple-touch-icon-precomposed" href="dist/ico/apple-touch-icon-57-precomposed.png">

</head>

<body style="padding-top:10px">
  <div class="col-lg-6" align="center">
        <a href="/"><img alt="LOGO" src="dist/img/alpslogo.png"></a>
        <h2>AMAC</h2>
  </div>
  <div class="login-wrap">
	<div class="login-html">
		<h3 class="login-box-msg"  align="center">
			<% if(request.getParameter("msg") != null) {
				out.println(request.getParameter("msg"));
        	   }else{out.println("Sign in to start your session");}
        	   %>
        	   <br />
        </h3>
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Sign In</label>
		<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">About ALPS</label>
		<div class="login-form">
			<div class="sign-in-htm" style="padding-top:30px;">
				<form action="login.jsp" method="post">
					<div class="group">
						<label for="user" class="label">Username</label>
						<input id="user" name="username" type="text" class="input">
					</div>
					<div class="group">
						<label for="pass" class="label">Password</label>
						<input id="pass" name="password" type="password" class="input" data-type="password">
					</div>
					<div class="group" style="padding-top:20px;padding-bottom:20px;">
						<input id="check" type="checkbox" class="check" checked>
						<label for="check"><span class="icon"></span> Keep me Signed in</label>
					</div>
					<div class="group">
						<input type="submit" name="login" class="button" value="Sign In">
					</div>
				</form>
				<div class="hr"></div>
				<div class="foot-lnk">
					<a href="#forgot">Network Simplified ! ! !</a>
				</div>
			</div>
			<div class="sign-up-htm" style="padding-top:30px;">
				<div class="group">
					
				</div>
				<div class="hr"></div>
				<div class="foot-lnk">
					<label for="tab-1">Network Simplified!!!</a>
				</div>
			</div>
		</div>
	</div>
</div>
  
  
</body>
</html>