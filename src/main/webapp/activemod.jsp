<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>

<p></p>

<p id="demo"></p>

<%@page import="
javax.servlet.*,
java.util.Date,
java.net.URL,
java.util.Arrays
"%>
<%
String x = "";
String uri = request.getRequestURI();
String pagename = uri.substring(uri.lastIndexOf("/")+1);
out.println(pagename.substring(0,pagename.length()-4)+"<br>");
String section = pagename.substring(0,pagename.length()-4);
String sectionid = "index";

String[] gwsetting = {"quickset","ipchange","ipchange_single","dhcpws"};
String[] hotspot = {"hotspot","hotspot_wg"};
String[] locmw = {"locations_mw","new_location_mw","new_vlanloc_mw","add_vlan_mw"};
String[] loc = {"locations","new_location","new_vlanloc","add_vlan"};
String[] multiwan = {"multiwan_int","multiwan_qki"};
String[] manv = {"man_voucher","gen_voucher","man_voucher_sales"};
String[] conf = {"conf_rooms","conf_sched","conf_sales"};
String[] guest_mgt = {"social","guest"};
String[] prepaid = {"activate_purchase","manage_pp"};
String[] superuser = {"module_admin","license_admin","mwsettings"};
String[] content_mgt = {"captive","captive_set"};
String[] qrcode = {"qrcode_gen","wifiqr"};
String[] subscr = {"subscribers","subplans","subbills"};

if(section.equals("activemod")){
	sectionid = "index";
}else if(Arrays.asList(gwsetting).contains(section)){
	sectionid = "gwsetting";
}else if(Arrays.asList(locmw).contains(section)){
	sectionid = "locmw";
}else if(Arrays.asList(loc).contains(section)){
	sectionid = "loc";
}else if(Arrays.asList(multiwan).contains(section)){
	sectionid = "multiwan";
}else if(Arrays.asList(manv).contains(section)){
	sectionid = "manv";
}else if(Arrays.asList(conf).contains(section)){
	sectionid = "conf";
}else if(Arrays.asList(guest_mgt).contains(section)){
	sectionid = "guest_mgt";
}else if(Arrays.asList(prepaid).contains(section)){
	sectionid = "prepaid";
}else if(Arrays.asList(superuser).contains(section)){
	sectionid = "superuser";
}else if(Arrays.asList(hotspot).contains(section)){
	sectionid = "hotspot";
}else if(Arrays.asList(content_mgt).contains(section)){
	sectionid = "content_mgt";
}else if(Arrays.asList(qrcode).contains(section)){
	sectionid = "qrcode";
}else if(Arrays.asList(subscr).contains(section)){
	sectionid = "subscr";
}else if(section.equals("sched_bypass")){
	sectionid = "schedb";
}else{
	//out.println(section);
	sectionid = section;
}
%>
<input type="hidden" id="section" readonly value="<% out.print(sectionid);%>">
<script>
document.addEventListener("DOMContentLoaded", function(){
	    var sec = document.getElementById("section").value;
	    var el = document.getElementById(sec);
	    if(el) {
	      el.className += el.className ? ' active' : 'active';
	      el.scrollIntoView({block: "end", behavior: "smooth"});
	    }
	    //alert(sec);
	},false);
</script>

</body>
</html>