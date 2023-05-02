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
com.alps.Dhcp,
com.alps.ComExec,
com.alps.FileEditor,
com.alps.Gateway,
java.net.InetAddress,
java.net.UnknownHostException,
java.sql.PreparedStatement"
%>

<%
Dao dao = new Dao();
FileEditor fe = new FileEditor();
Dhcp d = new Dhcp(), curd = new Dhcp();
AlpsLog al = new AlpsLog();
Properties prop = new Properties();
ComExec cex = new ComExec();
%>
<%
if(request.getParameter("updatestat") != null) {
	String adip="", netmask="", smask="", gateway="", bc="", net="", currip="", csmask="", cnetmask="", cgateway="", cbc="", cdid="";
	//Getting Current IP Setting
	curd = d.getDhcp();
	currip = curd.getIp();csmask=curd.getSubmask();cnetmask = curd.getNetmask();cbc=curd.getBroadcast();cgateway=curd.getGateway();
	//New IP Settings
	adip = request.getParameter("ip").toString().trim();
	netmask = request.getParameter("netmask");
	smask = request.getParameter("smask");
	bc = request.getParameter("bcast");
	gateway = request.getParameter("gateway");

	//Do Change commands
	String command = "echo ebahnadmin | sudo ip addr del "+currip+"/"+cnetmask+" dev eth1";
	String command1 = "echo ebahnadmin | sudo ip addr add "+adip+"/"+netmask+" dev eth1";
	String command2 = "echo ebahnadmin | sudo ip addr add broadcast "+gateway+" dev eth1";
	String command3 = "echo ebahnadmin | sudo /etc/init.d/network restart";
	
	//Update Script and Do Change
	if(fe.editIpScr(adip,smask,netmask,gateway,bc,currip,cnetmask,csmask,cgateway,cbc)){
		if(cex.comExec(command)&&cex.comExec(command1)&&cex.comExec(command2)&&cex.comExec(command3)){
			//update ewsip.properties
			try { 
				d.setDhcp(adip, netmask, smask, gateway, bc);
			} catch(Exception e3) { System.out.println(e3);}
			String rswar = dao.getSetting("ip_path").replace("setip", "restartwar");
			cex.comExec(""+rswar);
			response.sendRedirect("http://"+adip+"");
		}
	}
}

%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Alps Gateway | Admin Port</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/AdminLTE.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="../../plugins/iCheck/square/blue.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body class="hold-transition login-page">
    <div class="login-box">
      <div class="login-logo">
        <a href="/"><img alt="LOGO" src="dist/img/alpslogo.png"></a>
      </div><!-- /.login-logo -->
      <div class="login-box-body">
        <h3 align="center" class="text-primary"><strong><b>Administrator Dashboard</b></strong></h3>
        <p class="login-box-msg">
	        <% 
	        Dhcp dcon = d.getDhcp();
	        if(request.getParameter("msg") != null) {out.println(request.getParameter("msg"));
	        }else{out.println("Please Set Your Network Profile");}
	        %>
        </p>
        <form action="dhcpws.jsp" method="post">
          <label>IP Address</label>
          <div class="form-group has-feedback">
            <input type="text" required class="form-control" placeholder="<%out.print(dcon.getIp()); %>" name="ip" id="ip">
            <span class="glyphicon glyphicon-laptop form-control-feedback"></span>
          </div>
          <label>Subnet Mask</label>
          <div class="row">
          	<div class="form-group col-md-7">
            	<input type="text" required class="form-control" placeholder="<%out.print(dcon.getNetmask()); %>" name="netmask" id="netmask">
            </div>
          	<div class="form-group col-md-5">
			    <select required class="form-control" name="smask">
			    	<option class="text-danger" value=""><%out.print(dcon.getSubmask()); %><option>
			      	<option></option>
			      	<% 
		               	for (int i = 0; i<=30; i++) {
		                	out.println("<option>/"+i+"</option>");
		               	}
	                 %>
			    </select>
			</div>
		  </div>
          <div class="form-group has-feedback">
          	<label>Gateway</label>
            <input type="text" required class="form-control" placeholder="<%out.print(dcon.getGateway()); %>" name="gateway" id="gateway">
            <span class="glyphicon glyphicon-tree-structure form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <label>Broadcast</label>
            <input type="text" required class="form-control" placeholder="<%out.print(dcon.getBroadcast()); %>" name="bcast" id="bcast">
            <span class="glyphicon glyphicon-tree-structure form-control-feedback"></span>
          </div>
          <div class="row">
            <div class="col-md-12">
              <input type="submit" name="updatestat" id="updatestat" value="Update Static IP Settings" class="btn btn-primary btn-block btn-flat">
            </div><!-- /.col -->
          </div>
        </form>

        <!--<div class="social-auth-links text-center">
          <p>- OR -</p>
          <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i> Sign in using Facebook</a>
          <a href="#" class="btn btn-block btn-social btn-google btn-flat"><i class="fa fa-google-plus"></i> Sign in using Google+</a>
        </div>--><!-- /.social-auth-links -->

        
      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->

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
  </body>
</html>
