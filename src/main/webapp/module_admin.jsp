<%@include file="header.jsp" %>
<%
	if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("module")) {
	
	try {
		String item = request.getParameter("item").toString();
		cn.createStatement().execute("UPDATE modules SET active='1' WHERE id="+item);		
		System.out.println("Updated!");
		response.sendRedirect("module_admin.jsp");
		
		String logact = "Module "+item+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
  	  
	} catch (Exception e1) { 
		System.out.println(e1); }
}
else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("module")) {
	
	try {
		String item = request.getParameter("item").toString();
		cn.createStatement().execute("UPDATE modules SET active='0' WHERE id="+item);		
		System.out.println("Updated!");
		response.sendRedirect("module_admin.jsp");
		
		String logact = "Module "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
  	  
	} catch (Exception e1) { 
		System.out.println(e1); }
}
else if(request.getParameter("q") != null && request.getParameter("q").equals("acquire")&& request.getParameter("type").equals("module")) {
	try {
		String item = request.getParameter("item").toString();
		cn.createStatement().execute("UPDATE modules SET active='1', `acquired`='1' WHERE id="+item);		
		System.out.println("Updated!");
		response.sendRedirect("module_admin.jsp");
		
		String logact = "Module "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
  	  
	} catch (Exception e1) { 
		System.out.println(e1); }
}
else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("module")) {
	
	try {
		String item = request.getParameter("item").toString();
		cn.createStatement().execute("UPDATE modules SET active='0', `acquired`='0' WHERE id="+item);		
		System.out.println("Updated!");
		response.sendRedirect("module_admin.jsp");
		
		String logact = "Module "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
  	  
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>


 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>

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
	<div class="box">
                <div class="box-header">
                  <h3 class="box-title">Manage Modules</h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                  <table id="example1" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Title</th>
                        <th>Status</th>
                        <th>Acquisition</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                    <%
                    connect();
                    ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM modules");
                      String btn = "", btn1 = "";
                	  while(rs.next()){
                	  if(rs.getString("active").equals("1")){
                		  btn = "<a href='?q=disable&type=module&item="+rs.getString("id")+"'><button class='btn btn-sm btn-danger'>Disable</button></a>";
                	  }else if(rs.getString("active").equals("0")){
                		  btn = "<a href='?q=enable&type=module&item="+rs.getString("id")+"'><button class='btn btn-sm btn-success'>Enable</button></a>";
                	  }
                	  if(rs.getString("acquired").equals("1")){
                		  btn1 = "<a href='?q=remove&type=module&item="+rs.getString("id")+"'><button class='btn btn-sm btn-danger'>Remove</button></a>";
                	  }else if(rs.getString("acquired").equals("0")){
                		  btn1 = "<a href='?q=acquire&type=module&item="+rs.getString("id")+"'><button class='btn btn-sm btn-success'>Acquire</button></a>";
                	  }
                	  %>
                      <tr>
                        <td><% out.println(rs.getString("ID")); %></td>
                        <td><% out.println(rs.getString("name")); %></td>
                        <td><% out.println(rs.getString("title")); %></td>
                        <td><% out.println(rs.getString("active")); %></td>
                        <td><% out.println(rs.getString("acquired")); %></td>
                        <td><% out.println(btn); %><% out.println(btn1); %></td>
                                          
                      </tr>
					<% } %>
                    </tbody>
                    <tfoot>
                    </tfoot>
                  </table>
                </div><!-- /.box-body -->
              </div><!-- /.box -->
            </div><!-- /.col -->
          </div><!-- /.row -->
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->
	
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