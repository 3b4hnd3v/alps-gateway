<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%! 
String ip = "", url = "";
%>
<%
connect();
try {
  	ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `dashboard` where name='pcode'");
  	
  	while(rs.next()){
  		url = rs.getString("value");
  		
  	}
		
		cn.close();
	} catch(Exception e) {  System.out.println(e);}
%>
<% 
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update")) {
	
	try {
		connect();
		String nurl = request.getParameter("url");
		cn.createStatement().execute("UPDATE settings SET value='"+nurl+"' WHERE name='pcode'");
		
		cn.close();
		
		String logact = "New Purchase URL "+nurl+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Clear Previous Purchase")) {
	
	try {
		for (Map<String,String> mp : g.users()) {
		//ResultSet rs2=cn.createStatement().executeQuery("SELECT name FROM purchased_cards where status =! ");
			String s = mp.get(".id");
			String un = mp.get("name");
			String pw = mp.get("password");
			String deleteSQL = "DELETE FROM purchased_cards WHERE username='"+un+"' AND password='"+pw+"'";
	        if(cn.createStatement().execute(deleteSQL)){
	            g.deletePurchase(s);
	            
	        }
		
		}
		String logact = "All previous purchases cleared By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("index.jsp?msg=Purchases Cleared Successfully");
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("manage_pp.jsp?msg=Cannot Clear Purchases at the moment");}
}
%>
<div class="content-wrapper">
<!-- Error Message -->
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
<!-- Horizontal Form -->
 <div class="box box-info">
   <div class="box-header with-border">
     <h3 class="box-title">Manage Alps Prepaid</h3>
   </div><!-- /.box-header -->
   <!-- form start -->
   <form action="manage_pp.jsp" method="post" class="form-horizontal">
     <div class="box-body">
       <div class="form-group">
         <label for="ip" class="col-sm-2 control-label">Code URL</label>
         <div class="col-sm-10">
           <input type="text" class="form-control" id="url" name="url" placeholder="url" value="<% out.println(url);%>">
         </div>
       </div>
     </div>
     <div class="box-footer">
       <a href="index.jsp" ><button class="btn btn-default">Cancel</button></a>
       <button type="submit" class="btn btn-info pull-right">Update</button>
     </div><!-- /.box-footer -->
   </form>
 </div><!-- /.box -->

 <!-- Horizontal Form -->
 <div class="box box-info">
   <div class="box-header with-border">
     <h3 class="box-title">Clear Previous Purchases</h3>
   </div><!-- /.box-header -->
   <!-- form start -->
   <form action="manage_pp.jsp" method="post" class="form-horizontal">
     <div class="box-body">
	   <div class="col-sm-10">
          <p>Please make sure that you clear previous purchases before activating new purchase.</p>
          <p>This will ensure proper running of <strong>Alps Gateway</strong>.</p>
        </div>
        <br />
       <div class="form-group">
         <div class="col-sm-10">
           <input type="hidden" class="form-control" id="action" name="action" value="Delete Purchased Users In Gateway">
         </div>
       </div>
     </div>
     <div class="box-footer">
       <a href="index.jsp" ><button class="btn btn-default">Cancel</button></a>
       <button type="submit" class="btn btn-info pull-right">Clear Previous Purchase</button>
     </div><!-- /.box-footer -->
   </form>
 </div><!-- /.box -->
 <!-- Horizontal Form -->
 <div class="box box-info">
   <div class="box-header with-border">
     <h3 class="box-title">Order Prepaid Purchase</h3>
   </div><!-- /.box-header -->
   <!-- form start -->
     <div class="box-body">
	   <div class="col-sm-10">
          <p>Alps provide a convinient way for prepaid clients to purchase login credentials online.</p>
          <p>This Please Order Your Prepaid Vouchers at<strong>Alps Online</strong>.</p>
        </div>
        <br />  
     </div>
     <div class="box-footer">
       <a href="http://prepaid.alpsgateway.com" target="_blank"><button type="submit" class="btn btn-info pull-right">Order Now</button></a>
     </div><!-- /.box-footer -->
 </div><!-- /.box -->
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