<%@include file="header.jsp" %>

 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%
//bypass vlan
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Bypass VLAN")) {
	try {
		String vn = request.getParameter("vlan");
		g.bypassVlan(vn);
		
		String logact = "VLAN "+vn+" bypassed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("vlan_bypass.jsp?msg=VLAN has been succesfully bypassed.&type=success");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
//unbypass vlan
if(request.getParameter("q") != null && request.getParameter("q").equals("unbypass")&& request.getParameter("type").equals("vlan")) {
	
	try {
		String vn = request.getParameter("item").toString();
		if(g.unBypassVlan(vn)){
			String logact = "VLAN "+vn+" un-bypassed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			response.sendRedirect("vlan_bypass.jsp?msg=VLAN has been succesfully removed from bypassed.&type=success");
		}
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
            Bypass VLan
            <small>Open VLan user access / Suspend Landing Page</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Interfaces</a></li>
            <li class="active">VLan Bypass</li>
          </ol>
        </section>
        <section class="content-header" style="margin-top:30px;">
			<div class="panel box box-primary">
	           <div class="box-header with-border">
	             <h4 class="box-title">
	               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	                 Bypass VLan <span><i class="fa fa-angle-double-down"></i></span>
	               </a>
	             </h4>
	           </div>
	           <div id="collapseOne" class="panel-collapse collapse">
	             <div class="box-body">
	             	<form class="form-horizontal" action="vlan_bypass.jsp" method="post">
				         <div class="form-group">
				           <label for="vlan" class="col-sm-2 control-label">Select Vlan</label>
				           <div class="col-sm-10">
				             <select class="form-control" id="vlan" name="vlan">
				             <%for (Map<String,String> mp : g.getVlan()) {
					  				String s = mp.get("name");
					  				%>
					  				<option><%out.print(s);%></option>
				             <%}%>
				             </select>
				           </div>
				         </div>
					     <input type="submit" name="submit" class="form-control btn btn-info" value="Bypass VLAN" />
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
                  <h3 class="box-title">Bypassed VLans</h3>
                  <%@include file="import.jsp" %>
                </div><!-- /.box-header -->
                <div class="box-body">
                  <table id="example1" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>VLan</th>
                        <th>Status</th>
                        <th>Location</th>
                        <th><i class="fa fa-cog"></i></th>                        
                      </tr>
                    </thead>
                    <tbody>
                    <%for (Map<String,String> mp : g.getBrigeVlan("Bypass")) {		
                    	String s = mp.get("interface");
					  	String btn = "<a href='?q=unbypass&type=vlan&item="+s+"'><button class='btn btn-xs btn-success'>Un-Bypass</button></a>";
					  	out.println("<tr>");
						out.println("<td>"+mp.get("interface")+"</td>");
						out.println("<td>"+mp.get("bridge")+"</td>");
						out.println("<td>"+mp.get("comment")+"</td>");
						out.println("<td>"+btn+"</td>");
						out.println("</tr>");
					}%>
                    </tbody>
                    
                  </table>
                </div><!-- /.box-body -->
              </div><!-- /.box -->
            </div><!-- /.col -->
          </div><!-- /.row -->
        </section><!-- /.content -->
	</div><!-- /.content-wrapper -->
<footer class="main-footer">
  <div class="pull-right hidden-xs">
  <b>Version</b> <%=sysver%>
  </div>
  <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">ALPS Gateway</a>.</strong> All rights reserved.
</footer>
<!-- /Table Export -->   
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
<!-- jQuery 2.1.4-->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script> 
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.js"></script>
<script>
  $(function () {
	$("#example1").DataTable({'responsive': true});
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