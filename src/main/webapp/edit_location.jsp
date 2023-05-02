<%@include file="header.jsp" %>

 <body class="hold-transition skin-blue layout-boxed sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>      
<!-- =============================================== -->
<div class="content-wrapper">
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Interface")) {
	
	try {
		String intid = request.getParameter("intid");
		String ipid = request.getParameter("ipid");
		String dhcpid = request.getParameter("dhcpid");
		String dnetid = request.getParameter("dnetid");
		String hsid = request.getParameter("hsid");
		String hspid = request.getParameter("hspid");
		String pid = request.getParameter("poolid");
		String intname = request.getParameter("intname");
		String inttype = request.getParameter("inttype");
		String mtu = request.getParameter("mtu");
		
		String pn = intname+"_pool";
		String dhcpn = intname+"_dhcp";
		String hsname = intname+"_hotspot";
		String hspname = intname+"_hsp";
		
		String command = "/interface/set name="+intname+" .id="+intid;
		if(g.quickCommand(command)!=null){
			String ipcom = "/ip/address/set comment='"+intname+"' .id="+ipid;
			String poolcom = "/ip/pool/set name='"+pn+"' .id="+pid;
			String dhcpcom = "/ip/dhcp-server/set name='"+dhcpn+"' .id="+dhcpid;
			String dnetcom = "/ip/dhcp-server/network/set comment='"+intname+"' .id="+dnetid;
			String hscom = "/ip/hotspot/set name='"+hsname+"' .id="+hsid;
			String hspcom = "/ip/hotspot/profile/set name='"+hspname+"' .id="+hspid;
			
			String[] coms = {ipcom, poolcom, dhcpcom, dnetcom, hscom, hspcom};
			
			for(String c: coms){
				g.quickCommand(c);
			}
		}
		
		String logact = "Interface "+intname+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("locations.jsp");
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<%
String intid = "", intname = "", inttype = "", mtu = "", mtu12 = "", ipsetid = "", poolid = "", dhcpid = "", dnetid = "", hsid = "", hspid = "";  
if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("type").equals("interface")) {
	String id = request.getParameter("item");
	String name = request.getParameter("location");
  	
  	for (Map<String,String> mp : g.getInterface(id)) {
  		//System.out.println(mp);
		intid = mp.get(".id"); 
		intname = mp.get("name"); 
		inttype = mp.get("type"); 
		mtu = mp.get("mtu"); 
		mtu12 = mp.get("l2mtu"); 
	}
  	
  	for (Map<String,String> mp : g.getIpByName(name)) {
  		ipsetid = mp.get(".id");
  	}
  	
    String com = "/ip/pool/print where name="+name+"_pool";
  	for (Map<String,String> mp : g.quickCommand(com)) {
		poolid = mp.get(".id");
  	}
  	
	String hsc = "/ip/hotspot/print where name="+name+"_hotspot";
  	for (Map<String,String> mp : g.quickCommand(hsc)) {
  		hsid = mp.get(".id"); 
  	}
  	
	String hspc = "/ip/hotspot/profile/print where name="+name+"_hsp";
  	for (Map<String,String> mp : g.quickCommand(hspc)) {
  		hspid = mp.get(".id");
  	}
  	
  	String dnetc = "/ip/dhcp-server/network/print where comment="+name;
  	for (Map<String,String> mp : g.quickCommand(dnetc)) {
  		dnetid = mp.get(".id");
  	}
  	
  	String dhcpc = "/ip/dhcp-server/print where name="+name+"_dhcp";
  	for (Map<String,String> mp : g.quickCommand(dhcpc)) {
  		dhcpid = mp.get(".id");
  	}
}
%>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Edit Location
    <small><% out.print("Editing - INT: "+intid+" IPA: "+ipsetid+" DP: "+poolid+" DHCP: "+dhcpid+" DNET: "+dnetid+" HS: "+hsid+" HSP: "+hspid); %></small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="locations.jsp">Location</a></li>
    <li class="active">Edit</li>
  </ol>
</section>

<section class="content">
	<div class="panel box box-primary">
    <div class="box-header with-border">
      <h4 class="box-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Edit Location
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
    		
    	}
      	//System.out.println(wgsid);
	  %>
      <form action="edit_location.jsp" method="post">
      	<div class="form-group">
      		<input type="hidden" name="intid" id="intid" readonly class="form-control" value="<%= intid %>">
      		<input type="hidden" name="ipid" id="ipid" readonly class="form-control" value="<%= ipsetid %>">
      		<input type="hidden" name="dhcpid" id="dhcpid" readonly class="form-control" value="<%= dhcpid %>">
      		<input type="hidden" name="dnetid" id="dnetid" readonly class="form-control" value="<%= dnetid %>">
      		<input type="hidden" name="hsid" id="hsid" readonly class="form-control" value="<%= hsid %>">
      		<input type="hidden" name="hspid" id="hspid" readonly class="form-control" value="<%= hspid %>">
      		<input type="hidden" name="poolid" id="poolid" readonly class="form-control" value="<%= poolid %>">
      		<input type="hidden" class="form-control" name="inttype" id="inttype" value="<%= inttype %>">
      		<input type="hidden" class="form-control" name="mtu" id="mtu" value="<%= mtu %>">
      	</div>
      	<div class="form-group">
      		<label>Location Name:</label>
			<input type="text" class="form-control" name="intname" id="intname" value="<% out.println(intname); %>"><br />
		</div>
      	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Update Interface">
      </form>
      <a href="reset.jsp?type=interface&item=<%out.println(intid);%>"></a><button class="btn btn-info pull-right">Reset Counter</button></a>
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