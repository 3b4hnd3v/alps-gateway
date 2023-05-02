package com.alps.master;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import com.alps.Db;

public class Mao {
	//Db db = new Db("jdbc:mysql://localhost/alpsgateway?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT" , "ebahn", "ebahn");
	Db db = new Db();
	static Connection cn = null;
	
	public Mao() {
		cn = db.cn();
	}
	
	public static void main(String[] args) {
		System.out.println("hi");
		
		Mao dao = new Mao();
		//dao.getRecipients();
		//dao.updateIp("172.27.5.66");
		//String myip = dao.getPass();
		//System.out.print(myip);
		dao.getWANIP();
	}
	
	public String getip() {
		String ip = "";
		try {
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `master_set`  WHERE setting_name='ip'"); rs.next();
			ip = rs.getString("setting_value").toString();
			
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return ip;
	}
	public String getSetting(String param) {
		String v = "";
		try {
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `master_set`  WHERE setting_name='"+param+"'"); rs.next();
			v = rs.getString("setting_value").toString();
			
		} catch (SQLException e) { e.printStackTrace(); } 

		return v;
	}
	public String getip(int val) {
		String ip = "";
		String val1 = String.valueOf(val);
		if(val == 0){val1 = "";}
		try {
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `master_set`  WHERE setting_name='ip"+val1+"'"); rs.next();
			ip = rs.getString("setting_value").toString();
			
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return ip;
	}
	public String getDefaultIp() {
		String wsip = "";
		try {
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `master_set`  WHERE setting_name='default_ip'"); rs.next();
			wsip = rs.getString("setting_value").toString();
			
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return wsip;
	}
	public boolean updateSetting(String name, String val) {
		
        boolean result = false;
        try {
			cn.createStatement().execute("UPDATE `master_set` SET setting_value='"+val+"' WHERE setting_name='"+name+"'");
				result = true;
				System.out.println(result);
				//cn.close();
			
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	
	public String[] getWANIP() {
		String[] wanIp = new String[4];
		try {
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `master_set` WHERE `setting_name` LIKE 'ip%'");
			int i=0;
			while(rs.next()){
				String wip = rs.getString("setting_value");
				wanIp[i] = wip;
				System.out.println("Wan"+i+":"+wanIp[i]);
				i++;
			}
			
			
		} catch (SQLException e) { e.printStackTrace(); }
		
		return wanIp;
		
	}
	public boolean updateSetting(String stid, String stn, String stv) {
		
        boolean result = false;
        try {
			cn.createStatement().execute("UPDATE `master_set` SET `setting_value`='"+stv+"' WHERE setting_name='"+stn+"' AND `id`="+stid);
			result = true;
				
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	public boolean updateIP(String stn, String stv) {
		
        boolean result = false;
        try {
			cn.createStatement().execute("UPDATE `master_set` SET `setting_value`='"+stv+"' WHERE setting_name='"+stn+"'");
			result = true;
				
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
}
