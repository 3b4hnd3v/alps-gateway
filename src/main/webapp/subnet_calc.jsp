<%@include file="header.jsp" %>
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
            ALPS Subnet Calculator
            <small>Please follow the steps below to start up your gateway</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Subnet Calculator</li>
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
	          <div class="col-md-12" style="margin-top:30px;">
	              <div class="box box-solid">
	                <div class="box-header with-border">
	                  <h3 class="box-title">Subnet Calculator</h3>
	                  <div class="box-tools">
	                    <button class="btn btn-box-tool"><i class="fa fa-calculator"></i></button>
	                  </div>
	                </div>
	                <div class="box-body no-padding">
	                  <% 
	                  String cidr_add = "192.168.0.0/16";
	                  if(request.getParameter("calculate") != null){ 
	                	  cidr_add = request.getParameter("cidr_add");
	                	  SubnetUtils su = new SubnetUtils(cidr_add);
	                	  SubnetUtils.SubnetInfo si = su.getInfo();
	                	  String network = si.getAddress();
	                	  int noOfAds = si.getAddressCount();
	                	  String bcast = si.getBroadcastAddress();
	                	  String netmask = si.getNetmask();
	                	  String netadd = si.getNetworkAddress();
	                	  String high = si.getHighAddress();
	                	  String low = si.getLowAddress();
	                	  String hs_add = si.getLowAddress()+"0";
	                	  String pool_start = si.getLowAddress()+"1";
	                	  String cidr = si.getCidrSignature();
	                	  String range = pool_start+"-"+high;
	                	  String smask = su.toSlasher(netmask);
	                  %>
	                  <ul class="nav nav-pills nav-stacked">
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> Given Address <span class="pull-right"><%= cidr_add %></span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> Network Address <span class="pull-right"><%= network %></span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> Number Of Addresses <span class="pull-right"><%= noOfAds %></span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> Broadcast Address <span class="pull-right"><%= bcast %></span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> Netmask <span class="pull-right"><%= netmask %></span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> Subnet Mask <span class="pull-right">/<%= smask %></span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> Top Address <span class="pull-right"><%= high %></span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> Low Address <span class="pull-right"><%= low %></span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> Hotspot Address <span class="pull-right"><%= hs_add %></span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> Address Pool <span class="pull-right"><%= range %></span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-square"></i> CiDR Signature <span class="pull-right"><%= cidr %></span></a></li>
	                    <li class="active"><a href="#">&nbsp;</a></li>
	                    <li class="active"><a class="pull-right" href="subnet_calc.jsp">Clear</a></li>
	                  </ul>
	                  <% }else{ %>
					  <div class="col-md-12" style="padding-bottom:20px; padding-top:20px;">
						<form action="#" method="post">
							<div class="form-group">
							    <label>Address</label>
								<input type="text" class="form-control" name="cidr_add">
								<small>CiDR Notation. Example: 192.168.0.0/16</small>
							</div>
							<button type="submit" name="calculate" value="calculate" class='btn btn-lg bg-navy col-sm-12'>Add New Location</button>
						</form>
					  </div>
	                  <% } %>
	                </div><!-- /.box-body -->
	              </div><!-- /. box -->
	              
	          </div><!-- /.col -->
          </div>
          
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->

      <footer class="main-footer">
		  <div class="pull-right hidden-xs">
		    <b>ALPS</b> Start UP
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
