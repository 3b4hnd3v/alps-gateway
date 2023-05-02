package com.alps;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class Dhcp {
	String ip;
	String netmask;
	String submask;
	String broadcast;
	String gateway;
	
	Dao dao = new Dao();
	
	public String getIp() {
		return ip;
	}
	public String getNetmask() {
		return netmask;
	}
	public String getSubmask() {
		return submask;
	}
	public String getBroadcast() {
		return broadcast;
	}
	public String getGateway() {
		return gateway;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public void setNetmask(String netmask) {
		this.netmask = netmask;
	}
	public void setSubmask(String submask) {
		this.submask = submask;
	}
	public void setBroadcast(String broadcast) {
		this.broadcast = broadcast;
	}
	public void setGateway(String gateway) {
		this.gateway = gateway;
	}
	
	public Dhcp getDhcp(){
		Dhcp d = new Dhcp();
		try { 
			String wsip = dao.getSetting("wsip");
			String[] prop = wsip.split("-");
			System.out.println("current wsip : "+wsip);
			d.setIp(prop[0]);
			d.setSubmask(prop[1]);
			d.setNetmask(prop[2]);
			d.setGateway(prop[3]);
			d.setBroadcast(prop[4]);
			
		} catch(Exception e3) { System.out.println(e3); }
		return d;
	}
	
	public boolean setDhcp(){
		boolean d = false;
		try { 
			String wsip = ip+"-"+submask+"-"+netmask+"-"+gateway+"-"+broadcast;
			System.out.println(wsip);
			d = dao.updateSetting("wsip", wsip);
		} catch(Exception e3) { System.out.println(e3); }
		return d;
	}
	
	public boolean setDhcp(String ip,String netmask,String submask,String gateway,String broadcast){
		boolean d = false;
		try { 
			String wsip = ip+"-"+submask+"-"+netmask+"-"+gateway+"-"+broadcast;
			System.out.println(wsip);
			d = dao.updateSetting("wsip", wsip);
		} catch(Exception e3) { System.out.println(e3); }
		return d;
	}
	
	public static void main(String[] args){
		Dhcp d = new Dhcp();
		Dhcp d1 =d.getDhcp();
		System.out.println(d1.getIp());
		//d.setDhcp("172.27.5.99", "255.255.255.0", "/24", "172.27.5.1", "172.27.5.255");
	}
	
}
