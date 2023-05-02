package com.alps;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Captive {
	int id;
	String desc;
	String url;
	String imgloc;
	
	Db db = new Db();
	Connection cn = null;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getImgloc() {
		return imgloc;
	}
	public void setImgloc(String imgloc) {
		this.imgloc = imgloc;
	}
	
	public List<Captive> getAll(){
		List<Captive> lr = new ArrayList<Captive>();
		try{
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `captive_type`");
       	  	
       	  	while(rs.next()){
       	  		Captive r = new Captive();
       	  		r.setId(rs.getInt("id"));
       	  		r.setDesc(rs.getString("description"));
       	  		r.setUrl(rs.getString("homepage"));
       	  		r.setImgloc(rs.getString("imgloc"));
       	  		lr.add(r);
		   }
       	   //cn.close();
		}catch(Exception e){e.printStackTrace();}
		
		return lr;
	}
	public List<Captive> getOne(String val){
		List<Captive> lr = new ArrayList<Captive>();
		try{
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `captive_type` where `id` = '"+val+"'");
       	  	
       	  	while(rs.next()){
       	  		Captive r = new Captive();
       	  		r.setId(rs.getInt("id"));
       	  		r.setDesc(rs.getString("description"));
       	  		r.setUrl(rs.getString("homepage"));
       	  		r.setImgloc(rs.getString("imgloc"));

       	  		lr.add(r);
		   }
     		//cn.close();
		   
		}catch(Exception e){}
		
		return lr;
	}
	public List<Captive> getOne(String param, String val){
		List<Captive> lr = new ArrayList<Captive>();
		try{
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `captive_type` where "+param+" = '"+val+"'");
       	  	
       	  	while(rs.next()){
       	  		Captive r = new Captive();
       	  		r.setId(rs.getInt("id"));
       	  		r.setDesc(rs.getString("description"));
       	  		r.setUrl(rs.getString("homepage"));
       	  		r.setImgloc(rs.getString("imgloc"));

       	  		lr.add(r);
		   }
     		//cn.close();
		}catch(Exception e){}
		
		return lr;
	}
	public String getImgloc(String capt){
		String ret = "";
		try{
			ResultSet rs = cn.createStatement().executeQuery("SELECT imgloc FROM `captive_type` where `id`= '"+capt+"'");rs.next();
			ret = rs.getString(0);
		}catch(Exception e){}
		return ret;
	}
	
}
