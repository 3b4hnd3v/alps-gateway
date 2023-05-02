package com.alps;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Bypass {
	int id;
	String device;
	String mac;
	String rate;
	String start;
	String end;
	String repeat;
	String status;
	String item;
	String added;
	
	Db db = new Db();

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDevice() {
		return device;
	}

	public void setDevice(String device) {
		this.device = device;
	}

	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getRepeat() {
		return repeat;
	}

	public void setRepeat(String repeat) {
		this.repeat = repeat;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public String getAdded() {
		return added;
	}

	public void setAdded(String added) {
		this.added = added;
	}
	
	public boolean add(){
		boolean result = false;
		
		try{
			Connection cn = db.cn();
			PreparedStatement ps1 = cn.prepareStatement("INSERT INTO `bypass` (`device`, `mac`, `rate`, `start`, `end`, `repeats`) "
					+ "VALUES(?, ?, ?, ?, ?, ?)");
			ps1.setString(1,device);
			ps1.setString(2,mac);
			ps1.setString(3,rate);
			ps1.setString(4,start);
			ps1.setString(5,end);
			ps1.setString(6,repeat);
			
			if(ps1.executeUpdate() == 1){
				result = true;
			}
			cn.close();
		}catch(Exception e){System.out.println(e);}
		
		return result;
		
	}
	public ArrayList<Bypass> getAll(){
		ArrayList<Bypass> all = new ArrayList<Bypass>();
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `bypass`");
			while (rs.next()){
				Bypass us = new Bypass();
				us.setId(rs.getInt("id"));
				us.setDevice(rs.getString("device"));
				us.setMac(rs.getString("mac"));
				us.setRate(rs.getString("rate"));
				us.setStart(rs.getString("start"));
				us.setEnd(rs.getString("end"));
				us.setRepeat(rs.getString("repeats"));
				us.setStatus(rs.getString("status"));
				us.setItem(rs.getString("item"));
				us.setAdded(rs.getString("addedon"));
				all.add(us);
			}
			System.out.println(all.size());
			cn.close();
		} catch(Exception e) { System.out.println(e); }
		return all;
		
	}
	public ArrayList<Bypass> getBy(String param, String val){
		ArrayList<Bypass> all = new ArrayList<Bypass>();
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `bypass` WHERE `"+param+"`='"+val+"'");
			while (rs.next()){
				Bypass us = new Bypass();
				us.setId(rs.getInt("id"));
				us.setDevice(rs.getString("device"));
				us.setMac(rs.getString("mac"));
				us.setRate(rs.getString("rate"));
				us.setStart(rs.getString("start"));
				us.setEnd(rs.getString("end"));
				us.setRepeat(rs.getString("repeats"));
				us.setStatus(rs.getString("status"));
				us.setItem(rs.getString("item"));
				us.setAdded(rs.getString("addedon"));
				all.add(us);
			}
			System.out.println(all.size());
			cn.close();
		} catch(Exception e) { System.out.println(e); }
		return all;
		
	}
	public ArrayList<Bypass> checkSchedule(String day, String time){
		ArrayList<Bypass> all = new ArrayList<Bypass>();
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `bypass` WHERE `repeats` LIKE '%"+day+"%' AND `start`='"+time+"'");
			while (rs.next()){
				Bypass us = new Bypass();
				us.setId(rs.getInt("id"));
				us.setDevice(rs.getString("device"));
				us.setMac(rs.getString("mac"));
				us.setRate(rs.getString("rate"));
				us.setStart(rs.getString("start"));
				us.setEnd(rs.getString("end"));
				us.setRepeat(rs.getString("repeats"));
				us.setStatus(rs.getString("status"));
				us.setItem(rs.getString("item"));
				us.setAdded(rs.getString("addedon"));
				all.add(us);
			}
			System.out.println("Found "+all.size());
			cn.close();
		} catch(Exception e) { System.out.println(e); }
		return all;
		
	}
	public Bypass getOne(String id){
		Bypass us = new Bypass();
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `bypass` WHERE `id`="+id);
			while (rs.next()){
				us.setId(rs.getInt("id"));
				us.setDevice(rs.getString("device"));
				us.setMac(rs.getString("mac"));
				us.setRate(rs.getString("rate"));
				us.setStart(rs.getString("start"));
				us.setEnd(rs.getString("end"));
				us.setRepeat(rs.getString("repeats"));
				us.setStatus(rs.getString("status"));
				us.setItem(rs.getString("item"));
				us.setAdded(rs.getString("addedon"));
				cn.close();
			}
		} catch(Exception e) { System.out.println(e); }
		return us;
		
	}
	
	public boolean delete(String id){
		boolean result = false;
		try {
			Connection cn = db.cn();
			cn.createStatement().execute("DELETE FROM `bypass` WHERE `id`="+id);
			result = true;
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
		return result;
	}
	
	public boolean changeStat(String id, String stat){
		boolean result = false;
		try {
			Connection cn = db.cn();
			PreparedStatement ps1 = cn.prepareStatement("UPDATE `bypass` SET `status`=? WHERE `id`=?");
			ps1.setString(1,stat);
			ps1.setString(2,id);
			if(ps1.executeUpdate() == 1){
				result = true;
			}
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
		return result;
	}
	
	public boolean setBypassItem(String id, String item){
		boolean result = false;
		try {
			Connection cn = db.cn();
			PreparedStatement ps1 = cn.prepareStatement("UPDATE `bypass` SET `item`=? WHERE `id`=?");
			ps1.setString(1,item);
			ps1.setString(2,id);
			if(ps1.executeUpdate() == 1){
				result = true;
			}
			cn.close();
		} catch (Exception e) { e.printStackTrace(); } 
		return result;
	}
}
