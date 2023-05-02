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
com.alps.ComExec,
com.alps.Dao,
com.alps.Db,
java.sql.PreparedStatement"%>

<%
Db db = new Db();
AlpsLog al = new AlpsLog();
Dao dao = new Dao();
ComExec cex = new ComExec();

try{
	if(dao.getSetting("installation").equals("New")){
		response.sendRedirect("home.jsp?type=success&msg=Lets get through some installation process!"); 
	}
}catch(Exception e) { System.out.println(e); }

%>

<%
if(request.getParameter("login") != null) {
	String user="", pass="", user2="", pass2="", role="", name="", dept="";
	user = request.getParameter("username");
	pass = request.getParameter("password");
	
	Connection cn = db.cn();
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

	session.invalidate();
	
}
%>
<!DOCTYPE html>
<html >
<head>
  <meta charset="UTF-8">
  <title>Alps Gateway | Log in</title>
  
  
  <link rel='stylesheet prefetch' href='http://fonts.googleapis.com/css?family=Open+Sans:600'>
  <link rel="stylesheet" href="stylesheets/style.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <link rel="shortcut icon" href="dist/ico/favicon.png">
  <link rel="apple-touch-icon-precomposed" sizes="144x144" href="dist/ico/apple-touch-icon-144-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="114x114" href="dist/ico/apple-touch-icon-114-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="72x72" href="dist/ico/apple-touch-icon-72-precomposed.png">
  <link rel="apple-touch-icon-precomposed" href="dist/ico/apple-touch-icon-57-precomposed.png">
  <style>
  	body{
  		padding-top:70px;
  		background-image: url(https://lh4.googleusercontent.com/-XplyTa1Za-I/VMSgIyAYkHI/AAAAAAAADxM/oL-rD6VP4ts/w1184-h666/Android-Lollipop-wallpapers-Google-Now-Wallpaper-2.png);
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat;
		min-height: 100vh;
  	}
  	.title-box{
  		align-content:center;
  		margin:auto;
		max-width:525px;
  		box-shadow:0 12px 15px 0 rgba(0,0,0,.24),0 17px 50px 0 rgba(0,0,0,.19);
  		background: rgba(255, 255, 255, 0.1);
  		border: 3px solid transparent;
  		border-radius: 10px;
  	}
  </style>
</head>

<body style="">
  <!-- <div class="title-box" align="center">
        <a href="/">
        	<img width="200px" height="60px" alt="LOGO" src="dist/img/alpslogo.png">
        </a>
        <h2>AMAC</h2>
        
  </div> -->
  <div class="login-wrap" style="border-radius:25px; min-height:90vh;">
  	
	<div class="login-html" style="border-radius:25px;">
		<div class="login-box-msg"  align="center" style="margin-bottom:30px; margin-top:10px;">
			<div class="title-box" align="center">
		        <a href="/">
		        	<img width="50%" class="img-responsive" alt="LOGO" src="dist/img/alpslogo.png">
		        </a>
		        <h2>AMAC</h2>
		    </div>
        </div>
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
		<label for="tab-1" class="tab" style="padding-right:30%;">
			<i class="ion-log-in"></i> Login
		</label>
		<input id="tab-2" type="radio" name="tab" class="sign-up">
		<label for="tab-2" class="tab" style="padding-right:30px;">
			<i class="ion-information-circled"></i> About
		</label>
		<div class="login-form">
			<div class="sign-in-htm" style="padding-top:30px;">
				<form action="login.jsp" method="post">
					<div class="group">
						<label for="user" class="label" style="padding-left:20px; padding-bottom:10px; font-size:2em;">
							<i class="ion-ios-person"></i>
						</label>
						<input id="user" name="username" type="text" class="input">
					</div>
					<div class="group">
						<label for="pass" class="label" style="padding-left:20px; padding-bottom:10px; font-size:2em;">
							<i class="ion-android-lock"></i>
						</label>
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
					<% 
					String sm = "Sign in to start your session";
					if(request.getParameter("msg") != null) {
						sm = request.getParameter("msg");
        	   		}
        	   		%>
					<label for="tab-1"><%= sm %></label>
					
				</div>
			</div>
			<div class="sign-up-htm" style="padding-top:30px;">
				<div class="group">
					
				</div>
				<div class="hr"></div>
				<div class="foot-lnk">
					<label for="tab-1"><a href="#forgot">Network Simplified ! ! !</a></label>
				</div>
			</div>
		</div>
	</div>
</div>
  
  
</body>
</html>