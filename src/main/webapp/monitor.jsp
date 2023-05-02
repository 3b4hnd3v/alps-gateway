<%@include file="header.jsp" %>

 <body class="hold-transition skin-blue layout-boxed sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>      
<!-- =============================================== -->
<%!
public String mobile = "";
public String tablet = "";
public String pc ="";
public String all ="";
public double totuptime = 0.0;
public int totpacin =0;
public int totpacout =0;
%>	
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
      
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>ALPS Management And Control</h1>
  <small>Single Glance Dashboard and Quick Reports</small>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active">AMAC</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <!-- Info boxes -->
  <div class="row">
    <div class="col-md-3 col-sm-6 col-xs-12">
      <div class="info-box">
        <span class="info-box-icon bg-aqua"><i class="ion ion-ios-people-outline"></i></span>
        <div class="info-box-content">
          <span class="info-box-text">User Accounts</span>
         	<% 
         	try{
         		for (Map<String,String> mp : gc.users()) {
         	
				String s = mp.get("ret"); %>
				<span class="info-box-number"><%out.println(s); %></span>
				<% } 
         	}catch(Exception e){System.out.println(e);response.sendRedirect("ipchange.jsp");}
         	%>
          
        </div><!-- /.info-box-content -->
      </div><!-- /.info-box -->
    </div><!-- /.col -->
    <div class="col-md-3 col-sm-6 col-xs-12">
      <div class="info-box">
        <span class="info-box-icon bg-red"><i class="ion-wifi"></i></span>
        <div class="info-box-content">
          <span class="info-box-text">Hotspot Active Users</span>
          <% 
          try{
          	for (Map<String,String> mp : gc.activeUsers()) {
			String s = mp.get("ret"); %>
           	<span class="info-box-number"><%out.println(s); %></span>
          <% } }catch(Exception e){System.out.println("count"+e);}%>
        </div><!-- /.info-box-content -->
      </div><!-- /.info-box -->
    </div><!-- /.col -->

    <!-- fix for small devices only -->
    <div class="clearfix visible-sm-block"></div>

    <div class="col-md-3 col-sm-6 col-xs-12">
      <div class="info-box">
        <span class="info-box-icon bg-green"><i class="ion ion-network"></i></span>
        <div class="info-box-content">
          <span class="info-box-text">Interfaces</span>
          <% try{
        	  for (Map<String,String> mp : gc.interfaces()) {
          
				String s = mp.get("ret"); %>
          		<span class="info-box-number"><%out.println(s); %></span>
          <% } }catch(Exception e){System.out.println("count"+e);}%>
        </div><!-- /.info-box-content -->
      </div><!-- /.info-box -->
    </div><!-- /.col -->
    <div class="col-md-3 col-sm-6 col-xs-12">
      <div class="info-box">
        <span class="info-box-icon bg-yellow"><i class="ion ion-iphone"></i></span>
        <div class="info-box-content">
          <span class="info-box-text">Host Devices</span>
          <% try{
        	  for (Map<String,String> mp : gc.hosts()) {
				String s = mp.get("ret"); %>
          		<span class="info-box-number"><%out.println(s); %></span>
          <% }  }catch(Exception e){System.out.println("count"+e);}%>
        </div><!-- /.info-box-content -->
      </div><!-- /.info-box -->
    </div><!-- /.col -->
  </div><!-- /.row -->

  <div class="row">
    <div class="col-md-12">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title" id="info"></h3>
          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
            <div class="btn-group">
              <button type="button" class="btn btn-box-tool dropdown-toggle" data-toggle="dropdown"><i class="fa fa-wrench"></i></button>
              <ul class="dropdown-menu" role="menu">
                <li><a class="btn btn-warning btn-flat" onclick="ConfirmReset()">Reset <i class="fa fa-times pull-right"></i></a></li>
                <li><a class="btn btn-success btn-flat" href="#">Refresh <i class="fa fa-refresh pull-right"></i></a></li>
                <li class="divider"></li>
                <li><a href="#">Edit <i class="fa fa-edit pull-right"></i></a></li>
              </ul>
            </div>
            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
          </div>
        </div><!-- /.box-header -->
        <div class="box-body">
          <div class="row">
            <div class="col-md-8">
              <!--<p class="text-center">
                <strong>Total Network Usage Per Month</strong>
              </p>-->
              <div class="chart" id="voltaic_holder" style="background-image: url(dist/img/loading.gif); height:400px; background-repeat:no-repeat;position:relative;">
              	<!-- <img alt="Bandwidth Utilization" class="img-responsive" src="/chart?type=ds&w=700&h=350">-->
                <!-- Sales Chart Canvas -->
                <canvas id="salesChart" style="height: 400px;"></canvas>
              </div><!-- /.chart-responsive -->
            </div><!-- /.col -->
            <div class="col-md-4">
              <p class="text-center">
                <strong>Device Login History</strong>
              </p>
              <div class="progress-group">
                <span class="progress-text">Total Number of Mobile Devices</span>
                <%
                connect();
                try {
              		ResultSet rs1 = cn.createStatement().executeQuery("SELECT COUNT(*) AS `mobile` FROM `onlinusers` WHERE device='Mobile'"); rs1.next();
            		mobile = rs1.getString("mobile");
            		cn.close();
            	} catch(Exception e) { mobile = "N/A";} %>
                <span class="progress-number"><b><%out.println(mobile); %></b></span>
                <div class="progress sm">
                  <div class="progress-bar progress-bar-aqua" style="width: <%out.println(mobile+"%");%>"></div>
                </div>
              </div><!-- /.progress-group -->
              <div class="progress-group">
                <span class="progress-text">Total Number of Tablets</span>
                <%
                connect();
                try {
              		ResultSet rs1 = cn.createStatement().executeQuery("SELECT COUNT(*) AS `tablet` FROM `onlinusers` WHERE device='Tablet'"); rs1.next();
            		tablet = rs1.getString("tablet");
            		cn.close();
            	} catch(Exception e) { tablet = "N/A";} %>
                <span class="progress-number"><b><%out.println(tablet); %></b></span>
                <div class="progress sm">
                  <div class="progress-bar progress-bar-red" style="width: <%out.println(tablet+"%");%>"></div>
                </div>
              </div><!-- /.progress-group -->
              <div class="progress-group">
                <span class="progress-text">Total Number of PC</span>
                <% 
                 connect();
                 try {
               		ResultSet rs1 = cn.createStatement().executeQuery("SELECT COUNT(*) AS `pc` FROM `onlinusers` WHERE device='PC'"); rs1.next();
             		pc = rs1.getString("pc");
             		cn.close();
             	} catch(Exception e) { tablet = "N/A";} %>
                <span class="progress-number"><b><%out.println(pc); %></b></span>
                <div class="progress sm">
                  <div class="progress-bar progress-bar-green" style="width: <%out.println(pc+"%");%>"></div>
                </div>
              </div><!-- /.progress-group -->
              <div class="progress-group">
                <span class="progress-text">Total Number of Connected Devices</span>
                <% 
                 connect();
                 try {
               		ResultSet rs1 = cn.createStatement().executeQuery("SELECT COUNT(*) AS `all` FROM `onlinusers`"); rs1.next();
             		all = rs1.getString("all");
             		cn.close();
             	} catch(Exception e) { tablet = "N/A";} %>
                <span class="progress-number"><b><%out.println(all); %></b></span>
                <div class="progress sm">
                  <div class="progress-bar progress-bar-yellow" style="width: <%out.println(all+"%");%>"></div>
                </div>
              </div><!-- /.progress-group -->
            </div><!-- /.col -->
          </div><!-- /.row -->
        </div><!-- ./box-body -->
        <div class="box-footer">
          <div class="row">
            <div class="col-sm-3 col-xs-6">
              <div class="description-block border-right">
                <span class="description-percentage text-green"><i class="fa fa-x5 fa-caret-up"></i></span>
                <%
                try{
                  totuptime = 0;
		            for (Map<String,String> mp : g.users()) {
		          	  String t = mp.get("uptime");
		          	  t = t.replace("w", ":");
		          	  t = t.replace("d", ":");
		          	  t = t.replace("h", ":");
		          	  t = t.replace("m", ":");
		          	  t = t.replace("s", "");
		          	  String[] ut = t.split(":");
		          	  if(ut.length == 2){
			           	  int m = Integer.parseInt(ut[0]);
			           	  int s = Integer.parseInt(ut[1]);
			           	  double tot = m + s/60;
			           	  totuptime = totuptime + tot;
			          	  System.out.println("L2 = "+totuptime);
		          	  }if(ut.length == 3){
		          		  int h = Integer.parseInt(ut[0]);
			           	  int m = Integer.parseInt(ut[1]);
			           	  int s = Integer.parseInt(ut[2]);
			           	  double tot = (60 * h) + m + (s/60);
			           	  totuptime = totuptime + tot;
			          	  //System.out.println("L3 = "+totuptime);
		          	  }else if(ut.length == 4){
		          		  int d = Integer.parseInt(ut[0]);
			           	  int h = Integer.parseInt(ut[1]);
			           	  int m = Integer.parseInt(ut[2]);
			           	  int s = Integer.parseInt(ut[3]);
			           	  int tot = (1440 * d) + (60 * h) + m + (s/60) ;
			           	  totuptime = totuptime + tot;
			          	  //System.out.println("L4 = "+totuptime);
		          	  }else if(ut.length == 5){
		          		  int w = Integer.parseInt(ut[0]);
		          		  int d = Integer.parseInt(ut[1]);
			           	  int h = Integer.parseInt(ut[2]);
			           	  int m = Integer.parseInt(ut[3]);
			           	  int s = Integer.parseInt(ut[4]);
			           	  int tot = (10080 * w) + (1440 * d) + (60 * h) + m + (s/60) ;
			           	  totuptime = totuptime + tot;
			          	 // System.out.println("L5 = "+totuptime);
		          	  }else if(ut.length == 1){
		          		  totuptime = totuptime + Integer.parseInt(ut[0]);
			          	  //System.out.println("L1 = "+totuptime);
		          	  }else
		          		  totuptime = 0.0;
		            }
		          	  
				}catch(Exception e){System.out.print(e);}%>
                <h5 class="description-header"><% out.println(totuptime); %></h5>
                <span class="description-text">TOTAL MINUTES ONLINE</span>
              </div><!-- /.description-block -->
            </div><!-- /.col -->
            <div class="col-sm-3 col-xs-6">
              <div class="description-block border-right">
                <span class="description-percentage text-yellow"><i class="fa fa-x5 fa-caret-up"></i></span>
                <%
                try{
                	totpacin = 0;
                	totpacin = gc.totPacIn();
            	}catch(Exception e){System.out.print(e);}%>
                <h5 class="description-header"><% out.println(Math.abs(totpacin)); %></h5>
                <span class="description-text">TOTAL PACKETS DOWNLOAD</span>
              </div><!-- /.description-block -->
            </div><!-- /.col -->
            <div class="col-sm-3 col-xs-6">
              <div class="description-block border-right">
              	<%
              	try{
             		totpacout = 0;
             		totpacout =  gc.totPacOut();
				}catch(Exception e){System.out.print(e);}%>
                <span class="description-percentage text-green"><i class="fa fa-x5 fa-caret-up"></i></span>
                <h5 class="description-header"><% out.println(totpacout); %></h5>
                <span class="description-text">TOTAL PACKETS UPLOAD</span>
              </div><!-- /.description-block -->
            </div><!-- /.col -->
            <div class="col-sm-3 col-xs-6">
              <div class="description-block">
                <span class="description-percentage text-red"><i class="fa fa-x5 fa-caret-up"></i></span>
                <% try{
                	for (Map<String,String> mp : gc.hosts()) {
 					String s = mp.get("ret"); %>
                	<h5 class="description-header"><%out.println(s); %></h5>
                <% } }catch(Exception e){System.out.print(e);}%>
                <span class="description-text">TOTAl NUMBER OF GUESTS</span>
              </div><!-- /.description-block -->
            </div>
          </div><!-- /.row -->
        </div><!-- /.box-footer -->
      </div><!-- /.box -->
      
     <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title col-md-9" id="info">Network Diagnosis</h3>
        <h1 class="box-title col-md-3  pull-left text-danger" id="info">Network Errors And Drops</h1>
      </div><!-- /.box-header -->
      <div class="box-body"></div>
      <div class="box-footer">
        <div class="row">
          <div class="col-sm-3 col-xs-6">
            <div class="description-block border-right">
              <span class="description-percentage text-green"><i class="fa fa-caret-up"></i></span>
              <h5 class="description-header"><%out.println(gc.totDropsOut()); %></h5>
              <span class="description-text">UPLOAD PACKET DROPS</span>
            </div><!-- /.description-block -->
          </div><!-- /.col -->
          <div class="col-sm-3 col-xs-6">
            <div class="description-block border-right">
              <span class="description-percentage text-green"><i class="fa fa-caret-up"></i></span>
              <h5 class="description-header"><%out.println(gc.totErrorsOut()); %></h5>
              <span class="description-text">UPLOAD PACKET ERRORS</span>
            </div><!-- /.description-block -->
          </div><!-- /.col -->
          <div class="col-sm-3 col-xs-6">
            <div class="description-block border-right">
              <span class="description-percentage text-red"><i class="fa fa-caret-down"></i></span>
              <h5 class="description-header"><%out.println(gc.totDropsIn()); %></h5>
              <span class="description-text">DOWNLOAD PACKET DROPS</span>
            </div><!-- /.description-block -->
          </div><!-- /.col -->
          <div class="col-sm-3 col-xs-6">
            <div class="description-block">
              <span class="description-percentage text-red"><i class="fa fa-caret-down"></i></span>
              <h5 class="description-header"><%out.println(gc.totErrorsIn()); %></h5>
              <span class="description-text">DOWNLOAD PACKET ERRORS</span>
            </div><!-- /.description-block -->
          </div>
        </div><!-- /.row -->
      </div><!-- /.box-footer -->
    </div><!-- /.box -->
      
    </div><!-- /.col -->
  </div><!-- /.row -->

</div><!-- /.content-wrapper -->

<footer class="main-footer">
  <div class="pull-right hidden-xs">
    <b>Version</b> <%=sysver%>
  </div>
  <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">eBahn Technology Sdn. Bhd</a>.</strong> All rights reserved.
</footer>

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
  <!-- Create the tabs -->
<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
  <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
  <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
</ul>
<!-- Tab panes -->
<div class="tab-content">
  <!-- Home tab content -->
  <div class="tab-pane" id="control-sidebar-home-tab">
    <h3 class="control-sidebar-heading">Recent Activity</h3>
    <ul class="control-sidebar-menu">
      <li>
        <a href="javascript::;">
          <i class="menu-icon fa fa-birthday-cake bg-red"></i>
          <div class="menu-info">
            <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>
            <p>Will be 23 on April 24th</p>
          </div>
        </a>
      </li>
      <li>
        <a href="javascript::;">
          <i class="menu-icon fa fa-user bg-yellow"></i>
          <div class="menu-info">
            <h4 class="control-sidebar-subheading">Frodo Updated His Profile</h4>
            <p>New phone +1(800)555-1234</p>
          </div>
        </a>
      </li>
      <li>
        <a href="javascript::;">
          <i class="menu-icon fa fa-envelope-o bg-light-blue"></i>
          <div class="menu-info">
            <h4 class="control-sidebar-subheading">Nora Joined Mailing List</h4>
            <p>nora@example.com</p>
          </div>
        </a>
      </li>
      <li>
        <a href="javascript::;">
          <i class="menu-icon fa fa-file-code-o bg-green"></i>
          <div class="menu-info">
            <h4 class="control-sidebar-subheading">Cron Job 254 Executed</h4>
            <p>Execution time 5 seconds</p>
          </div>
        </a>
      </li>
    </ul><!-- /.control-sidebar-menu -->

    <h3 class="control-sidebar-heading">Tasks Progress</h3>
    <ul class="control-sidebar-menu">
      <li>
        <a href="javascript::;">
          <h4 class="control-sidebar-subheading">
            Custom Template Design
            <span class="label label-danger pull-right">70%</span>
          </h4>
          <div class="progress progress-xxs">
            <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
          </div>
        </a>
      </li>
      <li>
        <a href="javascript::;">
          <h4 class="control-sidebar-subheading">
            Update Resume
            <span class="label label-success pull-right">95%</span>
          </h4>
          <div class="progress progress-xxs">
            <div class="progress-bar progress-bar-success" style="width: 95%"></div>
          </div>
        </a>
      </li>
      <li>
        <a href="javascript::;">
          <h4 class="control-sidebar-subheading">
            Laravel Integration
            <span class="label label-warning pull-right">50%</span>
          </h4>
          <div class="progress progress-xxs">
            <div class="progress-bar progress-bar-warning" style="width: 50%"></div>
          </div>
        </a>
      </li>
      <li>
        <a href="javascript::;">
          <h4 class="control-sidebar-subheading">
            Back End Framework
            <span class="label label-primary pull-right">68%</span>
          </h4>
          <div class="progress progress-xxs">
            <div class="progress-bar progress-bar-primary" style="width: 68%"></div>
          </div>
        </a>
      </li>
    </ul><!-- /.control-sidebar-menu -->

  </div><!-- /.tab-pane -->
  <!-- Stats tab content -->
  <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div><!-- /.tab-pane -->
  <!-- Settings tab content -->
  <div class="tab-pane" id="control-sidebar-settings-tab">
    <form method="post">
      <h3 class="control-sidebar-heading">General Settings</h3>
      <div class="form-group">
        <label class="control-sidebar-subheading">
          Report panel usage
          <input type="checkbox" class="pull-right" checked>
        </label>
        <p>
          Some information about this general settings option
        </p>
      </div><!-- /.form-group -->

      <div class="form-group">
        <label class="control-sidebar-subheading">
          Allow mail redirect
          <input type="checkbox" class="pull-right" checked>
        </label>
        <p>
          Other sets of options are available
        </p>
      </div><!-- /.form-group -->

      <div class="form-group">
        <label class="control-sidebar-subheading">
          Expose author name in posts
          <input type="checkbox" class="pull-right" checked>
        </label>
        <p>
          Allow the user to show his name in blog posts
        </p>
      </div><!-- /.form-group -->

      <h3 class="control-sidebar-heading">Chat Settings</h3>

      <div class="form-group">
        <label class="control-sidebar-subheading">
          Show me as online
          <input type="checkbox" class="pull-right" checked>
        </label>
      </div><!-- /.form-group -->

      <div class="form-group">
        <label class="control-sidebar-subheading">
          Turn off notifications
          <input type="checkbox" class="pull-right">
        </label>
      </div><!-- /.form-group -->

      <div class="form-group">
        <label class="control-sidebar-subheading">
          Delete chat history
          <a href="javascript::;" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>
        </label>
      </div><!-- /.form-group -->
    </form>
  </div><!-- /.tab-pane -->
  </div>
</aside><!-- /.control-sidebar -->
<!-- Add the sidebar's background. This div must be placed
     immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div><!-- ./wrapper -->

<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- ChartJS 1.0.1 -->
<script src="plugins/chartjs/Chart.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard2.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<% 
if(request.getParameter("q")!=null && request.getParameter("q").equals("resetcomplete")){

%>
	<script>
		var x = "Reset Completed Successfully!"; 
		document.getElementById("info").innerHTML = x;
	</script>
<% }%>
<script>
function ConfirmReset() {
    var x;
    if (confirm("Press a button!") == true) {
    	window.location = "action.jsp?q=resetgraph";
    } else {
        x = "Reset Cancelled!";
    }
    document.getElementById("info").innerHTML = x;
}
</script>
  </body>
</html>
