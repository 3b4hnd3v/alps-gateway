<%@include file="header.jsp" %>
<%
Mao mao = new Mao();
if(request.getParameter("update_qos") != null){
	String average_bandwidth = request.getParameter("average_bandwidth");
	boolean upd = mao.updateSetting("average_bandwidth", average_bandwidth);
	if(upd){
		response.sendRedirect("qos_service_priority.jsp");
	}
}
String ave_bw = mao.getSetting("average_bandwidth");
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
            ALPS Gateway QoS Setup
            <small>Please follow the steps below to setup QoS on your gateway</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">QoS Setup <%= ave_bw %></li>
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
	                    <button class="btn btn-box-tool"><i class="fa fa-calculator"></i></button>
	                  </div>
	                </div>
	                <div class="box-body" id="tester">
	                	<div class="row" style="padding-bottom:20px; padding-top:20px;">
		                  <div class="col-sm-10">
							<div class="form-group">
							    <label>Speed Test Result</label>
								<input type="number" class="form-control" id="new_test_result" />
								<small id="error_tag">e.g. 100</small>
							</div>
						  </div>
						  <div class="col-sm-2">
						  	<div class="form-group">
							    <label>&nbsp;</label>
						  		<button type="button" onclick="addNewTest()" class='btn btn-md bg-navy col-sm-12'>Add Test Result</button>
						  	</div>
						  </div>
						</div>
					</div>
					<div class="box-body no-padding">
						<ul class="nav nav-pills nav-stacked" id="test-result-block">
						  <li class="active"><a href="#"><i class="fa fa-square"></i> Speed Test 1 <span id="test_0" class="pull-right"></span></a></li>
						  <li class="active"><a href="#"><i class="fa fa-square"></i> Speed Test 2 <span id="test_1" class="pull-right"></span></a></li>
						  <li class="active"><a href="#"><i class="fa fa-square"></i> Speed Test 3 <span id="test_2" class="pull-right"></span></a></li>
						  <li class="active"><a href="#"><i class="fa fa-square"></i> Speed Test 4 <span id="test_3" class="pull-right"></span></a></li>
						  <li class="active"><a href="#"><i class="fa fa-square"></i> Speed Test 5 <span id="test_4" class="pull-right"></span></a></li>
						</ul>
						<ul class="nav nav-pills nav-stacked">
						  <li class="active"><a class="pull-right" href="qos_setup.jsp">Clear</a></li>
						  <li class="active"><a class="pull-right" id="average_bandwidth">0</a></li>
						</ul>
	                </div><!-- /.box-body -->
	                <div class="box-body" id="continue" style="display:none;">
	                	<form action="qos_setup.jsp" method="post" id="setup_form">
		                	<div class="row" style="padding-bottom:20px; padding-top:20px;">
			                  <div class="col-sm-10">
								<div class="form-group">
								    <label>Average Speed</label>
									<input type="number" class="form-control" id="ave_bandwidth" name="average_bandwidth" />
								</div>
							  </div>
							  <div class="col-sm-2">
							  	<div class="form-group">
								    <label>&nbsp;</label>
							  		<button type="submit" name="update_qos" value="submit" class='btn btn-md bg-navy col-sm-12'>Continue</button>
							  	</div>
							  </div>
							</div>
						</form>
					</div>
	              </div><!-- /. box -->
	              
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
	<script type="text/javascript">
		var testResults = [];
		function addNewTest(){
			var testResult = document.getElementById("new_test_result").value;
			testResults.push(parseInt(testResult)); 
			
			var i, 
				sum = 0;
			for (i = 0; i < testResults.length; i++) {
			  sum = sum + testResults[i];
			  document.getElementById("test_" + i).innerHTML = testResults[i];
			}
			
			var average = Math.round(sum / testResults.length);
			document.getElementById("average_bandwidth").innerHTML = average;
			
			if(testResults.length == 5){
				document.getElementById("ave_bandwidth").value = average;
				document.getElementById("tester").style.display = "none"; 
				document.getElementById("continue").style.display = "block"; 
				//document.getElementById("setup_form").submit(); 
			}
		}
		
	</script>
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
