package com.alps;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LdpContent {
	int id;
	String name;
	String content;
	String value;
	String captive;
	Connection cn;
	Db db = new Db();
	
	
	public LdpContent(){
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getCaptive() {
		return captive;
	}
	public void setCaptive(String captive) {
		this.captive = captive;
	}
	public List<LdpContent> getAll(){
		List<LdpContent> lc = new ArrayList<LdpContent>();
		try{
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `ldpage` ORDER BY `name` ASC");
       	  	
       	  	while(rs.next()){
       	  		LdpContent c = new LdpContent();
       	  		c.setId(rs.getInt("id"));
       	  		c.setName(rs.getString("name"));
       	  		c.setContent(rs.getString("content"));
       	  		c.setValue(rs.getString("value"));
       	  		c.setCaptive(rs.getString("captive"));
			   
       	  		lc.add(c);
		    }
       	  	cn.close();
		}catch(Exception e){e.printStackTrace();}
		
		return lc;
	}
	public LdpContent getOne(String id){
	  	LdpContent c = new LdpContent();
		try{
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `ldpage` WHERE `id`="+id);
       	  	
       	  	while(rs.next()){
       	  		c.setId(rs.getInt("id"));
       	  		c.setName(rs.getString("name"));
       	  		c.setContent(rs.getString("content"));
       	  		c.setValue(rs.getString("value"));
       	  		c.setCaptive(rs.getString("captive"));
		   }
     	   cn.close();
		}catch(Exception e){e.printStackTrace();}
		
		return c;
	}
	public List<LdpContent> getCaptiveCont(String capt){
		List<LdpContent> lc = new ArrayList<LdpContent>();
		try{
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `ldpage` WHERE `captive`='"+capt+"' OR `captive`='All'");
       	  	
       	  	while(rs.next()){
       	  		System.out.println(rs.getString("name"));
       	  		LdpContent c = new LdpContent();
       	  		c.setId(rs.getInt("id"));
       	  		c.setName(rs.getString("name"));
       	  		c.setContent(rs.getString("content"));
       	  		c.setValue(rs.getString("value"));
       	  		c.setCaptive(rs.getString("captive"));
			   
       	  		lc.add(c);
		    }
       	  	cn.close();
		   
		}catch(Exception e){e.printStackTrace();}
		
		return lc;
	}
	
	public int update(){
		int psu = 0;
		try{
			cn = db.cn();
			PreparedStatement ps = cn.prepareStatement("UPDATE `ldpage` SET name=?, content=?, value=?, captive=? WHERE `id`=?");
			
			ps.setString(1,name);
			ps.setString(2,content);
			ps.setString(3,value);
			ps.setString(4,captive);
			ps.setInt(5,id);
			
			psu =  ps.executeUpdate();
			cn.close();
		}catch(Exception e){}
		return psu;
	}

}
