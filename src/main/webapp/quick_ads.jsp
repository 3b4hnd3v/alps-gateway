<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%
String success="", error="";
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Set Quick Advertisement")) {
	
	try {
		String pid = request.getParameter("pid");
		String adstat = request.getParameter("adstat");
		String adurl = request.getParameter("urllist");
		String interval = request.getParameter("interval");
		String ato = request.getParameter("ato");
		if(g.setAds(pid,adstat,adurl, interval, ato)){
			success = "Advertisement Successfully Set";
		}else{success = "Failed To Set Advertisement";}
		
		String logact = "Adverts set to profile "+pid+" By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else{
	success="";
	error="";
}
if(request.getParameter("q") != null && request.getParameter("q").equals("changestat")) {
	
	try {
		String item = request.getParameter("item");
		String stat = request.getParameter("stat");
		
		g.adStat(item, stat);
		
		success = "Advertisement Status Changed";
		
	} catch (Exception e1) { 
		System.out.println(e1); }
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
<%if(success != "" && error != ""){ %>
	<div class="alert alert-warning alert-dismissible">
	  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  <h4><i class="icon fa fa-ban"></i> Hey There !</h4>
	  <%= success %>
	  <%= error %>
	</div>
<%}%>
<!-- COntent Section to /.section -->
<section class="content-header">
  <h1>
    Quick Ads
    <small>Quick Advertisement on User Plans</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Captive</a></li>
    <li class="active">Quick Ads</li>
  </ol>
</section>
<br><br>
<section class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="panel-group" id="accordion">
			<% 
			List<Map<String, String>> lmp = g.userprofile();
	        for (Map<String,String> mp : lmp) {
	        	System.out.println(mp);
	 			String s = mp.get("name");
	 			int i = lmp.indexOf(mp);
	 			String btn_st = "<a title='Disable Advertising On This User Plan' class='fa fa-power-off text-danger' href='?q=changestat&stat=false&item="+mp.get(".id")+"'></a>";
	 			if(mp.containsKey("advertise") && Boolean.valueOf(mp.get("advertise")) && !Boolean.valueOf(mp.get("default"))){
	        %>
					  <div class="panel box box-primary">
					    <div class="box-heading">
					      <h4 class="box-title">
					        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%= i %>">
					        <%= s %></a>
					        <span style='padding:10px;' class='pull-right'><%= btn_st %></span>
					      </h4>
					    </div>
					    <div id="collapse<%= i %>" class="panel-collapse collapse">
					      <div class="panel-body">
					      	<form method="post" action="quick_ads.jsp">
					      		<input type="hidden" class="form-control" name="pid" value="<%= mp.get(".id") %>">
					      		<input type="hidden" class="form-control" name="adstat" value="<%= mp.get("advertise") %>">
						      	<div class="form-group">
						      		<label>Advertise URL</label>
									<textarea rows="2" class="form-control" name="urllist"><%= mp.get("advertise-url") %></textarea>
									<small>Separate multiple URLs with ","</small>
									<small class="pull-right">e.g: http://www.example.com,http://www.example1.com</small>
						      	</div>
						      	<div class="row">
						      		<div class="col-sm-6">
						              	<label>Show Advert every [hh:mm:ss]</label>
										<input type="text" class="form-control" name="interval" value="<%= mp.get("advertise-interval") %>"><br />
						            </div>
						            <div class="col-sm-6">
						              	<label>Show Advert for [hh:mm:ss] duration</label>
										<input type="text" class="form-control" name="ato" value="<%= mp.get("advertise-timeout") %>"><br />
						            </div>
						      	</div>
					  			<input type="submit" name="submit" class="form-control btn btn-info" value="Set Quick Advertisement" />
								
					      	</form>
					      </div>
					    </div>
					  </div>
			<% 
	        	}else if(mp.containsKey("advertise") && !Boolean.valueOf(mp.get("advertise")) && !Boolean.valueOf(mp.get("default"))){
		 			btn_st = "<a title='Enable Advertising On This User Plan' class='pull-right fa fa-power-off text-success' href='?q=changestat&stat=true&item="+mp.get(".id")+"'></a>";
	        %>
					  <div class="panel box box-primary">
					    <div class="box-heading">
					      <h4 class="box-title">
					        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%= i %>">
					        <%= s %></a>
					        <span style='padding:10px;' class='pull-right'><%= btn_st %></span>
					      </h4>
					    </div>
					    <div id="collapse<%= i %>" class="panel-collapse collapse">
					      <div class="panel-body">
					      	<p>Currently set to <%out.println( String.valueOf( mp.get("advertise-url") ).replace("null", "None")); %>. Click <%= btn_st %> to enable and keep the setting or set new values below.</p>
					      	<form method="post" action="quick_ads.jsp">
					      		<input type="hidden" class="form-control" name="pid" value="<%= mp.get(".id") %>">
					      		<input type="hidden" class="form-control" name="adstat" value="true">
						      	<div class="form-group">
						      		<label>Advertise URL</label>
									<textarea rows="2" class="form-control" name="urllist"></textarea>
									<small>Separate multiple URLs with ","</small>
									<small class="pull-right">e.g: http://www.example.com,http://www.example1.com</small>
						      	</div>
						      	<div class="row">
						      		<div class="col-sm-6">
						              	<label>Show Advert every [hh:mm:ss]</label>
										<input type="text" class="form-control" name="interval" value="00:00:00"><br />
						            </div>
						            <div class="col-sm-6">
						              	<label>Show Advert for [hh:mm:ss] duration</label>
										<input type="text" class="form-control" name="ato" value="00:00:00"><br />
						            </div>
						      	</div>
						      	<input type="submit" name="submit" class="form-control btn btn-info" value="Set Quick Advertisement" />
						      	
					      	</form>
					      </div>
					    </div>
					  </div>
	        <% 
	        	}
	        }
	        %>
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