package com.alps.master;

import java.util.List;
import java.util.Map;

import me.legrange.mikrotik.ApiConnection;

public class MasterCounter {
	static Mao mao = new Mao();
	static String ip = mao.getSetting("ip");
	static String pass = mao.getSetting("username");
	static String user = mao.getSetting("password");
	MasterApi g = new MasterApi();
	public static void main(String[] args) {
		
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
