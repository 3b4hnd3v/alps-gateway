<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<% //Walled Garden
String msg = "0x0", cvp = "collapse";
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Make Payment")) {
	
	try {
		String bid = request.getParameter("billid");
		String subid = request.getParameter("subscr");
		String amt = request.getParameter("amt");
		String bf = request.getParameter("bf");
		String bt = request.getParameter("bt");
		//update bill and update subscriber current bill to bf 
		//So that bill generator use bill+plan dur to generate new bill and curdate +plan dur as bt
		if(1==1+1){
			String logact = "New Subscription plan #"+bid+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
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
		String deleteSQL = "DELETE FROM `subbills` WHERE id="+item;
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
String edid ="",edsub = "",edamt = "",edfo = "",edto = "";
if(request.getParameter("q") != null && request.getParameter("q").equals("pay")&& request.getParameter("item")!= null) {
	
	try {
		String item = request.getParameter("item");
		
		connect();
	 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `subbills`");
		while(rs1.next()){
			edid = rs1.getString("id");
	 		edsub = rs1.getString("subscriber");
	 		edamt = rs1.getString("amount");
	 		edfo = rs1.getString("bill_for");
	 		edto = rs1.getString("bill_to");
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
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Subscription Bills
    <small>Generated Subscription Bills</small>
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
		         	<span><i class="fa fa-cogs"></i></span>
		        </a>
		      </h4>
		    </div>
		    <div id="collapseTwo" class="panel-collapse <%= cvp%>">
		      <div class="box-body">
		      	<form action="subbills.jsp" method="post">	      		
		      		<div class="col-sm-12">
				      	<label>Subscriber #ID</label>
						<input type="text" class="form-control" name="billid" value="<%= edid%>"><br />
						<input type="text" class="form-control" name="subscr" value="<%= edsub%>"><br />
					</div>
					<div class="col-sm-4">
				      	<label>Amount</label>
						<input type="text" class="form-control" name="amt" value="<%= edamt%>"><br />
					</div>
					<div class="col-sm-4">
				      	<label>Bill For</label>
						<input type="text" class="form-control" name="bf" value="<%= edfo%>"><br />
					</div>
					<div class="col-sm-4">
				      	<label>Bill To</label>
						<input type="text" class="form-control" name="bt" value="<%= edto%>"><br />
					</div>
					
		      		<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Make Payment" />
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
         <h3 class="box-title">Generated Bills</h3>
       </div><!-- /.box-header -->
       <div class="box-body table-responsive">
         <table id="example1" class="table table-bordered table-striped">
           <thead>
	           <tr>
					<th>ID</th>
					<th>Subscriber</th>
					<th>Plan</th>
					<th>Amount</th>
					<th>Date</th>
					<th>Expires On</th>
					<th>Status</th>
					<th>Paid On</th>
					<th><i class="fa fa-cogs"></i></th>
			   </tr>
		   </thead>
           <tbody>
			<% 
			connect();
			try {
			 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `subbills` ORDER BY `id` DESC");
				while(rs1.next()){
			 		String stid=rs1.getString("id");
			 		String stn=rs1.getString("subscriber");
				  	String btn_rm = "<a href='?q=delete&item="+stid+"'><button class='btn btn-md btn-danger'><i class='fa fa-times pull-right'></i></button></a>";
				  	String btn_ed = "<a href='?q=pay&item="+stid+"'><button class='btn btn-md btn-info'><i class='fa fa-money pull-right'></i></button></a>";
			
					out.println("<tr>");
					out.println("<td>"+stid+"</td>");
					out.println("<td>"+stn+"</td>");
					out.println("<td>"+rs1.getString("plan")+"</td>");
					out.println("<td>"+rs1.getString("amount")+"</td>");
					out.println("<td>"+rs1.getString("bill_for")+"</td>");
					out.println("<td>"+rs1.getString("bill_to")+"</td>");
					out.println("<td>"+rs1.getString("status")+"</td>");
					out.println("<td>"+rs1.getString("paidon")+"</td>");
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
<!-- page script -->
</body>
</html>