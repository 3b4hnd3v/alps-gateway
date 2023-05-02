<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="
javax.servlet.*,
org.apache.commons.lang3.StringUtils,
java.awt.EventQueue,
java.awt.event.ActionListener,
java.awt.event.ActionEvent,
java.util.Date,
java.io.*,
java.util.*,
org.json.simple.JSONArray,
org.json.simple.JSONObject,
org.json.simple.JSONValue,
org.json.simple.parser.JSONParser,
java.net.URL,
java.net.URLEncoder,
java.net.*,
java.net.HttpURLConnection,
java.net.MalformedURLException,
java.net.URLConnection,
java.io.BufferedReader,
java.util.Properties,
java.sql.Connection,
java.sql.DriverManager,
java.sql.ResultSet,
java.sql.Timestamp,
java.sql.SQLException,
java.sql.Statement,
java.sql.ResultSetMetaData,
java.sql.PreparedStatement,
java.util.Date,
java.text.DateFormat,
java.text.SimpleDateFormat,
java.util.Calendar,
java.io.BufferedWriter,
java.io.File,
java.io.FileOutputStream,
java.io.FileWriter,
java.io.IOException,
java.io.PrintWriter,
java.io.BufferedReader,
java.nio.charset.Charset,
java.nio.file.Files,
java.net.InetAddress,
java.nio.file.*,
com.api.graphing.InterfaceGraph,
com.api.graphing.BarGraph,
com.api.graphing.UserGraph,
com.api.graphing.Donut,
com.api.graphing.DataSrc
"%>
<%JSONObject jObject = new JSONObject(); InterfaceGraph ig = new InterfaceGraph(); DataSrc au = new DataSrc(); %>
<%
if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("monitor")){
	List<Integer> lan = new ArrayList<Integer>(),
	wan = new ArrayList<Integer>(),
	wan1 = new ArrayList<Integer>(),
	wan2 = new ArrayList<Integer>(),
	wan3 = new ArrayList<Integer>(),
	master = new ArrayList<Integer>(),
	lanin = new ArrayList<Integer>(),
	wanin = new ArrayList<Integer>(),
	wan1in = new ArrayList<Integer>(),
	wan2in = new ArrayList<Integer>(),
	wan3in = new ArrayList<Integer>(),
	masterin = new ArrayList<Integer>();
	
	List<InterfaceGraph> lig = new ArrayList<InterfaceGraph>();
	List<InterfaceGraph> ligin = new ArrayList<InterfaceGraph>();
    for (Map<String, String> mp : au.getInterface()) {
	  //System.out.println(r);
	  	 String interf = mp.get("name");
	  	 String intype = mp.get("type");
	  	 if(interf.equalsIgnoreCase("master")||intype.equalsIgnoreCase("ether")){
		  	 InterfaceGraph i = new InterfaceGraph(interf);
		  	 InterfaceGraph ii = new InterfaceGraph(interf);
	   	 
		   	 i.setLabel(interf+" - Out");
		   	 ii.setLabel(interf+" - In");
		   	 int j = 0;
		   	 for (Map<String, String> r : au.monitor(interf)){
		   		 if(j++ <= 11){		   		 
			   		 String name = r.get("name");
			   		 String txp =  r.get("tx-packets-per-second");
			   		 String rxp =  r.get("rx-packets-per-second");
			   		 if(name.equalsIgnoreCase("LAN")){
			   			 lan.add(Integer.parseInt(txp));
			   			 lanin.add(Integer.parseInt(rxp));
			   			 i.setData(lan);
			   			 ii.setData(lanin);
			   		 }else if(name.equalsIgnoreCase("WAN")){
			   			 wan.add(Integer.parseInt(txp));
			   			 wanin.add(Integer.parseInt(rxp));
			   			 i.setData(wan);
			   			 ii.setData(wanin);
			   		 }else if(name.equalsIgnoreCase("WAN1")){
			   			 wan1.add(Integer.parseInt(txp));
			   			 wan1in.add(Integer.parseInt(rxp));
			   			 i.setData(wan1);
			   			 ii.setData(wan1in);
			   		 }else if(name.equalsIgnoreCase("wAN2")){
			   			 wan2.add(Integer.parseInt(txp));
			   			 wan2in.add(Integer.parseInt(rxp));
			   			 i.setData(wan2);
			   			 ii.setData(wan2in);
			   		 }
			   		 else if(name.equalsIgnoreCase("wAN3")){
			   			 wan3.add(Integer.parseInt(txp));
			   			 wan3in.add(Integer.parseInt(rxp));
			   			 i.setData(wan3);
			   			 ii.setData(wan3in);
			   		 }
			   		 else if(name.equalsIgnoreCase("Master")){
			  			 master.add(Integer.parseInt(txp));
			  			 masterin.add(Integer.parseInt(rxp));
			  			 i.setData(master);
			  			 ii.setData(masterin);
			  		 }
		   	 	}
		   	 }
	   	 	 lig.add(i);
	   	 	 ligin.add(ii);
	  	 }
	}
	
	
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (InterfaceGraph igr : lig)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("label", igr.getLabel());
	         igJSON.put("fillColor", igr.getFillColor());
	         igJSON.put("strokeColor", igr.getStrokeColor());
	         igJSON.put("pointColor", igr.getPointColor());
	         igJSON.put("pointStrokeColor", igr.getPointStrokeColor());
	         igJSON.put("pointHighlightFill", igr.getPointHighlightFill());
	         igJSON.put("pointHighlightStroke", igr.getPointHighlightStroke());
	         igJSON.put("data", igr.getData());
	         jArray.add(igJSON);
	    }
	    for (InterfaceGraph igr : ligin)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("label", igr.getLabel());
	         igJSON.put("fillColor", igr.getFillColor());
	         igJSON.put("strokeColor", igr.getStrokeColor());
	         igJSON.put("pointColor", igr.getPointColor());
	         igJSON.put("pointStrokeColor", igr.getPointStrokeColor());
	         igJSON.put("pointHighlightFill", igr.getPointHighlightFill());
	         igJSON.put("pointHighlightStroke", igr.getPointHighlightStroke());
	         igJSON.put("data", igr.getData());
	         jArray.add(igJSON);
	    }
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("main")){
	System.out.println("lp");
	List<BarGraph> bar = new ArrayList<BarGraph>();
	List<Map<String,String>> data = au.getInterface();
	for (Map<String, String> mp : data) {
		String t = mp.get("type");
		if(!t.equalsIgnoreCase("vlan")){
			if(!String.valueOf(mp.get("comment")).contains("Default")){
		  		String y = mp.get("name");
			  	String a = mp.get("tx-packet");
			  	String b = mp.get("rx-packet");
			  	BarGraph bg = new BarGraph();
			  	bg.setY(y);
			  	bg.setA(Integer.parseInt(a));
			  	bg.setB(Integer.parseInt(b));
			  	
			  	bar.add(bg);
			}
		}
	}
	
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (BarGraph ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", ba.getY());
	         igJSON.put("a", ba.getA());
	         igJSON.put("b", ba.getB());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("location_packets")){
	System.out.println("lp");
	List<BarGraph> bar = new ArrayList<BarGraph>();
	List<Map<String,String>> data = au.getInterface();
	for (Map<String, String> mp : data) {
	  	 String intype = mp.get("type");
	  	 if(intype.equalsIgnoreCase("bridge")){
		  	String y = mp.get("name");
		  	String a = mp.get("tx-packet");
		  	String b = mp.get("rx-packet");
		  	BarGraph bg = new BarGraph();
		  	bg.setY(y);
		  	bg.setA(Integer.parseInt(a));
		  	bg.setB(Integer.parseInt(b));
		  	
		  	bar.add(bg);
	  	 }
	}
	
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (BarGraph ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", ba.getY());
	         igJSON.put("a", ba.getA());
	         igJSON.put("b", ba.getB());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("location_drops")){
	System.out.println("lp");
	List<BarGraph> bar = new ArrayList<BarGraph>();
	List<Map<String,String>> data = au.getInterface();
	for (Map<String, String> mp : data) {
	  	 String intype = mp.get("type");
	  	 if(intype.equalsIgnoreCase("bridge")){
		  	String y = mp.get("name");
		  	String a = mp.get("tx-drop");
		  	String b = mp.get("rx-drop");
		  	BarGraph bg = new BarGraph();
		  	bg.setY(y);
		  	bg.setA(Integer.parseInt(a));
		  	bg.setB(Integer.parseInt(b));
		  	
		  	bar.add(bg);
	  	 }
	}
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (BarGraph ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", ba.getY());
	         igJSON.put("a", ba.getA());
	         igJSON.put("b", ba.getB());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("location_errors")){
	System.out.println("lp");
	List<BarGraph> bar = new ArrayList<BarGraph>();
	List<Map<String,String>> data = au.getInterface();
	for (Map<String, String> mp : data) {
	  	 String intype = mp.get("type");
	  	 if(intype.equalsIgnoreCase("bridge")){
		  	String y = mp.get("name");
		  	String a = mp.get("tx-error");
		  	String b = mp.get("rx-error");
		  	BarGraph bg = new BarGraph();
		  	bg.setY(y);
		  	bg.setA(Integer.parseInt(a));
		  	bg.setB(Integer.parseInt(b));
		  	
		  	bar.add(bg);
	  	 }
	}
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (BarGraph ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", ba.getY());
	         igJSON.put("a", ba.getA());
	         igJSON.put("b", ba.getB());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("location_bytes")){
	List<BarGraph> bar = new ArrayList<BarGraph>();
	List<Map<String, String>> data = au.getInterface();
	for (Map<String, String> mp : data) {
	  	 String intype = mp.get("type");
	  	 if(intype.equalsIgnoreCase("bridge")){
		  	String y = mp.get("name");
		  	String a = mp.get("tx-byte");
		  	String b = mp.get("rx-byte");
		  	BarGraph bg = new BarGraph();
		  	//bg.setY(y);
		  	bg.setY(y);
		  	bg.setA(Long.parseLong(a));
		  	bg.setB(Long.parseLong(b));
		  	
		  	bar.add(bg);
	  	 }
	}
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (BarGraph ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", ba.getY());
	         igJSON.put("a", ba.getA());
	         igJSON.put("b", ba.getB());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("vlan_packets")){
	List<BarGraph> bar = new ArrayList<BarGraph>();
	List<Map<String,String>> data = au.getInterface();
	for (Map<String, String> mp : data) {
	  	 String intype = mp.get("type");
	  	 if(intype.equalsIgnoreCase("vlan")){
		  	String y = mp.get("name");
		  	String a = mp.get("tx-packet");
		  	String b = mp.get("rx-packet");
		  	BarGraph bg = new BarGraph();
		  	bg.setY(y);
		  	bg.setA(Integer.parseInt(a));
		  	bg.setB(Integer.parseInt(b));
		  	
		  	bar.add(bg);
	  	 }
	}
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (BarGraph ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", ba.getY());
	         igJSON.put("a", ba.getA());
	         igJSON.put("b", ba.getB());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("vlan_drops")){
	List<BarGraph> bar = new ArrayList<BarGraph>();
	List<Map<String, String>> data = au.getInterface();
	for (Map<String, String> mp : data) {
	  	 String intype = mp.get("type");
	  	 if(intype.equalsIgnoreCase("vlan")){
		  	String y = mp.get("name");
		  	String a = mp.get("tx-drop");
		  	String b = mp.get("rx-drop");
		  	BarGraph bg = new BarGraph();
		  	bg.setY(y);
		  	bg.setA(Integer.parseInt(a));
		  	bg.setB(Integer.parseInt(b));
		  	
		  	bar.add(bg);
	  	 }
	}
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (BarGraph ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", ba.getY());
	         igJSON.put("a", ba.getA());
	         igJSON.put("b", ba.getB());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("vlan_errors")){
	List<BarGraph> bar = new ArrayList<BarGraph>();
	List<Map<String, String>> data = au.getInterface();
	for (Map<String, String> mp : data) {
	  	 String intype = mp.get("type");
	  	 if(intype.equalsIgnoreCase("vlan")){
		  	String y = mp.get("name");
		  	String a = mp.get("tx-error");
		  	String b = mp.get("rx-error");
		  	BarGraph bg = new BarGraph();
		  	bg.setY(y);
		  	bg.setA(Long.parseLong(a));
		  	bg.setB(Long.parseLong(b));
		  	
		  	bar.add(bg);
	  	 }
	}
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (BarGraph ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", ba.getY());
	         igJSON.put("a", ba.getA());
	         igJSON.put("b", ba.getB());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("vlan_bytes")){
	List<BarGraph> bar = new ArrayList<BarGraph>();
	List<Map<String, String>> data = au.getInterface();
	for (Map<String, String> mp : data) {
	  	 String intype = mp.get("type");
	  	 if(intype.equalsIgnoreCase("vlan")){
		  	String y = mp.get("name");
		  	String a = mp.get("tx-byte");
		  	String b = mp.get("rx-byte");
		  	BarGraph bg = new BarGraph();
		  	bg.setY(y);
		  	bg.setA(Long.parseLong(a));
		  	bg.setB(Long.parseLong(b));
		  	
		  	bar.add(bg);
	  	 }
	}
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (BarGraph ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", ba.getY());
	         igJSON.put("a", ba.getA());
	         igJSON.put("b", ba.getB());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("ether_drops")){
	List<BarGraph> bar = new ArrayList<BarGraph>();
	List<Map<String, String>> data = au.getInterface();
	for (Map<String, String> mp : data) {
	  	 String intype = mp.get("type");
	  	 if(intype.equalsIgnoreCase("ether")){
		  	String y = mp.get("name");
		  	String a = mp.get("tx-drop");
		  	String b = mp.get("rx-drop");
		  	BarGraph bg = new BarGraph();
		  	bg.setY(y);
		  	bg.setA(Integer.parseInt(a));
		  	bg.setB(Integer.parseInt(b));
		  	
		  	bar.add(bg);
	  	 }
	}
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (BarGraph ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", ba.getY());
	         igJSON.put("a", ba.getA());
	         igJSON.put("b", ba.getB());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("user_packets")){
	
	List<UserGraph> use = new ArrayList<UserGraph>();
	List<Map<String,String>> data = au.getUser();
	for (Map<String, String> mp : data) {
	  	 
		  	String y = mp.get("name");
		  	String a = mp.get("packets-in");
		  	String b = mp.get("packets-out");
		  	UserGraph bg = new UserGraph();
		  	bg.setY(y);
		  	bg.setItem1(Integer.parseInt(a));
		  	bg.setItem2(Integer.parseInt(b));
		  	
		  	use.add(bg);
	  	 }
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (UserGraph us : use)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", us.getY());
	         igJSON.put("a", us.getItem1());
	         igJSON.put("b", us.getItem2());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}

}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("user_bytes")){
	
	List<UserGraph> use = new ArrayList<UserGraph>();
	List<Map<String,String>> data = au.getUser();
	for (Map<String, String> mp : data) {
	  	 
		  	String y = mp.get("name");
		  	String a = mp.get("bytes-in");
		  	String b = mp.get("bytes-out");
		  	UserGraph bg = new UserGraph();
		  	bg.setY(y);
		  	bg.setItem1(Integer.parseInt(a));
		  	bg.setItem2(Integer.parseInt(b));
		  	
		  	use.add(bg);
	  	 }
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (UserGraph us : use)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("y", us.getY());
	         igJSON.put("a", us.getItem1());
	         igJSON.put("b", us.getItem2());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}

}
else if(request.getParameter("q")!=null && request.getParameter("q").equalsIgnoreCase("social") && request.getParameter("uid")!=null && request.getParameter("cid")!=null){
	String uid = request.getParameter("uid");
	String cid = request.getParameter("cid");
	System.out.println(uid+"=="+cid);
	List<Donut> bar = au.social(cid, uid);
	try
	{
	    JSONArray jArray = new JSONArray();
	    for (Donut ba : bar)
	    {
	         JSONObject igJSON = new JSONObject();
	         igJSON.put("label", ba.getLabel());
	         igJSON.put("value", ba.getValue());
	         jArray.add(igJSON);
	    }
	    
	    jObject.put("datasets", jArray);
	} catch (Exception jse) {
	    jse.printStackTrace();
	}
}
//System.out.print(jObject);
response.setContentType("application/jsonp");
response.setHeader("Access-Control-Allow-Origin", "*");
response.setHeader("Access-Control-Allow-Credentials", "true");
response.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With");
response.setHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, PUT");
response.setHeader("Access-Control-Max-Age", "86400");
response.setCharacterEncoding("UTF-8");
response.getWriter().flush();
response.getWriter().print(jObject);
response.setContentType("text/html");
%>