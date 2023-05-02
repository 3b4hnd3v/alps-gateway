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
java.sql.PreparedStatement"%>

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
    <title>ALPS Gateway | System Start Up</title>
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
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">

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
        background-image: url(https://lh4.googleusercontent.com/-XplyTa1Za-I/VMSgIyAYkHI/AAAAAAAADxM/oL-rD6VP4ts/w1184-h666/Android-Lollipop-wallpapers-Google-Now-Wallpaper-2.png);
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat;
		border: 3px solid transparent;
  		border-radius: 10px;
  		min-height:70vh;
      }
    </style>
  </head>
  <!-- ADD THE CLASS sidedar-collapse TO HIDE THE SIDEBAR PRIOR TO LOADING THE SITE -->
  <body class="hold-transition skin-blue sidebar-collapse sidebar-mini">
    <!-- Site wrapper -->
    <div class="wrapper">

      <header class="main-header">
        <!-- Logo -->
        <a href="" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>A</b>LPS</span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>ALPS</b> Gateway</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvasx" role="button">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              
              <!-- User Account: style can be found in dropdown.less -->
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdownx">
                  <img src="dist/img/wheel.png" class="user-image" alt="User Image">
                  <span class="hidden-xs">ALPS Start Up</span>
                </a>
                
              </li>
              <!-- Control Sidebar Toggle Button -->
              <li>
                <a href="#" data-toggle="control-sidebarx"><i class="fa fa-caret-right"></i></a>
              </li>
            </ul>
          </div>
        </nav>
      </header>

      <!-- =============================================== -->

      <!-- Left side column. contains the sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
          
        </section>
        <!-- /.sidebar -->
      </aside>

      <!-- =============================================== -->

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            ALPS Start Up
            <small>Please follow the steps below to start up your gateway</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Start Up</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <%if(request.getParameter("msg") != null && request.getParameter("type") != null && request.getParameter("type").equals("error")){ %>
				<div class="alert alert-danger alert-dismissible">
				  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				  <h4><i class="icon fa fa-ban"></i> Oops :( !</h4>
				  <%out.println(request.getParameter("msg")); %>
				</div>
		  <%}else if(request.getParameter("msg") != null && request.getParameter("type") != null && request.getParameter("type").equals("success")){ %>
				<div class="alert alert-success alert-dismissible">
				  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				  <h4><i class="icon fa fa-info"></i> Alert!</h4>
				  <%out.println(request.getParameter("msg")); %>
				</div>
		  <%}else if(request.getParameter("msg") != null){ %>
				<div class="alert alert-info alert-dismissible">
				  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				  <h4><i class="icon fa fa-info"></i> Alert!</h4>
				  <%out.println(request.getParameter("msg")); %>
				</div>
		  <%}%>
          
          	  	
          <% if(request.getParameter("q") != null && request.getParameter("q").equals("UserReg")) { %>
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
          <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("ClientReg")) { %>
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
          <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("HomePage")) { %>
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
          <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("LicenseAct")) { %>
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
          <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("Location")) { %>
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
          <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("exe")) { %>
        
          <%}else{ %>
          <div class="row">
          	 
	          <div class="col-sm-8">
		          <!-- Default box -->
		          <div class="box">
		            <div class="box-header with-border">
		              <h3 class="box-title">&nbsp;</h3>
		              
		            </div>
		            <div class="box-body" style="max-height:70vh; overflow:hidden;">
		            	<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
		                    <ol class="carousel-indicators">
		                      <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
		                      <li data-target="#carousel-example-generic" data-slide-to="1" class=""></li>
		                      <li data-target="#carousel-example-generic" data-slide-to="2" class=""></li>
		                      <li data-target="#carousel-example-generic" data-slide-to="3" class=""></li>
		                      <li data-target="#carousel-example-generic" data-slide-to="4" class=""></li>
		                    </ol>
		                    <div class="carousel-inner">
		                      <div class="item active">
		                        <img style="width:100%; height:70vh;" src="dist/img/aboutus.png" alt="First slide">
		                        <div class="carousel-caption">
		                          About ALPS
		                        </div>
		                      </div>
		                      <div class="item">
		                        <img style="width:100%; height:70vh;" src="dist/img/alps.png" alt="Second slide">
		                        <div class="carousel-caption">
		                          ALPS Gateway
		                        </div>
		                      </div>
		                      <div class="item">
		                        <img style="width:100%; height:70vh;" src="dist/img/application.png" alt="Third slide">
		                        <div class="carousel-caption">
		                          Applications
		                        </div>
		                      </div>
		                      <div class="item">
		                        <img style="width:100%; height:70vh;" src="dist/img/corevalue.png" alt="Third slide">
		                        <div class="carousel-caption">
		                          Core Values
		                        </div>
		                      </div>
		                      <div class="item">
		                        <img style="width:100%; height:70vh;" src="dist/img/04.jpg" alt="Third slide">
		                        <div class="carousel-caption">
		                          Core Values
		                        </div>
		                      </div>
		                    </div>
		                    <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
		                      <span class="fa fa-angle-left"></span>
		                    </a>
		                    <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
		                      <span class="fa fa-angle-right"></span>
		                    </a>
		                  </div>
		            </div><!-- /.box-body -->
		            <div class="box-footer">
		              <a href="?q=UserReg"><button class = "btn btn-block btn-lg btn-danger">Start Installation</button></a>
		            </div><!-- /.box-footer-->
		          </div><!-- /.box -->
	          </div>
	          <div class="col-md-4">
	              <div class="box box-solid" style="min-height:82vh;">
	                <div class="box-header with-border">
	                  <h3 class="box-title">Our Features</h3>
	                  <div class="box-tools">
	                    <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	                  </div>
	                </div>
	                <div class="box-body no-padding">
	                  <ul class="nav nav-pills nav-stacked">
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Plug And Play <span class="label label-primary pull-right">12</span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Easy Deployment </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> User Friendly GUI </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Easy To Use <span class="label label-warning pull-right">65</span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Simplified Configurations</a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> WAN Load Balancing </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> WAN Load Balancing </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> 24 / 7 System Support </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Quality Of Service Guaranteed </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Bandwidth Usage Control </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> AAA Features Including Radius </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Beautiful Landing Pages </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Social Authentication </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Multiple Customizable Captive Portals </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-ellipsis-h"></i> And Much More </a></li>
	                  </ul>
	                </div><!-- /.box-body -->
	              </div><!-- /. box -->
	              
	          </div><!-- /.col -->
          </div>
          <%}%>
          
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->

      <footer class="main-footer">
		  <div class="pull-right hidden-xs">
		    <b>ALPS</b> Start UP
		  </div>
		  <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">Alps Gateway</a>.</strong> All rights reserved.
	  </footer>

      <!-- Control Sidebar -->
      <aside class="control-sidebar control-sidebar-dark">
        
      </aside><!-- /.control-sidebar -->
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->

    <!-- jQuery 2.1.4 -->
    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js"></script>
  </body>
</html>
