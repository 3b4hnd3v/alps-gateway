<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="
javax.servlet.*,
org.apache.commons.lang3.StringUtils,
java.awt.EventQueue,
java.awt.event.ActionListener,
java.awt.event.ActionEvent,java.util.Date,
java.io.*,
java.util.*,
org.json.simple.JSONArray,
org.json.simple.JSONObject,
org.json.simple.JSONValue,
org.json.simple.parser.JSONParser,
java.net.URL,
java.net.URLEncoder,
javax.servlet.http.HttpUtils.*,
java.net.*,
java.net.HttpURLConnection,
java.net.MalformedURLException,
java.net.URLConnection,java.io.BufferedReader,
java.util.Properties,
java.sql.Connection,
java.sql.DriverManager,
java.sql.ResultSet,
java.sql.Timestamp,
java.sql.SQLException,
java.sql.Statement,
java.sql.ResultSetMetaData,
java.sql.PreparedStatement,
com.alps.*,
com.mail.Licmail,
com.alps.GCounter,
org.apache.commons.lang3.ArrayUtils,
java.util.Date,
java.text.DateFormat,
java.text.SimpleDateFormat,
java.util.Calendar,
java.io.BufferedWriter,
java.io.File,java.io.FileOutputStream,
java.io.FileWriter,java.io.IOException,
java.io.PrintWriter,
java.io.BufferedReader,
java.nio.charset.Charset,
java.nio.file.Files,
java.net.InetAddress,
com.alps.master.*,
com.ftp.FTPFunctions,
java.nio.file.*"%>
<%!
Gateway g = new Gateway(); 
MasterApi mg = new MasterApi(); 
GCounter gc = new GCounter();
AlpsLog al = new AlpsLog();
Dao dao = new Dao();
Mao mao = new Mao();
Dhcp d = new Dhcp();
public String dbhost="127.0.0.1", dbport="3306", dbname="alpsgateway", dbuser="ebahn", dbpass="ebahn";
public static Connection cn = null, cn1 = null;

public Connection connect() {
	Properties prop = new Properties();
	
	try { Class.forName("com.mysql.jdbc.Driver");
	cn = DriverManager.getConnection("jdbc:mysql://"+dbhost+":"+dbport+"/"+dbname, dbuser, dbpass);
	} catch(Exception e) { System.out.println(e); }
	return cn;
}
public Connection connectpms() {
	String ptype = dao.getSetting("active_pms");
	if(!ptype.isEmpty()&&ptype.equalsIgnoreCase("external_pms")){
		dbhost=ptype.split(":")[0];
		dbport=ptype.split(":")[1];
		dbname=ptype.split(":")[2];
		dbuser=ptype.split(":")[3];
		dbpass=ptype.split(":")[4];
	}else{
		dbname = "pms";
	}
	try { Class.forName("com.mysql.jdbc.Driver");
	cn1 = DriverManager.getConnection("jdbc:mysql://"+dbhost+":"+dbport+"/"+dbname, dbuser, dbpass);
	} catch(Exception e) { System.out.println(e); }
	return cn1;
}
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Alps Gateway | Admin Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.css">
    <!-- .min AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css"><!-- Morris charts -->
    <link rel="stylesheet" href="plugins/morris/morris.css">
    <!-- Bootstrap WYSIHTML5 -->
	<link rel="shortcut icon" href="dist/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="dist/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="dist/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="dist/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="dist/ico/apple-touch-icon-57-precomposed.png">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
		.example-modal .modal {
		  position: relative;
		  top: auto;
		  bottom: auto;
		  right: auto;
		  left: auto;
		  display: block;
		  z-index: 1;
		}
		.example-modal .modal {
		  background: transparent !important;
		}
		hr { 
		display: block;
		margin-top: 0.5em;
		margin-bottom: 0.5em;
		margin-left: auto;
		margin-right: auto;
		border-style: inset;
		} 
		hr.style-eight { padding: 0; border: none; border-top: medium double #333; color: #333; text-align: center; } hr.style-eight:after { content: "§"; display: inline-block; position: relative; top: -0.7em; font-size: 1.5em; padding: 0 0.25em; background: white; }
		
		
		/* USER PROFILE PAGE */
		.card {
		    margin-top: 20px;
		    padding: 30px;
		    background-color: rgba(214, 224, 226, 0.2);
		    -webkit-border-top-left-radius:5px;
		    -moz-border-top-left-radius:5px;
		    border-top-left-radius:5px;
		    -webkit-border-top-right-radius:5px;
		    -moz-border-top-right-radius:5px;
		    border-top-right-radius:5px;
		    -webkit-box-sizing: border-box;
		    -moz-box-sizing: border-box;
		    box-sizing: border-box;
		}
		.card.hovercard {
		    position: relative;
		    padding-top: 0;
		    overflow: hidden;
		    text-align: center;
		    background-color: #fff;
		    background-color: rgba(255, 255, 255, 1);
		}
		.card.hovercard .card-background {
		    height: 130px;
		}
		.card-background img {
		    -webkit-filter: blur(25px);
		    -moz-filter: blur(25px);
		    -o-filter: blur(25px);
		    -ms-filter: blur(25px);
		    filter: blur(25px);
		    margin-left: -100px;
		    margin-top: -200px;
		    min-width: 130%;
		}
		.card.hovercard .useravatar {
		    position: absolute;
		    top: 15px;
		    left: 0;
		    right: 0;
		}
		.card.hovercard .useravatar img {
		    width: 100px;
		    height: 100px;
		    max-width: 100px;
		    max-height: 100px;
		    -webkit-border-radius: 50%;
		    -moz-border-radius: 50%;
		    border-radius: 50%;
		    border: 5px solid rgba(255, 255, 255, 0.5);
		}
		.card.hovercard .card-info {
		    position: absolute;
		    bottom: 14px;
		    left: 0;
		    right: 0;
		}
		.card.hovercard .card-info .card-title {
		    padding:0 5px;
		    font-size: 20px;
		    line-height: 1;
		    color: #262626;
		    background-color: rgba(255, 255, 255, 0.1);
		    -webkit-border-radius: 4px;
		    -moz-border-radius: 4px;
		    border-radius: 4px;
		}
		.card.hovercard .card-info {
		    overflow: hidden;
		    font-size: 12px;
		    line-height: 20px;
		    color: #737373;
		    text-overflow: ellipsis;
		}
		.card.hovercard .bottom {
		    padding: 0 20px;
		    margin-bottom: 17px;
		}
		.btn-pref .btn {
		    -webkit-border-radius:0 !important;
		}
		
		.sidebar{
			max-height:94vh;
			min-height:94vh;
			overflow-x:hidden;
			overflow-y:scroll;
		}
		.content-wrapper{
			max-height:80vh;
			min-height:80vh;
			overflow-x:hidden;
			overflow-y:scroll;
		}
    </style>
    
  </head>
  <% 
	  if(session.getAttribute("logged")==null) { 		
		  try { response.sendRedirect("login.jsp"); }catch(Exception e){}
	  } 
  %>