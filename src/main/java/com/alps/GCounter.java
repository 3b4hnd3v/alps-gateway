package com.alps;


import java.util.List;
import java.util.Map;
import com.alps.*;

import me.legrange.mikrotik.ApiConnection;

public class GCounter {
	static Dao dao = new Dao();
	static String ip = dao.getSetting("default_ip");
	//String pass = "admin";
	static String pass = dao.getSetting("password");
	//String user = "";
	static String user = dao.getSetting("username");
	//static String ip = "172.27.5.96";
	Gateway g = new Gateway();

	public static void main(String[] args) {
		System.out.println(ip+"="+pass+"="+user);
		GCounter gt = new GCounter();
		for (Map<String,String> r : gt.users()) {
			  System.out.println(r);
			}
	}
	
	// Count Users
	public List<Map<String, String>> users() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/hotspot/user/print count-only");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	// Count Active Users
	public List<Map<String, String>> activeUsers() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/hotspot/active/print count-only");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> BypassedUsers() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/arp/print count-only where interface=Bypass");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	// Count Hosts
	public List<Map<String, String>> hosts() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/hotspot/host/print count-only");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	//Count Interfaces
	public List<Map<String, String>> interfaces() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/interface/print count-only");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	// Count Users
	public List<Map<String, String>> vlans(String bn) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/interface/bridge/port/print count-only where bridge='"+bn+"'");;
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public int totPacIn(){
		int totpacin=0;
		
        try{
	    	for (Map<String,String> mp : g.interfaces()) {
	  	   		totpacin = totpacin + Integer.parseInt(mp.get("rx-packet"));
	    	}
    	}catch(Exception e){System.out.print(e);}
		
		return totpacin;
	}
	
	public int totPacOut(){
		int totpacout=0;
		
        try{
	    	for (Map<String,String> mp : g.interfaces()) {
	  	   		totpacout = totpacout + Integer.parseInt(mp.get("tx-packet"));
	    	}
    	}catch(Exception e){System.out.print(e);}
		
		return totpacout;
	}
	
	public int totDropsOut(){
		int ret=0;
		
        try{
	    	for (Map<String,String> mp : g.interfaces()) {
	    		String packets = mp.get("tx-drop");
	    		ret = ret + Integer.parseInt(packets);
	    	}
    	}catch(Exception e){System.out.print(e);}
		
		return ret;
	}
	
	public int totDropsIn(){
		int ret=0;
		
        try{
	    	for (Map<String,String> mp : g.interfaces()) {
	    		String packets = mp.get("tx-drop");
	    		ret = ret + Integer.parseInt(packets);
	    	}
    	}catch(Exception e){System.out.print(e);}
		
		return ret;
	}
	
	public int totErrorsIn(){
		int ret=0;
		
        try{
	    	for (Map<String,String> mp : g.interfaces()) {
	    		ret = ret + Integer.parseInt(mp.get("tx-error"));
	    	}
    	}catch(Exception e){System.out.print(e);}
		
		return ret;
	}
	
	public int totErrorsOut(){
		int ret=0;
		
        try{
	    	for (Map<String,String> mp : g.interfaces()) {
	    		ret = ret + Integer.parseInt(mp.get("rx-error"));
	    	}
    	}catch(Exception e){System.out.print(e);}
		
		return ret;
	}

}
