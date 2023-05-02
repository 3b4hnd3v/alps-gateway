package com.alps;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class LMOIpList {
	int id;
	String interf;
	String address;
	String mask;
	String network;
	String status;
	String assigned;
	String added;
	
	Db db = new Db();
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getInterf() {
		return interf;
	}
	public void setInterf(String interf) {
		this.interf = interf;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMask() {
		return mask;
	}
	public void setMask(String mask) {
		this.mask = mask;
	}
	public String getNetwork() {
		return network;
	}
	public void setNetwork(String network) {
		this.network = network;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAssigned() {
		return assigned;
	}
	public void setAssigned(String assigned) {
		this.assigned = assigned;
	}
	public String getAdded() {
		return added;
	}
	public void setAdded(String added) {
		this.added = added;
	}
	
	public ArrayList<LMOIpList> getAll(){
		ArrayList<LMOIpList> all = new ArrayList<LMOIpList>();
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `lmo_iplist`");
			while (rs.next()){
				LMOIpList us = new LMOIpList();
				us.setId(rs.getInt("id"));
				us.setInterf(rs.getString("interf"));
				us.setAddress(rs.getString("address"));
				us.setMask(rs.getString("mask"));
				us.setNetwork(rs.getString("network"));
				us.setStatus(rs.getString("status"));
				us.setAssigned(rs.getString("assigned"));
				us.setAdded(rs.getString("added"));
				all.add(us);
			}
			//System.out.println(all.size());
			cn.close();
		} catch(Exception e) { System.out.println(e); }
		return all;
		
	}
	public ArrayList<LMOIpList> getBy(String param, String val){
		ArrayList<LMOIpList> all = new ArrayList<LMOIpList>();
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `lmo_iplist` WHERE `"+param+"`='"+val+"'");
			while (rs.next()){
				LMOIpList us = new LMOIpList();
				us.setId(rs.getInt("id"));
				us.setInterf(rs.getString("interf"));
				us.setAddress(rs.getString("address"));
				us.setMask(rs.getString("mask"));
				us.setNetwork(rs.getString("network"));
				us.setStatus(rs.getString("status"));
				us.setAssigned(rs.getString("assigned"));
				us.setAdded(rs.getString("added"));
				all.add(us);
			}
			//System.out.println(all.size());
			cn.close();
		} catch(Exception e) { System.out.println(e); }
		return all;
		
	}
	
	public LMOIpList getOne(String id){
		LMOIpList us = new LMOIpList();
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `lmo_iplist` WHERE `id`="+id);
			while (rs.next()){
				us.setId(rs.getInt("id"));
				us.setInterf(rs.getString("interf"));
				us.setAddress(rs.getString("address"));
				us.setMask(rs.getString("mask"));
				us.setNetwork(rs.getString("network"));
				us.setStatus(rs.getString("status"));
				us.setAssigned(rs.getString("assigned"));
				us.setAdded(rs.getString("added"));
			}
			cn.close();
		} catch(Exception e) { System.out.println(e); }
		return us;
		
	}
	
	public boolean delete(String id){
		boolean result = false;
		try {
			Connection cn = db.cn();
			cn.createStatement().execute("DELETE FROM `lmo_iplist` WHERE `id`="+id);
			result = true;
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
		return result;
	}
	
	public boolean add(){
		boolean result = false;
		
		try{
			Connection cn = db.cn();
			PreparedStatement ps1 = cn.prepareStatement("INSERT INTO `lmo_iplist` (`interf`, `address`, `mask`, `network`) "
					+ "VALUES(?, ?, ?, ?)");
			ps1.setString(1,interf);
			ps1.setString(2,address);
			ps1.setString(3,mask);
			ps1.setString(4,network);
			
			if(ps1.executeUpdate() == 1){
				result = true;
			}
			cn.close();
		}catch(Exception e){System.out.println(e);}
		
		return result;
		
	}
	public boolean changeStat(String id, String stat, String assigned){
		boolean result = false;
		try {
			Connection cn = db.cn();
			PreparedStatement ps1 = cn.prepareStatement("UPDATE `lmo_iplist` SET `status`=?, `assigned`=? WHERE `id`=?");
			ps1.setString(1,stat);
			ps1.setString(2,assigned);
			ps1.setString(3,id);
			if(ps1.executeUpdate() == 1){
				result = true;
			}
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
		return result;
	}

}
