<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="toolbar.jsp" %>
<%
LMOIpList us = new LMOIpList(),
editable = new LMOIpList();
String ipmessage="", 
lid="", 
lmo_item="",
interf="",
interf_id="",
result=""; 
if(request.getParameter("interf") != null && request.getParameter("interf_id") != null) {
	interf = request.getParameter("interf");
	interf_id = request.getParameter("interf_id");
}else{
	response.sendRedirect("letmeout_sel_int.jsp?msg=Please Select Interface&type=error");
}
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Address Range")) {
	String ippref = request.getParameter("ippref");
	String ipnet = request.getParameter("network");
	String netmask = request.getParameter("netmask");
	String iid = request.getParameter("interf_id");
	String iname = request.getParameter("interf");
	String ipfrom = request.getParameter("ipfrom");
	String ipto = request.getParameter("ipto");
	boolean ir = false;
	for(int i = Integer.parseInt(ipfrom); i <= Integer.parseInt(ipto); i++){
		String ipadd = ippref + i;
		
		us.setAddress(ipadd);
		us.setInterf(iname);
		us.setMask(netmask);
		us.setNetwork(ipnet);
		
		ir = us.add();
	}
	if(ir){
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Added Succesfully&type=success");
	}else{
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Failed To Add IP Range&type=error");
	}
}
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Remove")) {
	String item = request.getParameter("ref");
	String iid = request.getParameter("interf_id");
	String iname = request.getParameter("interf");
	String litem = request.getParameter("lid");
	
	if(mg.removeLmoIP(item) && mg.removeLmoNat(item)){
		us.changeStat(litem, "0","none");
		response.sendRedirect("letmeout.jsp?interf="+iname+"&interf_id="+iid+"&msg=Added Succesfully&type=success");
	}else{
		response.sendRedirect("letmeout.jsp?interf="+iname+"&interf_id="+iid+"&msg=Failed To Add IP Range&type=error");
	}
}

if(request.getParameter("lmo_reference") != null) {
	System.out.println("Activate");
	try {
		lmo_item = request.getParameter("lmo_reference");
		lid = lmo_item.split("_")[1];
		
		editable = us.getOne(lid);
	} catch (Exception e1) { System.out.println(e1); }
}
%>

<div class="content-wrapper">
	<!-- Content Header (Page header) -->
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
	<%} %>
	<%if(ipmessage != null && !ipmessage.equals("")){ %>
		<div class="alert alert-info alert-dismissible">
		  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		  <h4><i class="icon fa fa-info"></i> Alert!</h4>
		  <%out.println(ipmessage); %>
		</div>
	<%} %>
	<section class="content-header" style="margin-bottom:20px;">
	  <h1>
	    LetMeOut<sup>TM</sup> Client
	    <small>Manage LetMeOut<sup>TM</sup> Client</small>
	  </h1>
	  <ol class="breadcrumb">
	    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	    <li><a href="#">Main</a></li>
	    <li class="">WAN</li>
	    <li class="active">Interfaces</li>
	  </ol>
	</section>
	
	<section class="content">
		<div class="row">
			<div class="col-md-12">
	              <!-- Info Boxes Style 2 -->
	              <div class="info-box bg-blue">
	                <span class="info-box-icon"><i class="fa fa-laptop"></i></span>
	                <div class="info-box-content">
	                  <span class="info-box-text"><%= editable.getAssigned() %></span>
	                  <span class="info-box-number"><%= editable.getAddress() %></span>
	                  <div class="progress">
	                    <div class="progress-bar" style="width: 100%"></div>
	                  </div>
	                  <span class="progress-description">
	                    Client Let Out Via <%= interf %>
	                  </span>
	                </div><!-- /.info-box-content -->
	              </div><!-- /.info-box -->
	        </div>
	        <div class="col-md-12">
				<div class="panel box box-primary">
				        <div class="box-header with-border">
				          <h4 class="box-title" style="width:100%;">
				            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOneX">
				              Manage <%= lmo_item %>
				            </a>
				            <span class="pull-right"><i class="fa fa-cog"></i></span>
				          </h4>
				        </div>
				        <div id="collapseOne" class="panel-collapse collapse">
				          	<div class="box-body"></div><!-- /.box-body -->
				        </div>
				        <div class="box-footer">
				      <form action="#" method="post">
				      	<input type="hidden" required class="form-control" readonly name="interf_id" value="<%= interf_id %>">
				      	<input type="hidden" required class="form-control" readonly name="interf" value="<%= interf %>">
				      	<input type="hidden" required class="form-control" readonly name="lid" value="<%= lid %>">
				      	<input type="hidden" required class="form-control" readonly name="ref" value="<%= lmo_item %>">
				      	
				      	<input type="submit" name="submit" class="btn btn-danger btn-block" value="Remove">
				      </form>
				  </div><!-- /.box-footer -->
				</div>
			</div>
		</div>
        <div class="row">
			<div class="col-md-12">
				<div class="box">
				  <div class="box-header">
				    <h3 class="box-title">Client LetMeOut<sup>TM</sup> Connection Logs</h3>
				  </div><!-- /.box-header -->
				  <div class="box-body">
				    <table id="example1" class="table table-bordered table-striped table-responsive">
				        <thead>
				          <tr>
				            <th>Time</th>
				            <th>Access Activity</th>
				            <!-- <th>Scope</th> -->
				          </tr>
				        </thead>
				        <tbody>
				        <%
				        List<Map<String, String>> glogs = g.logs();
				        for (Map<String,String> mp : glogs) {
				        	  	if(mp.get("message").contains(lmo_item)){
				        	  		String msg = mp.get("message");
				        	  		msg = msg.replace("dstnat:", "<br />Connection: Incoming<br />");
				        	  		msg = msg.replace("in:", "In Interface: ");
				        	  		msg = msg.replace("out:", " | Out Interface: ");
				        	  		msg = msg.replace(", src-mac", "<br />Connecting Device MAC: ");
				        	  		msg = msg.replace(", proto", "<br />Connection Protocol: ");
				        	  		msg = msg.replaceFirst(",", "<br /> Connection Info: ");
				        	  		msg = msg.replace(", len", "<br />Data Length: ");
								  	out.println("<tr>");
									out.println("<td>"+mp.get("time")+"</td>");
									out.println("<td class='text-justify'>"+msg+"</td>");
									//out.println("<td>"+mp.get("topics")+"</td>");
									out.println("</tr>");
				        	  	}
						  }
						  %>
				        </tbody>
				        <tfoot>
				                  
				        </tfoot>
				    </table>
				  </div><!-- /.box-body -->
				</div><!-- /.box -->
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
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.js"></script>
<script>
  $(function () {
	$("#example1").DataTable({
		"responsive": true,
		"scrollY":        "700px",
        "scrollCollapse": true,
        "paging":         false
	});
    
  });
</script>
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