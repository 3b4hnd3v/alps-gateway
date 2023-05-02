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
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Generate Voucher Codes")) {
	
	try {
		String count = request.getParameter("count");
		String str = request.getParameter("stren");
		String server = request.getParameter("server");		
		String plan = request.getParameter("plan");
		String pid = plan.split("-")[0];
		System.out.println("planid"+pid);
		String tranid = "MVX-counter";
		String gwprof="",pdur = "", punit ="",pprice = "",lbi = "", lbo = "", psharing = "", lu = "";
		ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `purchase_plans` WHERE id="+pid);
	   	while(rs1.next()){
    		gwprof = rs1.getString("gateway_plan"); 
    		pdur = rs1.getString("duration");
    		punit = rs1.getString("unit"); 
    		pprice = rs1.getString("price"); 
    		lbi = rs1.getString("bytesin"); 
    		lbo = rs1.getString("bytesout"); 
    		psharing = rs1.getString("sharing"); 
    		lu = "";
    		System.out.print(pdur+" - "+punit);
	   	}
   		if(punit.equalsIgnoreCase("Days") || punit.equalsIgnoreCase("Day")){lu = pdur+"d 00:00:00";}
	   	else if(punit.equalsIgnoreCase("Hours") || punit.equalsIgnoreCase("Hour")){lu = pdur+":00:00";}
	   	else if(punit.equalsIgnoreCase("Minutes") || punit.equalsIgnoreCase("Minute")){lu = "00:"+pdur+":00";}
	    if(gwprof != "" && pdur != "" && lu != ""){
	    	int cnt = Integer.parseInt(count);int stren = Integer.parseInt(str);
	    	for(int i=0; i<cnt; i++){
	    		String[] genv = dao.genVoucher(stren);
	    		String uname = genv[0], pass = genv[1];
		    	if(g.createVoucher(uname, pass, gwprof, lu, lbi, lbo, server)){
		    			
		    		PreparedStatement ps = cn.prepareStatement("INSERT INTO `gr_postpaid` (`room_no`, `server`, `unit`, `duration`, `price`, `username`, `password`) "
		    					+ "VALUES(?, ?, ?, ?, ?, ?, ?)");
		    			
		   			ps.setString(1,"counter");
		   			ps.setString(2,server);
		   			ps.setString(3,punit);
		   			ps.setString(4,pdur);
		   			ps.setString(5,pprice);		
		   			ps.setString(6,uname);
		   			ps.setString(7,pass);
		   			ps.executeUpdate();
		   			
		    	}
	    	}
    	}
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("id")!= null) {
	
	try {
		String item = request.getParameter("id").toString();
		connect();
		String deleteSQL = "DELETE FROM gr_postpaid WHERE id="+item;
        if(cn.createStatement().execute(deleteSQL)){
        	String logact = "Voucher Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
    		al.addLog(logact);
        }
        cn.close();
		
	} catch (Exception e1) { System.out.println(e1); }
}

if(request.getParameter("q") != null && request.getParameter("q").equals("cancel")&& request.getParameter("id")!= null) {
	
	try {
		String item = request.getParameter("id").toString();
		dao.cancelVoucher(item);
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Voucher Code Generator
           <small>Generate Multiple Voucher Codes</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Manual Voucher</a></li>
           <li class="active">Generator</li>
         </ol>
       </section>
	<section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Generate Voucher
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="gen_voucher.jsp" method="post">
             		<div class="form-group col-sm-6">
			      		<label>Generate Voucher For</label>
						<input type="number" class="form-control" min="10" max="<% out.println(dao.getSetting("guest_cap"));%>" name="count" value="<% out.println(dao.getSetting("guest_cap"));%>"><br />
					</div>
					<div class="form-group col-sm-6">
			      		<label>Username and Password Strength</label>
						<input type="number" class="form-control" min="6" max="12" name="stren" value="6"><br />
					</div>
					<div class="form-group col-sm-6">
                    	<label>Active Location / Zone</label>
                    	<select class="form-control" name="server">
	                    	<option>all</option>
		                    <% 
	                      	for (Map<String,String> mp : g.hsservers()) {
					  		String s = mp.get("name");
	                        out.println("<option>"+s+"</option>");
	                      	}
	                        %>
                  		</select>
                    </div>
                    <div class="form-group col-sm-6">
                   	<label>Voucher Plan</label>
                   	<select class="form-control" name="plan">
	                    <% 
	                    try{
		                    connect();
		                    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `purchase_plans` WHERE `room_no`='counter'");
		                   	
		           			while(rs1.next()){
		        	    		
		        	    		String pid = rs1.getString("id"); 
		        	    		String desc =rs1.getString("description"); 
		        	    		
		        	    		String plan = pid+"-"+desc;
	                        	out.println("<option value='"+plan+"'>"+desc+"</option>");
		           			}
                      	}catch(Exception e){System.out.print(e);}
                        %>
                 		</select>
                 	</div>
	               	
			      	<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Generate Voucher Codes" />
			     </form>
             </div>
           </div>
         </div>
	</section>
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title col-sm-4">Generated Voucher Codes</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Room No.</th>
                       <th>Server</th>
                       <th>Duration</th>
                       <th>Price</th>
                       <th>Username</th>
                       <th>Password</th>
                       <th>Status</th>
                       <th>Created</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   connect();
                   try {
	                 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `gr_postpaid`");
	                 	String edbtn = "";
	                 	//`gr_postpaid` (`room_no`, `server`, `unit`, `duration`, `price`, `username`, `password`, `wireless_username`, `wireless_password`)
	                 	while(rs1.next()){
	                 		if(rs1.getString("status").equals("0")){edbtn="<a href='?q=cancel&id="+rs1.getString("id")+"&nm="+rs1.getString("username")+"' target='_self'><button class='btn btn-xs btn-info'>Cancel</button></a>";}
							String dlbtn="<a href='?q=delete&id="+rs1.getString("id")+"' target='_self'><button class='btn btn-xs btn-danger'>Delete</button></a>";

	                 		out.println("<tr>");
	            		 	out.println("<td>"+rs1.getString("id")+"</td>");
	            		 	out.println("<td>"+rs1.getString("room_no")+"</td>");
	            		 	out.println("<td>"+rs1.getString("server")+"</td>");
	            		 	out.println("<td>"+rs1.getString("duration")+" "+rs1.getString("unit")+"</td>");
	            		 	out.println("<td>"+rs1.getString("price")+"</td>");
	            		 	out.println("<td>"+rs1.getString("username")+"</td>");
	            		 	out.println("<td>"+rs1.getString("password")+"</td>");
	            		 	out.println("<td>"+rs1.getString("status")+"</td>");
	            		 	out.println("<td>"+rs1.getString("created")+"</td>");
	            		 	out.println("<td>"+edbtn+"	"+dlbtn+"</td>");
	            		 	out.println("</tr>");
	                 	}
	               		
	               		cn.close();
	               	} catch(Exception e) { out.println("<tr>");
        		 	out.println("<td>error</td>");
        		 	 out.println("</tr>");
					 }
	                %>
				</tbody>
				</table>
				</div>
			</div>
		</div>
	</div>
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
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.js"></script>
<script>
  $(function () {
	$("#example1").DataTable({"responsive": true});
    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false
    });
  });
</script>
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
<!--Table Export-->
<script>
function tableExport() {
   // check whether tableExport plugin is loaded
   if (typeof $.tableExport !== "function") {
   	$.getScript("js/tableexport/tableExport.js");
   	$.getScript("js/tableexport/jquery.base64.js");
   	$.getScript("js/tableexport/html2canvas.js");
   	$.getScript("js/tableexport/jspdf/libs/sprintf.js");
   	$.getScript("js/tableexport/jspdf/jspdf.js");
   	$.getScript("js/tableexport/jspdf/libs/base64.js");
   }
};
</script>
<!-- page script -->
</body>
</html>