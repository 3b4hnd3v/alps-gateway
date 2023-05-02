package com.api.graphing;

import java.util.List;
import java.util.Map;

import me.legrange.mikrotik.ApiConnection;

public class MasterApi {
	String ip;
	String username;
	String pass;
	Gateway gw = null;

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public MasterApi(){
		System.out.println("GCONN Request");
		Master g = new Master();
		gw = g.getInfo();
		username = gw.getUsername();
		pass = gw.getPassword();
		ip = gw.getIp();
		System.out.println(ip+"-"+username+"-"+pass);
	}
	
	public ApiConnection connectApi(){
		ApiConnection con = null;
		try {
			con = ApiConnection.connect(ip); // connect to router
			con.setTimeout(60000);
			con.login(username,pass); 
		} catch(Exception e1) {e1.printStackTrace(); return con;}
		return con;
	}
	
	public static void main(String[] args)
	{
		try{
			MasterApi ga = new MasterApi();
			List<Map<String, String>> rs = null;
			ApiConnection con = ga.connectApi();
			rs = con.execute("/interface/print");
			for (Map<String,String> r : rs) {
				System.out.println(r);
			}
			con.close();
			
		} catch(Exception e1) { e1.printStackTrace(); }
	}

}
