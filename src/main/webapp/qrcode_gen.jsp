<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%!public String location = "", client ="", fu ="", fp ="";%>
<%
client = dao.getDashValue("client");
location = dao.getDashValue("location");
fu = dao.getSetting("free_user");
fp = dao.getSetting("free_pass");
%>
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
    QR CODE Authentication
    <small>Hotspot Authentication with QR Code</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Portal</a></li>
    <li class="active">QR Code</li>
  </ol>
</section>
 <section class="content">
  <div class="callout callout-info">
    <h4>Tip!</h4>
    <p>Click QR Code To Print.</p>
    <p>You can also right-click to save individual QR Code</p>
    <p>QR Code Authentication works best with QR Code Reader by Scan inc. Application is available on App Store and Play Store</p>
  </div>
  <!-- Default box -->
  <div class="box">
    <div class="box-header with-border">
      <h3 class="box-title">Hotspot QR Code</h3>
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
        <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
      </div>
    </div>
    <div class="box-body">
      <div class="row">
      <%!public static String servername = "", serveradd = "", linklogin = "", linklogindir = "", linkloginsoc = "";%>
      <% 
		try{
			for (Map<String,String> mp : g.hsserverprof()) { 
				servername = mp.get("name");
				if(!servername.contains("default") && !servername.contains("Default")){
					serveradd = mp.get("hotspot-address");
					linklogin = "http://"+serveradd+"/login";
					linklogindir = "http://"+serveradd+"/login?username="+fu+"&password="+fp;
					linkloginsoc = "http://developers.alpsgateway.com/login.php?li="+linklogin+"&location="+location+"&clientid="+client;
	  %>
         <div class="col-lg-4 col-xs-8">
           <!-- small box -->
           <div class="small-box bg-aqua">
             <div class="inner">
               <a href="javascript:window.print()"><img class="img-responsive" alt="" src="/qrcode?qrtext=<%out.println(URLEncoder.encode(linklogin, "UTF-8"));%>"></a>
             </div>
             <span class="small-box-footer"><%out.println(servername);%> &nbsp;- Landing Page&nbsp;&nbsp;<i class="fa fa-qrcode"></i></span>
           </div>
         </div><!-- ./col -->
         <div class="col-lg-4 col-xs-8">
           <!-- small box -->
           <div class="small-box bg-aqua">
             <div class="inner">
               <a href="javascript:window.print()"><img class="img-responsive" alt="" src="/qrcode?qrtext=<%out.println(URLEncoder.encode(linklogindir, "UTF-8"));%>"></a>
             </div>
             <span class="small-box-footer"><%out.println(servername);%> &nbsp; - Direct Login&nbsp;&nbsp;<i class="fa fa-qrcode"></i></span>
           </div>
         </div><!-- ./col -->
         <div class="col-lg-4 col-xs-8">
           <!-- small box -->
           <div class="small-box bg-aqua">
             <div class="inner">
               <a href="javascript:window.print()"><img class="img-responsive" alt="" src="/qrcode?qrtext=<%out.println(URLEncoder.encode(linkloginsoc, "UTF-8"));%>"></a>
             </div>
             <span class="small-box-footer"><%out.println(servername);%> &nbsp; - Social&nbsp;&nbsp;<i class="fa fa-qrcode"></i></span>
           </div>
         </div><!-- ./col -->
       <%    
				}
			}
		 }catch(Exception e){System.out.println(e);}%>
        </div>
    </div><!-- /.box-body -->
    <div class="box-footer">
      Works Best with <strong>QR Code Reader</strong> by Scan Inc. on IOS And Android.
    </div><!-- /.box-footer-->
  </div><!-- /.box -->
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