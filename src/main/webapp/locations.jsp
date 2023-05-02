<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>

<%! String bn="0x0badf00d", ips="collapse", ipadd="Not Found", network="Not Found",id="", interf="Not Found"; %>

<% 
//remove walled garden
if(request.getParameter("q") != null && request.getParameter("q").equals("modal")) {
	
	try {
		String item = request.getParameter("item");
		bn = item;
		ips="collapse in";
		if(bn != "0x0badf00d"){
			for (Map<String,String> mp : g.getIpByName(bn)) {
			  	id = mp.get(".id");
			  	ipadd = mp.get("address");
			  	network = mp.get("network");
			  	interf = mp.get("interface");
			}
		}
			
	} catch (Exception e1) { System.out.println(e1); }
}else{
	ips="collapse";
	bn = "0x0badf00d";
}
%>
<% 
//remove enable disabled
if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("interface")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeBridge(item);
		
		String logact = "Interface "+item+" Removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("locations.jsp");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("interface")) {
	
	try {
		String id = request.getParameter("item").toString();
		
		g.disableInterface(id);
		
		String logact = "Interface "+id+" Removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("locations.jsp");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("interface")) {
	
	try {
		String id = request.getParameter("item").toString();
		
		g.enableInterface(id);
		
		String logact = "Interface "+id+" Removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("locations.jsp");
		
		
	} catch (Exception e1) { System.out.println(e1); }
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
    Locations
    <small>Network locations</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="hotspot.jsp?q=walledgarden">Network</a></li>
    <li class="active">Locations</li>
  </ol>
</section>
<!-- Table List -->
<section class="content-header">
	<div class="panel box box-primary">
          <%-- <div class="box-header with-border">
            <h4 class="box-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#">
                IP Settings (<% out.print(bn); %>)
              </a>
            </h4>
          </div> --%>
          <div id="collapseOne" class="panel-collapse <% out.print(ips); %>">
            <div class="box-body">
           		<span class="pull-left">IP Address:</span>
		        <span class="pull-right"><% out.print(ipadd); %></span><br />
		        <span class="pull-left">Network:</span>
		        <span class="pull-right"><% out.print(network); %></span><br />
		        <span class="pull-left">Interface:</span>
		        <span class="pull-right"><% out.print(interf); %></span><br />
            </div>
            <div class="box-body">
            	<a href='location_setting.jsp?location=<%=bn %>'><button class='btn btn-sm btn-warning'>Manage Settings</button></a>
            	<a href='add_vlan.jsp?location=<%=bn %>'><button class='btn btn-sm btn-success pull-right'>Manage VLAN</button></a>
            </div>
          </div>
        </div>
</section>
<div class='col-md-12'><a href="new_location.jsp"><button class='btn btn-lg bg-navy col-sm-12'>Add New Location</button></a></div>

<br />
<section class="content">
  <div class="row">
    <div class="col-xs-12"><!-- /.box -->

      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Locations</h3>
          <%@include file="import.jsp" %>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example1" class="table table-bordered table-striped table-responsive">
            <thead>
              <tr>
                <th><i class="fa fa-edit"></i></th>
                <th>Name</th>
                <th>Mac Address</th>
                <th>disabled</th>
                <th>IP Setting</th>
                <th><i class="fa fa-cog"></i></th>
              </tr>
            </thead>
            <tbody>
            <%for (Map<String,String> mp : g.bridges()) {
            	String c = String.valueOf(mp.get("comment"));
	      		if(!c.contains("Default")){
				  	String s = mp.get(".id");
				  	String name = mp.get("name");
				  	String btn_en = "<a href='?q=enable&type=interface&item="+s+"'><button class='btn btn-xs btn-success'>En</button></a>";
				  	String btn_ds = "<a href='?q=disable&type=interface&item="+s+"'><button class='btn btn-xs btn-warning'>Dis</button></a>";
				  	String btn_dl = "<a href='?q=remove&type=interface&item="+s+"'><button class='btn btn-xs btn-danger'>Del</button></a>";
				  	String btn_ed = "<a href='edit_location.jsp?q=edit&type=interface&item="+s+"&location="+name+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
				  	String btn_ip = "<a href='?q=modal&item="+name+"'><button class='btn btn-xs btn-info'>View Setting</button></a>";
					
				  	out.println("<tr>");
					out.println("<td>"+btn_ed+"</td>");
					out.println("<td>"+mp.get("name")+"</td>");
					out.println("<td>"+mp.get("mac-address")+"</td>");
					out.println("<td>"+mp.get("disabled")+"</td>");
					out.println("<td>"+btn_ip+"</td>");
					out.println("<td>"+btn_en+" "+btn_ds+" "+btn_dl+"</td>");
					out.println("</tr>");
	      		}
			  
			}%>
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