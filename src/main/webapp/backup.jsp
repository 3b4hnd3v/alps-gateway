<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%!public String location = "", client = "", buloc = ""; SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy"); Date but = new Date();%>
<%
client = dao.getDashValue("client").replaceAll("\\s","").toLowerCase();
buloc = "/home/alps/ALPS/Backup/";
GwBackUp gb = new GwBackUp();
%>
<% 
if(request.getParameter("q") != null && request.getParameter("q").equals("get")&& request.getParameter("type").equals("backup")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		gb.download(item);
		out.print("<script>alert('"+item+" is now ready for download');</script>");
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("restore")&& request.getParameter("type").equals("walledgarden")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		gb.restore(item);
		
	} catch (Exception e1) { System.out.println(e1); }
}%>
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
    Back Up And Restore
    <small>Systems Back Up Setup and Restore</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Policy</a></li>
    <li class="active">Back Up</li>
  </ol>
</section>
 <section class="content">
  <div class="callout callout-info">
    <h4>Tip!</h4>
    <p>Setup System Back Up to remote server. To avoid data and config loss in event of system failure.</p>
    <p>Remote Back Up Require Initial Setup. Read Manual For More Information on Initial Setup.</p>
    <p>Local Back </p>
  </div>
  <!-- Default box -->
  <div class="box">
    <div class="box-header with-border">
      <h3 class="box-title">Back Up History</h3>
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="#collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
        <button type="button" class="btn btn-box-tool" data-widget="#remove" data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
      </div>
    </div>
    <div class="box-body">
      <table id="example1" class="table table-bordered table-striped table-responsive">
	      <thead>
	        <tr>
	          <th>File</th>
	          <th>Created</th>
	          <th>Created For</th>
	          <th>Action</th>
	        </tr>
	      </thead>
	      <tbody>
	      <%for (String mp : gb.list()) {
         	   if(mp.contains(".backup")){
         		   String btn_dl = "";
         		   if(gb.isGot(mp)){
    				   btn_dl = "<a href='"+buloc+""+mp+"' download><button class='btn btn-xs btn-warning'>Download</button></a>";
         		   }else{
    				   btn_dl = "<a href='?q=get&type=backup&item="+mp+"'><button class='btn btn-xs btn-success'>Get</button></a>";
         		   }
				   String btn_rs = "<a href='?q=restore&type=backup&item="+mp+"'><button class='btn btn-xs btn-primary'>Restore</button></a>";
         		   try{
         			   String[] dets = mp.split("_");
         			   out.println("<tr>");
	   				   out.println("<td>"+mp+"</td>");
	   				   try{out.println("<td>"+dets[1]+"</td>");
	   				   out.println("<td>"+dets[0]+"</td>");}catch(Exception e){out.println("<td>NA</td>");out.println("<td>NA</td>");}
	   				   out.println("<td>"+btn_dl+" "+btn_rs+"</td>");
	   				   out.println("</tr>");
         		   }catch(Exception e){}
				   
         	   }
		 }%>
         </tbody>
       </table>
           
    </div><!-- /.box-body -->
    <div class="box-footer">
      .
    </div><!-- /.box-footer-->
  </div><!-- /.box -->
  <div class="box">
    <div class="box-header with-border">
      <h3 class="box-title">Back Up Setup</h3>
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="#collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
        <button type="button" class="btn btn-box-tool" data-widget="#remove" data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
      </div>
    </div>
    <div class="box-body">
      <div class="col-md-12 well">
      	<form action="backup.jsp" method="post" enctype="multipart/form-data">
	      	<input type="text" name="filename" class="form-control"><br>
	      	<input type="submit" name="submit" class="btn btn-primary" value="Create Backup">
	    </form>
      </div>
    </div><!-- /.box-body -->
    <div class="box-footer">
      .
    </div><!-- /.box-footer-->
  </div><!-- /.box -->
  <div class="box">
    <div class="box-header with-border">
      <h3 class="box-title">Upload Back Up</h3>
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="#collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
        <button type="button" class="btn btn-box-tool" data-widget="#remove" data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
      </div>
    </div>
    <div class="box-body">
      <form action="uploadBackup.jsp" method="post" enctype="multipart/form-data">
      	<input type="file" name="backup" class="form-control"><br>
      	<input type="submit" name="submit" class="btn btn-primary" value="Upload Backup">
      </form>
    </div><!-- /.box-body -->
    <div class="box-footer">
     .
    </div><!-- /.box-footer-->
  </div><!-- /.box -->
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
<!-- page script -->
</body>
</html>