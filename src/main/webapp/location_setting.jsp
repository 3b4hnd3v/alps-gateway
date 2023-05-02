<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<% 
Location locx = new Location();
String location = "";
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("type").equals("port")) {
	
	try {
		String item = request.getParameter("item");
		String itemname = request.getParameter("itemname");
		String locat = request.getParameter("location");
		g.removePort(item);
		g.removeVlanByName(itemname);
		
		
		String logact = "Vlan Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
				
	} catch (Exception e1) { System.out.println(e1); }
}

if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add VLAN")) {
	
	String locname = "", vlanid="", vlname = "";
	
	try {
		locname = request.getParameter("locname").toString();
		vlanid = request.getParameter("vlanid").toString();
		vlname = request.getParameter("vlname").toString();
		String interf = "LAN";
		String vact = locx.addVlan(vlanid, vlname, interf, "enabled");
		if(vact.equals("Yes")){
			locx.addPort(vlname, locname);
			response.sendRedirect("location_setting.jsp?location="+locname+"&msg=Vlan Added To Location.&type=success");
		}else if(vact.equals("Exist")){
			response.sendRedirect("location_setting.jsp?location="+locname+"&msg=Vlan Already Exist.&type=error");
		}else{
			response.sendRedirect("location_setting.jsp?location="+locname+"&msg=VLAN Can Not Be Added To Location.&type=error");
		}
		
	}catch(Exception e){
		System.out.println(e);
	}

}


if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Network Settings")) {
	try {
		String ipid = request.getParameter("ipid");
	
		String dnetid = request.getParameter("dnetid");
		String ip = request.getParameter("ipadd");
		String interf = request.getParameter("interf");
		String smask = request.getParameter("smask");
		String net = request.getParameter("net");
		String ipadd = ip+smask;
		String netmask = net+smask;
		
		String command = "/ip/dhcp-server/network/set address='"+netmask+"' gateway='"+ip+"' .id="+dnetid;
		g.quickCommand(command);
		g.updateIpadd(ipid , interf, ipadd, net);
		
	} catch (Exception e1) { System.out.println(e1); }
}

if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Pool Setting")) {
	
	try {
		String item = request.getParameter("pid");
		String pname = request.getParameter("poolname");
		String pranges = request.getParameter("ranges");
		String nextpool = request.getParameter("nextpool");
		
		g.editPool(pname,pranges,nextpool,item);
		
		String logact = "Address Pool "+pname+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
	} catch (Exception e1) { System.out.println(e1); }
}

if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Network Setting")) {
	
	try {
		String uid = request.getParameter("ipid");
		String dnid = request.getParameter("dnid");
		String interf = request.getParameter("interf");
		String ipadd = request.getParameter("ipadd");
		String net = request.getParameter("net");

		g.updateIpadd(uid , interf, ipadd, net);
		
		String logact = "Address on "+interf+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}

if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Access Setting")) {
	
	try {
		String hssid = request.getParameter("hssid");
		String hsserver = request.getParameter("hssname");
		String hssprof = request.getParameter("hssprof");
		String hssint = request.getParameter("hssint");
		String pool = request.getParameter("pool");
		String apm = request.getParameter("apm");
		String kato = request.getParameter("kato");
		String idto = request.getParameter("idto");
		
		g.updateHsserver(hssid , hsserver, hssprof, hssint, pool, apm, kato, idto);
		
		String logact = "Hostspot Server "+hsserver+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}

if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Network Profile Setting")) {
	
	try {
		String hspid = request.getParameter("hspid");
		String hsprof = request.getParameter("hsprof");
		String hsadd = request.getParameter("hsadd");
		String hsdir = request.getParameter("htmldir");
		String dnsname = "";
		String[] lb = request.getParameterValues("lb");
		String cookieto = request.getParameter("cookieto");
		String smtps = "0.0.0.0";
		String ratelim = request.getParameter("ratelim");
		String htproxy = request.getParameter("htproxy");
		String loginby = "";
		for(String l: lb){
			if(loginby==""){loginby = l;}
			else{loginby = loginby+","+l;}
		}
		
		g.updateHsserverProf(hspid, hsprof, hsadd, hsdir, dnsname, loginby, cookieto, smtps, ratelim, htproxy);

		String logact = "Hotspot Server Profile "+hsprof+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}


if(request.getParameter("location") != null){ 
	location = request.getParameter("location");
}else{
	
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

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Location Settings
    <small>Manage Location Settings</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Network</a></li>
    <li><a href="#">Zone</a></li>
    <li class="active">Setting</li>
  </ol>
</section>

<!-- Table List -->
<section class="content" style="margin-top:20px;">
  <div class="row">
    <div class="col-md-12"><!-- /.box -->
    <!-- /Location -->
    
    <!-- /IP nd Net -->
    <div class="panel box box-primary">
        <div class="box-header with-border">
          <h4 class="box-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseNet">
              <%= location %> Network Setting
            </a>
          </h4>
        </div>
        <div id="collapseNet" class="panel-collapse collapse">
          <div class="box-body">
          	<%
          	for (Map<String,String> mp : g.getIpByName(location)) {
          		String id = mp.get(".id");
          		String ipadd = mp.get("address");
          		String network = mp.get("network");
          		String interf = mp.get("interface");
			%>
				<form action="location_setting.jsp?location=<%= location %>" method="post">
		      		<input type="hidden" name="ipid" id="ipid" readonly class="form-control col-md-5" value="<% out.println(id); %>"><br />
		      		<%
					String com = "/ip/dhcp-server/network/print where comment="+location;
			      	for (Map<String,String> mpn : g.quickCommand(com)) {
			      	%>
			      	<input type="hidden" name="dnetid" id="dnetid" readonly class="form-control col-md-5" value="<% out.println(mpn.get(".id")); %>">
			      	<%}%>
			      	<div class="form-group">
		                <label>Location</label>
		          		<input type="text" name="interf" id="interf" class="form-control" value="<%= interf %>"><br />
		          	</div>
			      	<div class="row">
				      	<div class="form-group col-sm-7">
				      		<label>IP Address:</label>
							<input type="text" class="form-control" name="ipadd" id="ipadd" value="<% out.println(ipadd.split("/")[0]); %>"><br />
						</div>
						<div class="form-group col-sm-5">
					      	<label>Subnet Mask</label>
					      	<select class="form-control" name="smask">
					      	<option><% out.println("/"+ipadd.split("/")[1]); %></option>
					      	<option> </option>
					      	<% 
				               	for (int i = 0; i<=30; i++) {
				                	out.println("<option>/"+i+"</option>");
				               	}
			                 %>
							</select>
						</div>
					</div>
					<div class="form-group">
			      		<label>Network:</label>
						<input type="text" class="form-control" name="net" id="net" value="<% out.println(network); %>"><br />
					</div>
			      	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Network Settings">
			    </form>
          	<%}%>
          </div>
        </div>
    </div>
    	
    <!-- /Hotspot Server -->
    <div class="panel box box-primary">
        <div class="box-header with-border">
          <h4 class="box-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
              <%= location %> IP Pool Setting
            </a>
          </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse">
          <div class="box-body">
          <%	
          	String lpool = location+"_pool";
            String com = "/ip/pool/print where name="+lpool;
          	
	      	for (Map<String,String> mp : g.quickCommand(com)) {
	    		
	    		String poolid = mp.get(".id"); 
	    		String pname = mp.get("name"); 
	    		String prange = mp.get("ranges"); 
	    		String nextpool = mp.get("next-pool"); 
	    	
		 %>
		         <form action="location_setting.jsp?location=<%= location %>" method="post">
		          	<input type="hidden" name="pid" id="pid" class="form-control" value="<% out.println(poolid); %>"><br />
		          	<div class="form-group">
		                <label>Pool Name</label>
		          		<input type="text" name="poolname" readonly id="poolname" class="form-control" value="<% out.println(pname); %>"><br />
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
		                  	for (Map<String,String> mps : g.pool()) {
					  		String s = mps.get("name");
		                    out.println("<option>"+s+"</option>");
		                  	}
		                    %>
		                  </select>
		                  <p class="alert">Make sure you change from "Current = xxxxx"</p>
		                </div>
		          	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Pool Setting">
		          </form>
          <%} %>
          </div>
        </div>
      </div>
    
    <!-- /Hotspot Profile -->
    <div class="panel box box-primary">
        <div class="box-header with-border">
          <h4 class="box-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseHs">
              <%= location %> Network Access Setting
            </a>
          </h4>
        </div>
        <div id="collapseHs" class="panel-collapse collapse">
          <div class="box-body">
          <%	String lhs = location+"_hotspot";
          		String hsc = "/ip/hotspot/print where name="+lhs;
		      	for (Map<String,String> mp : g.quickCommand(hsc)) {
		    		
		      		String hssid = mp.get(".id"); 
		      		String hssname = mp.get("name"); 
		      		String hssprof = mp.get("profile"); 
		      		String hssint = mp.get("interface"); 
		      		String hsspool = mp.get("address-pool"); 
		      		String apm = mp.get("addresses-per-mac");
		      		String idto = mp.get("idle-timeout");
		      		String kato = mp.get("keepalive-timeout");
		    	
		 %>
          <form action="location_setting.jsp?location=<%= location %>" method="post">
          	<input type="hidden" name="hssid" id="hssid" readonly class="form-control" value="<% out.println(hssid); %>"><br />
          	<div class="form-group">
                <label>Name</label>
          		<input type="text" name="hssname" readonly id="hssname" class="form-control" value="<% out.println(hssname); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Profile</label>
          		<input type="text" name="hssprof" readonly id="hssprof" class="form-control" value="<% out.println(hssprof); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Interface</label>
          		<input type="text" name="hssint" readonly id="hssint" class="form-control" value="<% out.println(hssint); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Pool</label>
          		<input type="text" name="pool" readonly id="pool" class="form-control" value="<% out.println(hsspool); %>"><br />
          	</div>
          	<div class="row">
	          	<div class="form-group col-md-4">
	                <label>Address Per Mac</label>
	          		<input type="text" name="apm" id="apm" class="form-control" value="<% out.println(apm); %>"><br />
	          	</div>
	          	<div class="form-group col-md-4">
	                <label>Keep Alive</label>
	          		<input type="text" name="kato" id="kato" class="form-control" value="<% out.println(kato); %>"><br />
	          	</div>
	          	<div class="form-group col-md-4">
	                <label>Idle Timeout</label>
	          		<input type="text" name="idto" id="idto" class="form-control" value="<% out.println(idto); %>"><br />
	          	</div>
          	</div>
          	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Access Setting">
          </form>
          <%} %>
          </div>
        </div>
      </div>
    
    <!-- /Hotspot Server Profile -->
    <div class="panel box box-primary">
        <div class="box-header with-border">
          <h4 class="box-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseHsp">
              <%= location %> Network Profile Setting
            </a>
          </h4>
        </div>
        <div id="collapseHsp" class="panel-collapse collapse">
          <div class="box-body">
          <%	
          		String lhsp = location+"_hsp";
    			String hspc = "/ip/hotspot/profile/print where name="+lhsp;
		      	for (Map<String,String> mp : g.quickCommand(hspc)) {
		    		//System.out.println(mp);
		      		String hspid = mp.get(".id"); 
		      		String hspname = mp.get("name"); 
		      		String hsadd = mp.get("hotspot-address"); 
		      		String htdir = mp.get("html-directory"); 
		      		String dnsname = mp.get("dns-name"); 
		      		String loginby = mp.get("login-by");
		      		String cookieto = mp.get("http-cookie-lifetime");
		      		String smtps = mp.get("smtp-server");
		      		String ratelim = mp.get("rate-limit");
		      		String htproxy = mp.get("http-proxy");
		 %>
          <form action="location_setting.jsp?location=<%= location %>" method="post">
          	<input type="hidden" name="hspid" id="hspid" readonly class="form-control" value="<% out.println(hspid); %>"><br />
          	<div class="form-group">
                <label>Profile Name</label>
          		<input type="text" name="hsprof" id="hsprof" readonly class="form-control" value="<% out.println(hspname); %>"><br />
          	</div>
          	<div class="form-group">
                <label>Hotspot Address</label>
          		<input type="text" name="hsadd" id="hsadd"  class="form-control" value="<% out.println(hsadd); %>"><br />
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
	       		<label>Allowed Authentication Methods</label>
	       		<div>
                    <label class="checkbox-inline">
                        <input type="checkbox" name="lb" checked id="inlineCheckbox1" value="http-chap"> Challenge Handshake
                    </label>
                    <label class="checkbox-inline">
                        <input type="checkbox" name="lb" checked id="inlineCheckbox2" value="http-pap"> Password Auth
                    </label>
                    <label class="checkbox-inline">
                        <input type="checkbox" name="lb" checked id="inlineCheckbox3" value="cookie"> Stored Session
                    </label>
                    <label class="checkbox-inline">
                        <input type="checkbox" name="lb" checked id="inlineCheckbox3" value="https"> Secure HTTPS
                    </label>
                 </div>
	       	</div>
	       	<div class="row">
		       	<div class="form-group col-md-3">
		       		<label>Allow Radius Authentication</label>
					<select class="form-control" name="radius">
					   <option value="false">No Radius</option>
		               <option value="true">Allow Radius</option>
		            </select>
			    </div>
	          	<div class="form-group col-md-3">
	                <label>Cookie Lifetime</label>
	          		<input type="text" name="cookieto" id="cookieto" class="form-control" value="<% if(cookieto!=null){out.println(cookieto);}else{out.println();} %>"><br />
	          	</div>
	          	<div class="form-group col-md-3">
	                <label>Rate Limit</label>
	          		<input type="text" name="ratelim" id="ratelim" class="form-control" value="<% out.println(ratelim); %>">
	          		<small class="alert">X/X</small>
	          	</div>
	          	<div class="form-group col-md-3">
	                <label>HTTP - Proxy</label>
	          		<input type="text" readonly name="htproxy" id="htproxy" class="form-control" value="<% out.println(htproxy); %>"><br />
	          	</div>
          	</div>
          	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Network Profile Setting">
          </form>
          <%} %>
          </div>
        </div>
      </div>
    
    <!-- /VLAN -->
    <div class="panel box box-primary">
	    <div class="box-header with-border">
	      <h4 class="box-title">
	        <a data-toggle="collapse" data-parent="#accordion" href="#collapseO">
	          Add VLAN To <%= location %>
	        </a>
	      </h4>
	    </div>
	    <div id="collapseO" class="panel-collapse collapse">
	      <div class="box-body">
	      	<form action="location_setting.jsp?location=<%= location %>" method="post">
	      		<div class="form-group">
			      	<label>Location</label>
					<input type="text" readonly class="form-control" name="locname" value="<% out.print(location);%>"><br />
				</div>
	      		<div class="row">
		      		<div class="col-sm-6">
				      	<label>Vlan ID</label>
						<input type="text" class="form-control" name="vlanid"><br />
					</div>
					<div class="col-sm-6">
				      	<label>Vlan Name</label>
						<input type="text" class="form-control" name="vlname"><br />
					</div>      		
				</div>      		
	      		<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Add VLAN" />
		     </form>
	      </div>
	    </div>
	  </div>
	  
	  <div class="panel box box-primary">
        <div class="box-header">
          <h3 class="box-title">Vlans</h3>
        </div><!-- /.box-header -->
        <div class="box-body table-responsive">
          <table id="example1" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th>Name</th>
                <th>Status</th>
                <th>Disabled</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <%
               try{
            	   for (Map<String,String> mp : g.getBrigeVlan(location)) {
     				  //System.out.println(r);
     				  	String s = mp.get(".id");
     				  	String btn_dl = "<a href='?location="+location+"&q=delete&type=port&item="+s+"&itemname="+mp.get("interface")+"'><button class='btn btn-sm btn-danger'>Del</button></a>";
     				  	
     				  	out.println("<tr>");
     					out.println("<td>"+mp.get("interface")+"</td>");
     					out.println("<td>"+mp.get("status")+"</td>");
     					out.println("<td>"+mp.get("disabled")+"</td>");
     					out.println("<td>"+btn_dl+"</td>");						
     					out.println("</tr>");
     				}
               }catch(Exception e){
            	   e.printStackTrace();
               }
            %>
            
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    
    </div>
  </div>
</section>

<!-- Table List -->
<section class="content">
  <div class="row">
    <div class="col-md-12"><!-- /.box -->

     
    </div><!-- /.col -->
  </div><!-- /.row -->
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
	$("#example1").DataTable({responsive: true});
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
<script>
	$(document).ready(function () {
	    // check whether tableExport plugin is loaded
	    if (typeof $.tableExport !== "function") {
	    	$.getScript("plugins/tableexport/tableExport.js");
	    	$.getScript("plugins/tableexport/jquery.base64.js");
	    	$.getScript("plugins/tableexport/html2canvas.js");
	    	$.getScript("plugins/tableexport/jspdf/libs/sprintf.js");
	    	$.getScript("plugins/tableexport/jspdf/jspdf.js");
	    	$.getScript("plugins/tableexport/jspdf/libs/base64.js");
	        //alert("imported");
	    }
	});
</script>
<!-- page script -->
</body>
</html>