<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%! public InputStream data, error;
String url = "", upbtn="",
charset = "UTF-8";  // Or in Java 7 and later, use the constant: java.nio.charset.StandardCharsets.UTF_8.name()
%>
<%
connect();
try {
  	ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `settings` where `setting_name`='update_json'");
  	
  	while(rs.next()){
  		url = rs.getString("setting_value")+"?ver="+dao.getVersion();
  		//url = "http://clients.alpsgateway.com/json.php?all=Level%204%20Demo";
  		System.out.println(url);
  	}
		
		cn.close();
} catch(Exception e) {  System.out.println(e);}
if(dao.checklicense().equals("valid")){
	upbtn = "invalid";
}
%>
<div class="content-wrapper"  align="center">
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
<br>
<section class="content">
 <div class="row" style="margin-top: 10px;">
   <div class="col-md-12">
     <div class="box box-primary">
       <div class="box-header">
         <h3 class="box-title"><i class="fa fa-gear"></i>&nbsp;&nbsp;&nbsp;&nbsp;System Update</h3>
       </div>
       <div class="box-body">
			<div style="font-weight: 600; font-size: 15px; min-height: 50px;" class="col-md-12 well" >
				<p align="center">Current Version</p>
				<p align="center"><font size="25" color="green">You are currently running:</font></p>
				<p align="center"><font size="25" color="green" face="calibri maths">1.0</font></p>
				<br /><br />
				
				<p align="center">Update to most current version here</p>
				<button class="btn btn-lg btn-flat btn-success">Upgrade Now</button>
				
			</div>
	   </div><!-- /.box-body -->
	 </div><!-- /.box -->
   </div><!-- /.col -->
  </div><!-- /.row -->
</section>
<!-- Table List -->
<section class="content">
  <div class="row">
    <div class="col-xs-12"><!-- /.box -->
      <div class="box box-warning">
        <div class="box-header">
          <h3 align="center" class="box-title"><i class="fa fa-info"></i>&nbsp;&nbsp;&nbsp;&nbsp;System Update History</h3>
        </div><!-- /.box-header -->
        <div class="box-body table-responsive">
          <table id="example1" class="table table-bordered table-striped">
            <thead>
              <tr>
                <!-- <th>ID</th>-->
                <th>Name</th>
                <th>Description</th>
                <th>Version</th>
                <th>Type</th>
                <th>Date</th>
                <th>Status</th>
                <th>Update</th>
              </tr>
            </thead>
            <tbody>
            	<%
                   	 try {
					   String recv;
					   String recvbuff = "";
					   URL jsonpage = new URL(url);
					   URLConnection urlcon = jsonpage.openConnection();
					   BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream()));
					
					   while ((recv = buffread.readLine()) != null){
					    	recvbuff += recv;
					   }
					   buffread.close();
					   
					   Object obj=JSONValue.parse(recvbuff);
					   JSONArray array=(JSONArray)obj;
					   //System.out.print(recvbuff);
					   for(int i=1; i< array.size(); i++){
						  
						    JSONObject rs1=(JSONObject)array.get(i);
						    
	                 		String warfile = rs1.get("warfile").toString();
	                 		String dbfile = rs1.get("dbfile").toString();
		                 	String update_btn = "<a href='upgrade.jsp?q=upgrade&warfile="+warfile+"&dbfile="+dbfile+"' target='_blank'><button "+upbtn+" class='btn btn-sm btn-flat btn-success'>Upgrade Now</button>";
	                 		out.println("<tr>");
	            		 	//out.println("<td>"+rs1.get("uid")+"</td>");
	            		 	out.println("<td>"+rs1.get("name")+"</td>");
	            		 	out.println("<td>"+rs1.get("description")+"</td>");
	            		 	out.println("<td>"+rs1.get("version")+"</td>");
	            		 	out.println("<td>"+rs1.get("type")+"</td>");
	            		 	out.println("<td>"+rs1.get("date")+"</td>");
	            		 	out.println("<td>"+rs1.get("status")+"</td>");
	            		 	out.println("<td>"+update_btn+"</td>");
	            		 	out.println("</tr>");
	                 	}
	               		
	               		cn.close();
	               	} catch(Exception e) { 
        		 	 	System.out.print(e);
					 }
	                %>
            </tbody>
		  </table>
		</div>
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
	$("#example1").DataTable();
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