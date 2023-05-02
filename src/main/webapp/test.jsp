<%@include file="header.jsp" %>
<%@page import="java.io.*" %>
<%@page import="java.net.*" %>

<%
   String recv;
   String recvbuff = "";
   URL jsonpage = new URL("http://alpsgateway.svntechnology.com/json.php");
   URLConnection urlcon = jsonpage.openConnection();
   BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream()));

   while ((recv = buffread.readLine()) != null){
    recvbuff += recv;
    
   
   }
   buffread.close();
   
   Object obj=JSONValue.parse(recvbuff);
   JSONArray array=(JSONArray)obj;
   for(int i=1; i< array.size(); i++){
	   System.out.println("======the 2nd element of array======");
	   System.out.println(array.get(i));
	                 
	   JSONObject obj2=(JSONObject)array.get(i);
	   System.out.println("======field \"1\"==========");
	   System.out.println(obj2.get("id"));
	   //System.out.println(recvbuff);
   }
%>