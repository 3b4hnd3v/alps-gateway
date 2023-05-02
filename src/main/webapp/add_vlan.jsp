<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<% 
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("type").equals("port")) {
	
	try {
		String item = request.getParameter("item").toString();
		String itemname = request.getParameter("itemname").toString();
		String locat = request.getParameter("location");
		g.removePort(item);
		g.removeVlanByName(itemname);
		
		
		String logact = "Vlan Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("add_vlan.jsp?location="+locat+"&msg=Successfully removed&type=success");
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<%! String location = ""; %>
<%if(request.getParameter("location") == null){ %>
	<div class="content-wrapper">
	<section class="content-header">
	  <!--  h1>
	    Create Location
	    <small>Create New Location</small>
	  </h1>-->
	  <div class="panel box box-primary">
	    <div class="box-header with-border">
	      <h4 class="box-title">
	        <a data-toggle="collapse in" data-parent="#accordion" href="#">
	          Select Location <span><i class="fa fa-angle-double-down"></i></span>
	        </a>
	      </h4>
	    </div>
	    <div id="collapseOO" class="panel-collapse collapse in">
	      <div class="box-body">
	      	<form action="add_vlan.jsp" method="post">
	      		<div class="col-sm-12">
	      			<div class="form-group">
			      	<!--  label>Name</label>-->
			      	<select class="form-control" required name="location">
				      	<option></option>
				      	<% 
				      	for (Map<String,String> mp : g.bridges()) {
				      		String c = String.valueOf(mp.get("comment"));
				      		if(!c.contains("Default")){
						  		String s = mp.get("name");
		                        out.println("<option>"+s+"</option>");
				      		}
	                     }
		                 %>
					</select>
					</div>
				</div>
      			<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Proceed To Add VLAN" />
	     	</form>
	      </div>
	    </div>
	   </div>
		</section>
	 </div>
<%}else{
	location = request.getParameter("location").toString();
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
    Location VLAN
    <small>ADD VLANs To Location</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Network</a></li>
    <li><a href="#">Location</a></li>
    <li class="active">VLAN</li>
  </ol>
</section>
<section class="content-header">
<div class="panel box box-primary">
    <div class="box-header with-border">
      <h4 class="box-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseO">
          Manually Add VLANs <span><i class="fa fa-angle-double-down"></i></span>
        </a>
      </h4>
    </div>
    <div id="collapseO" class="panel-collapse collapse">
      <div class="box-body">
      	<form action="create_vlan.jsp" method="post">
      		<div class="col-sm-12" align="center"><span>Location</span><hr></div>
      		<div class="col-sm-12">
		      	<label>Name</label>
				<input type="text" readonly class="form-control" name="locname" value="<% out.print(location);%>"><br />
			</div>
      		<div class="col-sm-12" align="center"><span>VLAN</span><hr></div>
      		<div class="col-sm-6">
		      	<label>Vlan ID</label>
				<input type="text" class="form-control" name="vlanid"><br />
			</div>
			<div class="col-sm-6">
		      	<label>Vlan Name</label>
				<input type="text" class="form-control" name="vlname"><br />
			</div>      		
      		<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Create VLAN" />
	     </form>
      </div>
    </div>
  </div>
</section>
 <!-- Table List -->
<section class="content">
  <div class="row">
    <div class="col-md-7"><!-- /.box -->

      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Vlans</h3>
        </div><!-- /.box-header -->
        <div class="box-body table-responsive">
          <table id="example1" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Location</th>
                <th>Status</th>
                <th>Disabled</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <%
               try{
            	   for (Map<String,String> mp : g.getBrigeVlan(location)) {
     				  //System.out.println(r);
     				  	String s = mp.get(".id");
     				  	String btn_dl = "<a href='?location="+location+"&q=delete&type=port&item="+s+"&itemname="+mp.get("interface")+"'><button class='btn btn-sm btn-danger'>Del</button></a>";
     				  	
     				  	out.println("<tr>");
     					out.println("<td>"+s+"</td>");
     					out.println("<td>"+mp.get("interface")+"</td>");
     					out.println("<td>"+mp.get("bridge")+"</td>");
     					out.println("<td>"+mp.get("status")+"</td>");
     					out.println("<td>"+mp.get("disabled")+"</td>");
     					out.println("<td>"+btn_dl+"</td>");						
     					out.println("</tr>");
     				}
               }catch(Exception e){
            	   e.printStackTrace();
               }
            %>
            
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div><!-- /.col -->
    <div class="col-md-5 well"><!-- /.box -->
    <h3 align="center">Add Vlan By Upload</h3>
    	<form action="uploadVlan.jsp" method="post" enctype="multipart/form-data">
    		<input type="hidden" class="form-control" name="locname" value="<% out.print(location);%>">
    		<label>Choose File:</label>
			<input type="file" class="form-control" name="cfile">
			<small class="text-danger">**All files uploaded should have one word name. e.g: alps-vlan.xsl</small><br />
			<input type="submit" name="submit" class="form-control btn btn-info" value="Upload Vlans" />
    	</form>
    	<br />
    	<a href="/dist/files/ALPSVlanListTemplate.xlsx" download><button class="form-control btn btn-lg bg-navy">Download VLan List Template</button></a>
    </div>
  </div><!-- /.row -->
</section><!-- /.content -->

</div>
<%}%>
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
	$("#example1").DataTable({responsive: true});
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
<script>
	$(document).ready(function () {
	    // check whether tableExport plugin is loaded
	    if (typeof $.tableExport !== "function") {
	    	$.getScript("plugins/tableexport/tableExport.js");
	    	$.getScript("plugins/tableexport/jquery.base64.js");
	    	$.getScript("plugins/tableexport/html2canvas.js");
	    	$.getScript("plugins/tableexport/jspdf/libs/sprintf.js");
	    	$.getScript("plugins/tableexport/jspdf/jspdf.js");
	    	$.getScript("plugins/tableexport/jspdf/libs/base64.js");
	        //alert("imported");
	    }
	});
</script>
<!-- page script -->
</body>
</html>