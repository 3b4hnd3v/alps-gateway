<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>

<% 
if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("interface")) {
	
	try {
		String id = request.getParameter("item").toString();
		
		g.disableInterface(id);
		
		String logact = "Interface "+id+" Removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("zone_manager.jsp");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("interface")) {
	
	try {
		String id = request.getParameter("item").toString();
		
		g.enableInterface(id);
		
		String logact = "Interface "+id+" Removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("zone_manager.jsp");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>

<div class="content-wrapper" >
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
    Zone Manager
    <small>Network Zones / Locations</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="hotspot.jsp?q=walledgarden">LAN Network</a></li>
    <li class="active">Zone Manager</li>
  </ol>
</section>

<section class="content">
  <div class="row">
    <div class="col-xs-12"><!-- /.box -->

      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Locations</h3>          
        </div><!-- /.box-header -->
        <div class="box-body">
          <div class="row">
          	<%for (Map<String,String> mp : g.bridges()) {
          		Map<String,String> zs = null; String vlc = "0";
            	String c = String.valueOf(mp.get("comment"));
	      		if(!c.contains("Default")){
				  	String s = mp.get(".id");
				  	String name = mp.get("name");
				  	String btn_qs = "<a href='?q=disable&type=interface&item="+s+"'><button class='btn btn-xs btn-warning'>Disable</button></a>";
				  	if(Boolean.valueOf(mp.get("disabled"))){
					  	btn_qs = "<a href='?q=enable&type=interface&item="+s+"'><button class='btn btn-xs btn-success'>Enable</button></a>";
				  	}
				  	String btn_ed = "<a title='Change Name' href='edit_location.jsp?q=edit&type=interface&item="+s+"&location="+name+"'><button class='btn btn-xs btn-success'><i class='fa fa-edit'></i></button></a>";
				  	String btn_ip = "<a href='?q=modal&item="+name+"'><button class='btn btn-xs btn-info'>View Setting</button></a>";
				  	for (Map<String,String> imp : g.getIpByName(name)) {
				  		zs = imp;
				  	}
				  	
				  	for (Map<String,String> zv : gc.vlans(name)) {
				  		vlc = zv.get("ret");
				  	}
				  	
	      	%>
	      	<div class="col-md-12">
              <!-- Widget: user widget style 1 -->
              <div class="box box-widget widget-user-2">
                <!-- Add the bg color to the header using any of the bg-* classes -->
                <div class="widget-user-header bg-green">
                  <div class="widget-user-image">
                    <img class="img-circle" src="dist/img/icons/zone.png" alt="Zone Avatar">
                  </div><!-- /.widget-user-image -->
                  <h3 class="widget-user-username">
                  	<%= mp.get("name") %> 
                  	<span class="pull-right"><%= btn_ed %></span>
                  </h3>
                  <h5 class="widget-user-desc">
                  	<% if(Boolean.valueOf(mp.get("disabled"))){ %>
                  		Inactive
                  	<% }else{ %>
                  		Active
                  	<% } %>
                  </h5>
                </div>
                <div class="box-footer no-padding">
                  <ul class="nav nav-stacked">
                    <li><p style="padding:20px;">VLANS <span class="pull-right badge bg-blue"><%= vlc %></span></p></li>
                    <li><p style="padding:20px;">LAN IP <span class="pull-right"><%= zs.get("address") %></span></p></li>
                    <li>
                    	<p style="padding:20px;">
                    		Status :  
                    		<span class="badge bg-blue">
                    			<% if(Boolean.valueOf(mp.get("disabled"))){ %>
			                  		Inactive
			                  	<% }else{ %>
			                  		Active
			                  	<% } %>
                    		</span>
                    		<i style="padding-left:10px;" class="fa fa-wrench"></i> 
                    		<span class="pull-right badge bg-red"><% out.println(btn_qs); %></span>
                    	<p>
                    </li>
                    <li>
                    	<p style="padding:20px;">
                    		Manage <i style="padding-left:10px;" class="fa fa-cogs"></i>
	                    	<span class="pull-right">
		                    	<a style="margin-right:10px;" href='location_setting.jsp?location=<%=name %>' class='btn btn-sm btn-warning'>Manage Settings</a>
	            				<a href='add_vlan.jsp?location=<%=name %>' class='btn btn-sm btn-success pull-right'>Manage VLAN</a>
	                    	</span>
                    	<p>
                    </li>
                  </ul>
                </div>
              </div><!-- /.widget-user -->
            </div><!-- /.col -->
          	
            <%}}%>
          </div><!-- /.row -->
        </div><!-- /.box-body -->
        <div class="box-footer">
          <div class='row'>
	          <div class='col-md-12'>
	          	<a href="new_location.jsp">
	          		<button class='btn btn-lg bg-navy col-sm-12'>Add New Location</button>
	          	</a>
	          </div>
          </div>
        </div><!-- /.box-header -->
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