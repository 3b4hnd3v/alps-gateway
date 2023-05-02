<%@include file="header.jsp" %>
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>

<%! public String edpan="collapse", cfile = "", cid = "", cname = "", ctype = "", cval = ""; %>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update")){
	try{
		cid = request.getParameter("cid");
		cname = request.getParameter("cname"); 
		ctype = request.getParameter("ctype");
		cval = request.getParameter("cval");
		
		connect();
	
		cn.createStatement().execute("UPDATE `ldpage` SET `value`='"+cval+"' where name='"+cname+"'");
		cn.close();
		
		String logact = "Landing page Content "+cname+" has been changed to "+cval+" By "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("content_mgt.jsp?msg=Content Updated Successfully!&type=success"); 
	}catch(Exception e){System.out.println(e);
		response.sendRedirect("content_mgt.jsp?msg=Having Problem With Content Update!&type=error"); 
}
}
%>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("edit")){
	String item = request.getParameter("item");
	String cont = request.getParameter("type");
	edpan="collapse in";
	if(cont.equals("text")){
		cfile = "disabled";
	}else{cfile = "enabled";}
	connect();
	ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM ldpage WHERE `id`="+item); 
	if(rs.next()){
		cid = rs.getString("id");
		cname = rs.getString("name"); 
		ctype = rs.getString("content");
		cval = rs.getString("value");
	}	
	cn.close();
}else{edpan="collapse";}
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
           Content Management
           <small>Change Content of The Landing Page</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Content Management</a></li>
           <li class="active">Update</li>
         </ol>
       </section>
       <section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="">
                 No Function
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse <%out.println(edpan);%>">
             <div class="box-body">
             <%if(ctype.equals("text")){ %>
             	<form action="content_mgt.jsp" method="post">
					 <label>Content ID:</label>
						<input type="text" readonly class="form-control" name="cid" value="<% out.println(cid); %>"><br />
					 <label>Content Name:</label>
						<input type="text" class="form-control" name="cname" value="<% out.println(cname); %>"><br />
					 <label>Content Type:</label>
						<input type="text" class="form-control" name="ctype" value="<% out.println(ctype); %>"><br />
					 <label>Content:</label>
					 <div class="box-body pad">
					 	<textarea class="textarea" placeholder="Place some text here" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"><% out.println(cval); %></textarea><br />
					 </div>
					<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
				</form>
             
             <%}else if(ctype.equals("image")){  %>
             	<form action="edit_content.jsp" method="post" enctype="multipart/form-data">
					 <label>Content ID:</label>
						<input type="text" readonly class="form-control" name="cid" value="<% out.println(cid); %>"><br />
					 <label>Content Name:</label>
						<input type="text" class="form-control" name="cname" value="<% out.println(cname); %>"><br />
					 <label>Content Type:</label>
						<input type="text" class="form-control" name="ctype" value="<% out.println(ctype); %>"><br />
					 <label>New File Upload:</label>
					 	<small>Existing File</small>
					 	<input type="text" readonly class="form-control" value="<% out.println(cval); %>"><br />
						<input type="file" <% out.println(cfile); %> class="form-control" name="cfile">
						<small class="text-danger">**All image files uploaded should have one word name. e.g: background.jpg</small><br />
					<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
				</form>
				<%} %>
             </div>
           </div>
         </div>
         <!-- 
          <div class="box">
                <div class="box-header">
                  <h3 class="box-title">Bootstrap WYSIHTML5 <small>Simple and fast</small></h3>
                  <div class="pull-right box-tools">
                    <button type="button" class="btn btn-default btn-sm" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-default btn-sm" data-widget="remove" data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
                  </div>
                </div>
                <div class="box-body pad">
                  <form>
                    <textarea class="textarea" placeholder="Place some text here" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                  	<textarea id="editor1" name="editor1" rows="10" cols="80">
                                            This is my textarea to be replaced with CKEditor.
                    </textarea>
                  </form>
                </div>
              </div>
         -->
	</section>
       
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title">Landing Page Contents</h3>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Element Name</th>
                       <th>Element Content</th>
                       <th>Element Value</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   connect();
                   try {
	                 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `ldpage`");
	                 	
	                 	while(rs1.next()){
	    				  	String s = rs1.getString("id");
	    				  	String t = rs1.getString("content");
	    				  	String btn_dl = "<a href='?q=delete&type="+t+"&item="+s+"'><button class='btn btn-xs btn-danger'>Del</button></a>";
	    				  	String btn_ed = "<a href='?q=edit&type="+t+"&item="+s+"'><button class='btn btn-xs btn-info'>Edit</button></a>";

	                 		out.println("<tr>");
	            		 	out.println("<td>"+rs1.getString("id")+"</td>");
	            		 	out.println("<td>"+rs1.getString("name")+"</td>");
	            		 	out.println("<td>"+rs1.getString("content")+"</td>");
	            		 	out.println("<td  width='50%'>"+rs1.getString("value")+"</td>");
	            		 	out.println("<td>"+btn_dl+" "+btn_ed+"</td>");
	            		 	out.println("</tr>");
	                 	}
	               		
	               		cn.close();
	               	} catch(Exception e) { }
	                %>
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
<!-- Bootstrap WYSIHTML5 -->
<script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- CK Editor -->
<script src="https://cdn.ckeditor.com/4.4.3/standard/ckeditor.js"></script>
<script>
    $(function () {
      // Replace the <textarea id="editor1"> with a CKEditor
      // instance, using default configuration.
      CKEDITOR.replace('editor1');
      //bootstrap WYSIHTML5 - text editor
      $(".textarea").wysihtml5();
    });
</script>
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