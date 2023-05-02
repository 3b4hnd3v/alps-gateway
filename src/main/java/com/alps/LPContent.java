package com.alps;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class LPContent {
	int id;
	String logo;
	String bgimg;
	String title;
	String about;
	String footer;
	String nametag;
	String captive;
	String features;
	String tnc;
	String video;
	String wait;
	
	Connection cn = null;
	Db db = new Db();
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getBgimg() {
		return bgimg;
	}
	public void setBgimg(String bgimg) {
		this.bgimg = bgimg;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAbout() {
		return about;
	}
	public void setAbout(String about) {
		this.about = about;
	}
	public String getFooter() {
		return footer;
	}
	public void setFooter(String footer) {
		this.footer = footer;
	}
	public String getNametag() {
		return nametag;
	}
	public void setNametag(String nametag) {
		this.nametag = nametag;
	}
	public String getCaptive() {
		return captive;
	}
	public void setCaptive(String captive) {
		this.captive = captive;
	}
	public String getFeatures() {
		return features;
	}
	public void setFeatures(String features) {
		this.features = features;
	}
	public String getTnc() {
		return tnc;
	}
	public void setTnc(String tnc) {
		this.tnc = tnc;
	}
	public String getVideo() {
		return video;
	}
	public void setVideo(String video) {
		this.video = video;
	}
	public String getWait() {
		return wait;
	}
	public void setWait(String wait) {
		this.wait = wait;
	}
	
	public List<LPContent> getAll(){
		List<LPContent> lr = new ArrayList<LPContent>();
		try{
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `ldcontent`");
       	  	
       	  	while(rs.next()){
       	  		LPContent r = new LPContent();
       	  		r.setId(rs.getInt("id"));
       	  		r.setLogo(rs.getString("logo"));
       	  		r.setBgimg(rs.getString("bgimg"));
       	  		r.setTitle(rs.getString("title"));
       	  		r.setAbout(rs.getString("about"));
       	  		r.setFooter(rs.getString("footer"));
       	  		r.setNametag(rs.getString("nametag"));
       	  		r.setCaptive(rs.getString("captive"));
       	  		r.setTnc(rs.getString("tnc"));
       	  		r.setFeatures(rs.getString("features"));
       	  		r.setVideo(rs.getString("video"));
       	  		r.setWait(rs.getString("wait"));
       	  		lr.add(r);
		   }
       	   rs.close();
       	   cn.close();
		}catch(Exception e){e.printStackTrace();}
		
		return lr;
	}
	
	public List<LPContent> getOne(String val){
		List<LPContent> lr = new ArrayList<LPContent>();
		try{
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `ldcontent` where `id` ="+val);
       	  	
       	  	while(rs.next()){
	       	  	LPContent r = new LPContent();
	   	  		r.setId(rs.getInt("id"));
	   	  		r.setLogo(rs.getString("logo"));
	   	  		r.setBgimg(rs.getString("bgimg"));
	   	  		r.setTitle(rs.getString("title"));
	   	  		r.setAbout(rs.getString("about"));
	   	  		r.setFooter(rs.getString("footer"));
	   	  		r.setNametag(rs.getString("nametag"));
	   	  		r.setCaptive(rs.getString("captive"));
	   	  		r.setTnc(rs.getString("tnc"));
	   	  		r.setFeatures(rs.getString("features"));
	   	  		r.setVideo(rs.getString("video"));
	   	  		r.setWait(rs.getString("wait"));
	   	  		lr.add(r);
		   }
       	  	rs.close();
     		cn.close();
		   
		}catch(Exception e){}
		
		return lr;
	}
	public LPContent getOne(String param, String val){
		LPContent r = new LPContent();
		try{
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `ldcontent` where "+param+" = '"+val+"'");
       	  	
       	  	while(rs.next()){
	       	  	r.setId(rs.getInt("id"));
	   	  		r.setLogo(rs.getString("logo"));
	   	  		r.setBgimg(rs.getString("bgimg"));
	   	  		r.setTitle(rs.getString("title"));
	   	  		r.setAbout(rs.getString("about"));
	   	  		r.setFooter(rs.getString("footer"));
	   	  		r.setNametag(rs.getString("nametag"));
	   	  		r.setCaptive(rs.getString("captive"));
	   	  		r.setTnc(rs.getString("tnc"));
	   	  		r.setFeatures(rs.getString("features"));
	   	  		r.setVideo(rs.getString("video"));
	   	  		r.setWait(rs.getString("wait"));

		   }
       	  	rs.close();
     		cn.close();
		}catch(Exception e){}
		
		return r;
	}
	public int update(String item, String val, String id){
		int psu = 0;
		try{
			cn = db.cn();
			PreparedStatement ps = cn.prepareStatement("UPDATE `ldcontent` SET  `"+item+"`=? WHERE `id`=?");
			ps.setString(1,val);
			ps.setString(2,id);
			
			psu =  ps.executeUpdate();
			cn.close();
		} catch (Exception e1) { System.out.println(e1); return 0;}
		return psu;
	}

}
