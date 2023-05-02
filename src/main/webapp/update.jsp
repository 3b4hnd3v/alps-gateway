<%@include file="header.jsp" %>

 <body class="hold-transition skin-blue layout-boxed sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>      
<!-- =============================================== -->
<div class="content-wrapper">

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Pool")) {
	
	try {
		String item = request.getParameter("pid").toString();
		String pname = request.getParameter("poolname").toString();
		String pranges = request.getParameter("ranges").toString();
		String nextpool = request.getParameter("nextpool").toString();
		
		g.editPool(pname,pranges,nextpool,item);
		
		String logact = "Address Pool "+pname+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("ippadd.jsp?q=pool");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update User")) {
	
	try {
		String uid = request.getParameter("uid").toString();
		String username = request.getParameter("username").toString();
		String password = request.getParameter("password").toString();
		String prof = request.getParameter("prof").toString();
		String server = request.getParameter("server").toString();
		String ipadd = request.getParameter("ipadd").toString();
		String mac = request.getParameter("mac").toString();
		String lu = request.getParameter("lu").toString();
		String lbi = request.getParameter("lbi").toString();
		String lbo = request.getParameter("lbo").toString();
		String lbt = request.getParameter("lbt").toString();
		g.updateUser(uid, username, password, prof, server, lu, ipadd, mac, lbi, lbo, lbt);
		
		String logact = "User "+username+" Updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=users");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Plan")) {
	
	try {
		String uid = request.getParameter("uid").toString();
		String name = request.getParameter("name").toString();
		String pool = request.getParameter("pool").toString();
		String rate = request.getParameter("rate");
		String share = request.getParameter("share").toString();
		String cookieto = request.getParameter("cookieto").toString();
		String addcookie = request.getParameter("addcookie").toString();
		String statpage = request.getParameter("statpage").toString();
		String sessionto = request.getParameter("sessionto").toString();
		String idleto = request.getParameter("idleto").toString();
		String keepal = request.getParameter("keepal").toString();
		System.out.println("Update sebd Rate"+rate);
		g.updateUserProf(uid , name, pool, rate, addcookie, cookieto, share, statpage, sessionto, idleto, keepal);
		
		String logact = "User profile "+name+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("hotspot.jsp?q=userprofiles");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Walled Garden")) {
	
	try {
		String wgid = request.getParameter("wgid").toString();
		String dstadd = request.getParameter("dstadd").toString();
		String dstport = request.getParameter("dstport").toString();
		String action = request.getParameter("action").toString();
		
		g.updateWalledGarden(wgid , dstadd, dstport, action);
		
		String logact = "Walled Garden "+dstadd+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hotspot.jsp?q=walledgarden");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Walled Garden Site")) {
	
	try {
		String wgid = request.getParameter("wgid").toString();
		String dsthost = request.getParameter("dsthost").toString();
		String dstport = request.getParameter("dstport").toString();
		String protocol = request.getParameter("protocol").toString();
		String comment = request.getParameter("comment").toString();
		String action = request.getParameter("action").toString();
		
		g.updateWalledGardenSite(wgid , dsthost, dstport, protocol, comment, action);
		
		String logact = "Walled Garden "+dsthost+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hotspot.jsp?q=walledgarden");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Address")) {
	
	try {
		String uid = request.getParameter("uid").toString();
		String interf = request.getParameter("interf").toString();
		System.out.println("going");
		String ipadd = request.getParameter("ipadd").toString();
		String net = request.getParameter("net").toString();

		g.updateIpadd(uid , interf, ipadd, net);
		
		String logact = "Address on "+interf+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("ippadd.jsp?q=ipaddress");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Hotspot Server")) {
	
	try {
		String hssid = request.getParameter("hssid").toString();
		String hsserver = request.getParameter("hsserver").toString();
		String hssprof = request.getParameter("hssprof").toString();
		String hssint = request.getParameter("hssint").toString();
		String pool = request.getParameter("pool").toString();
		String apm = request.getParameter("apm").toString();
		String kato = request.getParameter("kato").toString();
		String idto = request.getParameter("idto").toString();
		
		g.updateHsserver(hssid , hsserver, hssprof, hssint, pool, apm, kato, idto);
		
		String logact = "Hostspot Server "+hsserver+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hs_server.jsp?q=servers");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Hotspot Server Profile")) {
	
	try {
		String hspid = request.getParameter("hspid").toString();
		String hsprof = request.getParameter("hsserver").toString();
		String hsadd = request.getParameter("hsadd").toString();
		String hsdir = request.getParameter("hsdir").toString();
		String dnsname = request.getParameter("dnsname").toString();
		String loginby = request.getParameter("loginby").toString();
		String cookieto = request.getParameter("cookieto").toString();
		String smtps = request.getParameter("smtps").toString();
		String ratelim = request.getParameter("ratelim").toString();
		String htproxy = request.getParameter("htproxy").toString();
		
		g.updateHsserverProf(hspid, hsprof, hsadd, htdir, dnsname, loginby, cookieto, smtps, ratelim, htproxy);

		String logact = "Hotspot Server Profile "+hsprof+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("hs_server.jsp?q=serverprofiles");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Interface")) {
	
	try {
		String intid = request.getParameter("intid").toString();
		String intname = request.getParameter("intname").toString();
		String inttype = request.getParameter("inttype").toString();
		String mtu = request.getParameter("mtu").toString();
		
		g.updateInterface(intid , intname, inttype, mtu);
		
		String logact = "Interface "+intname+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("ippadd.jsp?q=ipaddress");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update VLAN")) {
	
	try {
		String intid = request.getParameter("intid");
		String intname = request.getParameter("intname");
		String vlid = request.getParameter("vlid");
		String inttype = request.getParameter("inttype");
		String mtu = request.getParameter("mtu").trim();
		
		g.updateVlan(intid , intname, vlid, inttype, mtu);
		
		String logact = "Vlan "+intname+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("interfaces.jsp?q=vlan");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update DNS")) {
	
	try {
		String item = request.getParameter("did").toString();
		String dname = request.getParameter("dname").toString();
		String daddr = request.getParameter("daddr").toString();
		String dttl = request.getParameter("dttl").toString();
		
		g.editDNS(dname,daddr,dttl,item);
		
		String logact = "DNS Entry "+pname+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("dns.jsp?q=dnsstatic&msg=DNS Is Successfully Updated&type=success");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
//pool_edit
if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("pool")) { %>
	<%! public String pid = "", pname = "", prange = "", nextpool = "";  %>
	
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Edit DHCP Pool
        <small>Update already existing DHCP Pool</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">Pool</a></li>
        <li class="active">Edit</li>
      </ol>
    </section>
    
    <section class="content-header">
		<div class="panel box box-primary">
        <div class="box-header with-border">
          <h4 class="box-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
              Edit Pool
            </a>
          </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse-in">
          <div class="box-body">
          <%	String pid = request.getParameter("item");
		      	for (Map<String,String> mp : g.getPool(pid)) {
		    		
		    		pid = mp.get(".id"); 
		    		pname = mp.get("name"); 
		    		prange = mp.get("ranges"); 
		    		nextpool = mp.get("next-pool"); 
		    	}
		 %>
          <form action="update.jsp" method="post">
          	<div class="form-group">
                <label>ID</label>
          		<input type="text" name="pid" id="pid" class="form-control" value="<% out.println(pid); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Pool Name</label>
          		<input type="text" name="poolname" id="poolname" class="form-control" value="<% out.println(pname); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Pool Range</label>
          		<input type="text" name="ranges" id="ranges" class="form-control" value="<% out.println(prange); %>"><br />
          	</div>
          	<div class="form-group">
                  <label>Next Pool</label>
                  <select class="form-control" name="nextpool">
                  <option><%out.println("Current = "+nextpool);%></option>
                  <option></option>
                  <% 
                  	for (Map<String,String> mp : g.pool()) {
			  		String s = mp.get("name");
                    out.println("<option>"+s+"</option>");
                  	}
                    %>
                  </select>
                  <p class="alert">Make sure you change from "Current = xxxxx"</p>
                </div>
          	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Pool">
          	<a href="reset.jsp?type=pool&item=<%out.println(pid);%>"><button class="btn btn-info pull-right">Reset Counter</button></a>
          </form>
          </div>
        </div>
      </div>
	</section>
<%
//user_edit
}else if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("user")) { %>
	<%! public String uid = "", username = "", password = "", profile = "", server = "", ip = "", mac = "", lu = "", lbi = "", lbo = "", lbt = "";  %>
	
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        List of Hotspot Users
        <small>List of Available Network Interfaces</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="hotspot.jsp?q=users">User</a></li>
        <li class="active">Update</li>
      </ol>
    </section>
    
    <section class="content-header">
		<div class="panel box box-primary">
        <div class="box-header with-border">
          <h4 class="box-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
              Edit User
            </a>
          </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse-in">
          <div class="box-body">
          <%	String uid = request.getParameter("item");
		      	for (Map<String,String> mp : g.getUser(uid)) {
		      		System.out.println(mp);
		    		uid = mp.get(".id"); 
		    		username = mp.get("name"); 
		    		password = mp.get("password"); 
		    		profile = mp.get("profile"); 
		    		server = mp.get("server"); 
		    		ip = mp.get("address"); 
		    		mac = mp.get("mac-address"); 
		    		lu = mp.get("limit-uptime"); 
		    		lbi = mp.get("limit-bytes-in"); 
		    		lbo = mp.get("limit-bytes-out"); 
		    		lbt = mp.get("limit-bytes-out"); 
		    	}
		 %>
          <form action="update.jsp" method="post">
          	<div class="form-group">
                <label>ID</label>
          		<input type="text" name="uid" id="uid" readonly class="form-control" value="<% out.println(uid); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Userame</label>
          		<input type="text" name="username" id="username" class="form-control" value="<% out.println(username); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Password</label>
          	`	<input type="text" name="password" id="password" class="form-control" value="<% out.println(password); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Profile</label>
                <select class="form-control" name="prof">
                <option><% out.println(profile); %></option>
                <% 
                	for (Map<String,String> mp : g.userprofile()) {
					String s = mp.get("name");
					if(!s.equals(profile)){
                  	out.println("<option>"+s+"</option>");}
                	}
                  %>
                <option>none</option>
                </select>
            </div><br />
          	<div class="form-group">
                <label>Server</label>
                <select class="form-control" name="server">
                <option>all</option>
                <option><% out.println(server); %></option>
               	<% 
                	for (Map<String,String> mp : g.hsservers()) {
					String s = mp.get("name");
					if(!s.equals(server)){
                  	out.println("<option>"+s+"</option>");}
                	}
                  %>
                </select>
            </div>
          	<div class="col-sm-6">
            	<label>Address</label>
				<input type="text" class="form-control" name="ipadd" value="<%if(ip != null){out.print(ip);}else{out.print("0.0.0.0");}%>"><br />
            </div>
            <div class="col-sm-6">
             	<label>MAC Address</label>
				<input type="text" class="form-control" name="mac" value="<%if(mac != null){out.print(mac);}else{out.print("00:00:00:00:00:00");}%>"><br />
            </div>
            <div class="col-sm-3">
            	<label>Limit Uptime</label>
				<input type="text" class="form-control" name="lu" value="<%if(lu != null){out.print(lu);}else{out.print("0");}%>"><br />
            </div>
            <div class="col-sm-3">
             	<label>Limit Bytes In</label>
				<input type="text" class="form-control" name="lbi" value="<%if(lbi != null){out.print(lbi);}else{out.print("0");}%>"><br />
            </div>
            <div class="col-sm-3">
             	<label>Limit Bytes Out</label>
				<input type="text" class="form-control" name="lbo" value="<%if(lbo != null){out.print(lbo);}else{out.print("0");}%>"><br />
            </div>
            <div class="col-sm-3">
             	<label>Limit Bytes Total</label>
				<input type="text" class="form-control" name="lbt" value="<%if(lbt != null){out.print(lbt);}else{out.print("0");}%>"><br />
            </div>
          	<input type="submit" id="submit" name="submit" class="col-md-9 btn btn-success" value="Update User">
          	<a href="reset.jsp?type=user&item=<%out.println(uid);%>"><button class="btn btn-info pull-right">Reset Counter</button></a>
          	
          </form>
          </div>
        </div>
      </div>
	</section>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("userprof")) { %>
<%! public String prid = "", prname = "", pool = "", rlimit = "", cto = "", amc = "", sharelimit = "", statp = "", ito = "", sto = "", kat = "";  %>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Edit Gateway Plan
    <small>Update User Gateway Plan</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="hotspot.jsp?q=users">Gateway Plan</a></li>
    <li class="active">Update</li>
  </ol>
</section>

<section class="content-header">
	<div class="panel box box-primary">
    <div class="box-header with-border">
      <h4 class="box-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Edit User Profile
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse-in">
      <div class="box-body">
     <%	
     	String id = request.getParameter("item");
      	for (Map<String,String> mp : g.getUserProfile(id)) {
    		System.out.print(mp);
    		prid = mp.get(".id"); 
    		prname = mp.get("name"); 
    		pool = mp.get("address-pool"); 
    		rlimit = mp.get("rate-limit");
    		amc = mp.get("add-mac-cookie"); 
    		cto = mp.get("mac-cookie-timeout"); 
    		sharelimit = mp.get("shared-users"); 
    		statp = mp.get("open-status-page"); 
    		ito = mp.get("idle-timeout");
    		sto = mp.get("session-timeout");
    		kat = mp.get("keepalive-timeout");
    	}
	 %>
	  <form action="update.jsp" method="post">
	  	 <div class="form-group col-md-6">
            <label>ID</label>
      		<input type="text" name="uid" id="uid" readonly class="form-control" value="<% out.println(prid); %>"><br />
      	</div>
      	<div class="form-group col-md-6">
		 	<label>Name:</label>
			<input type="text" class="form-control" name="name" value="<% out.println(prname); %>"><br />
			<input type="hidden" class="form-control" name="pool" value="none">
		</div>
		
		 <label>Rate Limit:</label>
			<input type="text" class="form-control" name="rate" value="<% if(rlimit != null){out.println(rlimit);} %>"><br />
		 <label>Sharing Limit</label>
			<input type="text" class="form-control" name="share" value="<% out.println(sharelimit); %>"><br />
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
			<input type="text" class="form-control" name="cookieto" value='<% if(cto != null){out.println(cto);}else{out.println("3d 00:00:00");} %>'><br />
        </div>
        <div class="col-sm-3">
             <label>Idle Timeout</label>
			 <input type="text" class="form-control" name="idleto" value='<% if(ito != null){out.println(ito);}else{out.println("00:02:00");} %>'><br />
        </div>
        <div class="col-sm-3">
             <label>Session Timeout</label>
			 <input type="text" class="form-control" name="sessionto" value='<% if(sto != null){out.println(sto);}else{out.println("00:00:00");} %>'><br />
        </div>
        <div class="col-sm-3">
             <label>Keep Alive Timeout</label>
			 <input type="text" class="form-control" name="keepal" value='<% if(kat != null){out.println(kat);}else{out.println("none");} %>'><br />
        </div>
		<input type="submit" id="submit" name="submit" class="btn btn-success col-sm-12" value="Update Plan"><br>
	  </form>
	  <p><br><br></p>
      <a href="reset.jsp?type=userprof&item=<%out.println(prid);%>"><button class="btn btn-info pull-right">Reset Counter</button></a>
      </div>
    </div>
  </div>
</section>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("walledgarden")) { %>
<%! public String dstadd = "", action = "", dstport = "", wgid = "", protocol = "";  %>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Edit User Profile
    <small>Update Hotspot User Profile</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="hotspot.jsp?q=walledgarden">Walled Garden</a></li>
    <li class="active">Update</li>
  </ol>
</section>

<section class="content-header">
	<div class="panel box box-primary">
    <div class="box-header with-border">
      <h4 class="box-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Edit Walled Garden
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse-in">
      <div class="box-body">
      <%	
      	String id = request.getParameter("item");
      	for (Map<String,String> mp : g.getWalledGarden(id)) {
    		
    		wgid = mp.get(".id"); 
    		dstadd = mp.get("dst-address"); 
    		dstport = mp.get("dst-port"); 
    		action = mp.get("action"); 
    		
    	}
	  %>
      <form action="update.jsp" method="post">
      	<div class="form-group">
            <label>ID</label>
      		<input type="text" name="wgid" id="wgid" readonly class="form-control" value="<% out.println(wgid); %>"><br />
      	</div>
      	<div class="form-group">
      		<label>IP Address:</label>
			<input type="text" class="form-control" name="dstadd" id="dstadd" value="<% out.println(dstadd); %>"><br />
		</div>
		<div class="form-group">
      		<label>Destination Port:</label>
			<input type="text" class="form-control" name="dstport" id="dstport" value="<% out.println(((dstport == null) ? "" : dstport)); %>"><br />
		</div>
		
		<div class="form-group">
	        <label>Action</label>
			<input type="text" readonly class="form-control" name="action" value="<% out.println(action); %>"><br />
	    </div>
      	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Walled Garden">
      </form>
      <a href="reset.jsp?type=walledgarden&item=<%out.println(wgid);%>"><button class="btn btn-info pull-right">Reset Counter</button></a>
      </div>
    </div>
  </div>
</section>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("walledgardensite")) { %>
<%! public String dst_host = "", comment = "", act = "", dst_port = "", wgsid = "", prot = "";  %>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Edit Walled Garden Site
    <small>Update Walled Garden Site Rules</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="hotspot.jsp?q=walledgarden">Walled Garden</a></li>
    <li class="active">Update</li>
  </ol>
</section>

<section class="content-header">
	<div class="panel box box-primary">
    <div class="box-header with-border">
      <h4 class="box-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Edit Walled Garden Site
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse-in">
      <div class="box-body">
      <%	
      	String id = request.getParameter("item");
      	
      	for (Map<String,String> mp : g.getWalledGarden(id)) {
      		//System.out.println(mp);
    		wgsid = mp.get(".id"); 
    		dst_host = mp.get("dst-host"); 
    		dst_port = mp.get("dst-port"); 
    		comment = mp.get("comment"); 
    		act = mp.get("action"); 
    		prot = mp.get("protocol"); 
    		
    	}
      	//System.out.println(wgsid);
	  %>
      <form action="update.jsp" method="post">
      	<div class="form-group">
            <label>ID</label>
      		<input type="text" name="wgid" id="wgid" readonly class="form-control" value="<% out.println(wgsid); %>"><br />
      	</div>
      	<div class="form-group">
      		<label>Site Address:</label>
			<input type="text" class="form-control" name="dsthost" id="dsthost" value="<% out.println(dst_host); %>"><br />
		</div>
		<div class="form-group">
      		<label>Comment:</label>
			<input type="text" class="form-control" name="comment" id="comment" value="<% out.println(comment); %>"><br />
		</div>
		<div class="form-group">
      		<label>Destination Port:</label>
			<input type="text" class="form-control" name="dstport" id="dstport" value="<% out.println(((dstport == null) ? "" : dstport)); %>"><br />
		</div>
		<div class="form-group">
           <label>protocol:</label>
           <small>Current Port = <% out.println(prot); %></small>
           <select class="form-control" name="protocol">
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
		 <div class="form-group">
            <label>Action</label>
			<input type="text" class="form-control" name="action" value="<% out.println(act); %>"><br />
        </div>
      	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Walled Garden Site">
      </form>
      <a href="reset.jsp?type=walledgarden&item=<%out.println(wgsid);%>"><button class="btn btn-info pull-right">Reset Counter</button></a>
      </div>
    </div>
  </div>
</section>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("ipaddress")) { %>
	<%! public String ipid = "", address = "", network = "", addint = "";  %>
	
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Edit IP Address
        <small>Change IP Address of Interface</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="hotspot.jsp?q=users">User</a></li>
        <li class="active">Update</li>
      </ol>
    </section>
    
    <section class="content-header">
		<div class="panel box box-primary">
        <div class="box-header with-border">
          <h4 class="box-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
              Edit User
            </a>
          </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse-in">
          <div class="box-body">
          <%	String uid = request.getParameter("item");
		      	for (Map<String,String> mp : g.getIpaddress(uid)) {
		    		
		    		ipid = mp.get(".id"); 
		    		address = mp.get("address"); 
		    		network = mp.get("network"); 
		    		addint = mp.get("interface"); 
		    	
		    	}
		 %>
          <form action="update.jsp" method="post">
          	<div class="form-group">
                <label>ID</label>
          		<input type="text" name="uid" id="uid" readonly class="form-control" value="<% out.println(ipid); %>"><br />
          	</div>
          	<div class="form-group">
                <label>interface</label>
          		<input type="text" name="interf" id="interf" class="form-control" value="<% out.println(addint); %>"><br />
          	</div>
          	<div class="form-group">
                <label>IP Address</label>
          	`	<input type="text" name="ipadd" id="ipadd" class="form-control" value="<% out.println(address); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Network</label>
          	`	<input type="text" name="net" id="net" class="form-control" value="<% out.println(network); %>"><br />
          	</div>
          	
          	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Address">
          </form>
          <a href="reset.jsp?type=ipadd&item=<%out.println(ipid);%>"></a><button class="btn btn-info pull-right">Reset Counter</button></a>
          </div>
        </div>
      </div>
	</section>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("hsserver")) { %>
	<%! public String hssid = "", hssname = "", hssprof = "", hssint = "", hsspool = "", apm = "", idto = "", kato = "", https = "";  %>
	
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Edit Hotspot Server Information
        <small>Change Hotspot Server Settings</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="hotspot.jsp?q=users">Hotspot Server</a></li>
        <li class="active">Update</li>
      </ol>
    </section>
    
    <section class="content-header">
		<div class="panel box box-primary">
        <div class="box-header with-border">
          <h4 class="box-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
              Edit User
            </a>
          </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse-in">
          <div class="box-body">
          <%	String uid = request.getParameter("item");
		      	for (Map<String,String> mp : g.getHsServer(uid)) {
		    		
		      		hssid = mp.get(".id"); 
		      		hssname = mp.get("name"); 
		      		hssprof = mp.get("profile"); 
		      		hssint = mp.get("interface"); 
		      		hsspool = mp.get("address-pool"); 
		      		apm = mp.get("addresses-per-mac");
		      		idto = mp.get("idle-timeout");
		      		kato = mp.get("keepalive-timeout");
		      		https = mp.get("HTTPS");
		    	
		    	}
		 %>
          <form action="update.jsp" method="post">
          	<div class="form-group">
                <label>ID</label>
          		<input type="text" name="hssid" id="hssid" readonly class="form-control" value="<% out.println(hssid); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Name</label>
          		<input type="text" name="hssname" id="hssname" class="form-control" value="<% out.println(hssname); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Profile</label>
          		<input type="text" name="hssprof" id="hssprof" class="form-control" value="<% out.println(hssprof); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Interface</label>
          		<input type="text" name="hssint" id="hssint" class="form-control" value="<% out.println(hssint); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Pool</label>
          		<input type="text" name="pool" id="pool" class="form-control" value="<% out.println(hsspool); %>"><br />
          	</div>
          	<div class="form-group col-md-3">
                <label>Address/Mac</label>
          		<input type="text" name="apm" id="apm" class="form-control" value="<% out.println(apm); %>"><br />
          	</div>
          	<div class="form-group col-md-3">
                <label>Keep Alive</label>
          		<input type="text" name="kato" id="kato" class="form-control" value="<% out.println(kato); %>"><br />
          	</div>
          	<div class="form-group col-md-3">
                <label>Idle Timeout</label>
          		<input type="text" name="idto" id="idto" class="form-control" value="<% out.println(idto); %>"><br />
          	</div>
          	<div class="form-group col-md-3">
                <label>HTTPS</label>
          		<input type="text" name="https" id="https" class="form-control" value="<% out.println(https); %>"><br />
          	</div>
          	
          	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Hotspot Server">
          </form>
          <a href="reset.jsp?type=hsserver&item=<%out.println(hssid);%>"></a><button class="btn btn-info pull-right">Reset Counter</button></a>
          </div>
        </div>
      </div>
	</section>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("hsserverprof")) { %>
	<%! public String hspid = "", hspname = "", hsadd = "", htdir = "", dnsname = "", loginby = "", cookieto = "", smtps = "", ratelim = "", htproxy = "";  %>
	
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Edit Hotspot Server Information
        <small>Change Hotspot Server Settings</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="hotspot.jsp?q=users">Hotspot Server</a></li>
        <li class="active">Update</li>
      </ol>
    </section>
    
    <section class="content-header">
		<div class="panel box box-primary">
        <div class="box-header with-border">
          <h4 class="box-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
              Edit User
            </a>
          </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse-in">
          <div class="box-body">
          <%	String uid = request.getParameter("item");
		      	for (Map<String,String> mp : g.getHsServerProf(uid)) {
		    		
		      		hspid = mp.get(".id"); 
		      		hspname = mp.get("name"); 
		      		hsadd = mp.get("hotspot-address"); 
		      		htdir = mp.get("html-directory"); 
		      		dnsname = mp.get("dns-name"); 
		      		loginby = mp.get("login-by");
		      		cookieto = mp.get("http-cookie-lifetime");
		      		smtps = mp.get("smtp-server");
		      		ratelim = mp.get("rate-limit");
		      		htproxy = mp.get("http-proxy");
		    	
		    	}
		 %>
          <form action="update.jsp" method="post">
          	<div class="form-group">
                <label>ID</label>
          		<input type="text" name="hspid" id="hspid" readonly class="form-control" value="<% out.println(hspid); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Profile Name</label>
          		<input type="text" name="hsprof" id="hsprof" class="form-control" value="<% out.println(hspname); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Hotspot Address</label>
          		<input type="text" name="hsadd" id="hsadd" class="form-control" value="<% out.println(hsadd); %>"><br />
          	</div>
          	<div class="form-group">
          		<label>Landing Page</label>
			      	<select class="form-control" name="htmldir">
			      	<option value="<% out.println(htdir); %>"><% out.println(htdir); %></option>
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
          	</div>
          	<div class="form-group">
                <label>DNS Name</label>
          		<input type="text" name="dnsname" id="dnsname" class="form-control" value="<% out.println(dnsname); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Login By</label>
          		<input type="text" name="loginby" id="loginby" class="form-control" value="<% out.println(loginby); %>"><br />
          	</div>
          	<div class="form-group col-md-3">
                <label>Cookie Lifetime</label>
          		<input type="text" name="cookieto" id="cookieto" class="form-control" value="<% if(cookieto!=null){out.println(cookieto);}else{out.println();} %>"><br />
          	</div>
          	<div class="form-group col-md-3">
                <label>SMTP Server</label>
          		<input type="text" name="smtps" id="smtps" class="form-control" value="<% out.println(smtps); %>"><br />
          	</div>
          	<div class="form-group col-md-3">
                <label>Rate Limit</label>
          		<input type="text" name="ratelim" id="ratelim" class="form-control" value="<% out.println(ratelim); %>"><br />
          	</div>
          	<div class="form-group col-md-3">
                <label>HTTP - Proxy</label>
          		<input type="text" name="htproxy" id="htproxy" class="form-control" value="<% out.println(htproxy); %>"><br />
          	</div>
          	
          	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Hotspot Server Profile">
          </form>
          <a href="reset.jsp?type=hsserverprof&item=<%out.println(hspid);%>"></a><button class="btn btn-info pull-right">Reset Counter</button></a>
          </div>
        </div>
      </div>
	</section>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("interface")) { %>
<%! public String intid = "", intname = "", inttype = "", mtu = "", mtu12 = "";  %>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Edit Interface
    <small>Update Interface Information</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="hotspot.jsp?q=walledgarden">Interface</a></li>
    <li class="active">Update</li>
  </ol>
</section>

<section class="content-header">
	<div class="panel box box-primary">
    <div class="box-header with-border">
      <h4 class="box-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Edit Interface
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse-in">
      <div class="box-body">
      <%	
      	String id = request.getParameter("item");
      	
      	for (Map<String,String> mp : g.getInterface(id)) {
      		//System.out.println(mp);
    		intid = mp.get(".id"); 
    		intname = mp.get("name"); 
    		inttype = mp.get("type"); 
    		mtu = mp.get("mtu"); 
    		mtu12 = mp.get("l2mtu"); 
    	}
      	//System.out.println(wgsid);
	  %>
      <form action="update.jsp" method="post">
      	<div class="form-group">
            <label>ID</label>
      		<input type="text" name="intid" id="intid" readonly class="form-control" value="<% out.println(intid); %>"><br />
      	</div>
      	<div class="form-group">
      		<label>Interface Name:</label>
			<input type="text" class="form-control" name="intname" id="intname" value="<% out.println(intname); %>"><br />
		</div>
		<div class="form-group">
      		<label>Interface Type:</label>
			<input type="text" class="form-control" name="inttype" id="inttype" value="<% out.println(inttype); %>"><br />
		</div>
		<div class="form-group">
            <label>MTU:</label>
			<input type="text" class="form-control" name="mtu" value="<% out.println(mtu); %>"><br />
        </div>
      	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Interface">
      </form>
      <a href="reset.jsp?type=interface&item=<%out.println(intid);%>"></a><button class="btn btn-info pull-right">Reset Counter</button></a>
      </div>
    </div>
  </div>
</section>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("vlan")) { %>
<%! public String vintid = "", vname = "", vtype = "", vmtu = "", vmtul2 = "", vlid = "";  %>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Edit VLAN
    <small>Update VLAN Information</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="hotspot.jsp?q=walledgarden">Vlan</a></li>
    <li class="active">Update</li>
  </ol>
</section>

<section class="content-header">
	<div class="panel box box-primary">
    <div class="box-header with-border">
      <h4 class="box-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Edit VLAN
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse-in">
      <div class="box-body">
      <%	
      	String id = request.getParameter("item");
      	
      	for (Map<String,String> mp : g.getVlan(id)) {
      		//System.out.println(mp);
    		vintid = mp.get(".id"); 
    		vname = mp.get("name"); 
    		vtype = mp.get("type"); 
    		vmtu = mp.get("mtu"); 
    		vlid = mp.get("vlan-id"); 
    	}
      	//System.out.println(wgsid);
	  %>
      <form action="/update.jsp" method="post">
      	<div class="form-group">
            <label>ID</label>
      		<input type="text" name="intid" id="intid" readonly class="form-control" value="<% out.println(vintid); %>"><br />
      	</div>
      	<div class="form-group">
      		<label>Interface Name:</label>
			<input type="text" class="form-control" name="intname" id="intname" value="<% out.println(vname); %>"><br />
		</div>
		<div class="form-group">
            <label>VLAN ID</label>
      		<input type="text" name="vlid" id="vlid" class="form-control" value="<% out.println(vlid); %>"><br />
      	</div>
		<div class="form-group">
      		<label>Interface Type:</label>
			<input type="text" readonly class="form-control" name="inttype" id="inttype" value="vlan"><br />
		</div>
			<input type="hidden" class="form-control" name="mtu" value="<% out.println(vmtu); %>"><br />
      	<input type="submit" id="submit" name="submit" class="btn btn-success col-md-9" value="Update VLAN">
      </form>
      <a href="reset.jsp?type=interface&item=<%out.println(vintid);%>"><button class="btn btn-info pull-right">Reset Counter</button></a>
      </div>
    </div>
  </div>
</section>
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("dns")) { %>
	<%! public String did = "", dname = "", daddr = "", dttl = "";  %>
	
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Edit Static DNS
        <small>Update Static DNS Entry</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">DNS</a></li>
        <li class="active">Edit</li>
      </ol>
    </section>
    
    <section class="content-header">
		<div class="panel box box-primary">
        <div class="box-header with-border">
          <h4 class="box-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
              Edit DNS
            </a>
          </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse-in">
          <div class="box-body">
          <%	String did = request.getParameter("item");
		      	for (Map<String,String> mp : g.getDNS(did)) {
		    		
		    		did = mp.get(".id"); 
		    		dname = mp.get("name"); 
		    		daddr = mp.get("address"); 
		    		dttl = mp.get("ttl"); 
		    	}
		 %>
          <form action="update.jsp" method="post">
          	<div class="form-group">
                <label>ID</label>
          		<input type="text" name="did" id="did" class="form-control" value="<% out.println(did); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Name</label>
          		<input type="text" name="dname" id="dname" class="form-control" value="<% out.println(dname); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Address</label>
          		<input type="text" name="daddr" id="daddr" class="form-control" value="<% out.println(daddr); %>"><br />
          	</div>
          	<div class="form-group">
                  <label>TTL</label>
                  <input type="text" name="dttl" id="dttl" class="form-control" value="<% out.println(dttl); %>"><br />
            </div>
            
          	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update DNS">
          </form>
          </div>
        </div>
      </div>
	</section>
	
<%}%>
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