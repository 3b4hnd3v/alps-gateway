package com.api.graphing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Master {
	String ip;
	String username;
	String password;
	Connection cn = null;
	DbCon db = new DbCon();
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Master(){}
	
	public Master(int t){
		
		try{
			ip = getSetting("default_ip");
			username = getSetting("username");
			password = getSetting("password");
			
		}catch(Exception e){System.out.print(e);}

	}
	
	public Gateway getInfo(){
		Gateway g = new Gateway();
		try{
			g.setIp(getSetting("default_ip"));
			g.setUsername(getSetting("username"));
			g.setPassword(getSetting("password"));
		}catch(Exception e){e.printStackTrace();}
		return g;
	}
	
	private String getSetting(String name){
		String pass = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM master_set WHERE setting_name='"+name+"'"); rs.next();
			pass = rs.getString("setting_value").toString();
			//System.out.print(pass);
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return pass;
	}
	public static void main(String[] args){
		Gateway g = new Gateway();
		Gateway g1 = g.getInfo();
		System.out.println(g1.getIp()+""+g1.getUsername()+"'"+g1.getPassword()+"'");
	}
}
