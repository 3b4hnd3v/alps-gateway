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
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Alps Gateway | Log in</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/square/blue.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="shortcut icon" href="dist/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="dist/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="dist/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="dist/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="dist/ico/apple-touch-icon-57-precomposed.png">
    <style type="text/css">
    	html { 
		  background: url(dist/img/default_settings.jpg) no-repeat center center fixed; 
		  -webkit-background-size: cover;
		  -moz-background-size: cover;
		  -o-background-size: cover;
		  background-size: cover;
		}
    </style>
  </head>
  <body class="hold-transition login-page">
  <div class="row col-lg-10 col-lg-offset-1">
  	<!-- Logo -->
  	<div class="col-lg-6" align="center">
        <a href="/"><img alt="LOGO" src="dist/img/alpslogo.png"></a>
    </div>
    <!-- Logo -->
    <!-- Login -->
    <div class="col-lg-6 login-box well">
      <p><br></p>
      <!-- Head -->
      <div class="well login-logo" style="background:#ffffff;">
        <h3 align="center" class="text-primary" style="background:#ffffff;"><strong><b>ALPS Management And Control</b></strong></h3>
        <h3 align="center" class="text-primary" style="background:#ffffff;"><strong><b>AMAC</b></strong></h3>
      </div><!-- /.login-logo -->
      <!-- Head -->
      <p><br></p>
      <div class="login-box-body well">
        <p class="login-box-msg"><% if(request.getParameter("msg") != null) {out.println(request.getParameter("msg"));
        }else{out.println("Sign in to start your session");}%></p>
        <form action="login.jsp" method="post">
          <div class="form-group has-feedback">
            <input type="text" class="form-control" placeholder="Username" name="username" id="username">
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <input type="password" class="form-control" placeholder="Password" name="password" id="password">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>
          <div class="row">
            <div class="col-xs-8">
              <div class="checkbox icheck">
                <label>
                  
                </label>
              </div>
            </div><!-- /.col -->
            <div class="col-md-12">
              <input type="submit" name="login" name="login" value="Login" class="btn btn-primary btn-block btn-flat">
            </div><!-- /.col -->
          </div>
        </form>
        <hr />
      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->
	<!-- Login -->	
    <!-- jQuery 2.1.4 -->
    <script src="../../plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="../../bootstrap/js/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="../../plugins/iCheck/icheck.min.js"></script>
    <script>
      $(function () {
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%' // optional
        });
      });
    </script>
  </div>
  </body>
</html>
