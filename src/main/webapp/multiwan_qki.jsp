<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
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
    MultiWan - Quick Install
    <small>Quick Installation</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">MultiWan</a></li>
    <li class="active">Quick Install</li>
  </ol>
</section>
<section class="content">
  <div class="col-md-12" style="background-color:#549ED1;" align="center">
  <br>
	<!--  div class="well" style="background-color:#549ED1;">-->
	<% String[] iparray = dao.getWANIP();
	   for(int i = 0; i < iparray.length; i++) { 
		   
		   if (iparray[i] != null){
		   		InetAddress iaddress = InetAddress.getByName(iparray[i]);
		   		boolean chkConnection = iaddress.isReachable(3000);
		   		if (chkConnection == true){
	    %>
	   				<!-- green ip -->
	   				<div class="well col-md-3 col-xs-6" style="background-color:green;">
	   					<div class="col-md-3">
	   						<img alt="" class="img-responsive" src="dist/img/reached.png">
	   					</div>
	   					<div class="col-md-9">
	   						<p>Reachable</p>
	   					</div>
	   				</div>
	    <% 		} else{ %>
	  		   		<!-- red ip -->
	  		   		<div class="well col-md-3 col-xs-6" style="background-color:orange;">
	   					<div class="col-md-3">
	   						<img alt="" class="img-responsive" src="dist/img/unreached.png">
	   					</div>
	   					<div class="col-md-9">
	   						<p>Un-Reachable</p>
	   					</div>
	   				</div>
	  
	  	<%	}}else{ %>
	  			<!-- empty/inactive -->
	  			<div class="well col-md-3 col-xs-6" style="background-color:red;">
   					<div class="col-md-3">
   						<img alt="" class="img-responsive"  src="dist/img/inactive.png">
   					</div>
   					<div class="col-md-9">
   						<p>Inactive</p>
   					</div>
	   			</div>
	  	
	  	<%	}}%>
		
	</div>
</section>

<section class="content">
 <!-- Small boxes (Stat box) -->
 <div class="row col-md-12">
   <div class="col-lg-3 col-xs-6">
     <!-- small box -->
     <div class="small-box bg-aqua">
       <div class="inner">
         <h3>1 Port</h3>
         <p>No Wan Balancing</p>
         <p>3 ports Inactive</p>
       </div>
       <div class="icon">
         <i class="ion ion-bag"></i>
       </div>
       <a href="?q=1WAN" class="small-box-footer">Activate Now <i class="fa fa-arrow-circle-right"></i></a>
     </div>
   </div><!-- ./col -->
   <div class="col-lg-3 col-xs-6">
     <!-- small box -->
     <div class="small-box bg-green">
       <div class="inner">
         <h3>2 Port</h3>
         <p>2 Line-Wan Balancing</p>
         <p>2 ports Inactive</p>
       </div>
       <div class="icon">
         <i class="ion ion-stats-bars"></i>
       </div>
       <a href="?q=2WAN" class="small-box-footer">Activate Now <i class="fa fa-arrow-circle-right"></i></a>
     </div>
   </div><!-- ./col -->
   <div class="col-lg-3 col-xs-6">
     <!-- small box -->
     <div class="small-box bg-yellow">
       <div class="inner">
         <h3>3 Ports</h3>
         <p>3 Line-Wan Balancing</p>
         <p>1 port Inactive</p>
       </div>
       <div class="icon">
         <i class="ion ion-person-add"></i>
       </div>
       <a href="?q=3WAN" class="small-box-footer">Activate Now <i class="fa fa-arrow-circle-right"></i></a>
     </div>
   </div><!-- ./col -->
   <div class="col-lg-3 col-xs-6">
     <!-- small box -->
     <div class="small-box bg-red">
       <div class="inner">
         <h3>4 Ports</h3>
         <p>3 Line-Wan Balancing</p>
         <p>All ports Active</p>
       </div>
       <div class="icon">
         <i class="ion ion-pie-graph"></i>
       </div>
       <a href="?q=4WAN" class="small-box-footer">Activate Now <i class="fa fa-arrow-circle-right"></i></a>
     </div>
   </div><!-- ./col -->
 </div><!-- /.row -->
</section>
 
<section class="content" id="activate">
<% if(request.getParameter("q") != null && request.getParameter("q").equals("1WAN")) { %>
	<div class="example-modal">
      <div class="modal modal-info">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title" id="activebox">1 Port WAN</h4>
            </div>
            <div class="modal-body">
              <h4>Before you proceed &hellip;</h4>
              <p>By Activating this quick set up;</p>
              <p>ALL previous setup will be deleted and ALPS will reset to default.</p>
              <p>MultiWan functionality will be suspended. This can however be re-activated any time through this same process</p>
              <p>IP Address will be reset to default too. So you will need to change IP to your address range. Please refer to manual to see how to change IP.</p>
              <p>Click Proceed to continue.</p>
            </div>
            <div class="modal-footer">
              <a href="multiwan_qki.jsp"><button type="button" class="btn btn-outline pull-left">Cancel</button></a>
              <a href="action.jsp?q=multiwan&port=<%out.print(request.getParameter("q"));%>"><button type="button" class="btn btn-outline">Activate</button></a>
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div><!-- /.modal -->
    </div><!-- /.example-modal -->
    <script type="text/javascript">document.getElementById("activebox").scrollIntoView();</script>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("2WAN")) { %>
	<div class="example-modal">
     <div class="modal modal-success">
       <div class="modal-dialog">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
             <h4 class="modal-title">2 Port MultiWan</h4>
           </div>
           <div class="modal-body" id="activebox">
             <h4>Before you proceed &hellip;</h4>
             <p>By Activating this quick set up;</p>
             <p>ALL previous setup will be deleted and ALPS will reset to default.</p>
             <p>MultiWan functionality will be suspended. This can however be re-activated any time through this same process</p>
             <p>IP Address will be reset to default too. So you will need to change IP to your address range. Please refer to manual to see how to change IP.</p>
             <p>Click Proceed to continue.</p>
           </div>
           <div class="modal-footer">
             <a href="multiwan_qki.jsp"><button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Cancel</button></a>
             <a href="action.jsp?q=multiwan&port=<%out.print(request.getParameter("q"));%>"><button type="button" class="btn btn-outline">Activate</button></a>
           </div>
         </div><!-- /.modal-content -->
       </div><!-- /.modal-dialog -->
     </div><!-- /.modal -->
   </div><!-- /.example-modal -->
   <script type="text/javascript">document.getElementById("activebox").scrollIntoView();</script>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("3WAN")) { %>
   <div class="example-modal">
     <div class="modal modal-warning">
       <div class="modal-dialog">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
             <h4 class="modal-title">3 Port MultiWan</h4>
           </div>
           <div class="modal-body" id="activebox">
             <h4>Before you proceed &hellip;</h4>
             <p>By Activating this quick set up;</p>
             <p>ALL previous setup will be deleted and ALPS will reset to default.</p>
             <p>MultiWan functionality will be suspended. This can however be re-activated any time through this same process</p>
             <p>IP Address will be reset to default too. So you will need to change IP to your address range. Please refer to manual to see how to change IP.</p>
             <p>Click Proceed to continue.</p>
           </div>
           <div class="modal-footer">
             <a href="multiwan_qki.jsp"><button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Cancel</button></a>
             <a href="action.jsp?q=multiwan&port=<%out.print(request.getParameter("q"));%>"><button type="button" class="btn btn-outline">Activate</button></a>
           </div>
         </div><!-- /.modal-content -->
       </div><!-- /.modal-dialog -->
     </div><!-- /.modal -->
   </div><!-- /.example-modal -->
  <script type="text/javascript">document.getElementById("activebox").scrollIntoView();</script>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("4WAN")) { %>
  <div class="example-modal">
   <div class="modal modal-danger">
     <div class="modal-dialog">
       <div class="modal-content">
         <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           <h4 class="modal-title">4 Port MultiWan</h4>
         </div>
         <div class="modal-body" id="activebox">
           <h4>Before you proceed &hellip;</h4>
           <p>By Activating this quick set up;</p>
           <p>ALL previous setup will be deleted and ALPS will reset to default.</p>
           <p>MultiWan functionality will be suspended. This can however be re-activated any time through this same process</p>
           <p>IP Address will be reset to default too. So you will need to change IP to your address range. Please refer to manual to see how to change IP.</p>
           <p>Click Proceed to continue.</p>
         </div>
         <div class="modal-footer">
           <a href="multiwan_qki.jsp"><button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Cancel</button></a>
           <a href="action.jsp?q=multiwan&port=<%out.print(request.getParameter("q"));%>"><button type="button" class="btn btn-outline">Activate</button></a>
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div><!-- /.modal -->
 </div><!-- /.example-modal -->
<script type="text/javascript">document.getElementById("activebox").scrollIntoView();</script>
<%} %>
</section>
</div><!-- /.content-wrapper -->
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