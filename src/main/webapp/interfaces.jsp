<%@include file="header.jsp" %>

 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>

<% //Add Vlan
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Vlan")) {
	String a = "";
	try {
		String vid = request.getParameter("vid").toString();
		String vname = request.getParameter("vname").toString();
		String interf = request.getParameter("interface").toString();
		try{a = request.getParameter("enablearp").toString();}catch (Exception e1) { a = ""; }
		String arp = "reply-only";
		System.out.println("THIS IS A   "+a);

		
		//if(a == ""){arp = "disabled";}else{arp = "enabled";}
		System.out.println(vid+"="+vname+"="+interf+"="+arp);
		g.addVlan(vid, vname, interf, arp);
		
		String logact = "New VLAN "+vname+" Created By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("interfaces.jsp?q=vlan");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>
<% //Add Bridge
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Bridge")) {
	String a = "";
	try {
		String bname = request.getParameter("bname").toString();
		try{a = request.getParameter("enablearp").toString();}catch (Exception e1) { a = ""; }
		String arp = "disabled";
		System.out.println("THIS IS A   "+a);

		if(a == ""){arp = "disabled";}else{arp = "enabled";}
		System.out.println(bname+"="+arp);
		g.addBridge(bname, arp);
		
		String logact = "New Bridge "+bname+" Created By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("interfaces.jsp?q=bridge");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<%
//bypass vlan
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Bypass VLan")) {
	try {
		String vn = request.getParameter("vlan").toString();
		g.bypassVlan(vn);
		
		String logact = "VLAN "+vn+" bypassed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("interfaces.jsp?q=bypassed");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>
<% 
//remove Vlan
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("type").equals("vlan")) {
	
	try {
		String id = request.getParameter("item").toString();
		
		g.removeVlan(id);
		
		String logact = "Interface "+id+" Removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("interfaces.jsp?q="+request.getParameter("from").toString());
		
	} catch (Exception e1) { System.out.println(e1); }
}
//enable vlan
else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("vlan")) {
	
	try {
		String id = request.getParameter("item").toString();
		g.enableVlan(id);
		
		String logact = "VLAN "+id+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("interfaces.jsp?q=vlan");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
//disable vlan
else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("vlan")) {
	
	try {
		String id = request.getParameter("item").toString();
		g.disableVlan(id);
		
		String logact = "VLAN "+id+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("interfaces.jsp?q=vlan");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
//unbypass vlan
else if(request.getParameter("q") != null && request.getParameter("q").equals("unbypass")&& request.getParameter("type").equals("vlan")) {
	
	try {
		String vn = request.getParameter("item").toString();
		if(g.unBypassVlan(vn)){
			String logact = "VLAN "+vn+" un-bypassed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			response.sendRedirect("interfaces.jsp?q=bypassed");
		}
	} catch (Exception e1) { System.out.println(e1); }
}
//remove enable disabled bridge
else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("brigde")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeBridge(item);
		
		String logact = "Bridge "+item+" Removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("interface.jsp?q=bridge");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("brigde")) {
	
	try {
		String id = request.getParameter("item").toString();
		
		g.disableInterface(id);
		
		String logact = "Bridge "+id+" Removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("interface.jsp?q=bridge");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("brigde")) {
	
	try {
		String id = request.getParameter("item").toString();
		
		g.enableInterface(id);
		
		String logact = "Bridge "+id+" Removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("index.jsp");
		
		
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
	<% if(request.getParameter("q") != null && request.getParameter("q").equals("interfaces")) { %>

		<!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Interfaces
            <small>List of Available Network Interfaces</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Interface</a></li>
            <li class="active">Interface Addresses</li>
          </ol>
        </section>
		
        <!-- Table List -->
        <section class="content">
          <div class="row">
            <div class="col-xs-12"><!-- /.box -->

              <div class="box">
                <div class="box-header">
                  <h3 class="box-title">Interfaces</h3>
                  <%@include file="import.jsp" %>
                </div><!-- /.box-header -->
                <div class="box-body">
                  <table id="example1" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th><i class="fa fa-edit"></i></th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>LLU Time</th>
                        <th>Tx-packet</th>
                        <th>Mac-Address</th>
                        <th>Running</th>
                        <th>Disabled</th>
                        <th><i class="fa fa-cog"></i></th>
                        
                      </tr>
                    </thead>
                    <tbody>
                    <%for (Map<String,String> mp : g.interfaces()) {
                    	String f = mp.get("comment");
					  	if(!String.valueOf(f).contains("Default")&& !String.valueOf(f).contains("default") 
					  			&& !String.valueOf(mp.get("name")).equals("Master")&& !String.valueOf(mp.get("name")).equals("Bypass")){
							  	String s = mp.get(".id");
							  	String btn_ds = "";
							  	if (mp.get("type").equals("ether") || mp.get("name").equals("Master")){
							  		btn_ds = "";
							  	}else{
								  	btn_ds = "<a href='?q=delete&from=interfaces&type="+mp.get("type")+"&item="+s+"'><button class='btn btn-sm btn-danger'>Del</button></a>";
							  	}
							  	String btn_ed = "<a href='update.jsp?q=edit&type=interface&item="+s+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
		
							  	out.println("<tr>");
								out.println("<td>"+btn_ed+"</td>");
								out.println("<td>"+mp.get("name")+"</td>");
								out.println("<td>"+mp.get("type")+"</td>");
								out.println("<td>"+mp.get("last-link-up-time")+"</td>");
								out.println("<td>"+mp.get("tx-packet")+"</td>");
								out.println("<td>"+mp.get("mac-address")+"</td>");
								out.println("<td>"+mp.get("running")+"</td>");
								out.println("<td>"+mp.get("disabled")+"</td>");
								out.println("<td>"+btn_ds+"</td>");
		
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
		<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("vlan")) { %>
		
		<!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            VLANS
            <small>List of Vlans</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Interfaces</a></li>
            <li class="active">Vlan</li>
          </ol>
        </section>
        <section class="content-header">
			<div class="panel box box-primary">
	           <div class="box-header with-border">
	             <h4 class="box-title">
	               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	                 New Vlan <span><i class="fa fa-angle-double-down"></i></span>
	               </a>
	             </h4>
	           </div>
	           <div id="collapseOne" class="panel-collapse collapse">
	             <div class="box-body">
	             	<form action="interfaces.jsp" method="post">
						 <label>Vlan ID:</label>
							<input type="text" class="form-control" name="vid"><br />
		                 <label>Vlan Name:</label>
		                  	<input type="text" class="form-control" name="vname"><br />
		                 <div class="form-group">
	                      <label>Interface</label>
	                      <select class="form-control" name="interface">
	                      <% 
	                      	for (Map<String,String> mp : g.interfaces()) {
					  		String s = mp.get("name");
	                        out.println("<option>"+s+"</option>");
	                      	}
	                        %>
	                      </select>
	                    </div>
	                    <div class="checkbox">
	                        <label>
	                          <input type="checkbox" name="enablearp">
	                          Enable ARP
	                        </label>
	                      </div>
		                  <br />
		                  <input type="submit" name="submit" class="form-control btn btn-info" value="Add Vlan" />
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
                  <h3 class="box-title">Vlans</h3>
                  <%@include file="import.jsp" %>
                </div><!-- /.box-header -->
                <div class="box-body">
                  <table id="example1" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th><i class="fa fa-edit"></i></th>
                        <th>VID</th>
                        <th>Name</th>
                        <th>Interface</th>
                        <th>Mac-address</th>
                        <th>MTU</th>
                        <th>ARP</th>
                        <th>Running</th>
                        <th>Enabled</th>
                        <th><i class="fa fa-cog"></i></th>
                      </tr>
                    </thead>
                    <tbody>
                      <%for (Map<String,String> mp : g.getVlan()) {
                    	  	String f = "x"+mp.get("comment");
  					  		if(!f.equals("xdefault")){
							  	String s = mp.get(".id");
							  	String btn_dl = "<a href='?q=delete&from=vlan&type=vlan&item="+s+"'><button class='btn btn-sm btn-danger'>Del</button></a>";
							  	String btn_en = "<a href='?q=enable&type=vlan&item="+s+"'><button class='btn btn-sm btn-success'>En</button></a>";
							  	String btn_ds = "<a href='?q=disable&type=vlan&item="+s+"'><button class='btn btn-sm btn-warning'>Dis</button></a>";
							  	String btn_ed = "<a href='update.jsp?q=edit&type=vlan&item="+s+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
		
							  	out.println("<tr>");
								out.println("<td>"+btn_ed+"</td>");
								out.println("<td>"+mp.get("vlan-id")+"</td>");
								out.println("<td>"+mp.get("name")+"</td>");
								out.println("<td>"+mp.get("interface")+"</td>");
								out.println("<td>"+mp.get("mac-address")+"</td>");
								out.println("<td>"+mp.get("mtu")+"</td>");
								out.println("<td>"+mp.get("arp")+"</td>");
								out.println("<td>"+mp.get("running")+"</td>");
								out.println("<td>"+mp.get("disabled")+"</td>");
								out.println("<td>"+btn_dl+" "+btn_en+" "+btn_ds+"</td>");						
								out.println("</tr>");
		                	}
					}%>
                    
                  </table>
                </div><!-- /.box-body -->
              </div><!-- /.box -->
            </div><!-- /.col -->
          </div><!-- /.row -->
        </section><!-- /.content -->
        <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("bridge")) { %>
		
		<!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            BRIDGES
            <small>List of Bridges</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Interfaces</a></li>
            <li class="active">Bridges</li>
          </ol>
        </section>
        <section class="content-header">
			<div class="panel box box-primary">
	           <div class="box-header with-border">
	             <h4 class="box-title">
	               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	                 New Bridge <span><i class="fa fa-angle-double-down"></i></span>
	               </a>
	             </h4>
	           </div>
	           <div id="collapseOne" class="panel-collapse collapse">
	             <div class="box-body">
	             	<form action="interfaces.jsp" method="post">
		                 <label>Bridge Name:</label>
		                  	<input type="text" class="form-control" name="bname"><br />
		                 <div class="form-group">
	                      <label>ARP</label>
	                      <select class="form-control" name="arp">
	                      	<option>enabled</option>
	                      	<option>disabled</option>
	                      	<option>proxy-arp</option>
	                      	<option>reply-only</option>
	                      </select>
	                    </div>
		                  <br />
		                  <input type="submit" name="submit" class="form-control btn btn-info" value="Add Bridge" />
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
                  <h3 class="box-title">Bridge Interfaces</h3>
                  <%@include file="import.jsp" %>
                </div><!-- /.box-header -->
                <div class="box-body">
                  <table id="example1" class="table table-bordered table-striped">
                    <thead>
		              <tr>
		                <th><i class="fa fa-edit"></i></th>
		                <th>Name</th>
		                <th>L2 MTU</th>
		                <th>Mac Address</th>
		                <th>disabled</th>
		                <th><i class="fa fa-cog"></i></th>
		              </tr>
		            </thead>
		            <tbody>
		            <%
		             for (Map<String,String> mp : g.bridges()) {
		            	 String f = "x"+mp.get("comment");
						 if(!f.equals("xdefault")){
						  	String s = mp.get(".id");
						  	String name = mp.get("name");
						  	String btn_en = "<a href='?q=enable&type=brigde&item="+s+"'><button class='btn btn-xs btn-success'>En</button></a>";
						  	String btn_ds = "<a href='?q=disable&type=brigde&item="+s+"'><button class='btn btn-xs btn-warning'>Dis</button></a>";
						  	String btn_dl = "<a href='?q=remove&type=brigde&item="+s+"'><button class='btn btn-xs btn-danger'>Del</button></a>";
						  	String btn_ed = "<a href='update.jsp?q=edit&type=interface&item="+s+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
							
						  	out.println("<tr>");
							out.println("<td>"+btn_ed+"</td>");
							out.println("<td>"+mp.get("name")+"</td>");
							out.println("<td>"+mp.get("l2mtu")+"</td>");
							out.println("<td>"+mp.get("mac-address")+"</td>");
							out.println("<td>"+mp.get("disabled")+"</td>");
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
        <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("bypassed")) { %>
		
		<!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Bypass VLans
            <small>Open VLan user access</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Interfaces</a></li>
            <li class="active">VLan Bypass</li>
          </ol>
        </section>
        <section class="content-header">
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
	             	<form class="form-horizontal" action="interfaces.jsp" method="post">
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
					     <input type="submit" name="submit" class="form-control btn btn-info" value="Bypass VLan" />
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
        <%} else{%>
          <!-- Error Message -->
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
			
			<%} }%>
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