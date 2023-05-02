package com.pms.powerpro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PmsBilling {
	int id;
	String roomno;
	String price;
	String transid;
	String posttime;
	String status;
	
	Connection cn = null;

	public PmsBilling(){
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRoomno() {
		return roomno;
	}
	public void setRoomno(String roomno) {
		this.roomno = roomno;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getTransid() {
		return transid;
	}
	public void setTransid(String transid) {
		this.transid = transid;
	}
	public String getPosttime() {
		return posttime;
	}
	public void setPosttime(String posttime) {
		this.posttime = posttime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public Connection cn() {
		String dbhost="127.0.0.1", dbport="3306", dbname="pms", dbuser="ebahn", dbpass="ebahn";
		Connection cn1 = null;
		try { Class.forName("com.mysql.jdbc.Driver");
		cn1 = DriverManager.getConnection("jdbc:mysql://"+dbhost+":"+dbport+"/"+dbname, dbuser, dbpass);
		} catch(Exception e) { System.out.println(e); }
		return cn1;
	}
	
	public List<PmsBilling> getAll(){
		List<PmsBilling> lpb = new ArrayList<PmsBilling>();
		try{
			cn = cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `gr_voucher` ORDER BY `created` DESC");
       	  	while(rs.next()){
       	  		PmsBilling pb = new PmsBilling();
       	  		
       	  		pb.setId(rs.getInt("id"));
       	  		pb.setRoomno(rs.getString("room_no"));
       	  		pb.setTransid(rs.getString("username"));
       	  		pb.setPosttime(rs.getString("password"));
       	  		pb.setStatus(rs.getString("profile"));
       	  		pb.setPrice(rs.getString("price"));
       	  		lpb.add(pb);
		   }
     		cn.close();
		   
		}catch(Exception e){}
		
		return lpb;
	}
	public List<PmsBilling> getBy(String param, String val){
		List<PmsBilling> lpb = new ArrayList<PmsBilling>();
		try{
			cn = cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `gr_voucher` WHERE `"+param+"`='"+val+"' ORDER BY `created` DESC");
       	  	while(rs.next()){
       	  		PmsBilling pb = new PmsBilling();
       	  		
       	  		pb.setId(rs.getInt("id"));
       	  		pb.setRoomno(rs.getString("room_no"));
       	  		pb.setTransid(rs.getString("username"));
       	  		pb.setPosttime(rs.getString("password"));
       	  		pb.setStatus(rs.getString("profile"));
       	  		pb.setPrice(rs.getString("price"));
       	  		lpb.add(pb);
		   }
     		cn.close();
		   
		}catch(Exception e){}
		
		return lpb;
	}
	public int add(){
		int psu = 0;
		try{
			cn = cn();
			PreparedStatement ps = cn.prepareStatement("INSERT INTO `pms_billing` (`room_no`, `price`, `transid`) "
					+ "VALUES(?, ?, ?)");
			
			ps.setString(1,roomno);
			ps.setString(2,price);
			ps.setString(3,transid);
			
			psu =  ps.executeUpdate();
			cn.close();
		} catch (Exception e1) { System.out.println(e1); return 0;}
		return psu;
	}
	public boolean changeStatus(String id) {
		
        boolean result = false;
        try {
        	cn = cn();
			cn.createStatement().execute("UPDATE `pms_billing` SET `status`='1' WHERE `id`="+id);
			result = true;
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
			
		return result;
	}
}
