<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%!public String eid="",venue="",venueno="",evn="",comp="",cont="",phone="",email="",stdate="",puser="",ppass="",endate="",days="",dayrate="",pax="",paxrate="",server="",plan="",planname="",prof="",planid="",lbi="",lbo=""; 
	public double subtotal=0.00,total=0.00,subtax=0.00;%>
<%
if(request.getParameter("pid") != null){
String item = request.getParameter("pid");
connect();
	 try {
		ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `mr_purchase` WHERE `id`="+item);
	  	
	  	while(rs.next()){
	  		eid=rs.getString("id");
	  		venue=rs.getString("mr_name");
	  		venueno=rs.getString("mr_id");
	  		evn=rs.getString("description");
	  		comp=rs.getString("company_name");
	  		cont=rs.getString("contact_person");
	  		phone=rs.getString("contact_phone");
	  		email=rs.getString("contact_email");
	  		stdate=rs.getString("start_date");
	  		puser=rs.getString("username");
	  		ppass=rs.getString("password");
	  		endate=rs.getString("end_date");
	  		pax=rs.getString("connections");
	  		plan=rs.getString("plan_name");
	  	}
	  	
		ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `mr_purchase_line` WHERE `purchase`="+item);
	  	
	  	while(rs1.next()){
	  		total=rs1.getDouble("amount");
	  	}
	  	
	cn.close();
  } catch(Exception e) {System.out.print(e);}
}
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
           Conference Room Events
           <small>Event Summary</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">EBS</a></li>
           <li class="active">Events</li>
         </ol>
       </section>
	<section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#">
                 Your Event <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse in">
             <div class="box-body">
             	<br /><div class="col-sm-12" align="center"><strong>Event No:</strong> <% out.print(eid); %></div><br />
             	<div class="col-sm-12"><strong>Event Name:</strong> <% out.print(evn); %></div><br />
             	<div class="col-sm-12"><strong>Organiser:</strong> <% out.print(comp); %></div><br />
             	<div class="col-sm-6"><strong>From:</strong> <% out.print(stdate); %></div>
             	<div class="col-sm-6"><strong>To:</strong> <% out.print(endate); %></div><br />
             	<br /><div class="col-sm-12" align="center"><strong>Contact Information</strong></div><br />
             	<div class="col-sm-12"><strong>Name:</strong> <% out.print(cont); %></div><br>
             	<div class="col-sm-12"><strong>Phone Number:</strong> <% out.print(phone); %></div><br />
             	<div class="col-sm-12"><strong>Email:</strong> <% out.print(email); %></div><br>
             	<br /><div class="col-sm-12" align="center"><strong>Connection Information</strong></div><br />
             	<div class="col-sm-12"><strong>Plan:</strong> <% out.print(plan); %></div><br />
             	<div class="col-sm-12"><strong>Username:</strong> <% out.print(puser); %></div><br />
             	<div class="col-sm-12"><strong>Password:</strong> <% out.print(ppass); %></div><br />
             	<div class="col-sm-12"><strong>Connections:</strong> <% out.print(pax); %></div><br />
             	<hr /><br /><div class="col-sm-12" align="center"><strong>Billing</strong></div><br />
             	<div class="col-sm-12"><strong>Total:</strong> <% out.print(total); %></div><br />
             	<div class="col-sm-12"><strong>GST:</strong> Inclusive of 6% Government Tax</div><br />
             	<hr />
             	<a href="event_print.jsp?pid=<% out.print(eid); %>"><button class="btn btn-flat col-sm-12 btn-primary"><span><i class="fa fa-3x fa-print">Print</i></span></button></a>

             </div>
           </div>
         </div>
	</section>
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