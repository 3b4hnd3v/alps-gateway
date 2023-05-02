package com.api.graphing;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.*;

import me.legrange.mikrotik.ApiConnection;
import me.legrange.mikrotik.MikrotikApiException;
import me.legrange.mikrotik.ResultListener;

public class DataSrc {
	GatewayApi g= new GatewayApi();
	MasterApi mg= new MasterApi();
	PrimeCounter pc = new PrimeCounter();
	public static void main(String[] args){
		DataSrc ds = new DataSrc();
		for (Map<String,String> r : ds.getInterface()){

		System.out.println(r);
		}
		//ds.social("Epsom", "James Wong");
	}
	
	public List<Map<String, String>> Test() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = g.connectApi();
			
			rs = con.execute("/ip/hotspot/user/print");
			//rs = con.execute("/ip/hotspot/user/print");
			/*for (Map<String,String> r : rs){
				String interf = r.get("name");
				//monitor(interf);
			}*/
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String,String>> getEthernet() {
		List<Map<String,String>> lgi = null;
		try {
			ApiConnection con = g.connectApi();
			List<Map<String,String>> rs = con.execute("/interface/ethernet/print");
			lgi = rs;
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return lgi;
	}
	public List<Map<String,String>> getInterface() {
		List<Map<String,String>> lgi = null;
		try {
			ApiConnection con = g.connectApi();
			List<Map<String,String>> rs = con.execute("/interface/print");
			lgi = rs;
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return lgi;
	}
	public List<Map<String,String>> getWanInterface() {
		List<Map<String,String>> lgi = null;
		try {
			ApiConnection con = mg.connectApi();
			List<Map<String,String>> rs = con.execute("/interface/print");
			lgi = rs;
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return lgi;
	}
	public List<Map<String,String>> getUser() {
		List<Map<String,String>> lgi = null;
		try {
			ApiConnection con = g.connectApi();
			List<Map<String,String>> rs = con.execute("/ip/hotspot/user/print");
			lgi = rs;
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return lgi;
	}
	public boolean isActive(String interf){
		boolean res = false;
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = g.connectApi(); 
			rs = con.execute("/interface/print where name="+interf);
			if(!rs.isEmpty()){
				res = true;
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return res;
	}
	
	public List<Map<String,String>> User() {
		List<Map<String,String>> us = null;
		try {
			ApiConnection con = g.connectApi();
			List<Map<String,String>> 
			rs = con.execute("/ip/hotspot/user/print");
			us = rs;
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return us;
	}
	
	public List<Map<String, String>> monitor(String interf){
		final List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
		final ApiConnection con = g.connectApi(); 
		try {
			con.setTimeout(60000);
		} catch (MikrotikApiException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		String tag="";
		if(isActive(interf)){
			try {
				
				long start = System.currentTimeMillis();
				System.out.println( start / 1000000);
				tag = con.execute("/interface/monitor-traffic interface="+interf, 
					      new ResultListener() {

								public void receive(Map<String, String> result) {
						            		rs.add(result);
					            }

					           public void error(MikrotikApiException e) {
					               System.out.println("An error occurred: " + e.getMessage());
					           }

					           public void completed() {
					                System.out.println("Asynchronous command has finished"); 
					                
					           }

					        }
					  );
					pc.countPrimes(10);
					//long end = System.currentTimeMillis();
					//System.out.println( end / 1000000);
					//System.out.println((end - start) / 1000000);
					con.cancel(tag);
					con.close();
			} catch(Exception e1) { e1.printStackTrace(); }
			
		}
		
		return rs;
	}
	
	public List<Donut> social(String cid, String uid){
		List<Donut> bar = new ArrayList<Donut>();
		System.out.println(uid+"=="+cid);
		try{
			   String jsonurl = "http://developers.alpsgateway.com/json.php";
			
			   String url = jsonurl+"?cli="+URLEncoder.encode(cid, "UTF-8")+"&username="+URLEncoder.encode(uid, "UTF-8");
			   //System.out.println(url);
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
			   for(int i=1; i< array.size(); i++){
				  
				   JSONObject obj2=(JSONObject)array.get(i);
				   String location = obj2.get("location").toString();
				   String login = obj2.get("visit").toString();
				   System.out.println(location+"=="+login);
				   Donut d = new Donut();
				   d.setLabel(location);
				   d.setValue(Long.valueOf(login));
				   
				   bar.add(d);
			   }
			   System.out.println(bar.size());
			} catch(Exception e) { System.out.println(e);}
		return bar;
	}
	

	
}
