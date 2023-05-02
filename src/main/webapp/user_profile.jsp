<%@include file="header.jsp" %>
<%!  User user = new User(); public int uid=0; 
public String userid="", uname="", username="", password="", email="", department="", role="", edb="collapse"; %>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add User")) {
	
	try {
		String name = request.getParameter("uname");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("uemail");
		String department = request.getParameter("department");
		String role = request.getParameter("role");
		User user = new User();
		user.setName(name);
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(email);
		user.setDepartment(department);
		user.setRole(role);
		if(user.addUser()){
			String logact = "New User "+name+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			
			response.sendRedirect("user_profile.jsp?type=success&msg=New User Added.");
		}else{
			response.sendRedirect("user_profile.jsp?type=error&msg=New User Could Not Be Added.");

		}
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update User")) {
	System.out.println("Update");
	try {
		String uid = request.getParameter("uid");
		String name = request.getParameter("uname");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("uemail");
		String department = request.getParameter("department");
		String role = request.getParameter("role");
		User user = new User();
		user.setId(Integer.parseInt(uid));
		user.setName(name);
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(email);
		user.setDepartment(department);
		user.setRole(role);
		
		if(user.update()){
			String logact = "User "+name+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			
			response.sendRedirect("user_profile.jsp?type=success&msg=User Information Updated.");
		}else{
			response.sendRedirect("user_profile.jsp?type=error&msg=User Information Failed To Update.");

		}
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("del")) {
	
	try {
		String id = request.getParameter("item").toString();
		
		if(user.delete(Integer.parseInt(id))){
			String logact = "User: "+id+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			
			response.sendRedirect("user_profile.jsp?type=error&msg=User Deleted");
		}else{
			response.sendRedirect("user_profile.jsp?type=error&msg=User Could Not Be Deleted");
		}
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
else if(request.getParameter("q") != null && request.getParameter("q").equals("edit")) {
	
	try {
		String id = request.getParameter("item").toString();
		
		User targUser = user.getUser(Integer.parseInt(id));
		
		uid = targUser.getId();
		uname = targUser.getName();
		username = targUser.getUsername();
		password = targUser.getPassword();
		email = targUser.getEmail();
		department = targUser.getDepartment();
		role = targUser.getRole();
		
		edb = "collapse in";
	} catch (Exception e1) { System.out.println(e1); }
}else{
	edb = "collapse";
}
%>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini"  onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
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
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    User Profile
    <small>Profile Of Active User</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="index.php"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">User Profile</a></li>
  </ol>
</section>
<section class="content-header">
	<div class="panel box box-primary">
        <div class="box-header with-border">
        	<h4 class="box-title">
             <a data-toggle="collapse" data-parent="#accordion" href="collapseThree">
               User Information &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class="fa fa-info"></i></span>
             </a>
           </h4>
        </div>
        <div id="collapseThree" class="panel-collapse collapse in">
        	<div class="box-body">
        	<div class="col-lg-12 well">
        	<table class="table table-bordered table-striped table-hover">
        		<thead>
        			<tr>
                       <th>ID</th>
                       <th>Name</th>
                       <th>Email</th>
                       <th>User Name</th>
                       <th>Department</th>
                       <th>Role</th>
                       <th>Update</th>
                     </tr>
        		</thead>
        		<tbody>
        			<tr>
        				
        				<td><% try{out.print(session.getAttribute("user_id"));}catch(Exception e){System.out.println(e);} %></td>
        				<td><% try{out.print(session.getAttribute("name")); }catch(Exception e){System.out.println(e);}%></td>
        				<td><% try{out.print(session.getAttribute("email")); }catch(Exception e){System.out.println(e);}%></td>
        				<td><% try{out.print(session.getAttribute("username"));}catch(Exception e){System.out.println(e);} %></td>
        				<td><% try{out.print(session.getAttribute("dept")); }catch(Exception e){System.out.println(e);}%></td>
        				<td><% try{out.print(session.getAttribute("role")); }catch(Exception e){System.out.println(e);}%></td>
        				<% try{
        					//String s = session.getAttribute("user_id").toString();
        					String btn_ed = "<a href='?q=edit&item="+session.getAttribute("user_id")+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
        					out.print("<td>"+btn_ed+"</td>");
        				}catch(Exception e){System.out.println("sess"+e);}
        				%>
        			</tr>
        		</tbody>
        	</table>
       		</div>
       		</div>
       	</div>
     </div>
</section>
<% 


if(session.getAttribute("role") != null && (session.getAttribute("role").equals("Super") || session.getAttribute("role").equals("Main"))) { %>
<section class="content-header">
	<div class="panel box box-primary">
        <div class="box-header with-border">
        	<h4 class="box-title">
             <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
               Create User <span><i class="fa fa-angle-double-down"></i></span>
             </a>
           </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse">
        	<div class="box-body">
           		<form action="user_profile.jsp" method="post">
           			<label>Name</label>
						<input type="text" class="form-control" name="uname"><br />
           			<label>Username</label>
						<input type="text" class="form-control" name="username"><br />
 					<label>Password</label>
						<input type="text" class="form-control" name="password"><br />
			 		<div class="form-group">
                    	<label>Department</label>
                     	<select class="form-control" name="department">
	                     	<option>IT</option>
	                     	<option>Admin</option>
	                     	<option>Management</option>
	                     	<option>Support</option>
                  		</select>
              		</div>
              		<label>Email</label>
						<input type="text" class="form-control" name="uemail" value="Not Applicable"><br />
              		<div class="form-group">
                    	<label>Role</label>
                     	<select class="form-control" name="role">
                     		<option>Main</option>
                     		<option>Low Level User</option>
                     		<option>IT Manager</option>
                     	</select>
              		</div>
               		
					<input type="submit" name="submit" class="form-control btn btn-info" value="Create User" />
				</form>
         	</div>
       	</div>
     </div>
</section>
<section class="content-header">
	<div class="panel box box-primary">
        <div class="box-header with-border">
        	<h4 class="box-title">
             <a data-toggle="collapse" data-parent="#accordion" href="collapseOne">
               User Edit <span><i class="fa fa-angle-double-down"></i></span>
             </a>
           </h4>
        </div>
        <div id="collapseTwo" class="panel-collapse <% out.println(edb);%>">
        	<div class="box-body">
           		<form action="user_profile.jsp" method="post">
           			<label>User ID</label>
						<input type="text" class="form-control" readonly name="uid" value="<% out.print(uid); %>"><br />
           			<label>Name</label>
						<input type="text" class="form-control" name="uname" value="<% out.print(uname); %>"><br />
           			<label>Username</label>
						<input type="text" class="form-control" name="username" value="<% out.print(username); %>"><br />
 					<label>Email</label>
						<input type="text" class="form-control" name="uemail" value="<% out.print(email); %>">
						<small>Optional</small><br />
 					<label>Password</label>
						<input type="text" class="form-control" name="password" value="<% out.print(password); %>"><br />
			 		<div class="form-group">
                    	<label>Department</label>
                     	<select class="form-control" name="department">
	                     	<option><% out.print(department); %></option>
	                     	<option>--</option>
	                     	<option>IT</option>
	                     	<option>Admin</option>
	                     	<option>Management</option>
	                     	<option>Support</option>
                  		</select>
              		</div>
              		<div class="form-group">
                    	<label>Role</label>
                     	<select class="form-control" name="role">
                     		<option><% out.print(role); %></option>
	                     	<option>--</option>
                     		<option>Main</option>
                     		<option>Low Level User</option>
                     		<option>IT Manager</option>
                     	</select>
              		</div>
               		
					<input type="submit" name="submit" class="form-control btn btn-info" value="Update User" />
				</form>
				<p id="edb"></p>
				<script type="text/javascript">document.getElementById("edb").scrollIntoView();</script>
         	</div>
       	</div>
     </div>
</section>
<!-- Table List -->
<section class="content">
  <div class="row">
    <div class="col-xs-12"><!-- /.box -->

      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Authorized Users</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example1" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Username</th>
                <th>Password</th>
                <th>Email</th>
                <th>Department</th>
                <th>Role</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
	            <%
	            connect();
	            try {
	    			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `users` WHERE `role`!='Super'");
	    			while (rs.next()){
	    				if(!rs.getString("role").equalsIgnoreCase("Super")){
						 	String btn_dl = "<a href='?q=del&type=user&item="+rs.getString("user_id")+"'><button class='btn btn-xs btn-danger'>Del</button></a>";
						 	String btn_ed = "<a href='?q=edit&item="+rs.getString("user_id")+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
						 	out.println("<tr>");
							out.println("<td>"+rs.getString("user_id")+"</td>");
							out.println("<td>"+rs.getString("name")+"</td>");
							out.println("<td>"+rs.getString("username")+"</td>");
							out.println("<td>"+rs.getString("password")+"</td>");
							out.println("<td>"+rs.getString("email")+"</td>");
							out.println("<td>"+rs.getString("department")+"</td>");
							out.println("<td>"+rs.getString("role")+"</td>");
							out.println("<td>"+btn_ed+"  "+btn_dl+" </td>");
							out.println("</tr>");
	    				}
	    			}
	    			} catch(Exception e) { System.out.println(e); }	    		
				%>
            </tbody>
            <tfoot>
             
            </tfoot>
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div><!-- /.col -->
  </div><!-- /.row -->
</section><!-- /.content -->
<%} %>
</div>
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
	$("#example1").DataTable({"responsive": true});
    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true
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