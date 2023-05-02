<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%! 
public int totlog=0;
public static String user="", email="", flog="", clid="", defip = "";
%>
<%
defip = dao.getDefaultIp();
%>
<div class="content-wrapper"  align="center">
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
<br>
 <div class="row" style="margin-top: 10px;">
	   <div class="col-md-12">
	     <div class="box box-primary">
	       <div class="box-header">
	         <h3 class="box-title"><i class="fa fa-user"></i>Social Login Profile</h3>
	       </div>
	       <div class="box-body">
<%
try {
	totlog=0;
   String jsonurl = dao.getSocJson();
   user = request.getParameter("user").toString(); 
   clid = dao.getClient().toString().replace(" ", "%20"); 
   String url = jsonurl+"?cli="+clid+"&username="+ URLEncoder.encode(user,"UTF-8");
   System.out.println(url);
   String recv;
   String recvbuff = "";
   URL jsonpage = new URL(url);
   URLConnection urlcon = jsonpage.openConnection();
   BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream()));
	
   
   while ((recv = buffread.readLine()) != null){
    recvbuff += recv;
    
   
   }
   buffread.close();
   
   Object obj=JSONValue.parse(recvbuff);
   System.out.println(recvbuff);

   JSONArray array=(JSONArray)obj;
   totlog=0;
   for(int i=1; i< array.size(); i++){
	  
	   JSONObject obj2=(JSONObject)array.get(i);
	   
	   if(i == 1){
		   System.out.println("userassigned");
		   user = obj2.get("username").toString();
		   email = obj2.get("emailid").toString();
		   flog = obj2.get("created").toString();
		   System.out.println("userassigned="+user);
		}
	   String id = obj2.get("id").toString();
	   String provider = obj2.get("provider").toString();
	   String userid = obj2.get("userid").toString();
	   String username = obj2.get("username").toString();
	   String gender = obj2.get("gender").toString();
	   String imageurl = obj2.get("imageurl").toString();
	   String profurl = obj2.get("profileurl").toString();
	   String emailid = obj2.get("emailid").toString();
	   String location = obj2.get("location").toString();
	   String visit = obj2.get("visit").toString();
	   String created = obj2.get("created").toString();
	   String modified = obj2.get("modified").toString();
	   
	   totlog = totlog+ Integer.parseInt(obj2.get("visit").toString());
	   
	   %>
	   <div class="col-md-2">
	   <img src="<% out.println(imageurl); %>" class="img-responsive" width="60" height="55" /></div> 
       <div style="font-weight: 600; font-size: 15px; min-height: 50px;" class="col-md-10 well" >
       	<p class="col-md-6" align="center"><strong>User ID: <% out.println(id); %></strong></p>
       	
		<p class="col-md-6">User Name: <% out.println(username); %></p>
		<p class="col-md-6">Email: <% if(emailid.equals("")){out.println("Twitter Email Not Available");}else{out.println(emailid);} %></p>
		
		<p class="col-md-6">Login Through: <% out.println(provider); %></p>
		<p class="col-md-6">Login From: <% out.println(location); %></p>
		
		<p class="col-md-6">Number Of Login: <strong><% out.println(visit); %></strong></p>
		<p class="col-md-6">First Login On: <% out.println(created); %></p>
		
		<p class="col-md-6">Most Recent Login: <% out.println(modified); %></p>
       </div>
  <% } %>
  	<div style="font-weight: 600; font-size: 15px; min-height: 50px;" class="col-md-12 well" >
		<p class="col-md-12" align="center"><strong>Visit/Login Summary</strong></p>
		<div class="col-md-12">
		  <div class="box box-danger">
            <div class="box-header with-border">
              <h3 class="box-title">Social Authentication</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body chart-responsive">
              <div class="chart" id="sos" style="height: 400px; position: relative;"></div>
            </div>
            <!-- /.box-body -->
          </div>
		</div>
		
		<p class="col-md-6">User Name: <% out.println(user); %></p>
		<p class="col-md-6">Email: <% if(email.equals("")){out.println("Twitter Email Not Available");}else{out.println(email);} %></p>
		
		<p class="col-md-6">Total Number Of Login: <strong><% out.println(totlog); %></strong></p>
		<p class="col-md-6">Last Seen On: <% out.println(flog); %></p>
	</div>
  <% 
   } catch(Exception e) { System.out.println(e);
    		 	out.println("<div>Could Not Get User Records at the Moment</div>");
	}
%>


			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
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
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="plugins/morris/morris.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.js"></script>
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
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- page script -->
<script>
 $(document).ready(function() {
     var sos = (function () {
		var json = null;
		$.ajax({
			'async': false,
			'global': false,
			'url': "http://<%=defip%>/graph_data.jsp?q=social&uid=<%=user%>&cid=<%=clid%>",
			'dataType': "json",
			'timeout':600000,
			'success': function (data) {
				json = data.datasets;
				//alert(json);
				
			},
			'error': function (error) {
				
				alert("Error: Graphs Are Not Accessible Outside The Network");
			}
		}); 
		return json;
	})(); 
	var donut = new Morris.Donut({
	  element: 'sos',
	  resize: true,
	  colors: ["#3c8dbc", "#f56954", "#00a65a"],
	  data: sos,
	  hideHover: 'auto'
	});
 });
</script>
</body>
</html>