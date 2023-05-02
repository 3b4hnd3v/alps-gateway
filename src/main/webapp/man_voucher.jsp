<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%!public String url = "SELECT * FROM `guestinfo` ORDER BY `chkodate` DESC", gid="counter", gnm="counter", lnm="", gpc="", cvp="collapse";%>
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
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Create Voucher")) {
	
	try {
		String gid = request.getParameter("gid").toString();
		String uname = request.getParameter("ln").toString();
		String pass = request.getParameter("rn").toString();
		String server = request.getParameter("server").toString();
		String paym = request.getParameter("paym").toString();
		
		String plan = request.getParameter("plan").toString();
		String pid = plan.split("-")[0];
		System.out.println("planid"+pid);
		ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `purchase_plans` WHERE id="+pid);
	   	
			while(rs1.next()){
    		
    		String gwprof = rs1.getString("gateway_plan"); 
    		String pdur = rs1.getString("duration");
    		String punit = rs1.getString("unit"); 
    		String pprice = rs1.getString("price"); 
    		String lbi = rs1.getString("bytesin"); 
    		String lbo = rs1.getString("bytesout"); 
    		String psharing = rs1.getString("sharing"); 
    		String lu = "";
    		String tranid = "MVX"+gid;
    		System.out.print(pdur+" - "+punit);
    		
    		if(punit.equalsIgnoreCase("Days") || punit.equalsIgnoreCase("Day")){lu = pdur+"d 00:00:00";}
    		else if(punit.equalsIgnoreCase("Hours") || punit.equalsIgnoreCase("Hour")){lu = pdur+":00:00";}
    		else if(punit.equalsIgnoreCase("Minutes") || punit.equalsIgnoreCase("Minute")){lu = "00:"+pdur+":00";}
    		
    		if(g.createVoucher(uname, pass, gwprof, lu, lbi, lbo, server)){
    			
    			PreparedStatement ps = cn.prepareStatement("INSERT INTO `gr_postpaid` (`room_no`, `server`, `unit`, `duration`, `price`, `username`, `password`) "
    					+ "VALUES(?, ?, ?, ?, ?, ?, ?)");
    			
    			ps.setString(1,pass);
    			ps.setString(2,server);
    			ps.setString(3,punit);
    			ps.setString(4,pdur);
    			ps.setString(5,pprice);		
    			ps.setString(6,uname);
    			ps.setString(7,pass);
    			ps.executeUpdate();
    			
    			if(paym.equals("Charge To Room")){
    				try{
	    				connectpms();
	    				PreparedStatement ps1 = cn1.prepareStatement("INSERT INTO `pms_billing` (`room_no`, `price`, `transid`) "
	        					+ "VALUES(?, ?, ?)");
	        			
	        			ps1.setString(1,pass);
	        			ps1.setString(2,pprice);
	        			ps1.setString(3,tranid);
	        			
	        			ps1.executeUpdate();
    				}catch(Exception e){System.out.println(""+e);}
    			}
    		}
    	}
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("id")!= null) {
	
	try {
		String item = request.getParameter("id").toString();
		connectpms();
		String deleteSQL = "DELETE FROM guestinfo WHERE id="+item;
        if(cn1.createStatement().execute(deleteSQL)){
        	String logact = "PMS Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
    		al.addLog(logact);
    		response.sendRedirect("man_voucher.jsp");
        }
        cn1.close();
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("man_voucher.jsp");
		}
}
%>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("createvoucher")&& request.getParameter("id")!= null) {
	
	try {
		gid = request.getParameter("id").toString();
		gnm = request.getParameter("gn").toString();
		lnm = request.getParameter("ln").toString();
		gpc = request.getParameter("pc").toString();
		cvp = "collapse in";
		
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("man_voucher.jsp");
		}
}else{cvp = "collapse";}
%>
<% if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("id")!= null) { %>
<%!public String id = "", action = "", ln = "", gn = "", pc = "";%>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Edit PMS Guest Entry
    <small>Update PMS Guest Entry Values</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="hotspot.jsp?q=walledgarden">EBS</a></li>
    <li class="active">Manual Voucher</li>
  </ol>
</section>

<section class="content-header">
	<div class="panel box box-primary">
    <div class="box-header with-border">
      <h4 class="box-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Edit Guest Entry
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse-in">
      <div class="box-body">
      	<% 
			id=request.getParameter("id");
			gn=request.getParameter("gn");
			ln=request.getParameter("ln");
			pc=request.getParameter("pc");
		%>
      <form action="man_voucher.jsp" method="post">
      	<label>ID</label>
			<input type="text" class="form-control" name="dur" value="<% out.println(id);%>"><br />
		<label>Guest Name</label>
			<input type="text" class="form-control" name="dur" value="<% out.println(gn);%>"><br />
		<label>Last Name</label>
			<input type="text" class="form-control" name="dur" value="<% out.println(ln);%>"><br />
		<label>Promo Code</label>
			<input type="text" class="form-control" name="dur" value="<% out.println(pc);%>"><br />
      	<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Update Guest Entry" />
      </form>
      <a href="man_voucher.jsp"><button class="btn btn-info pull-right">Cancel</button></a>
      </div>
    </div>
  </div>
</section>
<%}else{ %>

<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           PMS Guest Information
           <small>Guest Information from PMS</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">EBS</a></li>
           <li class="active">PMS</li>
         </ol>
       </section>
	<section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Create Voucher
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse <% out.println(cvp);%>">
             <div class="box-body">
             	<form action="man_voucher.jsp" method="post">
             		<div class="col-sm-6">
			      	<label>ID</label>
						<input type="text" class="form-control" name="gid" value="<% out.println(gid);%>"><br />
					</div>
					<div class="form-group col-sm-6">
                   	<label>Payment Method</label>
                   	<select class="form-control" name="paym">
	                    <% 
	                    try{
		                    connect();
		                    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `payment_method`");
		                   	
		           			while(rs1.next()){
		        	    		
		        	    		String pmid = rs1.getString("code"); 
		        	    		String desc =rs1.getString("description"); 
		        	    		
		        	    		String pmeth = pmid+"-"+desc;
	                        	out.println("<option>"+pmeth+"</option>");
		           			}
                      	}catch(Exception e){System.out.print(e);}
                        %>
                 		</select>
                 	</div>
					<div class="col-sm-12">
					<label>Name</label>
						<input type="text" class="form-control" name="gn" value="<% out.println(gnm);%>"><br />
					
					<label>Username</label>
						<input type="text" class="form-control" name="ln" value="<% out.println(lnm);%>"><br />
					
					<label>Password</label>
						<input type="text" class="form-control" name="rn" value="<% out.println(gpc);%>"><br />
					</div>
					<br>
					<div class="form-group col-sm-6">
                    	<label>Server</label>
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
                   	<label>Purchase Plan</label>
                   	<select class="form-control" name="plan">
	                    <% 
	                    try{
		                    connect();
		                    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `purchase_plans`");
		                   	
		           			while(rs1.next()){
		        	    		
		        	    		String pid = rs1.getString("id"); 
		        	    		String desc =rs1.getString("description"); 
		        	    		
		        	    		String plan = pid+"-"+desc;
	                        	out.println("<option>"+plan+"</option>");
		           			}
                      	}catch(Exception e){System.out.print(e);}
                        %>
                 		</select>
                 	</div>
	               	
			      	<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Create Voucher" />
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
                 <h3 class="box-title col-sm-4">PMS Guest Information</h3>
                 <!-- <form action="man_voucher.jsp" method="post">
                  <div class="input-group margin pull-right col-sm-4">
                    <input type="text" name="item" class="form-control">
                    <span class="input-group-btn">
                      <input type="submit" name="search" class="btn btn-info btn-flat" value="Search!">
                    </span>
                  </div>
                  <div class="input-group margin pull-right col-sm-3">
                  <select name="st" class="form-control">
                  <option>GuestName</option>
                  <option>LastName</option>
                  <option>RoomNum</option>
                  </select>
                  <small>Please Check Spelling</small>
                  </div>
                 </form> -->
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Guest</th>
                       <th>Last name</th>
                       <th>Flag</th>
                       <th>Room</th>
                       <th>Account</th>
                       <th>Promo</th>
                       <th>Check Out</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   	 <%
                   	 connectpms();
                   	 try {
                   		ResultSet rs = cn1.createStatement().executeQuery(url);
                   	  	
                   	  	while(rs.next()){
                   	  		
						   String vbtn="<a href='man_voucher.jsp?q=createvoucher&id="+rs.getString("id")+"&gn="+rs.getString("lastname")+"&ln="+rs.getString("guestname")+"&pc="+rs.getString("roomnum")+"' target='_self'><button class='btn btn-xs btn-success'>Voucher</button></a>";
						   String dlbtn="<a href='man_voucher.jsp?q=delete&id="+rs.getString("id")+"' target='_self'><button class='btn btn-xs btn-danger'>Delete</button></a>";
						   String edbtn="<a href='man_voucher.jsp?q=edit&id="+rs.getString("id")+"&gn="+rs.getString("lastname")+"&ln="+rs.getString("guestname")+"&pc="+rs.getString("promocode")+"' target='_self'><button class='btn btn-xs btn-info'>Edit</button></a>";

						   out.println("<tr>");
						   out.println("<td>"+rs.getString("id")+"</td>");
						   out.println("<td>"+rs.getString("guestname")+"</td>");
						   out.println("<td>"+rs.getString("lastname")+"</td>");
						   out.println("<td>"+rs.getString("sflag")+"</td>");
						   out.println("<td>"+rs.getString("roomnum")+"</td>");
						   out.println("<td>"+rs.getString("acctnum")+"</td>");
						   out.println("<td>"+rs.getString("promocode")+"</td>");
						   out.println("<td>"+rs.getString("chkodate")+"</td>");
						   out.println("<td>"+edbtn+""+dlbtn+""+vbtn+"</td>");
						   
						   //System.out.println(obj2.get("id"));
						   out.println("</tr>");
					   }
                 		cn1.close();
					   } catch(Exception e) { 
						   System.out.print(e);
						out.println("<tr>");
	        		 	out.println("<td>Could Not Get User Records at the Moment</td>");
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
<%} %>
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