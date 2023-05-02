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
            ALPS Toolbar Home
            <small>Please follow the steps below to start up your gateway</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Toolbar Home</li>
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
	              <div class="box box-solid" style="min-height:82vh;">
	                <div class="box-header with-border">
	                  <h3 class="box-title">Our Features</h3>
	                  <div class="box-tools">
	                    <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	                  </div>
	                </div>
	                <div class="box-body no-padding">
	                  <ul class="nav nav-pills nav-stacked">
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Plug And Play <span class="label label-primary pull-right">12</span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Easy Deployment </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> User Friendly GUI </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Easy To Use <span class="label label-warning pull-right">65</span></a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Simplified Configurations</a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> WAN Load Balancing </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> WAN Load Balancing </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> 24 / 7 System Support </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Quality Of Service Guaranteed </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Bandwidth Usage Control </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> AAA Features Including Radius </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Beautiful Landing Pages </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Social Authentication </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-check-square-o"></i> Multiple Customizable Captive Portals </a></li>
	                    <li class="active"><a href="#"><i class="fa fa-ellipsis-h"></i> And Much More </a></li>
	                  </ul>
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
