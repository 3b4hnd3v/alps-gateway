<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<div class="content-wrapper">
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
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    WIFI Finder QR Code
    <small>Hotspot WIFI Finder By QR Code</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">QR Code</a></li>
    <li class="active">WIFI Finder</li>
  </ol>
</section>
 <section class="content">
  <div class="callout callout-info">
    <h4>Tip!</h4>
    <p>Click QR Code To Print.</p>
    <p>You can also right-click to save individual QR Code</p>
    <p>QR Code Authentication works best with QR Code Reader by Scan inc. Application is available on App Store and Play Store</p>
  </div>
  <%if(request.getParameter("submit")!=null && request.getParameter("submit").equals("Create WIFI Finder")){ %>
  <!-- Default box -->
  <div class="box">
    <div class="box-header with-border">
      <h3 class="box-title">WIFI Finder QR Code</h3>
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
        <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
      </div>
    </div>
    <div class="box-body">
      <div class="row">
      
      <%String wifiname = "No Wifi", username = "0x0", password = "0x0", hide = "false", linklogin = ""; %>
      <% 
		try{
			wifiname = request.getParameter("wifiname");
			username = request.getParameter("username");
			password = request.getParameter("password");
			hide = request.getParameter("hiding");
			linklogin = "WIFI:T:"+username+";S:"+wifiname+";P:"+password+";H:"+hide+";";
	 %>
         <div class="col-lg-6 col-lg-offset-3">
           <!-- small box -->
           <div class="small-box bg-aqua">
             <div class="inner">
               <a href="javascript:window.print()"><img class="img-responsive" alt="" src="/qrcode?qrtext=<%out.println(URLEncoder.encode(linklogin, "UTF-8"));%>"></a>
             </div>
             <span class="small-box-footer"><%out.println(wifiname);%> &nbsp;- Landing Page&nbsp;&nbsp;<i class="fa fa-qrcode"></i></span>
           </div>
         </div><!-- ./col -->
       <%}catch(Exception e){System.out.println(e);}%>
        </div>
    </div><!-- /.box-body -->
    <div class="box-footer">
      Works Best with <strong>QR Code Reader</strong> by Scan Inc. on IOS And Android.
    </div><!-- /.box-footer-->
  </div><!-- /.box -->
  <%}else{%>
  <!-- Default box -->
  <div class="box">
    <div class="box-header with-border">
      <h3 class="box-title">Generate WIFI Finder</h3>
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
        <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
      </div>
    </div>
    <div class="box-body">
      <div class="row">
         <div class="col-lg-6 col-lg-offset-3">
               <form action="wifiqr.jsp" method="post">
		      		<div class="col-sm-12 form-group">
				      	<label>SSID Name</label>
						<input type="text" class="form-control" name="wifiname"><br />
					</div>
		      		<div class="col-sm-6 form-group">
				      	<label>Authentication </label>
						<select name="username" class="form-control">
							<option value="nopass">No Password</option>
							<option value="WEP">WEP</option>
							<option value="WPA">WPA : Password Enabled</option>
							<option value="WPA">WPA 2 : Password Enabled</option>
						</select>
					</div>
					<div class="col-sm-6 form-group">
				      	<label>Password</label>
						<input type="text" class="form-control" name="password"><br />
					</div> 
					<div class="col-sm-6 form-group">
				      	<label>SSID Type</label>
						<select name="hiding" class="form-control">
							<option value="false">Open</option>
							<option value="true">Hidden</option>
						</select>
					</div>      		
		      		<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Create WIFI Finder" />
			   </form>
         </div><!-- ./col -->
        </div>
    </div><!-- /.box-body -->
    <div class="box-footer">
      Works Best with <strong>QR Code Reader</strong> by Scan Inc. on IOS And Android.
    </div><!-- /.box-footer-->
  </div><!-- /.box -->
  <%} %>
</section><!-- /.content -->
</div>
<footer class="main-footer">
  <div class="pull-right hidden-xs">
    <b>Version</b> <%=sysver%>
  </div>
  <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">Alps Gateway</a>.</strong> All rights reserved.
</footer>
</div> <!-- /.content -->
<!-- jQuery 2.1.4-->
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
<!-- page script -->
</body>
</html>