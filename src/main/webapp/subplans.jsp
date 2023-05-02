<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<% //Walled Garden
String msg = "0x0", cvp = "collapse";
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Create Plan")) {
	
	try {
		String name = request.getParameter("subname").toString();
		String rate = request.getParameter("rate").toString();
		String price = request.getParameter("price").toString();
		String duration = request.getParameter("duration").toString();
		String unit = request.getParameter("unit").toString();
		
		if(dao.addSubPlan(name, rate, price, duration, unit)){
			String logact = "New Subscription plan "+name+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			msg = "Subsciption Plan Created Successfully";
		}else{
			msg="Subscription plan Cannot be Added at the moment";
		}
		
	} catch (Exception e1) { System.out.println(e1); }
}
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Plan")) {
	
	try {
		String id = request.getParameter("plid").toString();
		String name = request.getParameter("subname").toString();
		String rate = request.getParameter("rate").toString();
		String price = request.getParameter("price").toString();
		String duration = request.getParameter("duration").toString();
		String unit = request.getParameter("unit").toString();
		
		if(dao.updateSubPlan(id, name, rate, price, duration, unit)){
			String logact = "New Subscription plan "+name+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			msg = "Subsciption Plan Updated Successfully";
		}else{
			msg="Subscription plan Cannot be Updated at the moment";
		}
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("item")!= null) {
	
	try {
		String item = request.getParameter("item").toString();
		connect();
		String deleteSQL = "DELETE FROM `subplans` WHERE id="+item;
        if(cn.createStatement().execute(deleteSQL)){
        	String logact = "Subscription Plan "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
    		al.addLog(logact);
    		msg = "Deleted Successfully";
        }
        cn.close();
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<%
String edid ="",edname = "",edrate = "",edprice = "",edunit = "",eddur = "";
if(request.getParameter("q") != null && request.getParameter("q").equals("edit")&& request.getParameter("item")!= null) {
	
	try {
		String item = request.getParameter("item");
		
		connect();
	 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `subplans`");
		while(rs1.next()){
			edid = rs1.getString("id");
	 		edname = rs1.getString("name");
	 		edrate = rs1.getString("rate");
	 		edprice = rs1.getString("price");
	 		edunit = rs1.getString("unit");
	 		eddur = rs1.getString("duration");
			cvp = "collapse in";
		}
		cn.close();
	} catch (Exception e1) { System.out.println(e1); }
}else{cvp = "collapse";}
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
<%if(msg != null && !msg.equalsIgnoreCase("0x0")){ %>
	<div class="alert alert-danger alert-dismissible">
	  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  <h4><i class="icon fa fa-ban"></i> Oops :( !</h4>
	  <%out.println(msg); %>
	</div>
<%}%>
<%
String nextid = dao.SubMax();
%>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Subscription Plan
    <small>Network Subscription Plan</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Policy</a></li>
    <li><a href="#">Subscription</a></li>
    <li><a href="#">Plans</a></li>
  </ol>
</section>
<section class="content">
<div><br /><br /></div>
<div class="row">
  <div class="col-md-12">
	<div class="panel box box-primary">
	    <div class="box-header with-border">
	      <h4 class="box-title">
	        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	         New Subscription Plans<span><i class="fa fa-angle-double-down"></i></span>
	        </a>
	      </h4>
	    </div>
	    <div id="collapseOne" class="panel-collapse collapse">
	      <div class="box-body">
	      	<form action="subplans.jsp" method="post">	      		
	      		<div class="col-sm-12">
			      	<label>Name</label>
					<input type="text" class="form-control" name="subname"><br />
				</div>
				<div class="col-sm-12">
			      	<label>Rate (Xk/Yk)</label>
					<input type="text" class="form-control" name="rate"><br />
				</div>
				<div class="col-sm-8">
			      	<label>Price</label>
					<input type="text" class="form-control" name="price"><br />
				</div>
				<div class="col-sm-4">
			      	<label>Unit</label>
					<input type="text" class="form-control" name="unit" value="RM"><br />
				</div>
				<div class="col-sm-10">
			      	<label>Duration</label>
					<input type="text" class="form-control" name="duration"><br />
				</div>
				<div class="col-sm-2">
					<br /> Days
				</div>
	      		<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Create Plan" />
		     </form>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="col-md-12">
		<div class="panel box box-primary">
		    <div class="box-header with-border">
		      <!-- <h4 class="box-title">
		        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
		         Edit Subscription Plan<span><i class="fa fa-angle-double-down"></i></span>
		        </a>
		      </h4> -->
		    </div>
		    <div id="collapseTwo" class="panel-collapse <%= cvp%>">
		      <div class="box-body">
		      	<form action="subplans.jsp" method="post">	      		
		      		<div class="col-sm-12">
				      	<label>Name</label>
						<input type="text" class="form-control" name="subname" value="<%= edname%>"><br />
						<input type="text" class="form-control" name="plid" value="<%= edid%>"><br />
					</div>
					<div class="col-sm-12">
				      	<label>Rate (Xk/Yk)</label>
						<input type="text" class="form-control" name="rate" value="<%= edrate%>"><br />
					</div>
					<div class="col-sm-8">
				      	<label>Price</label>
						<input type="text" class="form-control" name="price" value="<%= edprice%>"><br />
					</div>
					<div class="col-sm-4">
				      	<label>Unit</label>
						<input type="text" class="form-control" name="unit" value="<%= edunit%>"><br />
					</div>
					<div class="col-sm-10">
				      	<label>Duration</label>
						<input type="text" class="form-control" name="duration" value="<%= eddur%>"><br />
					</div>
					<div class="col-sm-2">
						<br /> Days
					</div>
		      		<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Update Plan" />
			     </form>
		      </div>
		    </div>
		  </div>
	</div>
</div>
<div class="row">
   <div class="col-xs-12"><!-- /.box -->
     <div class="box">
       <div class="box-header">
         <h3 class="box-title">Subscription Plans</h3>
       </div><!-- /.box-header -->
       <div class="box-body table-responsive">
         <table id="example1" class="table table-bordered table-striped">
           <thead>
           <tr>
			<th>ID</th>
			<th>Name</th>
			<th>Rate</th>
			<th>Price</th>
			<th>Days</th>
			<th>Created</th>
			<th>Action</th>
		   </tr>
		   </thead>
           <tbody>
			<% 
			connect();
			try {
			 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `subplans`");
				while(rs1.next()){
			 		String stid=rs1.getString("id");
			 		String stn=rs1.getString("name");
				  	String btn_rm = "<a href='?q=delete&item="+stid+"'><button class='btn btn-md btn-danger'><i class='fa fa-times pull-right'></i></button></a>";
				  	String btn_ed = "<a href='?q=edit&item="+stid+"'><button class='btn btn-md btn-info'><i class='fa fa-edit pull-right'></i></button></a>";
			
					out.println("<tr>");
					out.println("<td>"+stid+"</td>");
					out.println("<td>"+stn+"</td>");
					out.println("<td>"+rs1.getString("rate")+"</td>");
					out.println("<td>"+rs1.getString("price")+" "+rs1.getString("unit")+"</td>");
					out.println("<td>"+rs1.getString("duration")+"</td>");
					out.println("<td>"+rs1.getString("created")+"</td>");
					out.println("<td>"+btn_ed+" "+btn_rm+"</td>");
					out.println("</tr>");
				 }
				cn.close();
			} catch(Exception e) { System.out.println(e);} 
			%>
			</tbody>
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div><!-- /.col -->
  </div><!-- /.row -->
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