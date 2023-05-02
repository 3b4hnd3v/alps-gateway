<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%! public String venue="",venueno="",evn="",comp="",cont="",phone="",email="",stdate="",puser="",ppass="",endate="",days="",dayrate="",pax="",paxrate="",server="",total1="",plan="",planname="",prof="",planid="",lbi="",lbo="",vid="",vn="",lu=""; 
	public double subtotal=0.00,total=0.00,subtax=0.00;
%>
<%! Licmail lm = new Licmail(); %>
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Confirm Create Event")) {
	
	try {
		venue = request.getParameter("venue").toString();
		venueno = request.getParameter("venueno").toString();
		evn = request.getParameter("evn").toString();
		comp = request.getParameter("comp").toString();
		cont = request.getParameter("cn").toString();
		phone = request.getParameter("phone").toString();
		email = request.getParameter("email").toString();
		stdate = request.getParameter("stdate").toString();
		endate = request.getParameter("endate").toString();
		puser = request.getParameter("puser").toString();
		ppass = request.getParameter("ppass").toString();
		days = request.getParameter("days").toString();
		dayrate = request.getParameter("dayrate").toString();
		pax = request.getParameter("pax").toString();
		paxrate = request.getParameter("paxrate").toString();
		server = request.getParameter("server").toString();
		plan = request.getParameter("plan").toString();
		planid=request.getParameter("planid").toString();
		planname=request.getParameter("planname").toString();
		prof=request.getParameter("prof").toString();
		total1 = request.getParameter("tot").toString();
		lu = days+"d";
		
	}catch(Exception e1){System.out.print("empty"+e1);}
	try{
		connect();
		ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `purchase_plans` WHERE id="+planid);
	   	
		while(rs1.next()){
   		
    		lbi = rs1.getString("bytesin"); 
    		lbo = rs1.getString("bytesout");
    		System.out.print(lbo+"="+lbi);
		}
		cn.close();
	}catch(Exception e){System.out.print("plan"+e);
			lbi = "1024k"; 
			lbo = "512k";
	}
	try{
		if(g.createVoucher(puser, ppass, prof, lu, lbi, lbo, server)){
			System.out.println("User Created");
			connect();
			PreparedStatement ps = cn.prepareStatement("INSERT INTO `mr_purchase` (`description`, `company_name`, `contact_person`, `contact_phone`, `contact_email`, `start_date`, `end_date`, `mr_id`, `mr_name`, `amount`, `username`, `password`, `connections`, `plan_name`) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			
			ps.setString(1,evn);
			ps.setString(2,comp);
			ps.setString(3,cont);
			ps.setString(4,phone);
			ps.setString(5,email);		
			ps.setString(6,stdate);
			ps.setString(7,endate);
			ps.setString(8,venueno);
			ps.setString(9,venue);
			ps.setString(10,total1);
			ps.setString(11,puser);
			ps.setString(12,ppass);
			ps.setString(13,pax);
			ps.setString(14,planname);
			

			if(ps.executeUpdate() == 1){
				System.out.println("Event inserted");
				ResultSet rs2 = cn.createStatement().executeQuery("SELECT id FROM `mr_purchase` ORDER BY `id` DESC limit 1");rs2.next();
				String mrpid = rs2.getString("id");
				
				PreparedStatement ps1 = cn.prepareStatement("INSERT INTO `mr_purchase_line` (`purchase`, `meeting_room_id`, `meeting_room`, `start_time`, `end_time`, `connections`, `amount`) "
						+ "VALUES(?, ?, ?, ?, ?, ?, ?)");
				ps1.setString(1,mrpid);
				ps1.setString(2,venueno);
				ps1.setString(3,venue);
				ps1.setString(4,stdate);
				ps1.setString(5,endate);
				ps1.setString(6,days);
				ps1.setString(7,total1);
				if(ps1.executeUpdate() == 1){
					String emailbody = "Hi "+cont+"<br> You receive this Email because an event has been booked on Alps Gateway in <b>"+venue+"</b> with your name and email address.<br><br>Below is the detail of your Event as Booked. "
							+ " Event Name: "+evn+"<br>Company Name: "+comp+"<br>Start Date: "+stdate+"<br>End Date: "+endate+"<br>Venue: "+venue+"<br>Duration: "+days+"<br>No of People: "+pax+"<br>Charge: "+total1+"<br><h2>Wireless Connection Info: </h2><br>Plan Name: "+planname+"<br>Download Speed: "+lbi+"<br>Upload Speed: "+lbo+"<br>Username: "+puser+"<br>Password: "+ppass+"<br>"
							+"<br><p>Please be informed that this is a machine generated Email, Do not reply. <br><br>Please contact <a href='ebahn-solutions.com' target='_blank'>eBahn Solutions sdn bhd</a> or email us at: ebahnsolution@gmail.com."
							+ "<br><br>You can also call us at 01123765837.</p><p>Thank You.</p> ";
					String emailad = email;
					
			        lm.sendForEvent(emailad,emailbody);
				}
				System.out.println("connection inserted");
				response.sendRedirect("event_sucess.jsp?pid="+mrpid+"msg=Event Created Successfully.&type=success");
			}
			
		}else{
		response.sendRedirect("events.jsp?msg=Failure to create event. Please Try Again&type=error");}
		cn.close();
	}catch(Exception e){System.out.println("insert"+e);
		response.sendRedirect("events.jsp?msg=Failure to create event. Please Try Again&type=error");}
}
%>
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Create Event")) {
	
	try {
		venue = request.getParameter("venue").toString();
		evn = request.getParameter("evn").toString();
		comp = request.getParameter("comp").toString();
		cont = request.getParameter("cn").toString();
		phone = request.getParameter("phone").toString();
		email = request.getParameter("email").toString();
		stdate = request.getParameter("stdate").toString();
		endate = request.getParameter("endate").toString();
		puser = request.getParameter("puser").toString();
		ppass = request.getParameter("ppass").toString();
		days = request.getParameter("days").toString();
		dayrate = request.getParameter("dayrate").toString();
		pax = request.getParameter("pax").toString();
		paxrate = request.getParameter("paxrate").toString();
		server = request.getParameter("server").toString();
		plan = request.getParameter("plan").toString();
		
		String[] evenue=null;
		evenue = venue.split(" - ");
		vid = evenue[0];
		vn = evenue[1];
		
		String[] planval = plan.split("-");
		planname=planval[1];
		prof=planval[2];
		planid=planval[0];
		
		subtotal = (Integer.parseInt(pax) * Integer.parseInt(paxrate))+(Integer.parseInt(days) * Integer.parseInt(dayrate));
		subtax = subtotal * 6/100;
		
		total = subtotal + subtax;
		
	}catch(Exception e){System.out.println(e);}
	System.out.println(vid+"="+vn+"="+evn+"="+comp+"="+cont+"="+phone+"="+email+"="+stdate+"="+endate+"="+puser+"="+ppass+"="+days+"="+dayrate+"="+server);
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
<div class="row">
<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Conference Room Events
           <small>Conference Room Events</small>
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
                 Confirm New Event <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse in">
             <div class="box-body">
             	<form action="create_event.jsp" method="post">
             		<div class="form-group col-sm-12">
                   	<label>Event Venue</label>
                   		<input type="text" readonly class="form-control" name="venueno" value="<% out.println(vid);%>"><br />
                   		<input type="text" readonly class="form-control" name="venue" value="<% out.println(vn);%>"><br />
                 	</div>
             		<div class="col-sm-6">
			      	<label>Event Name</label>
						<input type="text" readonly class="form-control" name="evn" value="<% out.println(evn);%>"><br />
					</div>
					<div class="col-sm-6">
			      	<label>Company Name</label>
						<input type="text" readonly class="form-control" name="comp" value="<% out.println(comp);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Contact Name</label>
						<input type="text" readonly class="form-control" name="cn" value="<% out.println(cont);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Phone #</label>
						<input type="text" readonly class="form-control" name="phone" value="<% out.println(phone);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Email</label>
						<input type="email" readonly class="form-control" name="email" value="<% out.println(email);%>"><br />
					</div>
					<div class="col-sm-6">
					<label>Start Date</label>
						<input type="text" readonly class="form-control" name="stdate" value="<% out.println(stdate);%>"><br />
					</div>
					<div class="col-sm-6">
					<label>End Date</label>
						<input type="text" readonly class="form-control" name="endate" value="<% out.println(endate);%>"><br />
					</div>
					<div class="col-sm-2">
					<label>Days</label>
						<input type="text" readonly class="form-control" name="days" value="<% out.println(days);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Rate</label>
						<input type="text" readonly class="form-control" name="dayrate" value="<% out.println(dayrate);%>"><br />
					</div>
					<div class="col-sm-2">
					<label>Pax</label>
						<input type="text" readonly class="form-control" min="10" name="pax" value="<% out.println(pax);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Rate</label>
						<input type="text" readonly class="form-control" name="paxrate" value="<% out.println(paxrate);%>"><br />
					</div>
					<div class="col-sm-6">
                    	<label>Server</label>
                    	<input type="text" readonly class="form-control" name="server" value="<% out.println(server);%>"><br />
                    </div>
                    <div class="col-sm-6">
                   	<label>Purchase Plan</label>
                   	<input type="text" readonly class="form-control" name="plan" value="<% out.println(plan);%>"><br />
                 	</div>
                 	<div class="col-sm-4">
					<label>Bid Sub-total</label>
						<input type="text" readonly class="form-control" name="subtot" value="<% out.println(subtotal);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>GST</label>
						<input type="text" readonly class="form-control" name="subtax" value="<% out.println(subtax);%>"><br />
					</div>
					<div class="col-sm-4">
					<label>Bid Total</label>
						<input type="email" readonly class="form-control" name="tot" value="<% out.println(total);%>"><br />
					</div>
					<div class="col-sm-6">
			      	<label>WIFI UserName</label>
						<input type="text" readonly class="form-control" name="puser" value="<% out.println(puser);%>"><br />
					</div>
					<div class="col-sm-6">
			      	<label>WIFI Password</label>
						<input type="text" readonly class="form-control" name="ppass" value="<% out.println(ppass);%>"><br />
					</div>
	               	<input type="text" class="form-control" name="planid" value="<% out.println(planid);%>"><br />
                   	<input type="text" class="form-control" name="planname" value="<% out.println(planname);%>"><br />
                   	<input type="text" class="form-control" name="prof" value="<% out.println(prof);%>"><br />
			      	<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Confirm Create Event" />
			     </form>
             </div>
           </div>
         </div>
	</section>
</div><!-- /.content-wrapper -->
<%} %>
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