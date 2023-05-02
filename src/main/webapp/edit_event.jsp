<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%!public String eid="",venue="",venueno="",evn="",comp="",cont="",phone="",email="",stdate="",puser="",ppass="",endate="",days="",dayrate="",pax="",paxrate="",server="",plan="",planname="",prof="",planid="",lbi="",lbo=""; 
	public double subtotal=0.00,total=0.00,subtax=0.00;%>
<%
String item = request.getParameter("id");
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
	  		
  }
	cn.close();
  } catch(Exception e) {System.out.print(e);}

%>
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Event")) {
	
	try {
		String eid = request.getParameter("eid").toString();
		String venue = request.getParameter("venue").toString();
		String venueno = request.getParameter("venueno").toString();
		String evn = request.getParameter("evn").toString();
		String comp = request.getParameter("comp").toString();
		String cont = request.getParameter("cn").toString();
		String phone = request.getParameter("phone").toString();
		String email = request.getParameter("email").toString();
		String stdate = request.getParameter("stdate").toString();
		String endate = request.getParameter("endate").toString();
		String puser = request.getParameter("puser").toString();
		String ppass = request.getParameter("ppass").toString();
		String days = request.getParameter("days").toString();
		String dayrate = request.getParameter("dayrate").toString();
		String pax = request.getParameter("pax").toString();
		String paxrate = request.getParameter("paxrate").toString();
		String server = request.getParameter("server").toString();
		String plan = request.getParameter("plan").toString();
		
		String[] planval = plan.split("-");
		String planname=planval[1];
		String prof=planval[2];
		String planid=planval[0];
		
		double subtotal = (Integer.parseInt(pax) * Integer.parseInt(paxrate))+(Integer.parseInt(days) * Integer.parseInt(dayrate));
		double subtax = subtotal * 6/100;
		
		double total = subtotal + subtax;
		
		String lu = days+"d 00:00:00";
		
		try{
			ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `purchase_plans` WHERE id="+planid);
		   	
			while(rs1.next()){
    		
	    		lbi = rs1.getString("bytesin"); 
	    		lbo = rs1.getString("bytesout");
			}
		}catch(Exception e){System.out.print(e);
				lbi = "1024k"; 
				lbo = "512k";
		}
		
		if(g.createVoucher(puser, ppass, prof, lu, lbi, lbo, server)){
			PreparedStatement ps = cn.prepareStatement("UPDATE `mr_purchase` SET (`description`=?, `company_name`=?, `contact_person`=?, `contact_phone`=?, `contact_email`=?, `start_date`=?, `end_date`=?, `mr_id`=?, `mr_name`=?, `amount`=?, `username`=?, `password`=?, `connections`=?, `plan_name`=? WHERE `id`=?");
			
			ps.setString(1,evn);
			ps.setString(2,comp);
			ps.setString(3,cont);
			ps.setString(4,phone);
			ps.setString(5,email);		
			ps.setString(6,stdate);
			ps.setString(7,endate);
			ps.setString(8,venueno);
			ps.setString(9,venue);
			ps.setDouble(10,total);
			ps.setString(11,puser);
			ps.setString(12,ppass);
			ps.setString(13,pax);
			ps.setString(14,planname);
			ps.setString(14,planname);
			ps.setString(15,eid);
			
			if(ps.executeUpdate() == 1){
				
				PreparedStatement ps1 = cn.prepareStatement("UPDATE `mr_purchase_line` SET `purchase`=?, `meeting_room_id`=?, `meeting_room`=?, `start_time`=?, `end_time`=?, `connections`=?, `amount`=? WHERE purchase=?");
				ps1.setString(1,eid);
				ps1.setString(2,venueno);
				ps1.setString(2,venue);
				ps1.setString(3,stdate);
				ps1.setString(4,endate);
				ps1.setString(5,days);
				ps1.setString(6,pax);
				ps1.setString(7,eid);
				ps.executeUpdate();
				
				response.sendRedirect("event_sucess.jsp?pid="+eid+"&msg=Event Updated Successfully.&type=success");

			}
		}
		
		
	}catch(Exception e){System.out.println(e);
		response.sendRedirect("edit_event.jsp?pid="+eid+"&msg=Event Could Not Be Updated.&type=error");
	}
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
           <small>Edit Conference Room Events</small>
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
               <a data-toggle="collapse" data-parent="#accordion" href="collapseOne">
                 Update Event <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse in">
             <div class="box-body">
             	<form action="create_event.jsp" method="post">
	             	
					<input type="hidden" class="form-control" name="eid" value="<%out.print(eid);%>"><br />
					
             		<div class="form-group col-sm-12">
                   	<label>Event Venue</label>
	                   	<select class="form-control col-sm-6" name="venue">
		                   	<option><%out.print(venue);%> - <%out.print(venueno);%></option>
		                   	<option></option>
			                    <% 
			                    try{
				                    connect();
				                    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `meeting_rooms` WHERE `status`='Open'");
				           			while(rs1.next()){
				        	    		String rname =rs1.getString("name"); 
				        	    		String rno =rs1.getString("id"); 
			                        	out.println("<option>"+rno+" - "+rname+"</option>");
				           			}
				           			cn.close();
		                      	}catch(Exception e){System.out.print(e);response.sendRedirect("events.jsp");}
		                        %>
	                 	</select>
                 	</div>
             		<div class="col-sm-6">
			      	<label>Event Name</label>
						<input type="text" class="form-control" name="evn" value="<%out.print(evn);%>"><br />
					</div>
					<div class="col-sm-6">
			      	<label>Company Name</label>
						<input type="text" class="form-control" name="comp" value="<%out.print(comp);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Contact Name</label>
						<input type="text" class="form-control" name="cn" value="<%out.print(cont);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Phone #</label>
						<input type="text" class="form-control" name="phone" value="<%out.print(phone);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Email</label>
						<input type="email" class="form-control" name="email" value="<%out.print(email);%>"><br />
					</div>
					<div class="col-sm-6">
			      	<label>Preferred Username</label>
						<input type="text" class="form-control" name="puser" value="<%out.print(puser);%>"><br />
					</div>
					<div class="col-sm-6">
			      	<label>Preferred Password</label>
						<input type="text" class="form-control" name="ppass" value="<%out.print(ppass);%>"><br />
					</div>
					<div class="col-sm-6">
					<label>Start Date</label>
						<input type="date" class="form-control" name="stdate" value="<%out.print(stdate);%>"><br />
					</div>
					<div class="col-sm-6">
					<label>End Date</label>
						<input type="date" class="form-control" name="endate" value="<%out.print(endate);%>"><br />
					</div>
					<div class="col-sm-2">
					<label>Days</label>
						<input type="number" required class="form-control" min="1" name="days" value="<%out.print(days);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Rate</label>
						<input type="text" required class="form-control" name="dayrate" value="<%out.print(dayrate);%>"><br />
					</div>
					<div class="col-sm-2">
					<label>Pax</label>
						<input type="number" required class="form-control" min="10" name="pax" value="<%out.print(pax);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Rate</label>
						<input type="text" required class="form-control" name="paxrate" value="<%out.print(paxrate);%>"><br />
					</div>
					<div class="form-group col-sm-6">
                    	<label>Server</label>
                    	<select class="form-control" name="server">
	                    	<option></option>
	                    	<option>all</option>
		                    <% 
		                    try{
		                      	for (Map<String,String> mp : g.hsservers()) {
						  			String s = mp.get("name");
		                        	out.println("<option>"+s+"</option>");
	                      		}
	                      	}catch(Exception e){System.out.print(e);response.sendRedirect("events.jsp");}
	                        %>
                  		</select>
                  		<small>Select Meeting Room Vlan as Server</small>
                    </div>
                    <div class="form-group col-sm-6">
                   	<label>Purchase Plan</label>
                   	<select class="form-control" name="plan">
	                    <option></option>
	                    <% 
	                    try{
		                    connect();
		                    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `purchase_plans`");
		                   	
		           			while(rs1.next()){
		        	    		
		        	    		String pid = rs1.getString("id"); 
		        	    		String desc =rs1.getString("description"); 
		        	    		String gw =rs1.getString("gateway_plan"); 
		        	    		
		        	    		String plan = pid+"-"+desc+"-"+gw;
	                        	out.println("<option>"+plan+"</option>");
		           			}
		           			cn.close();
                      	}catch(Exception e){System.out.print(e);response.sendRedirect("events.jsp");}
                        %>
                 	</select>
                 	</div>
                 	
			      	<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Update Event" />
			     </form>
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
<!-- ChartJS 1.0.1 -->
<script src="plugins/chartjs/Chart.min.js"></script>

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