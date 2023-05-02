<%@include file="header.jsp" %>
<%
Mao mao = new Mao();
MasterApi mg = new MasterApi();

String ave_bw = mao.getSetting("average_bandwidth");

int average_bandwidth = Integer.valueOf(ave_bw);
int max_rate = Integer.valueOf(ave_bw);
int lim_rate = max_rate / 4;

String newStatus = "Enable", newStatusVal = "false", oldStatusVal = "false";
String newP2PStatus = "Enable", newP2PStatusVal = "false";
String[] services = {"Global", "WebBrowsing", "VideoStreaming", "VOIP", "Unspecified"};
Map<String, String> services_ids = new HashMap<String, String>();
Map<String, Map<String, String>> services_objs = new HashMap<String, Map<String, String>>();
if(average_bandwidth == 0){
	response.sendRedirect("qos_setup.jsp");
}

Map<String, String> ptop = mg.getFullP2P();
String ptopIdent = ptop.get(".id");
String ptopStat = ptop.get("disabled");

if(ptopStat.equals("false")){
	newP2PStatus = "Disable";
	newP2PStatusVal = "true";
}
%>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
	<%@include file="header2.jsp" %>
	<%@include file="toolbar.jsp" %>
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            ALPS Gateway QoS Service Priority
            <small>Please follow the steps below to setup QoS on your gateway</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">QoS Priority </li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <%if(request.getParameter("msg") != null && request.getParameter("type") != null && request.getParameter("type").equals("error")){ %>
				<div class="alert alert-danger alert-dismissible">
				  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				  <h4><i class="icon fa fa-ban"></i> Oops :( !</h4>
				  <%out.println(request.getParameter("msg")); %>
				</div>
		  <%}else if(request.getParameter("msg") != null && request.getParameter("type") != null && request.getParameter("type").equals("success")){ %>
				<div class="alert alert-success alert-dismissible">
				  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				  <h4><i class="icon fa fa-info"></i> Alert!</h4>
				  <%out.println(request.getParameter("msg")); %>
				</div>
		  <%}else if(request.getParameter("msg") != null){ %>
				<div class="alert alert-info alert-dismissible">
				  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				  <h4><i class="icon fa fa-info"></i> Alert!</h4>
				  <%out.println(request.getParameter("msg")); %>
				</div>
		  <%}%>
 		  <div class="row">
			<div class="col-md-12">
			  <div class="box box-solid">
			    <div class="box-header with-border">
			      <i class="fa fa-text-width"></i>
			
			      <h3 class="box-title">Instructions</h3>
			    </div>
			    <!-- /.box-header -->
			    <div class="box-body">
			      <dl>
			        <dt>Please Read</dt>
			        <dd>To ensure proper quality or service implementation, your gateway requires thorough testing to create quality baseline.</dd>
			        <dt>Speed Test</dt>
			        <dd>We can establish your network baseline quality by performing a series of speed tests.</dd>
			        <dd>Please perform each test and enter the speed in <strong>Mbps</strong></dd>
			        <!-- <dt>Malesuada porta</dt> -->
			        <dd>After completing the tests, kindly click continue to finish the setup</dd>
			      </dl>
			    </div>
			    <!-- /.box-body -->
			  </div>
			  <!-- /.box -->
			</div>
		  </div>
          <div class="row">
	          <div class="col-md-12" style="margin-top:30px;">
	              <div class="box box-solid">
	                <div class="box-header with-border">
	                  <h3 class="box-title">QoS Setup</h3>
	                  <div class="box-tools">
	                  	<i class="fa fa-cogs"></i>
	                  </div>
	                </div>
	                
					<div class="box-body no-padding">
						<ul class="nav nav-pills nav-stacked" id="test-result-block">
						  <% 
						  for(String service : services){ 
							  Map<String, String> r = mg.getFullQOS(service);
							  services_ids.put(service, r.get(".id"));
							  services_objs.put(service, r);
							  //out.println(r);
							  if(service.equals("Global")){
								  oldStatusVal = r.get("disabled");
								  if(r.get("disabled").equals("false")){ 
									  newStatus = "Disable"; 
									  newStatusVal = "true";
								  }
							  }
							  String rate = mg.bytesIntoHumanReadable(Long.valueOf(r.get("limit-at"))) + " / " + mg.bytesIntoHumanReadable(Long.valueOf(r.get("max-limit")));
						  %>
						  
						  	<li class="active">
						  		<a href="#">
						  			<i class="fa fa-square"></i> 
						  			<%= service %>
						  			<% if(service.equals("Global")){ %>
							  			<% if(r.get("disabled").equals("false")){ %>
								  				<strong class="pull-right text-success">
							  						<%= max_rate %> (Service Enabled)
								  				</strong>
						  				<% }else{ %>
							  					<span class="pull-right text-danger">
							  						<%= max_rate %>
							  					</span>
						  				<% } %>
						  			<% }else{ %>
						  					<strong class="pull-right text-info">
						  						<%= max_rate %> / <%= lim_rate %>
							  				</strong>
						  			<% } %>
						  		</a>
						  	</li>
						  
						  <% } %>
						  
						</ul>
	                </div><!-- /.box-body -->
	                <div class="box-footer">
		              Many more skins available. <a href="http://fronteed.com/iCheck/">Documentation</a>
		            </div>
	                
	              </div><!-- /. box -->
	              
	              <!-- Forms -->
	              <!-- iCheck -->
		          <div class="box box-primary" style="margin-top:50px;">
		            <div class="box-header">
		              <h3 class="box-title">
		              	Service Priorities
		              </h3>
		            </div>
		            <form action="qos_service_action.jsp" method="post" id="setup_form">
			            <div class="box-body">
							<% for (String service: services) {
									Map<String, String> set = services_objs.get(service);//.entrySet()
									String serviceStr = service + " : " + set.get(".id");
									if(!service.equals("Global")){
							%>
							<div class="row">
								<div class="col-sm-8">
									 <div class="form-group">
									   <label>
									     <input name="service" value="<%= serviceStr %>" type="checkbox" class="minimal" style="margin-right:10px;" checked readonly />	
									     <%= serviceStr %> - <%= set.get("comment") %>							     
									   </label>
									 </div>
								 </div>
								 
								 <div class="col-sm-1 pull-right">
								 	<div class="form-group">
								 		<input type="number" name="<%= service %>_priority" value="<%= set.get("priority") %>" class="form-control" />
								 	</div>
								 </div>
							</div>
			              	<%
			              			}else{
			              	%>
			              	<div class="row">
								<div class="col-sm-8">
									 <div class="form-group">
									   <label>
									     <input name="service" value="<%= serviceStr %>" type="checkbox" class="minimal" style="margin-right:10px;" checked readonly />	
									     <%= service %> <%= set.get("comment") %>							     
									   </label>
									 </div>
								 </div>
								 
								 <div class="col-sm-1 pull-right">
								 	<div class="form-group">
								 		<input readonly type="hidden" name="<%= service %>_priority" value="<%= set.get("priority") %>" class="form-control" />
								 	</div>
								 </div>
							</div>
			              	<%
			              			}
								}
							%>
			            </div>
			            <% if(services_ids.size() == 5){%>
		                <div class="box-footer" id="continue" >
		                	<input type="hidden" name="old_status" value="<%= oldStatusVal %>" />
		                	<input type="hidden" name="new_status" value="<%= newStatusVal %>" />
		                	<input type="hidden" name="max_rate" value="<%= max_rate %>" />
		                	<input type="hidden" name="limit_rate" value="<%= lim_rate %>" />
		                	<div class="row">
			                  <div class="col-sm-<%= oldStatusVal.equals("false") ? "9" : "12" %>">
							  	<div class="form-group">
							  		<button type="submit" name="submit" value="update_qos" class='btn btn-md btn-primary col-sm-12'><%= newStatus %></button>
							  	</div>
							  </div>
							  <% if(oldStatusVal.equals("false")){%>
							  <div class="col-sm-3">
							  	<div class="form-group">
							  		<button type="submit" name="submit" value="update_qos_priorities" class='btn btn-md btn-success col-sm-12'>Update</button>
							  	</div>
							  </div>
							  <% } %>
							</div>
						</div>
						<% } %>
			            <!-- /.box-body -->
		            </form>
		          </div>
		          <!-- /.box -->
		          <form action="qos_service_action.jsp" method="post">
	                  <input name="ident" type="hidden" value="<%= ptopIdent %>" />
	                  <input name="status" type="hidden" value="<%= newP2PStatusVal %>" />
		              <div class="box box-solid">
		                <div class="box-header with-border">
		                  <h3 class="box-title">P2P Bandwidth Limit</h3>
		                  <div class="box-tools">
		                  	<button type="submit" name="submit" value="update_qos_ptop" class='btn btn-md btn-<%= newP2PStatusVal.equals("true") ? "danger" : "success" %> btn-block'><%= newP2PStatus %></button>
		                  </div>
		                </div>							
		                <div class="box-footer">
		              		On Enabling this setting, ALPS will put a bottle-neck of <strong><%= ptop.get("limit-at") %> Bytes </strong> on P2P connections
		            	</div>
		             </div><!-- /. box -->
	              </form>
	          </div><!-- /.col -->
          </div>
          
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->

      <footer class="main-footer">
		  <div class="pull-right hidden-xs">
		    <b>ALPS</b> QoS
		  </div>
		  <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">Alps Gateway</a>.</strong> All rights reserved.
	  </footer>

      <!-- Control Sidebar -->
      <aside class="control-sidebar control-sidebar-dark">
        
      </aside><!-- /.control-sidebar -->
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->
	
    <!-- jQuery 2.1.4 -->
    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js"></script>
  </body>
</html>
