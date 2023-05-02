<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<% //Add new server
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add New Server")) {
	
	try {
		String name = request.getParameter("sname").toString();
		String interf = request.getParameter("interface").toString();
		String profile = request.getParameter("server").toString();
		String pool = request.getParameter("pool").toString();
		String permac = request.getParameter("permac").toString();
		String idle = request.getParameter("idle").toString();
		String kalive = request.getParameter("kalive").toString();
		
		System.out.println(kalive);
		g.addhs_server(name, profile, interf, pool, permac, idle, kalive);
		
		String logact = "New Hotspot Server added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=servers");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add New DHCP-Server")) {
	
	try {
		String dsname = request.getParameter("sname").toString();
		String sinterf = request.getParameter("interface").toString();
		String dpool = request.getParameter("pool").toString();
		String lease = request.getParameter("lease").toString();
		String bootp = request.getParameter("bootp").toString();
		
		System.out.println(bootp);
		g.add_dhcp(dsname, sinterf, dpool, lease, bootp);
		
		String logact = "New DHCP "+dsname+" Server added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=dhcp");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add New Server Profile")) {
	
	try {
		String pname = request.getParameter("pname").toString();
		String hsadd = request.getParameter("hsadd").toString();
		String htmldir = request.getParameter("htmldir").toString();
		String rate = request.getParameter("rate").toString();
		String lb[] = 	request.getParameterValues("lb");
		String loginby = "";
		String cto = request.getParameter("cto").toString();
		String rad = request.getParameter("radius").toString();
		String dns = pname+".alpsgateway.com";
		String cert = request.getParameter("cert").toString();
		for (int i = 0; i < lb.length; i++) {if(i>0){loginby =loginby+","+lb[i];}else{loginby =loginby+lb[i];}}
		System.out.println(loginby);
		if(g.addhs_prof(pname, hsadd, htmldir, loginby, cto, rad, dns, cert, rate)){
			String logact = "New Hotspot Server Profile added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			
			response.sendRedirect("hs_server.jsp?q=serverprofiles&msg=Created Successfully&type=success");
		}else{
			response.sendRedirect("hs_server.jsp?q=serverprofiles&msg=Profile Can not be created&type=error");
		}
			
		
	} catch (Exception e1) {System.out.println(e1); }
}
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Set Address")) {
	
	try {
		String interf = request.getParameter("interface").toString();
		String ipadd = request.getParameter("ip").toString();
		String net = request.getParameter("net").toString();
		
		g.addIpadd(interf, ipadd, net);
		
		String logact = "Address "+ipadd+" set to "+interf+" By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=ipaddress");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>
<% 
//remove enable disable
if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("server")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeHsserver(item);
		
		String logact = "Hotspot Server "+item+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=servers");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("server")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.enableHsserver(item);
		
		String logact = "Hotspot Server "+item+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=servers");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("server")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.disableHsserver(item);
		
		String logact = "Hotspot Server "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=servers");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("serverprof")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeServerprof(item);
		
		String logact = "Hotspot Server profile "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=serverprofiles");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("dhcp")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeDhcp(item);
		
		String logact = "DHCP Server "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=dhcp");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("dhcp")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.enableDhcp(item);
		
		String logact = "DHCP Server "+item+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=dhcp");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("dhcp")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.disableDhcp(item);
		
		String logact = "DHCP Server "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=dhcp");
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("address")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.enableIP(item);
		
		String logact = "Interface "+item+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=ipaddress");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("address")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.disableIP(item);
		
		String logact = "Interface "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hs_server.jsp?q=ipaddress");
		
		
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
<% if(request.getParameter("q") != null && request.getParameter("q").equals("servers")) { %>

<!-- Content Header (Page header) -->
      <section class="content-header">
        <h1>
          Network Servers
          <small>List Of Network Servers</small>
        </h1>
        <ol class="breadcrumb">
          <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
          <li><a href="#">Network Servers</a></li>
          <li class="active">Servers</li>
        </ol>
      </section>
	<section class="content-header">
	<div class="panel box box-primary">
          <div class="box-header with-border">
            <h4 class="box-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                Add New <span><i class="fa fa-angle-double-down"></i></span>
              </a>
            </h4>
          </div>
          <div id="collapseOne" class="panel-collapse collapse">
            <div class="box-body table-responsive">
            	<form action="hs_server.jsp" method="post">
			       	<label>Name</label>
					<input type="text" class="form-control" name="sname"><br />
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
						<div class="form-group">
		                  <label>Address Pool</label>
		                  <select class="form-control" name="pool">
		                  <option>none</option>
		                 <% 
		                  	for (Map<String,String> mp : g.pool()) {
		  						String s = mp.get("name");
		                    	out.println("<option>"+s+"</option>");
		                  	}
		                    %>
		                  </select>
		              </div>
		              <div class="form-group">
		                  <label>Profile</label>
		                  <select class="form-control" name="server">
		                  <option>All</option>
		                 <% 
		                  	for (Map<String,String> mp : g.hsserverprof()) {
		  						String s = mp.get("name");
		                    	out.println("<option>"+s+"</option>");
		                  	}
		                    %>
		                  </select>
		              </div>
		              <div class="col-sm-3">
		              <label>Address per Mac</label>
						<input type="number" class="form-control" name="permac" value=1><br />
		              </div>
		              <div class="col-sm-3">
		              <label>Idle Timeout</label>
						<input type="text" class="form-control" name="idle" value="none"><br />
		              </div>
		              <div class="col-sm-3">
		              <label>Keepalive Timeout</label>
						<input type="text" class="form-control" name="kalive" value="none"><br />
		              </div>
		             
					<input type="submit" name="submit" class="form-control btn btn-info" value="Add New Server" />
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
	            <h3 class="box-title">Servers</h3>
	          </div><!-- /.box-header -->
	          <div class="box-body table-responsive">
	            <table id="example1" class="table table-bordered table-striped table-responsive">
	              <thead>
	                <tr>
	                  <!-- <th>ID</th> -->
	                  <th>Name</th>
	                  <th>Interface</th>
	                  <th>Profile</th>
	                  <th>Pool</th>
	                  <th>Idle</th>
	                  <!--  <th>K/alive</th>-->
	                  <th>/Mac</th>
	                  <th>Disabled</th>
	                  <th>Invalid</th>
	                  <th><i class="fa fa-cog"></i></th>
	                </tr>
	              </thead>
	                <tbody>
					    <%
					    for (Map<String,String> mp : g.hsservers()) {
					    	String f = mp.get("comment");
					    	String st = mp.get("disabled");
						  	if(!String.valueOf(f).contains("default") && !String.valueOf(f).contains("Default")){
							 	String s = mp.get(".id");
							 	String btn_st = "<a href='?q=disable&type=server&item="+s+"'><button title='disable' class='btn btn-xs btn-warning fa fa-thumbs-down'></button></a>";
							 	String btn_dl = "<a href='?q=remove&type=server&item="+s+"'><button title='delete' class='btn btn-xs btn-danger fa fa-times'></button></a>";
							  	String btn_ed = "<a href='update.jsp?q=edit&type=hsserver&item="+s+"'><button title='edit' class='btn btn-xs btn-info fa fa-edit'></button></a>";
								if(Boolean.valueOf(st)){
								 	btn_st = "<a href='?q=enable&type=server&item="+s+"'><button title='enable' class='btn btn-xs btn-success fa fa-thumbs-up'></button></a>";
								}
							 	out.println("<tr>");
								//out.println("<td>"+btn_ed+"</td>");
								out.println("<td>"+mp.get("name")+"</td>");
								out.println("<td>"+mp.get("interface")+"</td>");
								out.println("<td>"+mp.get("profile")+"</td>");
								out.println("<td>"+mp.get("address-pool")+"</td>");
								out.println("<td>"+mp.get("idle-timeout")+"</td>");
								//out.println("<td>"+mp.get("keepalive-timeout")+"</td>");
								out.println("<td>"+mp.get("addresses-per-mac")+"</td>");
								out.println("<td>"+mp.get("invalid")+"</td>");
								out.println("<td>"+mp.get("disabled")+"</td>");
								out.println("<td>"+btn_ed+"  "+btn_st+"  "+btn_dl+"</td>");
								out.println("</tr>");
					    	}
					 
					}%>
	              </tbody>
	            </table>
	          </div><!-- /.box-body table-responsive -->
	        </div><!-- /.box -->
	      </div><!-- /.col -->
	    </div><!-- /.row -->
	  </section><!-- /.content -->

<%} else if(request.getParameter("q") != null && request.getParameter("q").equals("serverprofiles")) { %>

<!-- Content Header (Page header) -->
      <section class="content-header">
        <h1>
          Server Profiles
          <small>List Of Server Profiles</small>
        </h1>
        <ol class="breadcrumb">
          <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
          <li><a href="#">Network Servers</a></li>
          <li class="active">Profile</li>
        </ol>
      </section>
	<section class="content-header">
	<div class="panel box box-primary">
          <div class="box-header with-border">
            <h4 class="box-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                Add New Profile  <span><i class="fa fa-angle-double-down"></i></span>
              </a>
            </h4>
          </div>
          <div id="collapseOne" class="panel-collapse collapse">
            <div class="box-body table-responsive">
            	<form action="hs_server.jsp" method="post">
			       	<label>Name</label>
					<input type="text" class="form-control" name="pname"><br />
			       	<label>Hotspot Address</label>
					<input type="text" class="form-control" name="hsadd"><br />
					<label>Bandwidth Rate</label>
					<input type="text" class="form-control" name="rate" value=""><br />
			       	<!-- <div class="form-group">
		                <label>DNS Name</label>
		          		<input type="text" name="dnsname" id="dnsname" class="form-control" value=""><br />
		          	</div> -->
		          	<div class="form-group">
			          	<label>Secure SSL Certificate</label>
				      	<select class="form-control" name="cert">
					      	<option value="none">No HTTPS</option>
					      	<%for (Map<String,String> r : g.certs()){
					      		String n = r.get("name");
					      	%>
								<option value="<%=n%>"><%=n%></option>
							<%}%>
					   </select>
					</div>
					<label>Landing Page</label>
			      	<select class="form-control" name="htmldir">
			      	<option value="hotspot">Default</option>
			      	<option> </option>
			      	<% 
	                   try{
		                    connect();
		                    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `captive_type`");
		           			while(rs1.next()){
		        	    		String desc =rs1.getString("homepage"); 
		                       	out.println("<option>"+desc+"</option>");
		           			}
		           			cn.close();
	                   	}catch(Exception e){System.out.print(e);}
	                %>
					</select><br>
					<div class="form-group">
			       		<label>Allowed Authentication Methods</label>
			       		<div>
                           <label class="checkbox-inline">
                               <input type="checkbox" name="lb" id="inlineCheckbox1" value="http-chap"> Challenge Handshake
                           </label>
                           <label class="checkbox-inline">
                               <input type="checkbox" name="lb" id="inlineCheckbox2" value="http-pap"> Password Auth
                           </label>
                           <label class="checkbox-inline">
                               <input type="checkbox" name="lb" id="inlineCheckbox3" value="cookie"> Stored Session
                           </label>
                           <label class="checkbox-inline">
                               <input type="checkbox" name="lb" id="inlineCheckbox3" value="https"> Secure HTTPS
                           </label>
                           
                        </div>
			       	</div>
					<label>Stored Session Timeout</label>
					<input type="text" class="form-control" name="cto" value="3d 00:00:00"><br />
					
		            <label>Allow Radius Authentication</label>
					<select class="form-control" name="radius">
					   <option value="false">No Radius</option>
		               <option value="true">Allow Radius</option>
		            </select>  <br />
					<input type="submit" name="submit" class="form-control btn btn-info" value="Add New Server Profile" />
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
	            <h3 class="box-title">Network Server Profiles</h3>
	          </div><!-- /.box-header -->
	          <div class="box-body table-responsive">
	            <table id="example1" class="table table-bordered table-striped">
	              <thead>
	                <tr>
	                  <!-- <th>ID</th> -->
	                  <th>Name</th>
	                  <th>HTML Dir</th>
	                  <th>Rate Limit</th>
	                  <th>Hotspot Address</th>
	                  <th>Radius Auth</th>
	                  <th>DNS Name</th>
	                  <th>Login-By</th>
	                  <th><i class="fa fa-cog"></i></th>
	                </tr>
	              </thead>
	              <tbody>
					    <%
					    for (Map<String,String> mp : g.hsserverprof()) {
					    	String f = mp.get("comment");
						  	if(!String.valueOf(f).contains("default") && !String.valueOf(f).contains("Default")){
							 	String s = mp.get(".id");
							 	String btn_dl = "<a href='?q=remove&type=serverprof&item="+s+"'><button class='btn btn-xs btn-danger fa fa-times'></button></a>";
							  	String btn_ed = "<a href='update.jsp?q=edit&type=hsserverprof&item="+s+"'><button class='btn btn-xs btn-info fa fa-edit'></button></a>";
					
							 	out.println("<tr>");
								//out.println("<td>"+btn_ed+" "+s+"</td>");
								out.println("<td>"+mp.get("name")+"</td>");
								out.println("<td>"+mp.get("html-directory")+"</td>");
								out.println("<td>"+mp.get("rate-limit")+"</td>");
								out.println("<td>"+mp.get("hotspot-address")+"</td>");
								out.println("<td>"+mp.get("use-radius")+"</td>");
								out.println("<td>"+mp.get("dns-name")+"</td>");
								out.println("<td>"+mp.get("login-by")+"</td>");
								out.println("<td>"+btn_ed+" "+btn_dl+"</td>");
								out.println("</tr>");
					    	}
					}%>
	              </tbody>
	            </table>
	          </div><!-- /.box-body table-responsive -->
	        </div><!-- /.box -->
	      </div><!-- /.col -->
	    </div><!-- /.row -->
	  </section><!-- /.content -->


<%} else if(request.getParameter("q") != null && request.getParameter("q").equals("dhcp")) { %>

<!-- Content Header (Page header) -->
      <section class="content-header">
        <h1>
          DHCP Servers
          <small>List Of DHCP Servers</small>
        </h1>
        <ol class="breadcrumb">
          <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
          <li><a href="#">Network Servers</a></li>
          <li class="active">DHCP</li>
        </ol>
      </section>
<section class="content-header">
	<div class="panel box box-primary">
          <div class="box-header with-border">
            <h4 class="box-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                Add New DHCP Server  <span><i class="fa fa-angle-double-down"></i></span>
              </a>
            </h4>
          </div>
          <div id="collapseOne" class="panel-collapse collapse">
            <div class="box-body table-responsive">
            	<form action="hs_server.jsp" method="post">
			       	<label>Name</label>
					<input type="text" class="form-control" name="sname"><br />
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
                    <label>Lease Time</label>
					<input type="text" class="form-control" name="lease" value="00:10:00"><br />
                    <div class="form-group">
                      <label>Address Pool</label>
                      <select class="form-control" name="pool">
                      <!--  option>Static Only</option>-->
                      <% 
                      	for (Map<String,String> mp : g.pool()) {
				  		String s = mp.get("name");
                        out.println("<option>"+s+"</option>");
                      	}
                        %>
                      </select>
                    </div>
		            <div class="form-group">
                      <label>BootP Support</label>
                      <select class="form-control" name="bootp">
                      <option>static</option>
                      <option selected>dynamic</option>
                      <option>none</option>
                      
                      </select>
                    </div>
		              
					<input type="submit" name="submit" class="form-control btn btn-info" value="Add New DHCP-Server" />
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
	            <h3 class="box-title">DHCP Servers</h3>
	          </div><!-- /.box-header -->
	          <div class="box-body table-responsive">
	            <table id="example1" class="table table-bordered table-striped table-hover">
	              <thead>
	                <tr>
	                  
	                  <th>Name</th>
	                  <th>Address Pool</th>
	                  <th>Interface</th>
	                  <th>Lease Time</th>
	                  <th>BootP Support</th>
	                  <th>Disabled</th>
	                  <th><i class="fa fa-cog"></i></th>
	                </tr>
	              </thead>
	              <tbody>
				    <%
				    for (Map<String,String> mp : g.dhcp()) {
				    	String f = mp.get("comment");
					  	if(!String.valueOf(f).contains("default") && !String.valueOf(f).contains("Default")){
						 	String s = mp.get(".id");
						 	String btn_en = "<a href='?q=enable&type=dhcp&item="+s+"'><button class='btn btn-xs btn-success'>En</button></a>";
						 	String btn_ds = "<a href='?q=disable&type=dhcp&item="+s+"'><button class='btn btn-xs btn-warning'>Dis</button></a>";
						 	String btn_dl = "<a href='?q=remove&type=dhcp&item="+s+"'><button class='btn btn-xs btn-danger'>Del</button></a>";
						  	String btn_ed = "<a href='update.jsp?q=edit&type=dhcp&item="+s+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
					
						 	out.println("<tr>");
						 	//out.println("<td> "+s+"</td>");
							out.println("<td>"+mp.get("name")+"</td>");
							out.println("<td>"+mp.get("address-pool")+"</td>");
							out.println("<td>"+mp.get("interface")+"</td>");
							out.println("<td>"+mp.get("lease-time")+"</td>");
							out.println("<td>"+mp.get("bootp-support")+"</td>");
							out.println("<td>"+mp.get("disabled")+"</td>");
							out.println("<td>"+btn_en+"  "+btn_ds+"  "+btn_dl+"</td>");
							out.println("</tr>");
				    	}
					}%>
	              </tbody>
	            </table>
	          </div><!-- /.box-body table-responsive -->
	        </div><!-- /.box -->
	      </div><!-- /.col -->
	    </div><!-- /.row -->
	  </section><!-- /.content -->

<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("ipaddress")) { %>
	
	 <!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Network Addresses
           <small>List of Network Servers' IP Addresses</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Network Servers</a></li>
           <li class="active">Address</li>
         </ol>
       </section>
       <section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Set Interface Address
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="hotspot.jsp" method="post">
               		<div class="form-group col-md-6">
	                    <label>Address</label>
	                    <input type="text" class="form-control" name="ip" value="0.0.0.0/0">
	                </div><!-- /.form group -->
	                <div class="form-group col-lg-6">
	                    <label>Network</label>
	                    <input type="text" class="form-control" name="net" value="0.0.0.0">
                    </div><!-- /.form group -->
	                <div class="form-group col-md-12">
	                    <label>Interface</label>
	                    <select required class="form-control" name="interface">
	                    	<option value="">Select Interface</option>
	                    	<%for (Map<String,String> mp : g.interfaces()) {
	                    		String it = mp.get("type");
	                    		String in = mp.get("name");
	                    		if(it.equals("bridge")&&!in.equalsIgnoreCase("Master")){
	                    	%>
	                    	<option value="<%=mp.get("name")%>"><%=mp.get("name")%></option>
	                    	<%}}%>
	                   </select>
	                </div><!-- /.form group -->
	                
	                <input type="submit" name="submit" class="form-control btn btn-info" value="Set Address" />
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
                 <h3 class="box-title">Network Addresses</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body  table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Interface</th>
                       <th>Address</th>
                       <th>Network</th>
                       <th>Dynamic</th>
                       <th>disabled</th>
                       <th class="text-danger">Invalid</th>
                       <th><i class="fa fa-cog"></i></th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   
	                for (Map<String,String> mp : g.ipaddress()) {
	                	String f = mp.get("comment");
	                	if(!mp.get("actual-interface").equalsIgnoreCase("Master") && !mp.get("actual-interface").contains("WAN") && !String.valueOf(f).contains("default") || !String.valueOf(f).contains("Default")){
						  	String s = mp.get(".id");
						  	String btn_st = "<a title='Disable' href='?q=disable&type=address&item="+s+"'><button class='btn btn-xs btn-warning fa fa-thumbs-down'></button></a>";
						  	if (Boolean.valueOf(mp.get("disabled"))){
						  		btn_st = "<a title='Enable' href='?q=enable&type=address&item="+s+"'><button class='btn btn-xs btn-success fa fa-thumbs-up'></button></a>";
						  	}
						  	String btn_ed = "<a title='Edit' href='update.jsp?q=edit&type=ipaddress&item="+s+"'><button class='btn btn-xs btn-info fa fa-edit'></button></a>";
		
						  	out.println("<tr>");
							out.println("<td>"+mp.get("interface")+"</td>");
							out.println("<td>"+mp.get("address")+"</td>");
							out.println("<td>"+mp.get("network")+"</td>");
							out.println("<td>"+mp.get("dynamic")+"</td>");
							out.println("<td>"+mp.get("disabled")+"</td>");
							out.println("<td>"+mp.get("invalid")+"</td>");
							out.println("<td>"+btn_st+" "+btn_ed+"</td>");
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
<%}%>

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
      "autoWidth": false,
      "responsive": true
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