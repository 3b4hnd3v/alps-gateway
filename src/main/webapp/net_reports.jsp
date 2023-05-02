<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<div class="content-wrapper">
<%!
public static String defip = "";
%>
<% defip = dao.getDefaultIp(); %>
<%

if(request.getParameter("msg") != null && request.getParameter("type").equals("error")){ %>
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
	<br>
	  <h1>
	    Network Reports
	    <small>Graphical Network Reports</small>
	  </h1>
	  <ol class="breadcrumb">
	    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	    <li><a href="hotspot.jsp?q=walledgarden">Reports</a></li>
	    <li class="active">Network</li>
	  </ol>
	</section>
	<hr>
	<!-- Main content -->
    <section class="content">
      <div class="callout callout-warning">
        <h4>Info!</h4>

        <p><b>Data Info:</b> All Graphical Data is real time and represent the most current data in the network.</p>
      </div>
      <div class="row">
      	<div class="col-md-12">
          <!-- LINE CHART -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Location Packets</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="locpac" style="height: 300px;"></div>
            </div>
            <!-- /.box-body -->
          </div>
        </div>
        <div class="col-md-12">
          <!-- LINE CHART -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Location Bytes</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="locbyt" style="height: 300px;"></div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <div class="col-md-12">
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Location Error</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="locerr" style="height: 300px;"></div>
            </div>
            <!-- /.box-body -->
          </div>
        </div>
        <div class="col-md-12">
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Location Drops</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="locdrop" style="height: 300px;"></div>
            </div>
            <!-- /.box-body -->
          </div>
		</div>
		<div class="col-md-12">
		  <div class="box box-success">
            <div class="box-header with-border">
              <h3 class="box-title">Vlan Packets</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="vlanpac" style="height: 300px;"></div>
            </div>
            <!-- /.box-body -->
          </div>
		</div>
		<div class="col-md-12">
		  <div class="box box-success">
            <div class="box-header with-border">
              <h3 class="box-title">Vlan Drops</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="vlandro" style="height: 300px;"></div>
            </div>
            <!-- /.box-body -->
          </div>
		</div>
		<div class="col-md-12">
		  <div class="box box-danger">
            <div class="box-header with-border">
              <h3 class="box-title">Vlan Errors</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="vlanerr" style="height: 300px; position: relative;"></div>
            </div>
            <!-- /.box-body -->
          </div>
		</div>
		<div class="col-md-12">
		  <div class="box box-danger">
            <div class="box-header with-border">
              <h3 class="box-title">Vlan Bytes</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="vlanbyt" style="height: 300px; position: relative;"></div>
            </div>
            <!-- /.box-body -->
          </div>
		</div>
		<div class="col-md-12">
		  <div class="box box-danger">
            <div class="box-header with-border">
              <h3 class="box-title">Ether Drops</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="etherdrop" style="height: 300px; position: relative;"></div>
            </div>
            <!-- /.box-body -->
          </div>
		</div>
		<!--<div class="col-md-12">
		  <div class="box box-danger">
            <div class="box-header with-border">
              <h3 class="box-title">Social</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="sos" style="height: 300px; position: relative;"></div>
            </div>
          </div>
		</div>-->
		
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
<footer class="main-footer">
  <div class="pull-right hidden-xs">
    <b>Version</b> <%=sysver%>
  </div>
  <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">Alps Gateway</a>.</strong> All rights reserved.
</footer>
</div> <!-- /.content -->
<!-- jQuery 2.2.3 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="plugins/morris/morris.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- page script -->
<script>
 $(document).ready(function() {
     //alert("ready");
     "use strict";
 	var locpac = (function () {
 		var json = null;
 		$.ajax({
 			'async':false,
 			'global': false,
 			'url': "http://<%=defip%>/graph_data.jsp?q=location_packets",
 			'dataType': "json",
 			'timeout':600000,
 			'success': function (data) {
 				json = data.datasets;
 				//alert(json);
 				locbyte();
 			},
 			'error': function (error) {
 				
 				alert("Error: Graphs Are Not Accessible Outside The Network");
 			}
 		}); 
 		return json;
 	})(); 
 	// AREA CHART
     var area1 = new Morris.Area({
       element: 'locpac',
       resize: true,
       data: locpac,
       xkey: 'y',
       ykeys: ['a', 'b'],
       labels: ['Up', 'Down'],
       lineColors: ['#a0d0e0', '#3c8dbc'],
       hideHover: 'auto'
     });
  });
  function locbyte() {
		var locbyt = (function () {
			var json = null;
			$.ajax({
				'async':false,
				'global': false,
				'url': "http://<%=defip%>/graph_data.jsp?q=location_bytes",
				'dataType': "json",
				'timeout':600000,
				'success': function (data) {
					json = data.datasets;
					//alert(json);
					locerror();
				},
				'error': function (error) {
					
					//alert(error.message);
				}
			}); 
			return json;
		})(); 
		var bar = new Morris.Bar({
		  element: 'locbyt',
		  resize: true,
		  data: locbyt,
		  barColors: ['#00a65a', '#f56954'],
		  xkey: 'y',
		  ykeys: ['a', 'b'],
		  labels: ['Up', 'Down'],
		  hideHover: 'auto'
		});
	}  
 	function locerror() {
		var locerr = (function () {
			var json = null;
			$.ajax({
				'async':false,
				'global': false,
				'url': "http://<%=defip%>/graph_data.jsp?q=location_errors",
				'dataType': "json",
				'timeout':600000,
				'success': function (data) {
					json = data.datasets;
					//alert(json);
					locdropp();
				},
				'error': function (error) {
					
					//alert(error.message);
				}
			}); 
			return json;
		})(); 
		var bar = new Morris.Area({
		  element: 'locerr',
		  resize: true,
		  data: locerr,
		  barColors: ['#00a65a', '#f56954'],
		  xkey: 'y',
		  ykeys: ['a', 'b'],
		  labels: ['Up', 'Down'],
		  hideHover: 'auto'
		});
	}
 	function locdropp() {
		var locdrop = (function () {
			var json = null;
			$.ajax({
				'async':false,
				'global': false,
				'url': "http://<%=defip%>/graph_data.jsp?q=location_drops",
				'dataType': "json",
				'timeout':600000,
				'success': function (data) {
					json = data.datasets;
					//alert(json);
					vlanpack();
				},
				'error': function (error) {
					
					//alert(error.message);
				}
			}); 
			return json;
		})(); 
		var bar = new Morris.Area({
		  element: 'locdrop',
		  resize: true,
		  data: locdrop,
		  barColors: ['#00a65a', '#f56954'],
		  xkey: 'y',
		  ykeys: ['a', 'b'],
		  labels: ['Up', 'Down'],
		  hideHover: 'auto'
		});
	}
	
	function vlanpack() {
		var vlanpac = (function () {
			var json = null;
			$.ajax({
				'async':false,
				'global': false,
				'url': "http://<%=defip%>/graph_data.jsp?q=vlan_packets",
				'dataType': "json",
				'timeout':600000,
				'success': function (data) {
					json = data.datasets;
					//alert(json);
					vlandrop();
				},
				'error': function (error) {
					
					//alert(error.message);
				}
			}); 
			return json;
		})(); 
		var bar = new Morris.Area({
		  element: 'vlanpac',
		  resize: true,
		  data: vlanpac,
		  barColors: ['#00a65a', '#f56954'],
		  xkey: 'y',
		  ykeys: ['a', 'b'],
		  labels: ['Up', 'Down'],
		  hideHover: 'auto'
		});
	}
	
	function vlandrop() {
		var vlandro = (function () {
			var json = null;
			$.ajax({
				'async':false,
				'global': false,
				'url': "http://<%=defip%>/graph_data.jsp?q=vlan_drops",
				'dataType': "json",
				'timeout':600000,
				'success': function (data) {
					json = data.datasets;
					//alert(json);
					vlanderror();
				},
				'error': function (error) {
					
					//alert(error.message);
				}
			}); 
			return json;
		})(); 
		var bar = new Morris.Area({
		  element: 'vlandro',
		  resize: true,
		  data: vlandro,
		  barColors: ['#00a65a', '#f56954'],
		  xkey: 'y',
		  ykeys: ['a', 'b'],
		  labels: ['Up', 'Down'],
		  hideHover: 'auto'
		});
	}
	
	function vlanderror() {
		var vlanerr = (function () {
			var json = null;
			$.ajax({
				'async':false,
				'global': false,
				'url': "http://<%=defip%>/graph_data.jsp?q=vlan_errors",
				'dataType': "json",
				'timeout':600000,
				'success': function (data) {
					json = data.datasets;
					//alert(json);
					vlanbytes();
				},
				'error': function (error) {
					
					//alert(error.message);
				}
			}); 
			return json;
		})(); 
		var bar = new Morris.Line({
		  element: 'vlanerr',
		  resize: true,
		  data: vlanerr,
		  barColors: ['#00a65a', '#f56954'],
		  xkey: 'y',
		  ykeys: ['a', 'b'],
		  labels: ['Up', 'Down'],
		  hideHover: 'auto'
		});
	}
	
	function vlanbytes() {
		var vlanbyt = (function () {
			var json = null;
			$.ajax({
				'async':false,
				'global': false,
				'url': "http://<%=defip%>/graph_data.jsp?q=vlan_bytes",
				'dataType': "json",
				'timeout':600000,
				'success': function (data) {
					json = data.datasets;
					//alert(json);
					etherdrops();
				},
				'error': function (error) {
					
					//alert(error.message);
				}
			}); 
			return json;
		})(); 
		var bar = new Morris.Bar({
		  element: 'vlanbyt',
		  resize: true,
		  data: vlanbyt,
		  barColors: ['#00a65a', '#f56954'],
		  xkey: 'y',
		  ykeys: ['a', 'b'],
		  labels: ['Up', 'Down'],
		  hideHover: 'auto'
		});
	}
	function etherdrops() {
		var etherdrop = (function () {
			var json = null;
			$.ajax({
				'async':false,
				'global': false,
				'url': "http://<%=defip%>/graph_data.jsp?q=ether_drops",
				'dataType': "json",
				'timeout':600000,
				'success': function (data) {
					json = data.datasets;
					//alert(json);	
					social();
				},
				'error': function (error) {
					
					//alert(error.message);
				}
			}); 
			return json;
		})(); 
		var bar = new Morris.Line({
		  element: 'etherdrop',
		  resize: true,
		  data: etherdrop,
		  barColors: ['#00a65a', '#f56954'],
		  xkey: 'y',
		  ykeys: ['a', 'b'],
		  labels: ['Up', 'Down'],
		  hideHover: 'auto'
		});
	}
</script>
</body>
</html>