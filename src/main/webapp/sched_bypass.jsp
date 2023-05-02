<%@include file="header.jsp" %>

<body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
<!-- Site wrapper -->
<div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%
String bpan = "collapse", dmac="00:00:00:00:00:00", dn="Unknown", box="daily";
Bypass us = new Bypass();
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Set Schedule")) {
	
	try {
		String dvn = request.getParameter("devname");
		String dvm = request.getParameter("mac");
		String rate = request.getParameter("rate");
		String sta = request.getParameter("start");
		String end = request.getParameter("end");
		String[] prs = request.getParameterValues("days");
		String pr = "";
		for(String s: prs){
			if(pr != ""){pr = pr+"&"+s;}else{pr=pr+s;}
		}
		System.out.println(pr); 
		
		us.setDevice(dvn);
		us.setMac(dvm);
		us.setRate(rate);
		us.setStart(sta);
		us.setEnd(end);
		us.setRepeat(pr);
		
		us.add();
		
	} catch (Exception e1) { System.out.println(e1); }
}
if(request.getParameter("q") != null && request.getParameter("q").equals("del")) {
	
	try {
		String item = request.getParameter("item");
		us.delete(item);
		
	} catch (Exception e1) {System.out.println(e1);}
}
if(request.getParameter("q") != null && request.getParameter("q").equals("suspend")) {
	
	try {
		String item = request.getParameter("item");
		us.changeStat(item, "suspended");
	} catch (Exception e1) {System.out.println(e1);}
}
if(request.getParameter("q") != null && request.getParameter("q").equals("activate")) {
	
	try {
		String item = request.getParameter("item");
		us.changeStat(item, "active");
	} catch (Exception e1) {System.out.println(e1);}
}
if(request.getParameter("q") != null && request.getParameter("q").equals("schedule")) {
	
	try {
		box = request.getParameter("type");
		dn = request.getParameter("device");
		dmac = request.getParameter("mac");
		bpan = "collapse in";
	} catch (Exception e1) {System.out.println(e1);}
}else{
	bpan = "collapse";
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
<section class="content-header">
  <h1>
    Schedule Bypass
    <small>Schedule Automatic Device Bypass</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Policy</a></li>
    <li class="active">Schedule Bypass</li>
  </ol>
</section>
<section class="content-header">
	<div class="panel box box-primary">
          <div class="box-header with-border">
            <h4 class="box-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                New Schedule <span><i class="fa fa-angle-double-down"></i></span>
              </a>
            </h4>
          </div>
          <div id="collapseOne" class="panel-collapse <%= bpan %>">
            <div class="box-body">
            	<%if(box.equals("daily")){ %>
	            	<form action="sched_bypass.jsp" method="post">
					  <div class="form-group col-sm-6">
						<label>Device</label>
						<input type="text" class="form-control" name="devname" value="<%= dn %>">
					  </div>
		              <div class="form-group col-sm-6">
		                <label>MAC Address</label>
						<input type="text" class="form-control" name="mac" value="<%= dmac %>"><br />
		              </div>
		              <div class="form-group col-sm-4">
		                <label>Rate</label>
						<input type="text" class="form-control" name="rate" placeholder="Up/Down">
		              </div>
	                  <div class="form-group col-sm-4">
		              <label>Start Time</label>
						<input type="text" class="form-control" name="start" value="00:00"><br />
		              </div>
		              <div class="form-group col-sm-4">
		              <label>End Time</label>
						<input type="text" class="form-control" name="end" value="00:00"><br />
		              </div>
					  <div class="form-group col-sm-12">
	                     <label class="control-label" for="inputSuccess">Days</label>
	                     <div>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox1" value="Sunday"> Sunday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox2" value="Monday"> Monday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox3" value="Tuesday"> Tuesday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox3" value="Wednesday"> Wednesday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox3" value="Thursday"> Thursday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox3" value="Friday"> Friday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox3" value="Saturday"> Saturday
	                         </label>
	                      </div>
	                  </div><br>
	                  <div class="form-group col-sm-12">
					  	<input type="submit" name="submit" class="form-control btn btn-info" value="Set Schedule" />
					  </div>
				  </form>
				  <%}else if(box.equals("period")){ %>
				  <form action="sched_bypass.jsp" method="post">
					  <div class="form-group col-sm-6">
						<label>Device</label>
						<input type="text" class="form-control" name="devname" value="<%= dn %>">
					  </div>
		              <div class="form-group col-sm-6">
		                <label>MAC Address</label>
						<input type="text" class="form-control" name="mac" value="<%= dmac %>"><br />
		              </div>
		              <div class="form-group col-sm-4">
		                <label>Rate</label>
						<input type="text" class="form-control" name="rate" placeholder="Up/Down">
		              </div>
	                  <div class="form-group col-sm-4">
		              <label>Start Date</label>
						<input type="text" class="form-control" name="start" placeholder="dd-mm-yyyy">
						<small class="text-danger">Format: dd-mm-yyyy</small>
		              </div>
		              <div class="form-group col-sm-4">
		              <label>End Date</label>
						<input type="text" class="form-control" name="end" placeholder="dd-mm-yyyy">
						<small class="text-danger">Format: dd-mm-yyyy</small>
		              </div>
					  <div class="form-group col-sm-12">
	                     <label class="control-label" for="inputSuccess">Days</label>
	                     <div>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox1" value="Sunday"> Sunday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox2" value="Monday"> Monday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox3" value="Tuesday"> Tuesday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox3" value="Wednesday"> Wednesday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox3" value="Thursday"> Thursday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox3" value="Friday"> Friday
	                         </label>
	                         <label class="checkbox-inline">
	                             <input type="checkbox" name="days" id="inlineCheckbox3" value="Saturday"> Saturday
	                         </label>
	                      </div>
	                  </div><br>
	                  <div class="form-group col-sm-12">
					  	<input type="submit" name="submit" class="form-control btn btn-info" value="Set Schedule" />
					  </div>
				  </form>
				  <%} %>
            </div>
          </div>
        </div>
</section>
<!-- Table List -->
<section class="content">
  <div class="row">
    <div class="col-sm-12 col-xs-12"><!-- /.box -->

      <div class="box">
        <div class="box-header">
          <h3 class="box-title col-md-5">Devices</h3>
        </div><!-- /.box-header -->
        <div class="box-body table-responsive" style="max-height:500px; overflow-y:scroll;">
          <table id="example1" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th width="50%">Device</th>
                <th width="30%">MAC</th>
                <!-- <th>IP</th>
                <th>Zone</th> -->
                <th><i class="fa fa-cog"></i></th>
              </tr>
            </thead>
            <tbody>
            <%
           		for (Map<String,String> mp : g.dhcpLease()) {
           			String dev = String.valueOf(mp.get("host-name")).replace("null", "Unknown");
           			String mac = mp.get("mac-address");
           			String btn = "<a title='Daily Bypass' class='btn btn-sm btn-warning' href='?q=schedule&type=daily&device="+dev+"&mac="+mac+"'><i class='fa fa-clock-o'></i></a>";
           			String dbtn = "<a title='Period Bypass' class='btn btn-sm btn-success' href='?q=schedule&type=period&device="+dev+"&mac="+mac+"'><i class='fa fa-calendar-o'></i></a>";
				  	out.println("<tr>");
					out.println("<td>"+String.valueOf(mp.get("host-name")).replace("null", mp.get("mac-address"))+"</td>");
					out.println("<td>"+mp.get("mac-address")+"</td>");
					//out.println("<td>"+mp.get("address")+"</td>");
					//out.println("<td>"+mp.get("server")+"</td>");
					out.println("<td>"+btn+" | "+dbtn+"</td>");
					out.println("</tr>");
			}%>
           	</tbody>
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div><!-- /.col -->
    <div class="col-sm-12 col-xs-12"><!-- /.box -->

      <div class="box">
        <div class="box-header">
          <h3 class="box-title col-md-5">Active Schedules</h3>
        </div><!-- /.box-header -->
        <div class="box-body table-responsive" style="max-height:500px; overflow-y:scroll;">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th>Device</th>
                <th>MAC</th>
                <th>Rate</th>
                <th>Time</th>
                <th>status</th>
                <th><i class="fa fa-cog"></i></th>
              </tr>
            </thead>
            <tbody>
            	<%
            	Bypass b = new Bypass();
           		for (Bypass mp : b.getAll()) {
           			String dev = mp.getDevice();
           			String mac = mp.getMac();
           			String btnst = "";
           			String btndl = "<a class='btn btn-xs btn-danger' href='?q=del&item="+mp.getId()+"'><i class='fa fa-times'></i></a>";
           			if(mp.getStatus().equals("active")){
           				btnst = "<a class='btn btn-xs btn-warning' href='?q=suspend&item="+mp.getId()+"'><i class='fa fa-thumbs-down'></i></a>";
           			}else{
           				btnst = "<a class='btn btn-xs btn-success' href='?q=activate&item="+mp.getId()+"'><i class='fa fa-thumbs-up'></i></a>";
           			}
				  	out.println("<tr>");
					out.println("<td>"+dev+"</td>");
					out.println("<td>"+mac+"</td>");
					out.println("<td>"+mp.getRate()+"</td>");
					out.println("<td>"+mp.getStart()+" - "+mp.getEnd()+"</td>");
					out.println("<td>"+mp.getStatus()+"</td>");
					out.println("<td>"+btndl+" "+btnst+"</td>");
					out.println("</tr>");
				}%>
           	</tbody>
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div><!-- /.col -->
  </div><!-- /.row -->
</section><!-- /.content -->
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
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.js"></script>
<script>
  $(function () {
    $('#example1').DataTable({
      "paging": false,
      "lengthChange": false,
      "searching": true,
      "ordering": false,
      "info": false,
      "autoWidth": true
    });
    $('#example2').DataTable({
        "paging": false,
        "lengthChange": false,
        "searching": true,
        "ordering": false,
        "info": false,
        "autoWidth": true
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
<!--Table Export-->
<script>
function tableExport() {
   // check whether tableExport plugin is loaded
   if (typeof $.tableExport !== "function") {
   	$.getScript("js/tableexport/tableExport.js");
   	$.getScript("js/tableexport/jquery.base64.js");
   	$.getScript("js/tableexport/html2canvas.js");
   	$.getScript("js/tableexport/jspdf/libs/sprintf.js");
   	$.getScript("js/tableexport/jspdf/jspdf.js");
   	$.getScript("js/tableexport/jspdf/libs/base64.js");
   }
};
</script>
<!-- page script -->
</body>
</html>