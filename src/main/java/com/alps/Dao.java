package com.alps;

import java.net.InetAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Random;


public class Dao {
	Db db = new Db();
	
	public String getSetting(String param) {
		String ret = "";
		
		try {
			Connection cn = db.connect();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='"+param+"'"); 
			if(rs.next()) {
				ret = rs.getString("setting_value").toString();
			}
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 
		
		return ret;
	}
	
	public String getDashValue(String param) {
		String ret = "";
		
		try {
			Connection cn = db.connect();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE `name`='"+param+"'"); 
			if(rs.next()) {
				ret = rs.getString("value");
			}
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 
		
		return ret;
	}
	
	public String getDashInfo(String param) {
		String ret = "";
		
		try {
			Connection cn = db.connect();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE `name`='"+param+"'"); 
			if(rs.next()) {
				ret = rs.getString("info");
			}
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 
		
		return ret;
	}
	public boolean updateSetting(String stid, String stn, String stv) {
		
        boolean result = false;
        try {
        	Connection cn = db.cn();
			cn.createStatement().execute("UPDATE `settings` SET `setting_value`='"+stv+"' WHERE setting_name='"+stn+"' AND `id`="+stid);
			result = true;
			
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	
	public boolean updateSetting(String stn, String stv) {
		
        boolean result = false;
        try {
        	Connection cn = db.cn();
			cn.createStatement().execute("UPDATE `settings` SET `setting_value`='"+stv+"' WHERE setting_name='"+stn+"'");
			result = true;
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	
	public boolean updateDash(String stn, String stv) {
		
        boolean result = false;
        try {
        	Connection cn = db.cn();
			cn.createStatement().execute("UPDATE `dashboard` SET `value`='"+stv+"' WHERE name='"+stn+"'");
			result = true;
			cn.close();
				
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	
	public boolean runSQLCom(String com){
		boolean result = false;
		
		try{
			Connection cn = db.cn();
			cn.createStatement().execute(com);
			result = true;
			cn.close();
		}catch(Exception e){System.out.println(e);result = false;}
		
		return result;
	}
	
	//OPERATIONAL
	
	public HashMap<String, String> getActivePms(){
		HashMap<String, String> hm = new HashMap<String, String>();
		try { 
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM pms WHERE status='1'");
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			if(rs.next()){
				// The column count starts from 1
				for (int i = 1; i <= columnCount; i++ ) {
				  String name = rsmd.getColumnName(i);
				  String val = rs.getString(name);
				  //System.out.println(name+" = "+val);
				  hm.put(name, val);
				}
			}
			rs.close();
			cn.close();
		} catch(Exception e4) { System.out.println(e4); }
		return hm;
	}
	
	public boolean updateLP(String ntp, String mnt, String lp){
		boolean result = false;
		try {
			Connection cn = db.cn();
			cn.createStatement().execute("UPDATE `dashboard` SET value='"+ntp+"' AND info='"+mnt+"' WHERE name='"+lp+"'");
			result = true;
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return result;
	}
	public boolean updatePMS(String pid, String pname, String padd, String pport, String puser, String pkey, String status){
		boolean result = false;
		try {
			Connection cn = db.cn();
			cn.createStatement().execute("UPDATE `dashboard` SET name='"+pname+"',ip='"+padd+"',port='"+pport+"',user='"+puser+"',key='"+pkey+"',status='"+status+"' WHERE id="+pid);
			result = true;
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return result;
	}
	public String SubMax() {
		String ip = "";
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SHOW TABLE STATUS WHERE `Name` = 'subscribers'"); rs.next();
			ip = rs.getString("Auto_increment").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 
		return ip;
	}
	public boolean addSubPlan(String name, String rate, String price, String duration, String unit) {
        boolean result = false;
        try{
        	Connection cn = db.cn();
			PreparedStatement ps1 = cn.prepareStatement("INSERT INTO `subplans` (`name`, `rate`, `price`, `unit`, `duration`) "
					+ "VALUES(?, ?, ?, ?, ?)");
			
			ps1.setString(1,name);
			ps1.setString(2,rate);
			ps1.setString(3,price);
			ps1.setString(4,unit);
			ps1.setString(5,duration);
			
			result = ps1.executeUpdate()>0;
		}catch(Exception e){System.out.println(""+e);}
			
		return result;
	}
	public boolean updateSubPlan(String id, String name, String rate, String price, String duration, String unit) {
        boolean result = false;
        try{
        	Connection cn = db.cn();
			PreparedStatement ps1 = cn.prepareStatement("UPDATE `subplans` SET `name`=?, `rate`=?, `price`=?, `unit`=?, `duration`=? "
					+ "WHERE id=?");
			
			ps1.setString(1,name);
			ps1.setString(2,rate);
			ps1.setString(3,price);
			ps1.setString(4,unit);
			ps1.setString(5,duration);
			ps1.setString(6,id);
			
			result = ps1.executeUpdate()>0;
		}catch(Exception e){System.out.println(""+e);}
			
		return result;
	}
	public boolean addSubscriber(String name, String email, String mobile, String plan, String device, String duration) {
        boolean result = false;
        try{
        	String cb  = DateUtils.NextBill(Integer.valueOf(duration));
        	Connection cn = db.cn();
			PreparedStatement ps1 = cn.prepareStatement("INSERT INTO `subscribers` (`name`, `email`, `mobile`, `plan`, `device`, `curr_bill`) "
					+ "VALUES(?, ?, ?, ?, ?, ?)");
			
			ps1.setString(1,name);
			ps1.setString(2,email);
			ps1.setString(3,mobile);
			ps1.setString(4,plan);
			ps1.setString(5,device);
			ps1.setString(6,cb);
			
			result = ps1.executeUpdate()>0;
		}catch(Exception e){System.out.println(""+e);}
			
		return result;
	}
	public boolean addBilling(String subscriber, String plan, String amount, String duration) {
        boolean result = false;
        try{
        	String cb  = DateUtils.NextBill(Integer.valueOf(duration));
        	String curr  = DateUtils.NowBill();
        	Connection cn = db.cn();
			PreparedStatement ps1 = cn.prepareStatement("INSERT INTO `subbills` (`subscriber`, `plan`, `amount`, `bill_for`, `bill_to`) "
					+ "VALUES(?, ?, ?, ?, ?)");
			
			ps1.setString(1,subscriber);
			ps1.setString(2,plan);
			ps1.setString(3,amount);
			ps1.setString(4,curr);
			ps1.setString(5,cb);
			
			result = ps1.executeUpdate()>0;
		}catch(Exception e){System.out.println(""+e);}
			
		return result;
	}
	public boolean addLicense(String license, String gendate) {
        boolean result = false;
        try{
        	
        	Connection cn = db.cn();
			PreparedStatement ps1 = cn.prepareStatement("INSERT INTO `system_license` (`license`, `gendate`) "
					+ "VALUES(?, ?)");
			
			ps1.setString(1,license);
			ps1.setString(2,gendate);
			
			result = ps1.executeUpdate()>0;
		}catch(Exception e){System.out.println(""+e);}
			
		return result;
	}
	public String[] getRecipients() {
		int c = 0;
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT COUNT(`email`) as emailcount FROM `users` WHERE `email` IS NOT NULL AND `email`!='Not Applicable'");rs.next();
			c = rs.getInt("emailcount")+1;
			System.out.println(c);
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 
		String[] recp = new String[c];
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `users`");
			int a = 0;
			while(rs.next()){
				String r = rs.getString("email");
				if(r != null){
					recp[a]=r;
				}
				
				a++;
			}
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return recp;
	}
	public String checklicense() {
		String result = "";
		try {
			String lic = getDashValue("license");
			String licunix = lic.split("-")[1];
			
			long timestamp = System.currentTimeMillis()/1000;
			String s = String.valueOf(timestamp);
			System.out.println(timestamp+"=="+licunix);
			if(timestamp > Integer.parseInt(licunix)){
				result = "invalid";
			}else{
				result = "valid";
			}
		} catch(Exception e) { System.out.println(e); }
		return result;
	}
	public String[] genVoucher(int stren) {
		String[] genv = new String[2];
		try {
			genv[0] = getSaltString(stren);
			genv[1] = getSaltString(stren);
		} catch (Exception e) { e.printStackTrace(); }
		
		return genv;
		
	}
	public boolean cancelVoucher(String id) {
		
        boolean result = false;
        try {
        	Connection cn = db.cn();
			cn.createStatement().execute("UPDATE `gr_postpaid` SET `status`='1' WHERE `id`="+id);
			result = true;
			
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	protected String getSaltString(int stren) {
        String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@#$%&*_-=!";
        StringBuilder salt = new StringBuilder();
        Random rnd = new Random();
        while (salt.length() < stren) { // length of the random string.
            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
            salt.append(SALTCHARS.charAt(index));
        }
        String saltStr = salt.toString();
        return saltStr;

    }
	public HashMap<String, String> getMenuItems(){
		HashMap<String, String> hm = new HashMap<String, String>();
		try { 
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM modules");
			while(rs.next()){
				String name = rs.getString("name");
				String stat = rs.getString("active");
				
				hm.put(name, stat);
			}
			rs.close();
			cn.close();
		} catch(Exception e4) { System.out.println(e4); }
		return hm;
	}
	public String getLicenseMail() {
		// TODO Auto-generated method stub
		String cli = getDashValue("client");
		String license = getDashValue("license");
		String serialno = getSetting("serialno");
		String licexp = getDashValue("licexp");
		String licact = getDashValue("licact");
		
		String licMail = "Hi "+cli+"<br> You receive this Email because you are listed as a <b>USER</b> in Alps Gateway deployed in <b>"+cli+"</b>.<br><br>We will Like to inform you that the license for the product <b>"+serialno+"</b> activated on "+licact+" "
				+ " is set to expire on "+licexp+".<br><p>Please be informed that gateway functionalities will be suspended after the expiry date. To avoid interruption, Please contact <a href='ebahn-solutions.com' target='_blank'>eBahn Solutions sdn bhd</a> or email us at: ebahnsolution@gmail.com."
						+ "<br><br>You can also call us at 01123765837.</p><p>Thank You.</p> ";
		return licMail;
		
	}
	public String getEventMail() {
		// TODO Auto-generated method stub
		String cli = getDashValue("client");
		String license = getDashValue("client");
		String serialno = getSetting("serialno");
		String licexp = getDashValue("licexp");
		String licact = getDashValue("licact");
		
		String licMail = "Hi "+cli+"<br> You receive this Email because you are listed as a <b>USER</b> in Alps Gateway deployed in <b>"+cli+"</b>.<br><br>We will Like to inform you that the license for the product <b>"+serialno+"</b> activated on "+licact+" "
				+ " is set to expire on "+licexp+".<br><p>Please be informed that gateway functionalities will be suspended after the expiry date. To avoid interruption, Please contact <a href='ebahn-solutions.com' target='_blank'>eBahn Solutions sdn bhd</a> or email us at: ebahnsolution@gmail.com."
						+ "<br><br>You can also call us at 01123765837.</p><p>Thank You.</p> ";
		return licMail;
		
	}
	public boolean pingConnect(String stbip){
		boolean chkConnection = false;
		try{
			InetAddress address = InetAddress.getByName(stbip);
			chkConnection = address.isReachable(1000);
		}catch(Exception e){return chkConnection;}
		return chkConnection;
	}
}
