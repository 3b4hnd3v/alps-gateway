<!-- =============================================== -->
<%@page import="
javax.servlet.*,
java.util.Date,
java.io.*,
java.util.*,
java.sql.Connection,
java.sql.DriverManager,
java.sql.ResultSet,
java.sql.SQLException,
java.sql.Statement,
java.sql.ResultSetMetaData,
com.alps.Dao,
java.util.HashMap,
java.sql.PreparedStatement"
%>
<%
Dao sdao = new Dao();
HashMap<String, String> hm = new HashMap<String, String>();
String serialno="", sysver="";

try{
	hm = sdao.getMenuItems();
	serialno = sdao.getSetting("serialno");
	sysver = sdao.getDashValue("version");
}catch(Exception e){}
%>

<!-- Left side column. contains the sidebar -->
<aside class="main-sidebar">
  <!-- sidebar: style can be found in sidebar.less -->
  <section class="sidebar">
    <!-- Sidebar user panel -->
    <div class="user-panel">
      <div class="pull-left image">
        <img src="dist/img/avatar5.png" class="img-circle" alt="User Image">
      </div>
      <div class="pull-left info">
        <p><% out.println(session.getAttribute("name")+"-"+session.getAttribute("dept"));%></p>
        <p></p>
        <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
      </div>
    </div>
    <!-- search form -->
    
    <!-- /.search form -->
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu" >
      <li class="header text-danger">MAIN NAVIGATION</li>
      <li id="index">
       <a href="index.jsp">
       	<i class="fa fa-dashboard text-blue"></i> 
       		<span>AMAC</span>
       		 <i class="fa fa-angle-left pull-right"></i>
       </a>
      </li>
      <li id="tool">
       <a href="toolmain.jsp">
       		<i class="fa fa-wrench text-blue"></i> 
       		<span>ALPS Tools</span>
       		<i class="fa fa-angle-left pull-right"></i>
       </a>
      </li>
      <li id="gwsetting" class="treeview">
        <a href="#">
          <i class="fa fa-cogs text-blue"></i> <span>System Settings</span> <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="quickset.jsp"><i class="fa fa-circle-o"></i>System Preferences</a></li>
          <li><a href="license_mgt.jsp"><i class="fa fa-circle-o"></i>System License</a></li>
          <!-- <li><a href="dhcpws.jsp"><i class="fa fa-circle-o"></i>Admin Port</a></li> -->
        </ul>
      </li>
      <li class="header">WAN NETWORK</li>
      <%if(hm.get("multiwan").toString() != null && hm.get("multiwan").toString().equals("1")) { %>
      <li id="multiwan">
        <a href="multiwan_int.jsp">
          <i class="fa fa-code-fork text-yellow"></i> <span>WAN Interfaces</span>
          <i class="fa fa-angle-right pull-right"></i>
        </a>
      </li>
      <li id="ipchange">
      	<a href="ipchange.jsp">
      		<i class="fa fa-slack text-success"></i> <span>WAN IP Setup</span>
      		<i class="fa fa-angle-right pull-right"></i>
      	</a>
      </li>
      <li id="dns_servers">
      	<a href="dns_servers.jsp">
      		<i class="fa fa-database text-danger"></i> <span>Gateway DNS</span>
      		<i class="fa fa-angle-right pull-right"></i>
      	</a>
      </li>
      <%}%>
      <li class="header">LAN NETWORK</li>
      <% if(hm.get("hs_mgt").toString() != null && hm.get("hs_mgt").toString().equals("1")) { %>
      <li id="hotspot" class="treeview">
        <a href="#">
          <i class="fa fa-rss-square text-red"></i>
          <span>Access Config</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="hotspot.jsp?q=users"><i class="fa fa-circle-o"></i> Users</a></li>
          <li><a href="hotspot.jsp?q=userprofiles"><i class="fa fa-circle-o"></i> Gateway Plans</a></li>
          <li><a href="hotspot.jsp?q=activeusers"><i class="fa fa-circle-o"></i> Active Devices</a></li>
          <li><a href="hotspot.jsp?q=hosts"><i class="fa fa-circle-o"></i> Pre-Auth Devices</a></li>
          <li><a href="hotspot.jsp?q=throttled"><i class="fa fa-circle-o"></i> Throttled</a></li>
          <li><a href="hotspot.jsp?q=walledgarden"><i class="fa fa-circle-o"></i> Walled Garden</a></li>
          <li><a href="hotspot.jsp?q=cookies"><i class="fa fa-circle-o"></i> Stored Sessions</a></li>
        </ul>
      </li>
      <li id="schedb">
        <a href="sched_bypass.jsp">
          <i class="fa fa-clock-o text-blue"></i> <span>Schedule Bypass</span>
          <i class="fa fa-angle-right pull-right"></i>
        </a>
      </li> 
      <%} %>
      <% if(hm.get("hs_server").toString() != null && hm.get("hs_server").toString().equals("1") && session.getAttribute("role").equals("Super")) { %>
      <li id="hs_server" class="treeview">
        <a href="#">
          <i class="fa fa-cubes text-green"></i>
          <span>Network Servers</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="hs_server.jsp?q=servers"><i class="fa fa-circle-o"></i> Servers</a></li>
          <li><a href="hs_server.jsp?q=serverprofiles"><i class="fa fa-circle-o"></i> Server profiles</a></li>
          <li><a href="hs_server.jsp?q=dhcp"><i class="fa fa-circle-o"></i> DHCP Server</a></li>
          <li><a href="hs_server.jsp?q=ipaddress"><i class="fa fa-circle-o"></i> Server Address</a></li>
        </ul>
      </li>
      <%} %>
      <% if(hm.get("ip").toString() != null && hm.get("ip").toString().equals("1")) { %>
      <li id="ippadd" class="treeview">
        <a href="#">
          <i class="fa fa-connectdevelop text-yellow"></i>
          <span>IP Lists</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="ippadd.jsp?q=arp"><i class="fa fa-circle-o"></i> ARP</a></li>
          <li><a href="ippadd.jsp?q=around"><i class="fa fa-circle-o"></i> Neighboring Devices </a></li>
          <!-- <li><a href="ippadd.jsp?q=pooSettingl"><i class="fa fa-circle-o"></i> Pool</a></li> -->
          <li><a href="ippadd.jsp?q=lease"><i class="fa fa-circle-o"></i> Assigned IPs</a></li>
        </ul>
      </li>
      <li id="dns" class="treeview">
        <a href="#">
          <i class="fa fa-database text-orange"></i>
          <span>Internal DNS</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="dns.jsp?q=dnssettings"><i class="fa fa-circle-o"></i> Settings</a></li>
          <li><a href="dns.jsp?q=dnsstatic"><i class="fa fa-circle-o"></i> Static</a></li>
          <li><a href="dns.jsp?q=dns"><i class="fa fa-circle-o"></i> Cache</a></li>
        </ul>
      </li>
      <%} %>
      <% if(hm.get("interface").toString() != null && hm.get("interface").toString().equals("1")) { %>
      <li id="interfaces">
      	<a href="vlan_bypass.jsp">
          <i class="fa fa-refresh text-blue"></i>
          <span>Bypassed VLANs</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
      </li>
      <!-- <li id="interfaces" class="treeview">
        <a href="#">
          <i class="fa fa-share-alt text-blue"></i>
          <span>Interface</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="interfaces.jsp?q=interfaces"><i class="fa fa-circle-o"></i>Interface Addresses</a></li>
          <li><a href="interfaces.jsp?q=vlan"><i class="fa fa-circle-o"></i> Vlan</a></li>
          <li><a href="interfaces.jsp?q=bridge"><i class="fa fa-circle-o"></i> Bridges</a></li>
          <li><a href="interfaces.jsp?q=bypassed"><i class="fa fa-circle-o"></i> Vlan Bypass</a></li>
        </ul>
      </li> -->
      <%} %>
      <li class="header">Policy</li>
      <% if(hm.get("location-zoning").toString() != null && hm.get("location-zoning").toString().equals("1")){%>
      <li id="loc">
        <a href="zone_manager.jsp">
          <i class="fa fa-sitemap text-green"></i> <span>Zone Manager</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
      </li>
      <!-- <li id="loc" class="treeview">
        <a href="#">
          <i class="fa fa-sitemap text-green"></i> <span>Zones</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="locations.jsp"><i class="fa fa-circle-o"></i>Locations</a></li>
          <li><a href="new_location.jsp"><i class="fa fa-circle-o"></i>Add Location</a></li>
          <li><a href="add_vlan.jsp"><i class="fa fa-circle-o"></i>Location VLAN</a></li>
        </ul>
      </li> -->
      <%}%>
      <%if(hm.get("firewall").toString() != null && hm.get("firewall").toString().equals("1")) { %>
       <li id="firewall" class="treeview">
        <a href="#">
          <i class="fa fa-fire text-red"></i> <span>Filtering</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="firewall.jsp?q=webfiltering"><i class="fa fa-circle-o"></i>Web Filter</a></li>
          <li><a href="firewall.jsp?q=devicefiltering"><i class="fa fa-circle-o"></i>Device Filter</a></li>
          <li><a href="firewall.jsp?q=keyfiltering"><i class="fa fa-circle-o"></i>Keyword Filter</a></li>
          <li><a href="firewall.jsp?q=filterreport"><i class="fa fa-circle-o"></i>Filter Report</a></li>
        </ul>
      </li>
      <%}%>
      
      <%if(hm.get("backup").toString() != null && hm.get("backup").toString().equals("1")) { %>
      <li id="backup">
        <a href="backup.jsp">
          <i class="fa fa-download text-orange"></i> <span>Back Up &amp; Restore</span>
          <i class="fa fa-angle-left pull-right text-danger"></i>
        </a>
      </li>
      <%}%>
      <% if(hm.get("content_mgt").toString() != null && hm.get("pms").toString().equals("1")) { %>
      <li id="pms_mgt">
        <a href="pms_mgt.jsp">
          <i class="fa fa-gear text-blue"></i> <span>PMS Integration</span>
          <i class="fa fa-angle-right pull-right"></i>
        </a>
      </li>
      <%}%>
      <%if(hm.get("subscription").toString() != null && hm.get("subscription").toString().equals("1")) { %>
       <li id="subscr" class="treeview">
        <a href="#">
          <i class="fa fa-sitemap text-green"></i> <span>Subscription</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="subscribers.jsp"><i class="fa fa-circle-o"></i>Subscribers</a></li>
          <li><a href="subplans.jsp"><i class="fa fa-circle-o"></i>Plans</a></li>
          <li><a href="subbills.jsp"><i class="fa fa-circle-o"></i>Billing</a></li>
        </ul>
      </li>
      <%}%>
      <li class="header">Portal Control</li>
      <% if(hm.get("quickads").toString() != null && hm.get("quickads").toString().equals("1")) { %>
      <li id="quickads">
        <a href="quick_ads.jsp">
          <i class="fa fa-bullhorn text-blue"></i> <span>Quick Ads</span>
          <i class="fa fa-angle-right pull-right"></i>
        </a>
      </li>
      <%}%>
      <% if(hm.get("content_mgt").toString() != null && hm.get("content_mgt").toString().equals("1")) { %>
      <!-- <li id="content_mgt">
        <a href="content_mgt.jsp">
          <i class="fa fa-image text-blue"></i> <span>Content Management</span>
          <i class="fa fa-angle-right pull-right"></i>
        </a>
      </li> -->
      <li id="content_mgt" class="treeview">
        <a href="#">
          <i class="fa fa-code-fork text-yellow"></i> <span>Guest Captive</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="captive.jsp"><i class="fa fa-circle-o"></i>Captive Type</a></li>
          <li><a href="captive_set.jsp"><i class="fa fa-circle-o"></i>Captive Preferences</a></li>
        </ul>
      </li>
      <%} if(hm.get("qrcode").toString() != null && hm.get("qrcode").toString().equals("1")) { %>
      
      <li id="qrcode" class="treeview">
        <a href="#">
          <i class="fa fa-qrcode text-yellow"></i>
          <span>QRCODE Generator</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="qrcode_gen.jsp"><i class="fa fa-circle-o"></i>Auto Generator</a></li>
          <li><a href="wifiqr.jsp"><i class="fa fa-circle-o"></i>Wi-Finder</a></li>
          <!-- <li><a href="customqr.jsp"><i class="fa fa-circle-o"></i>My Custom Code</a></li> -->
        </ul>
      </li>
      <%} %>
     
      <%if(hm.get("ebs").toString() != null && hm.get("ebs").toString().equals("1")) { %>
      <li class="header">EBS</li>
      <%} %>
     
      <%if(hm.get("guestroom").toString() != null && hm.get("guestroom").toString().equals("1")) { %>
      <li id="guest_room" class="treeview">
        <a href="#">
          <i class="fa fa-tag text-green"></i>
          <span>Plan Management</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="guest_room.jsp?q=gr_plans"><i class="fa fa-circle-o"></i>Guest Plans</a></li>
          <li ><a href="guest_room.jsp?q=gw_plans"><i class="fa fa-circle-o"></i>Gateway Plans</a></li>
          
        </ul>
      </li>
      <%} %>
      <%if(hm.get("manualvoucher").toString() != null && hm.get("manualvoucher").toString().equals("1")) { %>
      <li id="manv" class="treeview">
        <a href="#">
          <i class="fa fa-cc text-orange"></i>
          <span>Manual Voucher</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li ><a href="man_voucher.jsp"><i class="fa fa-circle-o"></i>Manual Voucher</a></li>
          <li ><a href="gen_voucher.jsp"><i class="fa fa-circle-o"></i>Voucher Generator</a></li>
          <li ><a href="man_voucher_sales.jsp"><i class="fa fa-circle-o"></i>Manual Voucher Sales</a></li>
        </ul>
      </li>
      <!--  <li class="header"><hr></li>-->
     <%} %>
     <%if(hm.get("conference").toString() != null && hm.get("conference").toString().equals("1")) { %>
      <li id="conf" class="treeview">
        <a href="#">
          <i class="fa fa-group text-orange"></i>
          <span>Conference Management</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="events.jsp"><i class="fa fa-circle-o"></i>Events</a></li>
          <li ><a href="conf_rooms.jsp"><i class="fa fa-circle-o"></i>Conference Rooms</a></li>
          <li ><a href="conf_sched.jsp"><i class="fa fa-circle-o"></i>Conference Schedule</a></li>
          <li ><a href="conf_sales.jsp"><i class="fa fa-circle-o"></i>Conference Purchases</a></li>
        </ul>
      </li>
     <%} %>
     <% if(hm.get("analytics").toString() != null && hm.get("analytics").toString().equals("1")) { %>
     <li class="header">Analytics</li>
     <%} %>
     <% if(hm.get("guest_mgt").toString() != null && hm.get("guest_mgt").toString().equals("1")) { %>
      <li id="guest_mgt" class="treeview">
        <a href="#">
          <i class="fa fa-user text-blue"></i>
          <span>Analytic Reports</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li><a href="social.jsp"><i class="fa fa-circle-o"></i>Social Auth</a></li>
          <li ><a href="guest.jsp"><i class="fa fa-circle-o"></i>Device Login</a></li>
        </ul>
      </li>
      <%}%>
      <%if(hm.get("report").toString() != null && hm.get("report").toString().equals("1")) { %>
      <li id="net_reports">
        <a href="net_reports.jsp">
          <i class="fa fa-line-chart text-green"></i> <span>Network Reports</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
      </li>
      <li id="reports">
        <a href="reports.jsp">
          <i class="fa fa-area-chart text-red"></i> <span>System Monitor</span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
      </li>
     <%} %>
      <% if(hm.get("prepaid").toString() != null && hm.get("prepaid").toString().equals("1")) { %>
      <li class="header">Alps Prepaid</li>
      <li id="prepaid" class="treeview">
        <a href="#">
          <i class="fa fa-money text-red"></i>
          <span>Alps Prepaid</span>
          <span class="label label-primary pull-right">Premium</span>
        </a>
        <ul class="treeview-menu">
          <li><a href="activate_purchase.jsp"><i class="fa fa-circle-o"></i>Activate Purchase</a></li>
          <li ><a href="manage_pp.jsp"><i class="fa fa-circle-o"></i> Manage Prepaid</a></li>
        </ul>
      </li>
      <%} %>
      <% if(session.getAttribute("role") != null && session.getAttribute("role").equals("Super") && hm.get("su").toString() != null && hm.get("su").toString().equals("1")) { %>
      <li id="super" class="treeview">
        <a href="#">
          <i class="fa fa-user-secret text-blue"></i>
          <span>Super User</span>
          <span class="label label-primary pull-right">Super</span>
        </a>
        <ul class="treeview-menu">
          <li ><a href="ippadd.jsp?q=services"><i class="fa fa-circle-o"></i> Services</a></li>
          <li><a href="module_admin.jsp"><i class="fa fa-circle-o"></i>Manage Modules</a></li>
          <li ><a href="license_admin.jsp"><i class="fa fa-circle-o"></i> Manage License</a></li>
          <li><a href="mwsettings.jsp"><i class="fa fa-circle-o"></i> Middleware Settings</a></li>
        </ul>
      </li>
      <%}%>
      <li class="header">Updates</li>
      <li id="system_update">
       <a href="system_update.jsp">
       	<i class="fa fa-download text-blue"></i> 
       	<span>Systems Update</span>
       	<i class="fa fa-angle-left pull-right"></i>
       </a>
      </li>
     <% if(hm.get("logs").toString() != null && hm.get("logs").toString().equals("1")) { %>
      <li class="header">Gateway Log</li>
      <li id="daylog">
      	<a href="daylog.jsp">
      		<i class="fa fa-clock-o text-green"></i> <span>Gateway Logs</span>
      		<i class="fa fa-angle-left pull-right"></i>
      	</a>
      </li>
      <li id="systemlog">
      	<a href="systemlog.jsp">
      		<i class="fa fa-archive text-orange"></i> <span>Systems Logs</span>
      		<i class="fa fa-angle-left pull-right"></i>
      	</a>
      </li>
      <%} %>
      <li class="header"><hr></li>
      <li><a href="login.jsp?q=logout"><i class="fa fa-sign-out text-red"></i> <span>Logout</span><i class="fa fa-circle-o text-red pull-right"></i></a></li>
      <!-- <li><a href="action.jsp?q=reboot"><i class="fa fa-power-off text-red"></i> <span>Reboot</span><i class="fa fa-circle-o text-red pull-right"></i></a></li>
      <li><a href="action.jsp?q=refresh"><i class="fa fa-refresh text-yellow"></i> <span>Refresh</span><i class="fa fa-circle-o text-red pull-right"></i></a></li> -->
      <li><a href="action.jsp?q=reboot"><i class="fa fa-power-off text-green"></i> <span>System Reboot</span><i class="fa fa-circle-o text-red pull-right"></i></a></li>
      <li class="header"><b>Serial:   <% out.println(serialno); %></b></li>
    </ul>
    <%@include file="activemod.jsp" %>
  </section>
  <!-- /.sidebar -->
</aside>
<!-- SlimScroll 1.3.0 -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- =============================================== -->