<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<% //connect and disconnect ip
String bpan = "collapse", rpan = "collapse", dbpmac="Enter MAC", dbpip="Enter Given IP", bpid="x", bpmac="Enter MAC", bpremark="Enter MAC";
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Walled Garden")) {
	
	try {
		String host = request.getParameter("host");
		String port = "0x0badf00d";
				//request.getParameter("port").toString();
		if(request.getParameter("port") != null){port = request.getParameter("port");}
		System.out.print("port="+port);
		g.addWalledGarden(host, port);
		
		String logact = "Walled Garden Item "+host+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=walledgarden");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Walled Garden Site")) {
	
	try {
		String site = request.getParameter("site");
		String dport = request.getParameter("dport");
		String protocol = request.getParameter("protocol");
		
		g.addWalledGarden2(site,dport,protocol);
		
		String logact = "Walled Garden Site "+site+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=walledgarden");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Bypass")) {
	
	try {
		String mac = request.getParameter("mac");
		String dip = request.getParameter("dip");
		String lbi = request.getParameter("lbi");
		String lbo = request.getParameter("lbo");
		String remark = request.getParameter("remark");
		String rate = lbi+"/"+lbo;
		if(g.bypassHost(mac, remark)){
			g.queueBypassed(mac,dip, rate);
		}
		
		String logact = "Host "+mac+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=hosts");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Bypass")) {
	
	try {
		String mac = request.getParameter("mac");
		String did = request.getParameter("item");
		String remark = request.getParameter("remark");
		if(g.updateBypass(did, remark)){
			String logact = "Host "+mac+" bypass remark changed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
		}
		
		response.sendRedirect("hotspot.jsp?q=bypassed");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Create User")) {
	
	try {
		String prof = request.getParameter("prof").toString();
		String uname = request.getParameter("uname").toString();
		String pass = request.getParameter("pass").toString();
		String server = request.getParameter("server").toString();
		String ipadd = request.getParameter("ipadd").toString();
		String mac = request.getParameter("mac").toString();
		String lu = request.getParameter("lu").toString();
		String lbi = request.getParameter("lbi").toString();
		String lbo = request.getParameter("lbo").toString();
		String lbt = request.getParameter("lbt").toString();
		
		g.createUser(uname, pass, prof, lu, server, ipadd, mac, lbi, lbo, lbt);
		
		String logact = "User "+uname+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=users");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Create Plan")) {
	
	try {
		String name = request.getParameter("name").toString();
		String pool = request.getParameter("pool").toString();
		String rate = request.getParameter("rate").toString();
		String share = request.getParameter("share").toString();
		String cookieto = request.getParameter("cookieto").toString();
		String addcookie = request.getParameter("addcookie").toString();
		String statpage = request.getParameter("statpage").toString();
		String sessionto = request.getParameter("sessionto").toString();
		String idleto = request.getParameter("idleto").toString();
		String keepal = request.getParameter("keepal").toString();
		g.createUserProf(name, pool, rate, addcookie, cookieto, share, statpage, sessionto, idleto, keepal, "");
		
		String logact = "Profile "+name+" created By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=userprofiles");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>
<% 
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("type").equals("walledgarden")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeWalledGarden(item);
		
		String logact = "Host Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=walledgarden");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("walledgarden")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.enableWalledGarden(item);
		
		String logact = "Host Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=walledgarden");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("walledgarden")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.disableWalledGarden(item);
		
		String logact = "Host Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=walledgarden");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("host")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeHost(item);
		
		String logact = "Host Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hotspot.jsp?q=hosts");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("user")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeUser(item);
		
		String logact = "Host Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hotspot.jsp?q=users");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("user")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.enableUser(item);
		
		String logact = "Host Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hotspot.jsp?q=users");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}
else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("user")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.disableUser(item);
		
		String logact = "Host Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hotspot.jsp?q=users");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("type").equals("cookies")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeCookie(item);
		
		String logact = "Cookie Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hotspot.jsp?q=cookies");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("active")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeActiveUser(item);
		
		String logact = "Host Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hotspot.jsp?q=activeusers");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("user")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeUser(item);
		
		String logact = "User Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hotspot.jsp?q=users");
		
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("userprofile")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeUserProfile(item);
		
		String logact = "User Profile Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hotspot.jsp?q=userprofiles");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("hsserver")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.enableUser(item);
		
		String logact = "Hotspot Server "+item+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=hsservers");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("hsserver")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.disableUser(item);
		
		String logact = "Hotspot Server "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=hsservers");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("blockmac")) {
	
	try {
		String dmac = request.getParameter("dmac");
		String dtype = request.getParameter("type");
		
		if(g.addDevFilter(dmac)){
			String logact = "Device with MAC: "+dmac+" has been blocked By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			
			response.sendRedirect("hotspot.jsp?q="+dtype+"&msg=Blocked Successfully&type=success");
		}else{response.sendRedirect("hotspot.jsp?q="+dtype+"&msg=Fail to block&type=error");}
	} catch (Exception e1) { System.out.println(e1); }
}
if(request.getParameter("act") != null && request.getParameter("act").equals("bypassmac")) {
	
	try {
		dbpmac = request.getParameter("dmac");
		dbpip = request.getParameter("dip");
		String dtype = request.getParameter("type");
		bpan = "collapse in";
	} catch (Exception e1) { System.out.println(e1); }
}else{bpan = "collapse";}
if(request.getParameter("act") != null && request.getParameter("act").equals("bypassremark")) {
	
	try {
		bpid = request.getParameter("item");
		bpmac = request.getParameter("dmac");
		bpremark = request.getParameter("remark");
		rpan = "collapse in";
	} catch (Exception e1) { System.out.println(e1); }
}else{rpan = "collapse";}
if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("bypassed")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.enableBypassed(item);
		
		String logact = "Interface "+item+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=bypassed");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("remark")&& request.getParameter("type").equals("bypassed")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.enableBypassed(item);
		
		String logact = "Interface "+item+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=bypassed");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("bypassed")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.disableBypassed(item);
		
		String logact = "Interface "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=bypassed");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("bypassed")) {
	
	try {
		String item = request.getParameter("item").toString();
		String titem = request.getParameter("titem").toString();
		
		g.removeBypassed(item);
		g.removeThrottle(titem);
		
		String logact = "Interface "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=bypassed");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("throttled")) {
	
	try {
		String item = request.getParameter("item").toString();
		String bitem = request.getParameter("bitem").toString();
		
		g.enableThrottle(item);
		g.enableBypassed(bitem);
		
		String logact = "Interface "+item+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=throttled");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("throttled")) {
	
	try {
		String item = request.getParameter("item").toString();
		String bitem = request.getParameter("bitem").toString();
		
		g.disableThrottle(item);
		g.disableBypassed(bitem);
		
		String logact = "Interface "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=throttled");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("throttled")) {
	
	try {
		String item = request.getParameter("item").toString();
		String bitem = request.getParameter("bitem").toString();
		
		g.removeThrottle(item);
		g.removeBypassed(bitem);
		
		String logact = "Interface "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=throttled");
		
		
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
<% if(request.getParameter("q") != null && request.getParameter("q").equals("users")) { %>

	<!-- Content Header (Page header) -->
    <section class="content-header">
	    <h1>
	      List of Users
	      <small>Internet Access Users</small>
	    </h1>
	    <ol class="breadcrumb">
	      <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	      <li><a href="#">Access Config</a></li>
	      <li class="active">Users</li>
	    </ol>
    </section>
	<section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Create User <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="hotspot.jsp" method="post">
					 <div class="form-group">
	                      <label>Profile</label>
	                      <select class="form-control" name="prof">
	                      <% 
	                      	for (Map<String,String> mp : g.userprofile()) {
					  		String s = mp.get("name");
	                        out.println("<option>"+s+"</option>");
	                      	}
	                        %>
	                      </select>
	                  </div>
					 <label>Username</label>
						<input type="text" class="form-control" name="uname"><br />
					 <label>Password</label>
						<input type="text" class="form-control" name="pass"><br />
					<div class="form-group">
	                      <label>Server</label>
	                      <select class="form-control" name="server">
	                      <option>all</option>
		                    <% 
	                      	for (Map<String,String> mp : g.hsservers()) {
					  		String s = mp.get("name");
	                        out.println("<option>"+s+"</option>");
	                      	}
	                        %>
	                      </select>
	                  </div>
	                  <div class="col-sm-6">
		              <label>Address</label>
						<input type="text" class="form-control" name="ipadd" value="0.0.0.0"><br />
		              </div>
		              <div class="col-sm-6">
		              <label>MAC Address</label>
						<input type="text" class="form-control" name="mac" value="00:00:00:00:00:00"><br />
		              </div>
	                  <div class="col-sm-3">
		              <label>Limit Uptime</label>
						<input type="text" class="form-control" name="lu" value="0"><br />
		              </div>
		              <div class="col-sm-3">
		              <label>Limit Bytes In</label>
						<input type="text" class="form-control" name="lbi" value="0"><br />
		              </div>
		              <div class="col-sm-3">
		              <label>Limit Bytes Out</label>
						<input type="text" class="form-control" name="lbo" value="0"><br />
		              </div>
		              <div class="col-sm-3">
		              <label>Limit Bytes Total</label>
						<input type="text" class="form-control" name="lbt" value="0"><br />
		              </div>
					  <input type="submit" name="submit" class="form-control btn btn-info" value="Create User" />
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
                 <h3 class="box-title">Gateway Users</h3>
                 <div class="btn-group pull-right">
					<button class="btn btn-danger dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bars"></i> Export Data</button>
					<ul class="dropdown-menu">
						<li><a href="#" onClick ="$('#example1').tableExport({type:'json', tableName:'users'});"><img src='dist/img/icons/json.png' width="24"/> JSON</a></li>
						<li class="divider"></li>
						<li><a href="#" onClick ="$('#example1').tableExport({type:'xml', tableName:'users'});"><img src='dist/img/icons/xml.png' width="24"/> XML</a></li>
						<li><a href="#" onClick ="$('#example1').tableExport({type:'sql', tableName:'users'});"><img src='dist/img/icons/sql.png' width="24"/> SQL</a></li>
						<li class="divider"></li>
						<li><a href="#" onClick ="try{$('#example1').tableExport({type:'excel',escape:'false'});}catch(err){alert(err.message);}"><img src='dist/img/icons/xls.png' width="24"/> XLS</a></li>
						<li><a href="#" onClick ="$('#example1').tableExport({type:'doc',escape:'false'});"><img src='dist/img/icons/word.png' width="24"/> Word</a></li>
					</ul>
                 </div>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th><i class="fa fa-edit"></i></th>
                       <th>Name</th>
                       <th>Password</th>
                       <th>Profile</th>
                       <th>Uptime</th>
                       <th>Limit Uptime</th>
                       <th>Disabled</th>
                       <th><i class="fa fa-cog"></i></th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
	                for (Map<String,String> mp : g.users()) {
	                	String f = mp.get("comment");
					  	if(!String.valueOf(f).contains("default") && !String.valueOf(f).contains("Default") && !Boolean.valueOf(mp.get("default"))){
						  	String s = mp.get(".id");
						  	
						  	String btn_st = "<a href='?q=disable&type=user&item="+s+"'><button class='btn btn-xs btn-warning fa fa-thumbs-down'></button></a>";
						  	if (Boolean.valueOf(mp.get("disabled"))){
						  		btn_st = "<a href='?q=enable&type=user&item="+s+"'><button class='btn btn-xs btn-success fa fa-thumbs-up'></button></a>";
						  	}
						  	String btn_dl = "<a href='?q=remove&type=user&item="+s+"'><button class='btn btn-xs btn-danger fa fa-times'></button></button></a>";
						  	String btn_ed = "<a href='update.jsp?q=edit&type=user&item="+s+"'><button class='btn btn-xs btn-info fa fa-edit'></button></a>";
						  	out.println("<tr>");
							out.println("<td>"+btn_ed+"</td>");
							out.println("<td>"+mp.get("name")+"</td>");
							out.println("<td>"+mp.get("password")+"</td>");
							out.println("<td>"+mp.get("profile")+"</td>");
							out.println("<td>"+mp.get("uptime")+"</td>");
							out.println("<td>"+String.valueOf(mp.get("limit-uptime")).replace("null", "Unlimited")+"</td>");
							out.println("<td>"+mp.get("disabled")+"</td>");
							out.println("<td>"+btn_st+"  "+btn_dl+" </td>");
							out.println("</tr>");
					  	}
					}%>
                   </tbody>
                   <tfoot>
                     
                   </tfoot>
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
	<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("userprofiles")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           List of Gateway Plans
           <small>Internal Gateway Plans</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Access Config</a></li>
           <li class="active">Gateway Plan</li>
         </ol>
       </section>
       <section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Create New Plan <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="hotspot.jsp" method="post">
					 
					 <div class="form-group">
						 <label>Name:</label>
						 <input type="text" class="form-control" name="name"><br />
					     <input type="hidden" class="form-control" name="pool" value="none">
	                 </div>
					 <label>Rate Limit:</label>
					 <input type="text" class="form-control" name="rate"><br />
					 <label>Sharing Limit</label>
					 <input type="number" class="form-control" name="share"><br />
					 <div class="form-group">
	                      <label>Open Status Page</label>
	                      <select class="form-control" name="statpage">
		                      <option value="http-login">HTTP Login</option>
		                      <option value="always">always</option>
	                      </select>
	                  </div>
	                  <div class="col-sm-3">
		              <label>Add Mac-cookie</label>
						<select class="form-control" name="addcookie">
						<option>true</option>
						<option>false</option>
						</select>
						<br />
		              </div>
		              <div class="col-sm-3">
		              <label>Mac Cookie Timeout</label>
						<input type="text" class="form-control" name="cookieto" value="3d 00:00:00"><br />
		              </div>
	                  <div class="col-sm-3">
		              <label>Idle Timeout</label>
						<input type="text" class="form-control" name="idleto" value="00:02:00"><br />
		              </div>
		              <div class="col-sm-3">
		              <label>Session Timeout</label>
						<input type="text" class="form-control" name="sessionto" value="00:00:00"><br />
		              </div>
		              <div class="col-sm-3">
		              <label>Keep Alive Timeout</label>
						<input type="text" class="form-control" name="keepal" value="none"><br />
		              </div>
		              
	                  
					<input type="submit" name="submit" class="form-control btn btn-info" value="Create Plan" />
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
                 <h3 class="box-title">Gateway Plans</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body  table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th><i class="fa fa-edit"></i></th>
                       <th>Name</th>
                       <th>Pool</th>
                       <th>Sharing</th>
                       <th>Trans-Proxy</th>
                       <th>Add Cookie</th>
                       <th>Cookie Timeout</th>
                       <th><i class="fa fa-cog"></i></th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   
	                for (Map<String,String> mp : g.userprofile()) {
	                	String f = mp.get("default");
					  	if(!Boolean.valueOf(f) && !mp.get("name").contains("Default")){
		                	String s = mp.get(".id");
						  	String btn_dl = "<a href='?q=remove&type=userprof&item="+s+"'><button class='btn btn-xs btn-danger fa fa-times'></button></a>";
						  	String btn_ed = "<a href='update.jsp?q=edit&type=userprof&item="+s+"'><button class='btn btn-xs btn-info fa fa-edit'></button></a>";
	
						  	out.println("<tr>");
							out.println("<td>"+btn_ed+"</td>");
							out.println("<td>"+mp.get("name")+"</td>");
							out.println("<td>"+mp.get("address-pool")+"</td>");
							out.println("<td>"+mp.get("shared-users")+"</td>");
							out.println("<td>"+mp.get("transparent-proxy")+"</td>");
							out.println("<td>"+mp.get("add-mac-cookie")+"</td>");
							out.println("<td>"+mp.get("mac-cookie-timeout")+"</td>");
							//out.println("<td>"+mp.get("default")+"</td>");
							out.println("<td>"+btn_dl+"</td>");
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
       <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("activeusers")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Active Device
           <small>List of Devices Currently Connected</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Hotspot</a></li>
           <li class="active">Active Users</li>
         </ol>
       </section>
       <section class="content-header">
			<div class="panel box box-primary">
	           <div class="box-header with-border">
	             <h4 class="box-title">
	               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	                 Throttle <span><i class="fa fa-angle-double-down"></i></span>
	               </a>
	             </h4>
	           </div>
	           <div id="collapseOne" class="panel-collapse <%= bpan%>">
	             <div class="box-body">
	             	<form action="hotspot.jsp" method="post">
	             		<div class="col-sm-6">
							<label>Device Mac-Address:</label>
							<input type="text" class="form-control" name="mac" value="<%=dbpmac%>"><br />
						</div>
						<div class="col-sm-6">
							<label>Device IP:</label>
							<input type="text" class="form-control" name="dip" value="<%=dbpip%>"><br />
						</div>
						<div class="col-sm-6">
							<label>Upload Limit</label>
							<input type="text" class="form-control" name="lbi" value="5M"><br />
			            </div>
			            <div class="col-sm-6">
			              	<label>Download Limit</label>
							<input type="text" class="form-control" name="lbo" value="5M"><br />
			            </div>
						<button type="submit" name="submit" class="form-control btn btn-info" value="Bypass">Throttle Device</button>
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
                 <h3 class="box-title">Active Devices</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body  table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Mac</th>
                       <th>IP</th>
                       <th>Server</th>
                       <th>User</th>
                       <th>Up-time</th>
                       <th>Idle-time</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
	                for (Map<String,String> mp : g.activeUsers()) {
				  //System.out.println(r);
				  	String s = mp.get(".id");
				  	String btn_dl = "<a href='?q=remove&type=active&item="+s+"'><button class='btn btn-xs btn-danger'><i class='fa fa-times'></i></button></a>";
				  	String btn_bl = "<a href='?q=blockmac&type=activeusers&dmac="+mp.get("mac-address")+"'><button class='btn btn-xs btn-warning'><i class='fa fa-ban'></i></button></a>";
				  	String btn_bp = "<a href='?q=activeusers&act=bypassmac&dmac="+mp.get("mac-address")+"&dip="+mp.get("address")+"'><button title='Throttle' class='btn btn-xs btn-warning'><i class='fa  fa-rocket'></i></button></a>";

				  	out.println("<tr>");
					out.println("<td>"+s+"</td>");
					out.println("<td>"+mp.get("mac-address")+"</td>");
					out.println("<td>"+mp.get("address")+"</td>");
					out.println("<td>"+mp.get("server")+"</td>");
					out.println("<td>"+mp.get("user")+"</td>");
					out.println("<td>"+mp.get("uptime")+"</td>");
					out.println("<td>"+mp.get("idle-time")+"</td>");
					out.println("<td>"+btn_dl+" "+btn_bl+" "+btn_bp+"</td>");
					out.println("</tr>");
				  
				  
				}%>
                   
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
       
       <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("hosts")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Pre Auth Devices
           <small>Devices that are connected but not authenticated</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Hotspot Management</a></li>
           <li class="active">Pre Auth Devices</li>
         </ol>
       </section>
       <section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Bypass Mac-address <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse <%= bpan%>">
             <div class="box-body">
             	<form action="hotspot.jsp" method="post">
             		<div class="col-sm-6">
						<label>Enter Mac-Address To Bypass:</label>
						<input type="text" class="form-control" name="mac" value="<%=dbpmac%>"><br />
					</div>
					<div class="col-sm-6">
						<label>Device IP:</label>
						<input type="text" class="form-control" name="dip" value="<%=dbpip%>"><br />
					</div>
					<div class="col-sm-6">
						<label>Upload Limit</label>
						<input type="text" class="form-control" name="lbi" value="5M"><br />
		            </div>
		            <div class="col-sm-6">
		              	<label>Download Limit</label>
						<input type="text" class="form-control" name="lbo" value="5M"><br />
		            </div>
		            <div class="col-sm-12">
		              	<label>Remark</label>
						<input type="text" class="form-control" required name="remark" value="No Remarks"><br />
		            </div>
					<input type="submit" name="submit" class="form-control btn btn-info" value="Bypass" />
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
                 <h3 class="box-title">Pre Auth Devices</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Mac Address</th>
                       <th>IP</th>
                       <!-- <th>To-Address</th> -->
                       <th>Bypassed</th>
                       <th>Uptime</th>
                       <th>Idle</th>
                       <th>Server</th>
                       <th>Px-in</th>
                       <th>Px-out</th>
                       <th><i class="fa fa-cogs"></i></th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   	
	                for (Map<String,String> mp : g.hosts()) {
	                	String c = String.valueOf(mp.get("comment"));
					  	if(!c.contains("Default")){
						  	String s = mp.get(".id");
						  	String btn_bp = "";
						  	String btn_bl = "<a href='?q=blockmac&type=hosts&dmac="+mp.get("mac-address")+"'><button title='Block' class='btn btn-xs btn-warning'><i class='fa fa-ban'></i></button></a>";
						  	btn_bp = "<a href='?q=hosts&act=bypassmac&dmac="+mp.get("mac-address")+"&dip="+mp.get("address")+"'><button title='Bypass' class='btn btn-xs btn-warning'><i class='fa  fa-sign-out'></i></button></a>";
						  	String btn_ds = "<a href='?q=remove&type=host&item="+s+"'><button title='Remove' class='btn btn-xs btn-danger'><i class='fa fa-times'></i></button></a>";
						  	
						  	out.println("<tr>");
							out.println("<td>"+mp.get("mac-address")+"</td>");
							out.println("<td>"+mp.get("address")+"</td>");
							//out.println("<td>"+mp.get("to-address")+"</td>");
							out.println("<td>"+mp.get("bypassed")+"</td>");
							out.println("<td>"+mp.get("uptime")+"</td>");
							out.println("<td>"+mp.get("idle-time")+"</td>");
							out.println("<td>"+mp.get("server")+"</td>");
							out.println("<td>"+mp.get("packets-in")+"</td>");
							out.println("<td>"+mp.get("packets-out")+"</td>");
							out.println("<td>"+btn_ds+" "+btn_bl+" "+btn_bp+"</td>");
							out.println("</tr>");
					  	}
				  				  
					}%>
                   <tfoot>
                   	<tr>
                   		<td colspan="9">
                      		<a href='?q=bypassed'><button title='Bypassed' class='btn btn-xs btn-warning'><i class='fa  fa-sign-out'> View Bypassed</i></button></a>
                   		</td>
                   	</tr>
                   </tfoot>
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
           List of Bypassed Devices
           <small>Bypass host device</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Access Config</a></li>
           <li class="active">Bypassed</li>
         </ol>
       </section>
       
       <section class="content-header">
			<div class="panel box box-primary">
	           <div class="box-header with-border">
	             <h4 class="box-title">
	               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	                 Bypass Update <span><i class="fa fa-angle-double-down"></i></span>
	               </a>
	             </h4>
	           </div>
	           <div id="collapseOne" class="panel-collapse <%= rpan%>">
	             <div class="box-body">
	             	<form action="hotspot.jsp" method="post">
	             		<div class="col-sm-6">
							<label>Bypassed Item:</label>
							<input type="text" readonly class="form-control" name="item" value="<%=bpid%>"><br />
						</div>
						<div class="col-sm-6">
							<label>Bypassed Mac:</label>
							<input type="text" readonly class="form-control" name="mac" value="<%=bpmac%>"><br />
						</div>
			            <div class="col-sm-12">
			              	<label>Remark</label>
							<input type="text" class="form-control" required name="remark" value="<%=bpremark%>"><br />
			            </div>
						<input type="submit" name="submit" class="form-control btn btn-info" value="Update Bypass" />
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
                 <h3 class="box-title">Bypassed devices</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Device MAC</th>
                       <th>Status</th>
                       <th>Disabled</th>
                       <th>Remark</th>
                       <th><i class="fa fa-cogs"></i></th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   	
	                for (Map<String,String> mp : g.getBypassed()) {
	                	String c = String.valueOf(mp.get("comment"));
					  	if(!c.contains("Default")){
						  	String s = mp.get(".id");
						  	String bs = g.bypassThrottle(mp.get("mac-address"));
						  	String btn_bp = "<a href='?q=bypassed&act=bypassremark&item="+s+"&dmac="+mp.get("mac-address")+"&remark="+mp.get("comment")+"'><button title='Edit Remark' class='btn btn-xs btn-warning'><i class='fa  fa-edit'></i></button></a>";
						  	String btn_ds = "<a href='?q=remove&type=bypassed&item="+s+"&titem="+bs+"'><button title='Remove' class='btn btn-xs btn-danger fa fa-times'></button></a>";
						  	String btn_st = "<a href='?q=disable&type=bypassed&item="+s+"'><button title='Suspend Bypass' class='btn btn-xs btn-warning fa fa-thumbs-down'></button></a>";
						  	if (Boolean.valueOf(mp.get("disabled"))){
							  	btn_st = "<a href='?q=enable&type=bypassed&item="+s+"'><button title='Resume Bypass' class='btn btn-xs btn-success fa fa-thumbs-up'></button></a>";
						  	}
						  	out.println("<tr>");
							out.println("<td>"+mp.get("mac-address")+"</td>");
							out.println("<td>"+mp.get("type")+"</td>");
							out.println("<td>"+mp.get("disabled")+"</td>");
							out.println("<td>"+c+"</td>");
							out.println("<td>"+btn_ds+" "+btn_st+" "+btn_bp+"</td>");
							out.println("</tr>");
					  	}
					}%>
                   <tfoot>
                   	
                   </tfoot>
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
       
       <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("throttled")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           List of Throttled Devices
           <small>Throttled Device</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Access Config</a></li>
           <li class="active">Throttled</li>
         </ol>
       </section>    
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title">Throttled Devices</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Device MAC</th>
                       <th>Address</th>
                       <th>Rate</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
	                for (Map<String,String> mp : g.getThrottled()) {
	                	String c = String.valueOf(mp.get("comment"));
					  	if(!c.contains("Default")&&c.equals("Throttled")){
						  	String s = mp.get(".id");
						  	String n = mp.get("name");
						  	String bid = g.getBypassId(n);
						  	String btn_ds = "<a href='?q=remove&type=throttled&item="+s+"&bitem="+bid+"'><button title='Unthrottle' class='btn btn-xs btn-danger fa fa-times'></button></a>";
						  	String btn_st = "<a href='?q=disable&type=throttled&item="+s+"&bitem="+bid+"'><button title='Suspend Throttle' class='btn btn-xs btn-warning fa fa-thumbs-down'></button></a>";
						  	if (Boolean.valueOf(mp.get("disabled"))){
							  	btn_st = "<a href='?q=enable&type=throttled&item="+s+"&bitem="+bid+"'><button title='Resume Throttle' class='btn btn-xs btn-success fa fa-thumbs-up'></button></a>";
						  	}
						  	out.println("<tr>");
							out.println("<td>"+mp.get("name")+"</td>");
							out.println("<td>"+mp.get("target")+"</td>");
							out.println("<td>"+mp.get("max-limit")+"</td>");
							out.println("<td>"+btn_ds+" "+btn_st+"</td>");
							out.println("</tr>");
					  	}
				  				  
					}%>
                   <tfoot>
                   	
                   </tfoot>
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
       
       <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("walledgarden")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Walled Garden List
           <small>List of Walled garden sites and servers</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Access Config</a></li>
           <li class="active">Walled Garden</li>
         </ol>
       </section>
       <section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Add Walled Garden  <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
               <form action="hotspot.jsp" method="post">
               		<div class="form-group">
	                    <label>IP Address:</label>
	                    <div class="input-group">
	                      <div class="input-group-addon">
	                        <i class="fa fa-laptop"></i>
	                      </div>
	                      <input type="text" class="form-control" name="host" data-inputmask="'alias': 'ip'" data-mask>
	                    </div><!-- /.input group -->
	                  </div><!-- /.form group -->
	                  <label>Port:</label>
	                  <input type="text" class="form-control" name="port" value="0-65535">
	                  <br />
	                  <input type="submit" name="submit" class="form-control btn btn-info" value="Add Walled Garden" />
               </form>
               <hr>
               <h4>
		           Walled Garden Site
		           <small>Add a website to Walled Garden</small>
		       </h4>
               <form action="hotspot.jsp" method="post">
               		<div class="form-group col-md-6">
	                    <label>Destination port:</label>
	                    <input type="text" class="form-control" name="dport" value="80">
	                    <small>eg. 443 for https</small>
	                </div><!-- /.form group -->
	                <div class="form-group col-md-6">
	                    <label>protocol:</label>
	                    <select class="form-control" name="protocol">
	                    	<option></option>
	                    	<option>tcp</option>
	                    	<option>udp</option>
	                    	<option>icmp</option>
	                    	<option>ddp</option>
	                    	<option>egp</option>
	                    	<option>ggp</option>
	                    	<option>gre</option>
	                    	<option>hmp</option>
	                    	<option>idpr-cmtp</option>
	                    	<option>igmp</option>
	                    	<option>ipencap</option>
	                    	<option>ipencap</option>
	                    	<option>ipip</option>
	                    	<option>ipsec-ah</option>
	                    	<option>ipsec-esp</option>
	                    	<option>iso-tp4</option>
	                    	<option>ospf</option>
	                    	<option>pup</option>
	                    	<option>rdp</option>
	                    	<option>rspf</option>
	                    	<option>st</option>
	                   </select>
	                </div><!-- /.form group -->
	                <small>Default Set to TCP</small>
               		<div class="form-group col-lg-12">
	                    <label>Website Address:</label>
	                    <div class="input-group">
	                      <div class="input-group-addon">
	                        <i class="fa fa-globe"></i>
	                      </div>
	                      <input type="text" class="form-control" name="site">
	                    </div><!-- /.input group -->
	                  </div><!-- /.form group -->
	                  <br />
	                  <input type="submit" name="submit" class="form-control btn btn-info" value="Add Walled Garden Site" />
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
                 <h3 class="box-title">Walled Garden</h3>
               	 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Address</th>
                       <th>Type</th>
                       <th>Comment</th>
                       <th>Action</th>
                       <th>Disabled</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
	                for (Map<String,String> mp : g.walledGarden()) {
	                	String f = String.valueOf(mp.get("comment"));
					  	if(!f.contains("Default")){
			                String i = mp.get(".id");
			                String da = mp.get("dst-address");
			                String type= "";
						  	String btn_st = "<a href='?q=disable&type=walledgarden&item="+i+"'><button title='Disable' class='btn btn-xs btn-warning fa fa-thumbs-down'></button></a>";
						  	String btn_dl = "<a href='?q=delete&type=walledgarden&item="+i+"'><button class='btn btn-xs btn-danger fa fa-times'></button></a>";
						  	String btn_ed = "";
						  	if (Boolean.valueOf(mp.get("disabled"))){
							  	btn_st = "<a href='?q=enable&type=walledgarden&item="+i+"'><button title='Enable' class='btn btn-xs btn-success fa fa-thumbs-up'></button></a>";
						  	}
						  	out.println("<tr>");
						  	if (mp.containsKey("dst-address")){
						  		btn_ed = "<a href='update.jsp?q=edit&type=walledgarden&item="+i+"'><button title='Edit' class='btn btn-xs btn-info fa fa-edit'></button></a>";
						  		type = "IP";
						  		out.println("<td><a title='Summary' href='hotspot_wg.jsp?q="+type+"&item="+mp.get("dst-address")+"'>"+mp.get("dst-address")+"</a></td>");
						  	}else if (mp.containsKey("dst-host")){
						  		btn_ed = "<a href='update.jsp?q=edit&type=walledgardensite&item="+i+"'><button title='Edit' class='btn btn-xs btn-info fa fa-edit'></button></a>";
						  		type = "SITE";
						  		out.println("<td><a title='Summary' href='hotspot_wg.jsp?q="+type+"&item="+mp.get("dst-host")+"'>"+mp.get("dst-host")+"</a></td>");
						  	}else{
						  		btn_ed = "<a href='update.jsp?q=edit&type=walledgardenserver&item="+i+"'><button title='Edit' class='btn btn-xs btn-info fa fa-edit'></button></a>";
						  		type = "SERVER";
						  		out.println("<td><a title='Summary' href='hotspot_wg.jsp?q="+type+"&item="+mp.get("server")+"'>"+mp.get("server")+"</a></td>");
						  	}
						  	out.println("<td>"+type+"</td>");
						  	out.println("<td>"+((f == "null") ? "No Comment" : f)+"</td>");
							out.println("<td>"+mp.get("action")+"</td>");
							out.println("<td>"+mp.get("disabled")+"</td>");
							out.println("<td>"+btn_ed+" "+btn_st+" "+btn_dl+"</td>");
							out.println("</tr>");
	                	}
				  }%>
                  <tbody> 
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
       
       <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("cookies")) { %>
   	
   	<!-- Content Header (Page header) -->
          <section class="content-header">
            <h1>
              Stored Sessions
              <small>Device Stored Sessions</small>
            </h1>
            <ol class="breadcrumb">
              <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
              <li><a href="#">Hotspot Management</a></li>
              <li class="active">Stored Sessions</li>
            </ol>
          </section>
          
          <!-- Table List -->
          <section class="content">
            <div class="row">
              <div class="col-xs-12"><!-- /.box -->

                <div class="box">
                  <div class="box-header">
                    <h3 class="box-title">Device Stored Sessions</h3>
                    <%@include file="import.jsp" %>
                  </div><!-- /.box-header -->
                  <div class="box-body table-responsive">
                    <table id="example1" class="table table-bordered table-striped">
                      <thead>
                        <tr>
                          <th>Device MAC</th>
                          <th>User</th>
                          <th>Expires In</th>
                          <th><i class="fa fa-cog"></i></th>
                        </tr>
                      </thead>
                      <tbody>
                      <%for (Map<String,String> mp : g.cookies()) {
	   				  	String s = mp.get(".id");
					  	String btn_ds = "<a href='?q=delete&type=cookies&item="+s+"'><button class='btn btn-sm btn-danger'>Remove</button></a>";
	
	   				  	out.println("<tr>");
	   					//out.println("<td>"+mp.get(".id")+"</td>");
	   					out.println("<td>"+mp.get("mac-address")+"</td>");
	   					out.println("<td>"+mp.get("user")+"</td>");
	   					out.println("<td>"+mp.get("expires-in")+"</td>");
	   					out.println("<td>"+btn_ds+"</td>");
	   					out.println("</tr>");
	   				  }%>
                      </tbody>
                      
                    </table>
                  </div><!-- /.box-body -->
                </div><!-- /.box -->
              </div><!-- /.col -->
            </div><!-- /.row -->
          </section><!-- /.content --><% }%>
</div><!-- /.content-wrapper -->  
<footer class="main-footer">
  <div class="pull-right hidden-xs">
    <b>Version</b> <%=sysver%>
  </div>
  <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">Alps Gateway</a>.</strong> All rights reserved.
</footer>
</div> <!-- /.content -->
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
<!-- page script -->
</body>
</html>