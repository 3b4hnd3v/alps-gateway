package com.alps;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MonitorLogs {
	int id;
	String event;
	String device;
	String mac;
	String ip;
	String notes;
	String message;
	String added;
	
	Db db = new Db();
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
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
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getAdded() {
		return added;
	}
	public void setAdded(String added) {
		this.added = added;
	}
	
	public ArrayList<MonitorLogs> getAll(){
		ArrayList<MonitorLogs> all = new ArrayList<MonitorLogs>();
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `monitor_logs`");
			while (rs.next()){
				MonitorLogs us = new MonitorLogs();
				us.setId(rs.getInt("id"));
				us.setEvent(rs.getString("event"));
				us.setDevice(rs.getString("device"));
				us.setIp(rs.getString("ipadd"));
				us.setMac(rs.getString("mac"));
				us.setNotes(rs.getString("notes"));
				us.setMessage(rs.getString("message"));
				us.setAdded(rs.getString("added"));
				all.add(us);
			}
			//System.out.println(all.size());
			cn.close();
		} catch(Exception e) { System.out.println(e); }
		return all;
		
	}
	public ArrayList<MonitorLogs> getBy(String param, String val){
		ArrayList<MonitorLogs> all = new ArrayList<MonitorLogs>();
		try {
			Connection cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `monitor_logs` WHERE `"+param+"`='"+val+"'");
			while (rs.next()){
				MonitorLogs us = new MonitorLogs();
				us.setId(rs.getInt("id"));
				us.setEvent(rs.getString("event"));
				us.setDevice(rs.getString("device"));
				us.setMac(rs.getString("mac"));
				us.setIp(rs.getString("ipadd"));
				us.setNotes(rs.getString("notes"));
				us.setMessage(rs.getString("message"));
				us.setAdded(rs.getString("added"));
				all.add(us);
			}
			//System.out.println(all.size());
			cn.close();
		} catch(Exception e) { System.out.println(e); }
		return all;
		
	}

}
