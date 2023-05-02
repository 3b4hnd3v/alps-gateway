<%@include file="header.jsp" %>
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%Captive cv = new Captive(), editable = null; LPContent lc = new LPContent(), led = new LPContent(); String ed_pan = "collapse"; String imgloc = ""; %>
<% 
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update")) {
	
	try {
		String cid = request.getParameter("cid");
		String cna = request.getParameter("cname");
		String cva = request.getParameter("cval");
		
		lc.update(cna, cva, cid);
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
if(request.getParameter("check_update") != null && request.getParameter("check_update").equals("Update")) {
	
	try {
		String cid = request.getParameter("cid");
		String cna = request.getParameter("cname");
		String feats[] = request.getParameterValues("feats");
		String cva = "";
		for (int i = 0; i < feats.length; i++) {if(i>0){cva =cva+"&"+feats[i];}else{cva =cva+feats[i];}}
		
		lc.update(cna, cva, cid);
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
if(request.getParameter("q") != null && request.getParameter("q").equals("edit")) {
	try{
		ed_pan = "collapse-in";
		String item = request.getParameter("item").toString();
		imgloc = request.getParameter("img").toString();
		//led = lc.getOne(item);
	}catch (Exception e1) { System.out.println(e1);}
}else{ed_pan = "collapse";}
%>
<!-- Content Header (Page header) -->
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
<!-- COntent Section to /.section -->
<section class="content-header">
  <h1>
    Captive Portals
    <small>Gateway Landing Pages</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Captive</a></li>
    <li class="active">Types</li>
  </ol>
</section>
<br>
<section class="content">
<div class="row">
<% for (Captive c: cv.getAll() ) {%>
	<div class="example-modal col-lg-3">
		<div class="thumbnail">
			<a href="?q=content&name=<% out.print(c.getDesc());%>&img=<%out.print(c.getImgloc());%>&item=<% out.print(c.getId());%>">
	    		<img src="dist/img/lp.png" alt="Lights" style="width:100%" />
	    	</a>
	        <div class="caption ">
	        	 <h3>
	        	 	<a href="?q=content&name=<% out.print(c.getDesc());%>&img=<%out.print(c.getImgloc());%>&item=<% out.print(c.getId());%>"><%= c.getDesc() %></a>
		            <span class="pull-right"><a href="?q=content&name=<% out.print(c.getDesc());%>&img=<%out.print(c.getImgloc());%>&item=<% out.print(c.getId());%>"><i class="fa fa-edit"></i></a></span>
	        	 </h3>
	        </div>
	    </div>
	</div>
<%} %>
</div>
</section>
<%if(request.getParameter("q") != null && request.getParameter("q").equals("content")){ 
	String il = request.getParameter("img");
	String name = request.getParameter("name");
	String item = request.getParameter("item");
	led = lc.getOne("captive",name);
	String f = led.getFeatures();
	String[] feats = f.split(",");
%>
 <!-- Table List -->
<section class="content">
  <div class="row">
    <div class="col-xs-12"><!-- /.box -->
		<div class="panel-group" id="accordion">
			<div class="panel box box-primary">
			 	<div class="box-header with-border">
			 		<a data-toggle="collapse" data-parent="#accordion" href="#collapse0">
			      		<h3 class="box-title">Captive Page Features</h3>
			      	</a>
			      <div class="box-tools pull-right">
			        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			        </button>
			        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			      </div>
			    </div>
				<div id="collapse0" class="panel-collapse collapse in">
					<!--<div class="box-body"><span><a class="btn btn-xs btn-flat btn-default" href="javascript:history.go(-1)">Cancel</a></span></div>-->
			    	<div class="box-body">
				         <form action="content_mgt.jsp" method="post">
			       			<input type="text" readonly class="form-control" name="captive" value="<% out.println(led.getCaptive()); %>"><br />
			       			<input type="hidden" readonly class="form-control" name="cid" value="<% out.println(led.getId()); %>"><br />
							<input type="text" class="form-control" name="cname" value="features"><br />
							<label>Select Features:</label><br>
							<div class="form-group">
							<label class="checkbox-inline">
                                <input type="checkbox" name="features" id="inlineCheckbox1" value="soc" <%if(ArrayUtils.contains( feats, "soc" )){out.print("checked");}%>> Social Auth
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="features" id="inlineCheckbox2" value="auth" <%if(ArrayUtils.contains( feats, "auth" )){out.print("checked");}%>> User Auth
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="features" id="inlineCheckbox3" value="reg" <%if(ArrayUtils.contains( feats, "reg" )){out.print("checked");}%>> Register
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="features" id="inlineCheckbox3" value="qrauth" <%if(ArrayUtils.contains( feats, "qrauth" )){out.print("checked");}%>> UNIQR
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="features" id="inlineCheckbox3" value="free" <%if(ArrayUtils.contains( feats, "free" )){out.print("checked");}%>> Free Auth
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="features" id="inlineCheckbox3" value="stat" <%if(ArrayUtils.contains( feats, "stat" )){out.print("checked");}%>> Show Status
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="features" id="inlineCheckbox3" value="warn" <%if(ArrayUtils.contains( feats, "warn" )){out.print("checked");}%>> Captive Warning
                            </label>
							
				           </div>
						   <input type="submit" name="check_update" class="form-control btn btn-info" value="Update" />
						 </form>
			         </div>
				</div>
			</div>
			<div class="panel box box-primary">
			 	<div class="box-header with-border">
			 	  <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">
			      		<h3 class="box-title">Content: Title</h3>
			      </a>
			      <div class="box-tools pull-right">
			        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			        </button>
			        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			      </div>
			    </div>
				<div id="collapse1" class="panel-collapse collapse">
					<!--<div class="box-body"><span><a class="btn btn-xs btn-flat btn-default" href="javascript:history.go(-1)">Cancel</a></span></div>-->
			    	<div class="box-body">
				         <form action="content_mgt.jsp" method="post">
			       			<input type="text" readonly class="form-control" name="captive" value="<% out.println(led.getCaptive()); %>"><br />
			       			<input type="text" readonly class="form-control" name="cid" value="<% out.println(led.getId()); %>"><br />
							<label>Content Name:</label>
							<input type="text" class="form-control" name="cname" value="title"><br />
							<label>Content:</label>
							<textarea class="form-control" name="cval"><% out.println(led.getTitle()); %></textarea><br />
							<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
						 </form>
			         </div>
				</div>
			 </div>
			 <div class="panel box box-primary">
			 	<div class="box-header with-border">
			 		<a data-toggle="collapse" data-parent="#accordion" href="#collapse2">
			      		<h3 class="box-title">Content: About</h3>
			      	</a>
			      <div class="box-tools pull-right">
			        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			        </button>
			        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			      </div>
			    </div>
				<div id="collapse2" class="panel-collapse collapse">
					<!--<div class="box-body"><span><a class="btn btn-xs btn-flat btn-default" href="javascript:history.go(-1)">Cancel</a></span></div>-->
			    	<div class="box-body">
				         <form action="content_mgt.jsp" method="post">
			       			<input type="text" readonly class="form-control" name="captive" value="<% out.println(led.getCaptive()); %>"><br />
			       			<input type="text" readonly class="form-control" name="cid" value="<% out.println(led.getId()); %>"><br />
							<label>Content Name:</label>
							<input type="text" class="form-control" name="cname" value="about"><br />
							<label>Content:</label>
							<textarea class="form-control" name="cval"><% out.println(led.getAbout()); %></textarea><br />
							<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
						 </form>
			         </div>
				</div>
			 </div>
			 <div class="panel box box-primary">
			 	<div class="box-header with-border">
			 		<a data-toggle="collapse" data-parent="#accordion" href="#collapse3">
			      		<h3 class="box-title">Content: Footer</h3>
			      	</a>
			      <div class="box-tools pull-right">
			        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			        </button>
			        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			      </div>
			    </div>
				<div id="collapse3" class="panel-collapse collapse">
					<!--<div class="box-body"><span><a class="btn btn-xs btn-flat btn-default" href="javascript:history.go(-1)">Cancel</a></span></div>-->
			    	<div class="box-body">
				         <form action="content_mgt.jsp" method="post">
			       			<input type="text" readonly class="form-control" name="captive" value="<% out.println(led.getCaptive()); %>"><br />
			       			<input type="text" readonly class="form-control" name="cid" value="<% out.println(led.getId()); %>"><br />
							<label>Content Name:</label>
							<input type="text" class="form-control" name="cname" value="footer"><br />
							<label>Content:</label>
							<input type="text" class="form-control" name="cval" value="<% out.println(led.getFooter()); %>"><br />
							<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
						 </form>
			         </div>
				</div>
			 </div>
			 <div class="panel box box-primary">
			 	<div class="box-header with-border">
			      <h3 class="box-title">
			      	<a data-toggle="collapse" data-parent="#accordion" href="#collapse4">
			      		Content: Name Tag
			      	</a>
			      </h3>
			      <div class="box-tools pull-right">
			        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			        </button>
			        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			      </div>
			    </div>
				<div id="collapse4" class="panel-collapse collapse">
					<!--<div class="box-body"><span><a class="btn btn-xs btn-flat btn-default" href="javascript:history.go(-1)">Cancel</a></span></div>-->
			    	<div class="box-body">
				         <form action="content_mgt.jsp" method="post">
			       			<input type="text" readonly class="form-control" name="captive" value="<% out.println(led.getCaptive()); %>"><br />
			       			<input type="text" readonly class="form-control" name="cid" value="<% out.println(led.getId()); %>"><br />
							<label>Content Name:</label>
							<input type="text" class="form-control" name="cname" value="nametag"><br />
							<label>Content:</label>
							<textarea class="form-control" name="cval"><% out.println(led.getNametag()); %></textarea><br />
							<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
						 </form>
			         </div>
				</div>
			 </div>
			 <div class="panel box box-primary">
			 	<div class="box-header with-border">
			 		<a data-toggle="collapse" data-parent="#accordion" href="#collapse5">
			      		<h3 class="box-title">Content: Terms and Condition URL</h3>
			      	</a>
			      <div class="box-tools pull-right">
			        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			        </button>
			        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			      </div>
			    </div>
				<div id="collapse5" class="panel-collapse collapse">
					<!--<div class="box-body"><span><a class="btn btn-xs btn-flat btn-default" href="javascript:history.go(-1)">Cancel</a></span></div>-->
			    	<div class="box-body">
				         <form action="content_mgt.jsp" method="post">
			       			<input type="text" readonly class="form-control" name="captive" value="<% out.println(led.getCaptive()); %>"><br />
			       			<input type="text" readonly class="form-control" name="cid" value="<% out.println(led.getId()); %>"><br />
							<label>Content Name:</label>
							<input type="text" class="form-control" name="cname" value="tnc"><br />
							<label>Content:</label>
							<input type="text" class="form-control" name="cval" value="<% out.println(led.getTnc()); %>"><br />
							<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
						 </form>
			         </div>
				</div>
			 </div>
			 <div class="panel box box-primary">
			 	<div class="box-header with-border">
			 		<a data-toggle="collapse" data-parent="#accordion" href="#collapse6">
			      		<h3 class="box-title">Content: Waiting Time</h3>
			      	</a>
			      <div class="box-tools pull-right">
			        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			        </button>
			        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			      </div>
			    </div>
				<div id="collapse6" class="panel-collapse collapse">
					<!--<div class="box-body"><span><a class="btn btn-xs btn-flat btn-default" href="javascript:history.go(-1)">Cancel</a></span></div>-->
			    	<div class="box-body">
				         <form action="content_mgt.jsp" method="post">
			       			<input type="text" readonly class="form-control" name="cid" value="<% out.println(led.getId()); %>"><br />
			       			<input type="text" readonly class="form-control" name="captive" value="<% out.println(led.getCaptive()); %>"><br />
							<label>Content Name:</label>
							<input type="text" class="form-control" name="cname" value="wait"><br />
							<label>Content:</label>
							<input type="number" max="60" min="5" class="form-control" name="cval" value="<% out.println(led.getWait()); %>"><br />
							<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
						 </form>
			         </div>
				</div>
			 </div>
			 <div class="panel box box-primary">
			 	<div class="box-header with-border">
			 		<a data-toggle="collapse" data-parent="#accordion" href="#collapse7">
			      		<h3 class="box-title">Content: Logo</h3>
			      	</a>
			      <div class="box-tools pull-right">
			        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			        </button>
			        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			      </div>
			    </div>
				<div id="collapse7" class="panel-collapse collapse">
					<!--<div class="box-body"><span><a class="btn btn-xs btn-flat btn-default" href="javascript:history.go(-1)">Cancel</a></span></div>-->
			    	<div class="box-body">
			    		<form action="captive" method="post" enctype="multipart/form-data">
			    		    <input type="hidden" readonly class="form-control" name="operation" value="update">
			    			<input type="hidden" readonly class="form-control" name="imgloc" value="<% out.println(imgloc); %>">
			    			<input type="text" readonly class="form-control" name="captive" value="<% out.println(led.getCaptive()); %>"><br />
							<input type="text" readonly class="form-control" name="cid" value="<% out.println(led.getId()); %>"><br />
						 	<label>Content Name:</label>
							<input type="text" class="form-control" name="cname" value="logo"><br />
						 	<label>New File Upload:</label>
						 	<small>Existing File</small>
						 	<input type="text" readonly class="form-control" name="exfile" value="<% out.println(led.getLogo()); %>"><br />
							<input type="file" class="form-control" name="cfile">
							<small class="text-danger">**All image files uploaded should have one word name. e.g: background.jpg</small><br />
							<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
						</form>
			         </div>
				</div>
			 </div>
			 <div class="panel box box-primary">
			 	<div class="box-header with-border">
			 		<a data-toggle="collapse" data-parent="#accordion" href="#collapse8">
			      		<h3 class="box-title">Content: BG Image</h3>
			      	</a>
			      <div class="box-tools pull-right">
			        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			        </button>
			        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			      </div>
			    </div>
				<div id="collapse8" class="panel-collapse collapse">
					<!--<div class="box-body"><span><a class="btn btn-xs btn-flat btn-default" href="javascript:history.go(-1)">Cancel</a></span></div>-->
			    	<div class="box-body">
			    		<form action="captive" method="post" enctype="multipart/form-data">
			    			<input type="hidden" readonly class="form-control" name="operation" value="update">
			    			<input type="hidden" readonly class="form-control" name="imgloc" value="<% out.println(imgloc); %>">
			    			<input type="text" readonly class="form-control" name="captive" value="<% out.println(led.getCaptive()); %>"><br />
							<input type="text" readonly class="form-control" name="cid" value="<% out.println(led.getId()); %>"><br />
						 	<label>Content Name:</label>
							<input type="text" class="form-control" name="cname" value="bgimg"><br />
						 	<label>New File Upload:</label>
						 	<small>Existing File</small>
						 	<input type="text" readonly class="form-control" name="exfile" value="<% out.println(led.getBgimg()); %>"><br />
							<input type="file" class="form-control" name="cfile">
							<small class="text-danger">**All image files uploaded should have one word name. e.g: background.jpg</small><br />
							<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
						</form>
			         </div>
				</div>
			 </div>
			 <div class="panel box box-primary">
			 	<div class="box-header with-border">
			 	  <a data-toggle="collapse" data-parent="#accordion" href="#collapse9">
			      	<h3 class="box-title">Content: Video</h3>
			      </a>
			      <div class="box-tools pull-right">
			        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			        </button>
			        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			      </div>
			    </div>
				<div id="collapse9" class="panel-collapse collapse">
					<!--<div class="box-body"><span><a class="btn btn-xs btn-flat btn-default" href="javascript:history.go(-1)">Cancel</a></span></div>-->
			    	<div class="box-body">
			    		<form action="captive" method="post" enctype="multipart/form-data">
			    			<input type="hidden" readonly class="form-control" name="operation" value="update">
			    			<input type="hidden" readonly class="form-control" name="imgloc" value="<% out.println(imgloc); %>">
			    			<input type="text" readonly class="form-control" name="captive" value="<% out.println(led.getCaptive()); %>"><br />
							<input type="text" readonly class="form-control" name="cid" value="<% out.println(led.getId()); %>"><br />
						 	<label>Content Name:</label>
							<input type="text" class="form-control" name="cname" value="video"><br />
						 	<label>New File Upload:</label>
						 	<small>Existing File</small>
						 	<input type="text" readonly class="form-control" name="exfile" value="<% out.println(led.getVideo()); %>"><br />
							<input type="file" class="form-control" name="cfile">
							<small class="text-danger">**All image files uploaded should have one word name. e.g: background.jpg</small><br />
							<input type="submit" name="submit" class="form-control btn btn-info" value="Update" />
						</form>
			         </div>
				</div>
			 </div>
		</div>
    </div><!-- /.col -->
  </div><!-- /.row -->
</section><!-- /.content -->
<%} %>
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
<!-- Table Export -->
<script src="js/tableexport/tableExport.js"></script>
<script src="js/tableexport/jquery.base64.js"></script>
<script src="js/tableexport/html2canvas.js"></script>
<script src="js/tableexport/jspdf/libs/sprintf.js"></script>
<script src="js/tableexport/jspdf/jspdf.js"></script>
<script src="js/tableexport/jspdf/libs/base64.js"></script>        
<!-- END Table Export -->
</body>
</html>