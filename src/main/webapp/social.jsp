<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%!public InputStream data, error;
String url = "",
charset = "UTF-8";  // Or in Java 7 and later, use the constant: java.nio.charset.StandardCharsets.UTF_8.name()%>
<%
String cl = dao.getDashValue("client").toString().replace(" ", "%20");
url = dao.getSetting("socurl")+"?all="+cl;
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
           List of Social Auth Users
           <small>List Of Social Auth Users</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Hotspot</a></li>
           <li class="active">Users</li>
         </ol>
       </section>
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->
             <div class="box">
               <div class="box-header">
                 <h3 class="box-title col-sm-4">Social Authentication Users</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Provider</th>
                       <th>User name</th>
                       <th>Email ID</th>
                       <th>Location</th>
                       <th>Visits</th>
                       <th>1st Sign-in</th>
                       <th>Recent Sign-in</th>
                       <th class="noExl"><i class="fa fa-cogs"></i></th>
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
						  
						   JSONObject obj2=(JSONObject)array.get(i);
						   String prbtn="<a href='"+obj2.get("profileurl")+"' target='_blank'><button title='View Profile' class='btn btn-xs btn-info'><i class='fa fa-user'></i></button></a>";
						   String picbtn="<a href='"+obj2.get("imageurl")+"' target='_blank'><button title='Profile picture' class='btn btn-xs btn-success'><i class='fa fa-image'></i></button></a>";
						   String vbtn="<a href='social_user.jsp?client="+obj2.get("clientid")+"&user="+obj2.get("username")+"' target='_self'><button title='Summary' class='btn btn-xs btn-primary'><i class='fa fa-area-chart'></i></button></a>";

						   out.println("<tr>");
						   out.println("<td>"+obj2.get("id")+"</td>");
						   out.println("<td>"+obj2.get("provider")+"</td>");
						   //out.println("<td>"+obj2.get("userid")+"</td>");
						   out.println("<td>"+obj2.get("username")+"</td>");
						   //out.println("<td>"+obj2.get("gender")+"</td>");
						   out.println("<td>"+obj2.get("emailid")+"</td>");
						   out.println("<td>"+obj2.get("location")+"</td>");
						   out.println("<td>"+obj2.get("visit")+"</td>");
						   out.println("<td>"+obj2.get("created")+"</td>");
						   out.println("<td>"+obj2.get("modified")+"</td>");
						   out.println("<td class='noExl' id='noExl' width='220px'>"+prbtn+"&nbsp;"+picbtn+"&nbsp;"+vbtn+"</td>");
						   
						   //System.out.println(obj2.get("id"));
						   out.println("</tr>");
					   }
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
			
</div><!-- /.content-wrapper -->
<footer class="main-footer">
  <div class="pull-right hidden-xs">
    <b>Version</b> <%=sysver%>
  </div>
  <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">Alps Gateway</a>.</strong> All rights reserved.
</footer>
</div> <!-- /.content -->
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
<!-- jQuery 2.1.4-->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script> 
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.js"></script>
<script>
  $(function () {
	$("#example1").DataTable({
		"lengthChange": true,
		"responsive": true
	});
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
<!-- page script -->
</body>
</html>