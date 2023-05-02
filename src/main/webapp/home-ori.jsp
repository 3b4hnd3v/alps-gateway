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
com.alps.User,
com.alps.Dao,
java.sql.PreparedStatement"
%>

<%!
public String dbhost="127.0.0.1", dbport="3306", dbname="alpsgateway", dbuser="ebahn", dbpass="ebahn";
public static Connection cn = null;
AlpsLog al = new AlpsLog();
Dao dao = new Dao();

public Connection connect() {
	Properties prop = new Properties();
	
	try { Class.forName("com.mysql.jdbc.Driver");
	cn = DriverManager.getConnection("jdbc:mysql://"+dbhost+":"+dbport+"/"+dbname, dbuser, dbpass);
	} catch(Exception e) { System.out.println(e); }
	return cn;
}
%>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Next(1)")) {
	String user="", pass="", role="Main", name="", dept="", email="";
	user = request.getParameter("username");
	pass = request.getParameter("password");
	name = request.getParameter("name");
	dept = request.getParameter("department");
	email = request.getParameter("email");
	
	try { 
		User u = new User();
		u.setName(name);
		u.setUsername(user);
		u.setPassword(pass);
		u.setDepartment(dept);
		u.setEmail(email);
		u.setRole(role);
		if(u.addUser()){
			response.sendRedirect("home.jsp?q=ClientReg");
		}else{
			response.sendRedirect("home.jsp?q=UserReg&type=error&msg=User Registration Failed, Please Try Again");
		}
	} catch(Exception e4) { System.out.println("adda"+e4); }
	
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Next(2)")) {
	String client= request.getParameter("cname");
	
	try { 
		String com = "UPDATE `dashboard` SET `value`='"+client+"' WHERE `name`='client'";
		if(dao.runSQLCom(com)){
			response.sendRedirect("home.jsp?q=HomePage");
		}else{
			response.sendRedirect("home.jsp?q=ClientReg&type=error&msg=User Registration Failed, Please Try Again");
		}
	} catch(Exception e4) { System.out.println("adda"+e4); }
	
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Next(3)")) {
	String homepage = request.getParameter("homepage");
	
	try { 
		String com = "UPDATE `settings` SET `setting_value`='"+homepage+"' WHERE setting_name='guest_homepage'";
		if(dao.runSQLCom(com)){
			response.sendRedirect("home.jsp?q=LicenseAct");
		}else{
			response.sendRedirect("home.jsp?q=ClientReg&type=error&msg=Home Page Registration Failed, Please Try Again");
		}
	} catch(Exception e4) { System.out.println("adda"+e4); }
	
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Next(4)")) {
	try { 
		String license = request.getParameter("license");
		String expiry = request.getParameter("expiry");
		String com = "UPDATE `dashboard` SET `value`='"+license+"' WHERE `name`='license'";
		String com1 = "UPDATE `dashboard` SET `value`='"+expiry+"' WHERE `name`='licexp'";
		String com2 = "UPDATE `dashboard` SET `value`=CURDATE() WHERE `name`='licact'";
		if(dao.runSQLCom(com)&&dao.runSQLCom(com1)){
			if(dao.runSQLCom(com2)){
				response.sendRedirect("home.jsp?q=Location");
			}else{
				response.sendRedirect("home.jsp?q=ClientReg&type=error&msg=Home Page Registration Failed, Please Try Again");
			}
		}else{
			response.sendRedirect("home.jsp?q=ClientReg&type=error&msg=Home Page Registration Failed, Please Try Again");
		}
	} catch(Exception e4) { System.out.println("adda"+e4); }
	
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Next(5)")) {
	String lat = request.getParameter("lat");
	String lng = request.getParameter("long");
	String loc = request.getParameter("alocation");
	String latlng = "Lat="+lat+"Long="+lng;
	
	try { 
		
		String com = "UPDATE `dashboard` SET `value`='"+loc+"', `info`='"+latlng+"' WHERE `name`='location'";
		String com1 = "UPDATE `settings` SET `setting_value`='Done' WHERE `setting_name`='installation'";

		if(dao.runSQLCom(com) && dao.runSQLCom(com1)){
			response.sendRedirect("login.jsp");
		}else{
			response.sendRedirect("home.jsp?q=Location&type=error&msg=Home Page Registration Failed, Please Try Again");
		}
	} catch(Exception e4) { System.out.println("adda"+e4); }
	
}

%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Alps Gateway | Start</title>
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
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/square/blue.css">

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
    </style>
  </head>
  <body class="hold-transition login-page">
  
  <div class="well col-md-10 col-lg-offset-1" style="padding:20px">
  
	<%if(request.getParameter("msg") != null && request.getParameter("type").equals("error")){ %>
		<div class="alert alert-danger alert-dismissible">
		  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		  <h4><i class="icon fa fa-ban"></i> Oops :( !</h4>
		  <%out.println(request.getParameter("msg")); %>
		</div>
	<%}else if(request.getParameter("msg") != null && request.getParameter("type").equals("success")){ %>
		<div class="alert alert-info alert-dismissible">
		  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		  <h4><i class="icon fa fa-info"></i> Alert!</h4>
		  <%out.println(request.getParameter("msg")); %>
		</div>
	<%}%>
  	
	  <div class="row" align="center" style="padding-bottom:20px">
	    <section class="content-header col-md-6 col-lg-offset-3">
	      <img src="dist/img/alpslogo.png">
	    </section>
	  </div>
	  
	  <div class="row" align="center">
	    <section class="content-header well col-md-6 col-lg-offset-3">
	      <h1>Welcome To ALPS Gateway</h1>
	      <h4>Your Gateway To Seamless Application, Borderless Connectivity!</h4>
	    </section>
	  </div>
	   <div class="row" align="center"><a href="?q=UserReg"><button class = "btn btn-flat btn-danger">Start Installation</button></a></div>
	  <hr style="display: block; height: 1px; border: 0; border-top: 1px solid #ccc; margin: 1em 0; padding: 0; " />
	  <div class="row" align="center">
	  	<% if(request.getParameter("q") != null && request.getParameter("q").equals("UserReg")) { %>
	  	<section class="content" style="background-color:#E0FF66">
		 <div class="example-modal">
            <div class="modal modal-primary">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Let's start with Main User Registration</h4>
                    <small class="Text Danger">You will need this to Login to the system later</small>
                  </div>
                  <div class="modal-body">
                    <form action="home.jsp">
                    	<div class="form-group has-feedback">
				          <input type="text" required class="form-control" placeholder="Full Name" name="name" id="name">
				          <span class="glyphicon glyphicon-user form-control-feedback"></span>
				        </div>
				        <div class="form-group has-feedback">
				          <input type="text" required class="form-control" placeholder="Email" name="email" id="email">
				          <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
				        </div>
				        <div class="form-group has-feedback">
				          <input type="text" required class="form-control" placeholder="Username" name="username" id="username">
				          <span class="glyphicon glyphicon-user form-control-feedback"></span>
				        </div>
				        <div class="form-group has-feedback">
				          <input type="text" required class="form-control" placeholder="Password" name="password" id="password">
				          <span class="glyphicon glyphicon-lock form-control-feedback"></span>
				        </div>
				        <div class="form-group has-feedback">
				          <input type="text" required class="form-control" placeholder="Department" name="department" id="department">
				          <span class="glyphicon glyphicon-building form-control-feedback"></span>
				        </div>
				        <div class="row">
				        <input type="submit" class="btn btn-outline col-lg-10 col-lg-offset-1" name="submit" value="Next(1)">
				        </div>
                     </form>
                  </div>
                  <div class="modal-footer">
                    <a href="home.jsp?q=ClientReg"><button type="button" class="btn btn-outline">Skip</button></a>
                    <a href="home.jsp"><button type="button" class="btn btn-outline" data-dismiss="modal">Back</button></a>
                  </div>
                </div><!-- /.modal-content -->
              </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
          </div><!-- /.example-modal -->
        </section>
        <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("ClientReg")) { %>
        <section class="content" style="background-color:#CC4C8C">
		 <div class="example-modal">
            <div class="modal modal-success">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Now Lets Get To Know About Our Client</h4>
                    <small class="text-danger">Company Name will be used for licensing</small>
                  </div>
                  <div class="modal-body">
                    <form action="home.jsp">
                    	<div class="form-group has-feedback">
				          <input type="text" required class="form-control" placeholder="Company Name" name="cname" id="cname">
				          <span class="glyphicon glyphicon-user form-control-feedback"></span>
				        </div>
				        <div class="row">
				        	<input type="submit" class="btn btn-outline col-lg-10 col-lg-offset-1" name="submit" value="Next(2)">
				        </div>
				    </form>
                  </div>
                  <div class="modal-footer">
                    <a href="home.jsp?q=HomePage"><button type="button" class="btn btn-outline">Skip</button></a>
                    <a href="home.jsp"><button type="button" class="btn btn-outline pull-left">Close</button></a>
                  </div>
                </div><!-- /.modal-content -->
              </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
          </div><!-- /.example-modal -->
        </section>
        <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("HomePage")) { %>
        <section class="content" style="background-color:#FF0047">
		 <div class="example-modal">
            <div class="modal modal-warning">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Do you have a corporate page, Web site or Flash Portal?</h4>
                    <small class="text-danger">All users will see this page after successful connection.</small>
                  </div>
                  <div class="modal-body">
                    <form action="home.jsp">
                    	<div class="form-group has-feedback">
				          <input type="text" required class="form-control" placeholder="Home Page To Redirect To" name="homepage" id="homepage">
				          <span class="glyphicon glyphicon-user form-control-feedback"></span>
				        </div>
				        <div class="row">
				        	<input type="submit" class="btn btn-outline col-lg-10 col-lg-offset-1" name="submit" value="Next(3)">
				        </div>
				    </form>
                  </div>
                  <div class="modal-footer">
                    <a href="home.jsp"><button type="button" class="btn btn-outline pull-left">Close</button></a>
                    <a href="home.jsp?q=LicenseAct"><button type="button" class="btn btn-outline">Skip</button></a>
                  </div>
                </div><!-- /.modal-content -->
              </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
          </div><!-- /.example-modal -->
        </section>
        <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("LicenseAct")) { %>
        <section class="content" style="background-color:#549ED1">
		 <div class="example-modal">
            <div class="modal modal-primary">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Almost There... Got your license card?</h4>
                    <small class="text-danger">The License provided to you with ALPS Gateway.</small>
                  </div>
                  <div class="modal-body">
                    <form action="home.jsp">
                    	<div class="form-group has-feedback">
				          <input type="text" required class="form-control" placeholder="License No" name="license" id="homepage">
				          <span class="glyphicon glyphicon-user form-control-feedback"></span>
				        </div>
				        <div class="form-group has-feedback">
				          <input type="text" required class="form-control" placeholder="Expiry Date" name="expiry" id="expiry">
				          <span class="glyphicon glyphicon-user form-control-feedback"></span>
				        </div>
				        <div class="row">
				        	<input type="submit" class="btn btn-outline col-lg-10 col-lg-offset-1" name="submit" value="Next(4)">
				        </div>
				    </form>
                  </div>
                  <div class="modal-footer">
                    <a href="home.jsp"><button type="button" class="btn btn-outline pull-left">Close</button></a>
                    <a href="home.jsp?q=Location"><button type="button" class="btn btn-outline">Skip</button></a>
                  </div>
                </div><!-- /.modal-content -->
              </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
          </div><!-- /.example-modal -->
        </section>
        <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("Location")) { %>
        <section class="content well" style="background-color:#4FB017">
		 <div class="example-modal">
            <div class="modal modal-danger">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Finally.. Click the <i class="fa fa-globe"></i> for ALPS Gateway To Calibrate Location</h4>
                    <button class="btn btn-info btn-sm" onclick="getLocation()"><i class="fa fa-globe"></i></button>
                    <p id="repo"></p>
                  </div>
                  <div class="modal-body">
                    <form action="home.jsp">
                    	<div class="form-group has-feedback">
                    	  <label>Latitude</label>
				          <input type="text" readonly required class="form-control" name="lat" id="lat" value="">
				        </div>
				        <div class="form-group has-feedback">
				          <label>Longitude</label>
				          <input type="text" readonly required class="form-control" name="long" id="long" value="">
				        </div>
				        <div class="form-group has-feedback">
				          <label>Approximate Location</label>
				          <input type="text" required class="form-control" name="alocation" id="alocation" value="">
				          <small>Add your company name to be more specific. (e.g eBahn Solutions Kuala Lumpur)</small>
				        </div>
				        <div class="row">
				        	<input type="submit" class="btn btn-outline col-lg-10 col-lg-offset-1" name="submit" value="Next(5)">
				        </div>
				    </form>
                  </div>
                  <div class="modal-footer">
                    <a href="home.jsp?Location"><button type="button" class="btn btn-outline pull-left">Close</button></a>
                    <a href="home.jsp?Location"><button type="button" class="btn btn-outline">Skip</button></a>
                  </div>
                </div><!-- /.modal-content -->
              </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
          </div><!-- /.example-modal -->
        </section>
        
        <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("exe")) { %>
        
        <%}else{ %>
        <div class="row col-md-12">
		 <div class="col-md-12" style="background-color:#549ED1">
	      <img src="dist/img/alps.png" class="img-responsive" width="60%" width="50%">
	     </div>
        </div>
        <%}%>
	  </div>
	</div>
    <!-- jQuery 2.1.4 -->
    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="plugins/iCheck/icheck.min.js"></script>
    <script>
      $(function () {
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%' // optional
        });
      });
    </script>
    <script>
		var r = document.getElementById("repo");
		var x = document.getElementById("lat");
		var y = document.getElementById("long");
		var z = document.getElementById("alocation");
		//alert('loc'+myjson.results[0].address_components[1].short_name);
		
		function getLocation() {
		    if (navigator.geolocation) {
		        navigator.geolocation.getCurrentPosition(showPosition);
		    } else { 
		        r.innerHTML = "Geolocation is not supported by this browser. Enter Location Manually";
		    }
		}
		
		function showPosition(position) {
			var latlng = position.coords.latitude+","+position.coords.longitude;
			var xmlhttp = new XMLHttpRequest();
			var url = "http://maps.google.com/maps/api/geocode/json?latlng="+latlng+"&sensor=false";
			x.value = position.coords.latitude;
		    y.value = position.coords.longitude;	
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					var myArr = JSON.parse(xmlhttp.responseText);
					myFunction(myArr);
				}
			};
			xmlhttp.open("GET", url, true);
			xmlhttp.send();
		
			function myFunction(arr) {
				var out = "";
				out += arr.results[0].address_components[1].short_name;
				z.value = out;
			}
		    
		}
	</script>
    
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js"></script>
  </body>
</html>
