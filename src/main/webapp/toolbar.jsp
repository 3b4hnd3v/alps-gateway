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
      <li class="header">ALPS Network QOS</li>
      <li id="multiwan">
        <a href="qos_setup.jsp">
          <i class="fa fa-cogs text-blue"></i> <span>QOS SETUP</span>
          <i class="fa fa-angle-right pull-right"></i>
        </a>
      </li>
      <li id="ipchange">
      	<a href="qos_service_priority.jsp">
      		<i class="fa fa-tasks text-green"></i> <span>QOS Priority</span>
      		<i class="fa fa-angle-right pull-right"></i>
      	</a>
      </li>
      <!-- <li id="dns_servers">
      	<a href="qos_p2p_bottleneck.jsp">
      		<i class="fa fa-code-fork text-red"></i> <span>P2P Bottleneck</span>
      		<i class="fa fa-angle-right pull-right"></i>
      	</a>
      </li>
      <li class="header">ALPS Network Utilities</li>
      <!-- Not Available For Model
      <li id="letmeout" class="treeview">
        <a href="#">
          <i class="fa fa-globe text-orange"></i>
          <span>LetMeOut<sup>TM</sup></span>
          <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
          <li>
          	<a href="letmeout_setup.jsp">
          		<i class="fa fa-circle-o"></i>
          		LetMeOut<sup>TM</sup> Setup
          	</a>
          </li>
          <li>
          	<a href="letmeout_sel_int.jsp">
          		<i class="fa fa-circle-o"></i>
          		<span>LetMeOut<sup>TM</sup></span>
          	</a>
          </li>
        </ul>
      </li>  -->
      <li id="port_forward">
      	<a href="port_forward.jsp">
      		<i class="fa fa-slack text-green"></i> 
      		<span>IP Count</span>
      		<i class="fa fa-angle-right pull-right"></i>
      	</a>
      </li>
      <li id="multiwan">
        <a href="subnet_calc.jsp">
          <i class="fa fa-calculator text-yellow"></i> <span>Subnet Calculator</span>
          <i class="fa fa-angle-right pull-right"></i>
        </a>
      </li>
      <li id="tool_netwatch">
      	<a href="tool_netwatch.jsp">
      		<i class="fa fa-binoculars text-red"></i> 
      		<span>ALPS Sense<sup>TM</sup></span>
      		<i class="fa fa-angle-right pull-right"></i>
      	</a>
      </li>
      <li class="header">ALPS Network Tools</li>
      <li id="tool_nettrace">
      	<a href="tool_nettrace.jsp">
      		<i class="fa fa-code text-blue"></i> 
      		<span>ALPS NetTrace</span>
      		<i class="fa fa-angle-right pull-right"></i>
      	</a>
      </li>
      <!-- <li id="tool_netspeed">
      	<a href="tool_netspeed.jsp">
      		<i class="fa fa-bolt text-orange"></i> 
      		<span>ALPS Net - Speed</span>
      		<i class="fa fa-angle-right pull-right"></i>
      	</a>
      </li> -->
      <li id="tool_netscan">
      	<a href="tool_ipscan.jsp">
      		<i class="fa fa-search text-green"></i> 
      		<span>ALPS HostScan</span>
      		<i class="fa fa-angle-right pull-right"></i>
      	</a>
      </li>
      <li id="forensic">
      	<a href="alps_forensic.jsp">
      		<i class="fa fa-user-md text-danger"></i> 
      		<span>ALPS Forensic<sup>TM</sup></span>
      		<i class="fa fa-angle-right pull-right"></i>
      	</a>
      </li>
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