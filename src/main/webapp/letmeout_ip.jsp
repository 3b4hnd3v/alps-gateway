<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="toolbar.jsp" %>
<%
LMOIpList us = new LMOIpList();
String interf="", 
interf_id="", 
ipmessage="", 
ip="", 
ipprefix="", 
nm="", 
network="", 
pr="", 
gstat="", 
result=""; 
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Address Range")) {
	String ippref = request.getParameter("ippref");
	String ipnet = request.getParameter("network");
	String netmask = request.getParameter("netmask");
	String iid = request.getParameter("interf_id");
	String iname = request.getParameter("interf");
	String ipfrom = request.getParameter("ipfrom");
	String ipto = request.getParameter("ipto");
	boolean ir = false;
	for(int i = Integer.parseInt(ipfrom); i <= Integer.parseInt(ipto); i++){
		String ipadd = ippref + i;
		
		us.setAddress(ipadd);
		us.setInterf(iname);
		us.setMask(netmask);
		us.setNetwork(ipnet);
		
		ir = us.add();
	}
	if(ir){
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Added Succesfully&type=success");
	}else{
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Failed To Add IP Range&type=error");
	}
}
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Address")) {
	String ippref = request.getParameter("ippref");
	String ipnet = request.getParameter("network");
	String netmask = request.getParameter("netmask");
	String iid = request.getParameter("interf_id");
	String iname = request.getParameter("interf");
	String ipsur = request.getParameter("ip");
	boolean ir = false;
	
	String ipadd = ippref + ipsur;
	us.setAddress(ipadd);
	us.setInterf(iname);
	us.setMask(netmask);
	us.setNetwork(ipnet);
		
	ir = us.add();
	
	if(ir){
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Added Succesfully&type=success");
	}else{
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Failed To Add IP Range&type=error");
	}
}
if(request.getParameter("q") != null && request.getParameter("q").equals("remove")) {
	String item = request.getParameter("item");
	String iid = request.getParameter("interf_id");
	String iname = request.getParameter("interf");
	if(us.delete(item)){
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Added Succesfully&type=success");
	}else{
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Failed To Add IP Range&type=error");
	}
}
if(request.getParameter("q") != null && request.getParameter("q").equals("enable")) {
	String item = request.getParameter("item");
	String iid = request.getParameter("interf_id");
	String iname = request.getParameter("interf");
	if(us.changeStat(item, "0","none")){
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Added Succesfully&type=success");
	}else{
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Failed To Add IP Range&type=error");
	}
}
if(request.getParameter("q") != null && request.getParameter("q").equals("disable")) {
	String item = request.getParameter("item");
	String iid = request.getParameter("interf_id");
	String iname = request.getParameter("interf");
	if(us.changeStat(item, "1","none")){
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Added Succesfully&type=success");
	}else{
		response.sendRedirect("letmeout_ip.jsp?interf="+iname+"&interf_id="+iid+"&msg=Failed To Add IP Range&type=error");
	}
}
if(request.getParameter("interf") != null && request.getParameter("interf_id") != null) {
	System.out.println("Activate");
	try {
		interf = request.getParameter("interf");
		interf_id = request.getParameter("interf_id");
		List<Map<String,String>> rs = mg.interfadd(interf);
		if(!rs.isEmpty()){
			for(Map<String,String> mp : rs){
				String nip = mp.get("address");
				network = mp.get("network");
				ip = nip.split("/")[0];
				nm = nip.split("/")[1];
				String[] nugs = ip.replace(".", "-").split("-");
				ipprefix = nugs[0]+"."+nugs[1]+"."+nugs[2]+".";
				break;
			}
		}
	} catch (Exception e1) { System.out.println(e1); }
}
%>

<div class="content-wrapper">
	<!-- Content Header (Page header) -->
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
	<%} %>
	<%if(ipmessage != null && !ipmessage.equals("")){ %>
		<div class="alert alert-info alert-dismissible">
		  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		  <h4><i class="icon fa fa-info"></i> Alert!</h4>
		  <%out.println(ipmessage); %>
		</div>
	<%} %>
	<section class="content-header">
	  <h1>
	    LetMeOut<sup>TM</sup> Setup
	    <small>WAN LetMeOut<sup>TM</sup> Setup</small>
	  </h1>
	  <ol class="breadcrumb">
	    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	    <li><a href="#">Main</a></li>
	    <li class="">WAN</li>
	    <li class="active">Interfaces</li>
	  </ol>
	</section>
	<section class="content-header"><p></p></section>	
	<section class="content">
		<div class="panel box box-primary">
          <div class="box-header with-border">
            <h4 class="box-title" style="width:100%;">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                Add IP Range
              </a>
              <span class="pull-right"><i class="fa fa-angle-double-down"></i></span>
            </h4>
          </div>
          <div id="collapseOne" class="panel-collapse collapse">
            <div class="box-body">
            	<form method="post" action="#">
			    <div class="box-body">
					<input type="hidden" required class="form-control" readonly name="ippref" value="<%= ipprefix %>">
					<input type="hidden" required class="form-control" readonly name="netmask" value="<%= nm %>">
					<input type="hidden" required class="form-control" readonly name="network" value="<%= network %>">
					<input type="hidden" required class="form-control" readonly name="interf_id" value="<%= interf_id %>">
					<div class="row">
						 <div class="form-group col-sm-12">
						   <label for="ip" class="col-sm-12 control-label">Interface Name</label><br />
						   <div class="col-sm-12">
						     <input type="text" class="form-control" required readonly id="interf" name="interf" value="<%= interf %>">
						   </div>
						 </div>
						 <div class="form-group col-sm-12">
						 	<label for="ip" class="col-sm-12 control-label">IP Address Range</label>
						 </div>
						 <div class="form-group col-sm-2">
						 	<label class="control-label">&nbsp;</label>
							<div class="col-sm-12">
							  <strong><%= ipprefix %></strong>
							</div>
						 </div>
						 <div class="form-group col-sm-5">
						   <label for="netmask" class="col-sm-12 control-label">FROM</label><br />
						   <div class="col-sm-12">
						     <input type="number" required class="form-control" id="ipfrom" name="ipfrom" placeholder="0">
						   </div>
						 </div>
						 <div class="form-group col-sm-5">
						   <label for="netmask" class="col-sm-12 control-label">TO</label><br />
						   <div class="col-sm-12">
						     <input type="number" required class="form-control" id="ipto" name="ipto" placeholder="0">
						   </div>
						 </div>
					</div>
			    </div><!-- /.box-body -->
			    <div class="box-footer">
			      <a href="#" ><button class="btn btn-default">Cancel</button></a>
			      <input type="submit" name="submit" class="btn btn-info pull-right" value="Add Address Range">
			    </div><!-- /.box-footer -->
			  </form>
            </div>
          </div>
        </div>
        <div class="panel box box-primary">
          <div class="box-header with-border">
            <h4 class="box-title" style="width:100%;">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                Add Single IP 
              </a>
              <span class="pull-right"><i class="fa fa-angle-double-down"></i></span>
            </h4>
          </div>
          <div id="collapseTwo" class="panel-collapse collapse">
            <div class="box-body">
            	<form method="post" action="letmeout_ip.jsp">
				    <div class="box-body">
						<input type="hidden" required class="form-control" readonly name="ippref" value="<%= ipprefix %>">
						<input type="hidden" required class="form-control" readonly name="netmask" value="<%= nm %>">
						<input type="hidden" required class="form-control" readonly name="network" value="<%= network %>">
						<input type="hidden" required class="form-control" readonly name="interf_id" value="<%= interf_id %>">
						<div class="row">
							 <div class="form-group col-sm-12">
							   <label for="ip" class="col-sm-12 control-label">Interface Name</label><br />
							   <div class="col-sm-12">
							     <input type="text" class="form-control" required readonly id="interf" name="interf" value="<%= interf %>">
							   </div>
							 </div>
							 <div class="form-group col-sm-12">
							   <label for="netmask" class="col-sm-12 control-label">IP Address</label><br />
							 </div>
							 <div class="form-group col-sm-2">
							 	<label class="control-label">&nbsp;</label>
								<div class="col-sm-12">
								  <strong><%= ipprefix %></strong>
								</div>
							 </div>
							 <div class="form-group col-sm-10">
							   <label for="netmask" class="col-sm-12 control-label">&nbsp;</label><br />
							   <div class="col-sm-12">
							     <input type="number" required class="form-control" id="ip" name="ip" placeholder="0">
							   </div>
							 </div>
						</div>
				    </div><!-- /.box-body -->
				    <div class="box-footer">
				      <a href="#" ><button class="btn btn-default">Cancel</button></a>
				      <input type="submit" name="submit" class="btn btn-info pull-right" value="Add Address">
				    </div><!-- /.box-footer -->
			    </form>
            </div>
          </div>
        </div>
        
	  <div class="box">
	    <div class="box-header">
	      <h3 class="box-title"><%= interf %> LetMeOut<sup>TM</sup> Address List</h3>
	    </div><!-- /.box-header -->
	    <div class="box-body">
	      <table id="example1" class="table table-bordered table-striped table-responsive">
	        <thead>
	          <tr>
	            <th><i class="fa fa-edit"></i></th>
	            <th>Interface</th>
	            <th>Address</th>
	            <th>Network</th>
	            <th>Status</th>
	            <th>Assigned</th>
	            <th><i class="fa fa-cog"></i></th>
	          </tr>
	        </thead>
	        <tbody>
	        <%
	        ArrayList<LMOIpList> iplist = us.getBy("interf", interf);
	        for (LMOIpList mp : iplist) {
			  	String st = mp.getStatus();
			  	String s = mp.getId()+"";
			  	String name = mp.getInterf();
			  	String btn_st = "<a href='?q=enable&item="+s+"&interf="+interf+"&interf_id="+interf_id+"'><button class='btn btn-xs btn-success'><i class='fa fa-thumbs-up'></i></button></a>";
			  	if(st.equalsIgnoreCase("0")){
			  		btn_st = "<a href='?q=disable&item="+s+"&interf="+interf+"&interf_id="+interf_id+"'><button class='btn btn-xs btn-warning'><i class='fa fa-thumbs-down'></i></button></a>";
			  	}
			  	String btn_dl = "<a href='?q=remove&item="+s+"&interf="+interf+"&interf_id="+interf_id+"'><button class='btn btn-xs btn-danger'><i class='fa fa-trash'></i></button></a>";
			  	String btn_ed = "<a href='#'><button class='btn btn-xs btn-info'>Edit</button></a>";
				
			  	out.println("<tr>");
				out.println("<td>"+mp.getId()+"</td>");
				out.println("<td>"+mp.getInterf()+"</td>");
				out.println("<td>"+mp.getAddress()+"/"+mp.getMask()+"</td>");
				out.println("<td>"+mp.getNetwork()+"</td>");
				out.println("<td>"+mp.getStatus()+"</td>");
				out.println("<td>"+mp.getAssigned()+"</td>");
				out.println("<td>"+btn_st+" "+btn_dl+"</td>");
				out.println("</tr>");		  
			}%>
	        </tbody>
	      </table>
	    </div><!-- /.box-body -->
	  </div><!-- /.box -->
	  
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
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.js"></script>
<script>
  $(function () {
	$("#example1").DataTable({"responsive": true});
    
  });
</script>
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