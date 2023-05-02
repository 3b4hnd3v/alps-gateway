package com.alps;

import java.net.InetAddress;
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
import java.util.Random;

import com.alps.Db;

public class Dao {
	Db db = new Db("jdbc:mysql://localhost/alpsgateway" , "ebahn", "ebahn");
	static Connection cn = null;
	
	public Dao() {
		//cn = db.cn();
	}
	
	public static void main(String[] args) {
		System.out.println("hi");
		
		Dao dao = new Dao();
		//dao.getRecipients();
		//dao.updateIp("172.27.5.66");
		//String myip = dao.getPass();
		
		System.out.print(dao.pingConnect("10.0.0.2"));
		
	}
	
	public String getip() {
		String ip = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='ip'"); rs.next();
			ip = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return ip;
	}
	public String getSetting(String param) {
		String v = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='"+param+"'"); rs.next();
			v = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

		return v;
	}
	public String getDashValue(String param) {
		// TODO Auto-generated method stub
		String cli = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE name='"+param+"'"); rs.next();
			cli = rs.getString("value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return cli;
		
	}
	public String getDashInfo(String param) {
		// TODO Auto-generated method stub
		String cli = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE name='"+param+"'"); rs.next();
			cli = rs.getString("info");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return cli;
		
	}
	public String getIpPath() {
		String ippath = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='ws_ippath'"); rs.next();
			ippath = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return ippath;
	}
	public String getPorts() {
		String ports = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='gateway_ports'"); rs.next();
			ports = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return ports;
	}
	public String getip(int val) {
		String ip = "";
		String val1 = String.valueOf(val);
		if(val == 0){val1 = "";}
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='ip"+val1+"'"); rs.next();
			ip = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return ip;
	}
	public String getWsip() {
		String wsip = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='wsip'"); rs.next();
			wsip = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return wsip;
	}
	public String getDefaultIp() {
		String wsip = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='default_ip'"); rs.next();
			wsip = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return wsip;
	}
	public String getUser() {
		String user = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='username'"); rs.next();
			user = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return user;
	}
	public String getPass() {
		String pass = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='password'"); rs.next();
			pass = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 

			
		return pass;
	}
	public String[] getRecipients() {
		int c = 0;
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT COUNT(`email`) as emailcount FROM `users` WHERE `email` IS NOT NULL AND `email`!='Not Applicable'");rs.next();
			c = rs.getInt("emailcount")+1;
			System.out.println(c);
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); } 
		String[] recp = new String[c];
		try {
			cn = db.cn();
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
	
	public boolean updateIp(String ip) {
		
        boolean result = false;
        try {
        	cn = db.cn();
			cn.createStatement().execute("UPDATE settings SET setting_value='"+ip+"' WHERE setting_name='ip'");
			result = true;
			System.out.println(result);
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	public boolean updateDefault(String ip) {
		
        boolean result = false;
        try {
        	cn = db.cn();
			cn.createStatement().execute("UPDATE settings SET setting_value='"+ip+"' WHERE setting_name='default_ip'");
			result = true;
			System.out.println(result);
			cn.close();
			
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	public String getLogdir() {
		// TODO Auto-generated method stub
		String dir = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='log_location'"); rs.next();
			dir = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return dir;
		
	}
	
	public String[] getWANIP() {
		String[] wanIp = new String[4];
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `settings` WHERE `setting_name` LIKE 'ip%'");
			int i=0;
			while(rs.next()){
				String wip = rs.getString("setting_value");
				wanIp[i] = wip;
				System.out.println("Wan:"+wanIp[i]);
			}
			i++;
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		
		return wanIp;
		
	}
	public String[] genVoucher(int stren) {
		String[] genv = new String[2];
		try {
			genv[0] = getSaltString(stren);
			genv[1] = getSaltString(stren);
		} catch (Exception e) { e.printStackTrace(); }
		
		return genv;
		
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
	public String getSocJson() {
		// TODO Auto-generated method stub
		String js = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='socurl'"); rs.next();
			js = rs.getString("setting_value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return js;
		
	}
	public String getClient() {
		// TODO Auto-generated method stub
		String cli = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE name='client'"); rs.next();
			cli = rs.getString("value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return cli;
		
	}
	public String getVersion() {
		// TODO Auto-generated method stub
		String cli = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE name='version'"); rs.next();
			cli = rs.getString("value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return cli;
		
	}
	
	public String getLocation() {
		// TODO Auto-generated method stub
		String cli = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE name='location'"); rs.next();
			cli = rs.getString("value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return cli;
		
	}
	public String getfreeUser() {
		// TODO Auto-generated method stub
		String cli = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='free_user'"); rs.next();
			cli = rs.getString("setting_value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return cli;
		
	}
	
	public String getfreePass() {
		// TODO Auto-generated method stub
		String cli = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='free_pass'"); rs.next();
			cli = rs.getString("setting_value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return cli;
		
	}
	
	public String getlpimg() {
		// TODO Auto-generated method stub
		String cli = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='lpimg'"); rs.next();
			cli = rs.getString("setting_value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return cli;
		
	}
	public String getInstallStatus() {
		// TODO Auto-generated method stub
		String ins = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `settings` WHERE `setting_name`='installation'"); rs.next();
			ins = rs.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return ins;
		
	}
	public String checklicense() {
		String result = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='license'"); 
			rs.next();
			String lic = rs.getString("setting_value");
			rs.close();
			cn.close();
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
	public String getLicenseMail() {
		// TODO Auto-generated method stub
		String cli = getClient();
		String license = "";
		String serialno = "";
		String licexp = "";
		String licact = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='license'"); rs.next();
			ResultSet rs2 = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='serialno'"); rs2.next();
			license = rs.getString("setting_value");
			serialno = rs2.getString("setting_value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE name='licexp'"); rs.next();
			ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE name='licact'"); rs1.next();
			licexp = rs.getString("value");
			licact = rs1.getString("value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		
		String licMail = "Hi "+cli+"<br> You receive this Email because you are listed as a <b>USER</b> in Alps Gateway deployed in <b>"+cli+"</b>.<br><br>We will Like to inform you that the license for the product <b>"+serialno+"</b> activated on "+licact+" "
				+ " is set to expire on "+licexp+".<br><p>Please be informed that gateway functionalities will be suspended after the expiry date. To avoid interruption, Please contact <a href='ebahn-solutions.com' target='_blank'>eBahn Solutions sdn bhd</a> or email us at: ebahnsolution@gmail.com."
						+ "<br><br>You can also call us at 01123765837.</p><p>Thank You.</p> ";
		return licMail;
		
	}
	public String getEventMail() {
		// TODO Auto-generated method stub
		String cli = getClient();
		String license = "";
		String serialno = "";
		String licexp = "";
		String licact = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='license'"); rs.next();
			ResultSet rs2 = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='serialno'"); rs2.next();
			license = rs.getString("setting_value").toString();
			serialno = rs2.getString("setting_value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE name='licexp'"); rs.next();
			ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM dashboard WHERE name='licact'"); rs1.next();
			licexp = rs.getString("value").toString();
			licact = rs1.getString("value").toString();
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		
		String licMail = "Hi "+cli+"<br> You receive this Email because you are listed as a <b>USER</b> in Alps Gateway deployed in <b>"+cli+"</b>.<br><br>We will Like to inform you that the license for the product <b>"+serialno+"</b> activated on "+licact+" "
				+ " is set to expire on "+licexp+".<br><p>Please be informed that gateway functionalities will be suspended after the expiry date. To avoid interruption, Please contact <a href='ebahn-solutions.com' target='_blank'>eBahn Solutions sdn bhd</a> or email us at: ebahnsolution@gmail.com."
						+ "<br><br>You can also call us at 01123765837.</p><p>Thank You.</p> ";
		return licMail;
		
	}
	public boolean updateSetting(String stid, String stn, String stv) {
		
        boolean result = false;
        try {
        	cn = db.cn();
			cn.createStatement().execute("UPDATE `settings` SET `setting_value`='"+stv+"' WHERE setting_name='"+stn+"' AND `id`="+stid);
			result = true;
			
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	public boolean cancelVoucher(String id) {
		
        boolean result = false;
        try {
        	cn = db.cn();
			cn.createStatement().execute("UPDATE `gr_postpaid` SET `status`='1' WHERE `id`="+id);
			result = true;
			
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	public boolean updateIP(String stn, String stv) {
		
        boolean result = false;
        try {
        	cn = db.cn();
			cn.createStatement().execute("UPDATE `settings` SET `setting_value`='"+stv+"' WHERE setting_name='"+stn+"'");
			result = true;
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	
	public boolean updateDash(String stn, String stv) {
		
        boolean result = false;
        try {
        	cn = db.cn();
			cn.createStatement().execute("UPDATE `dashboard` SET `value`='"+stv+"' WHERE name='"+stn+"'");
			result = true;
			cn.close();
				
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	
	public boolean deleteSetting(String stid) {
		
        boolean result = false;
        try {
        	cn = db.cn();
			cn.createStatement().execute("DELETE * FROM `settings` WHERE `id`="+stid);
			result = true;
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
	
	public boolean resetIP(String script) {
        boolean result = false;
        try {
        	if(script.equals("1WAN")){
	        	String defip = "172.27.5.81";
	        	if(updateIP("ip", defip)&&updateIP("ip1", "")&&updateIP("ip2", "")&&updateIP("ip3", "")){
	        		result = true;
	        	}
        	}else if(script.equals("2WAN")){
	        	String defip = "172.27.5.81";
	        	String defip1 = "172.27.5.82";
	        	
	        	if(updateIP("ip", defip)&&updateIP("ip1", defip1)&&updateIP("ip2", "")&&updateIP("ip3", "")){
	        		result = true;
	        	}
        	}else if(script.equals("3WAN")){
	        	String defip = "172.27.5.81";
	        	String defip1 = "172.27.5.82";
	        	String defip2 = "172.27.5.83";
	        	if(updateIP("ip", defip)&&updateIP("ip1", defip1)&&updateIP("ip2", defip2)&&updateIP("ip3", "")){
	        		result = true;
	        	}
	        	
        	}if(script.equals("4WAN")){
	        	String defip = "172.27.5.81";
	        	String defip1 = "172.27.5.82";
	        	String defip2 = "172.27.5.83";
	        	String defip3 = "172.27.5.84";
	        	if(updateIP("ip", defip)&&updateIP("ip1", defip1)&&updateIP("ip2", defip2)&&updateIP("ip3", defip3)){
	        		result = true;
	        	}
        	}else{
        		result = false;
        	}
				
		} catch (Exception e) { e.printStackTrace(); result = false; } 
			
		return result;
	}
	
	public boolean runSQLCom(String com){
		boolean result = false;
		
		try{
			cn = db.cn();
			cn.createStatement().execute(com);
			result = true;
			cn.close();
		}catch(Exception e){System.out.println(e);result = false;}
		
		return result;
	}
	
	public HashMap<String, String> getMenuItems(){
		HashMap<String, String> hm = new HashMap<String, String>();
		try { 
			cn = db.cn();
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
	
	public String getSerial(){
		String serial = null;
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `settings` where `setting_name` = 'serialno'"); rs.next();
			serial = rs.getString("setting_value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return serial;
	}
	public Timestamp getLastBan(String transmit) {
		Timestamp lbu = null;
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT `dailyup` AS lastbanup FROM `main_graph` WHERE `transmit`='"+transmit+"'"); rs.next();
			//lbu = rs.getString("lastbanup").toString();
			lbu = rs.getTimestamp("lastbanup");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return lbu;
		
	}
	
	public int getMonthBan(String month, String transmit){
		int mb = 0;
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT "+month+" AS mb FROM `main_graph` WHERE `transmit`='"+transmit+"'"); rs.next();
			mb = rs.getInt("mb");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return mb;
	}
	
	public boolean updateMonthBan(int nmb, String month, String transmit){
		boolean res = false;
		try {
			Calendar cal = Calendar.getInstance();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String now = dateFormat.format(cal.getTime());
			//TO DO Update dailyup
			cn = db.cn();
			cn.createStatement().execute("UPDATE `main_graph` SET "+month.toLowerCase()+"='"+nmb+"', `dailyup`='"+now+"' WHERE transmit='"+transmit+"'");
			res = true;
			cn.close();
			System.out.print(month.toLowerCase()+" updated to "+nmb+" at "+now);
		} catch (SQLException e) { e.printStackTrace(); }
		return res;
	}
	
	public String getLastBackUp(){
		String lpi = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `dashboard` WHERE `name`='lastbackup'"); rs.next();
			lpi = rs.getString("value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return lpi;
	}
	
	public String getAutoBackUp(){
		String lpo = "";
		try {
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `dashboard` WHERE `name`='autobackup'"); rs.next();
			lpo = rs.getString("value");
			rs.close();
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return lpo;
	}
	
	public boolean updateLP(String ntp, String mnt, String lp){
		boolean result = false;
		try {
			cn = db.cn();
			cn.createStatement().execute("UPDATE `dashboard` SET value='"+ntp+"' AND info='"+mnt+"' WHERE name='"+lp+"'");
			result = true;
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return result;
	}
	public boolean updatePMS(String pid, String pname, String padd, String pport, String puser, String pkey, String status){
		boolean result = false;
		try {
			cn = db.cn();
			cn.createStatement().execute("UPDATE `dashboard` SET name='"+pname+"',ip='"+padd+"',port='"+pport+"',user='"+puser+"',key='"+pkey+"',status='"+status+"' WHERE id="+pid);
			result = true;
			cn.close();
		} catch (SQLException e) { e.printStackTrace(); }
		return result;
	}
	public String SubMax() {
		String ip = "";
		try {
			cn = db.cn();
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
        	cn = db.cn();
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
        	cn = db.cn();
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
        	cn = db.cn();
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
        	cn = db.cn();
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
	public HashMap<String, String> getActivePms(){
		HashMap<String, String> hm = new HashMap<String, String>();
		try { 
			cn = db.cn();
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
	public boolean pingConnect(String stbip){
		boolean chkConnection = false;
		try{
			InetAddress address = InetAddress.getByName(stbip);
			chkConnection = address.isReachable(1000);
		}catch(Exception e){return chkConnection;}
			return chkConnection;
	}
}
