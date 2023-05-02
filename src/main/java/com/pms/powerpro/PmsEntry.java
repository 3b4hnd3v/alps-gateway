package com.pms.powerpro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PmsEntry {
	String client;
	int id;
	String guestname;
	String lastname;
	String language;
	String sflag;
	String roomnum;
	String acctnum;
	String promocode;
	String chkodate;
	
	Connection cn = null;

	public PmsEntry(String user){
		client = user;
		
	}
	public PmsEntry(){
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGuestname() {
		return guestname;
	}
	public void setGuestname(String guestname) {
		this.guestname = guestname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getSflag() {
		return sflag;
	}
	public void setSflag(String sflag) {
		this.sflag = sflag;
	}
	public String getRoomnum() {
		return roomnum;
	}
	public void setRoomnum(String roomnum) {
		this.roomnum = roomnum;
	}
	public String getAcctnum() {
		return acctnum;
	}
	public void setAcctnum(String acctnum) {
		this.acctnum = acctnum;
	}
	public String getPromocode() {
		return promocode;
	}
	public void setPromocode(String promocode) {
		this.promocode = promocode;
	}
	public String getChkodate() {
		return chkodate;
	}
	public void setChkodate(String chkodate) {
		this.chkodate = chkodate;
	}
	
	public Connection cn() {
		String dbhost="127.0.0.1", dbport="3306", dbname="alpsgateway", dbuser="ebahn", dbpass="ebahn";
		Connection cn1 = null;
		try { Class.forName("com.mysql.jdbc.Driver");
		cn1 = DriverManager.getConnection("jdbc:mysql://"+dbhost+":"+dbport+"/pms", dbuser, dbpass);
		} catch(Exception e) { System.out.println(e); }
		return cn1;
	}
	
	public List<PmsEntry> getAll(){
		List<PmsEntry> lpe = new ArrayList<PmsEntry>();
		try{
			cn = cn();
			ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `guestinfo`");
         	while(rs1.next()){
         		PmsEntry pe = new PmsEntry();
         		pe.setId(Integer.parseInt(rs1.getString("id")));
         		pe.setGuestname(rs1.getString("guestname"));
         		pe.setLastname(rs1.getString("lastname"));
         		pe.setLanguage(rs1.getString("language"));
         		pe.setSflag(rs1.getString("sflag"));
         		pe.setRoomnum(rs1.getString("roomnum"));
         		pe.setAcctnum(rs1.getString("acctnum"));
         		pe.setPromocode(rs1.getString("promocode"));
         		pe.setChkodate(rs1.getString("chkodate"));
         		
         		lpe.add(pe);
         	}
         	cn.close();
		}catch(Exception e){System.out.println(e);}
		
		return lpe;
	}
	public PmsEntry getOne(String id){
 		PmsEntry pe = new PmsEntry();
		try{
			cn = cn();
			ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `guestinfo` WHERE `id`="+id);
         	while(rs1.next()){
         		pe.setId(Integer.parseInt(rs1.getString("id")));
         		pe.setGuestname(rs1.getString("guestname"));
         		pe.setLastname(rs1.getString("lastname"));
         		pe.setLanguage(rs1.getString("language"));
         		pe.setSflag(rs1.getString("sflag"));
         		pe.setRoomnum(rs1.getString("roomnum"));
         		pe.setAcctnum(rs1.getString("acctnum"));
         		pe.setPromocode(rs1.getString("promocode"));
         		pe.setChkodate(rs1.getString("chkodate"));
         		
         	}
         	cn.close();
		}catch(Exception e){System.out.println("X"+e);}
		
		return pe;
	}
	public int add(){
		int psu = 0;
		try{
			cn = cn();
			PreparedStatement ps = cn.prepareStatement("INSERT INTO `guestinfo` (`guestname`, `lastname`, `language`, `sflag`, `roomnum`, `acctnum`, `promocode`, `chkodate`) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?)");
			ps.setString(1,guestname);
			ps.setString(2,lastname);
			ps.setString(3,language);
			ps.setString(4,sflag);
			ps.setString(5,roomnum);
			ps.setString(6,acctnum);
			ps.setString(7,promocode);
			ps.setString(8,chkodate);
			
			psu =  ps.executeUpdate();
			cn.close();
		} catch (Exception e1) { System.out.println(e1); return 0;}
		return psu;
	}
	public boolean delete(String id){
		boolean result = false;
		try{
			cn = cn();
			cn.createStatement().execute("DELETE FROM `guestinfo` WHERE id="+id);
			result = true;
			cn.close();
		} catch (Exception e1) { System.out.println(e1); return result;}
		return result;
	}
	
	public boolean delete(String rn, String rid){
		boolean result = false;
		try{
			cn = cn();
			cn.createStatement().execute("DELETE FROM `guestinfo` WHERE roomnum='"+rn+"' AND acctnum='"+rid+"'");
			result = true;
			cn.close();
		} catch (Exception e1) { System.out.println(e1); return result;}
		return result;
	}
	
	public int update(){
		int psu = 0;
		try{
			cn = cn();
			PreparedStatement ps = cn.prepareStatement("UPDATE `guestinfo` SET guestname=?, lastname=?, sflag=?, roomnum=?, acctnum=?, promocode=?, chkodate=? WHERE `id`=?");
			
			ps.setString(1,guestname);
			ps.setString(2,lastname);
			ps.setString(3,sflag);
			ps.setString(4,roomnum);
			ps.setString(5,acctnum);
			ps.setString(6,promocode);
			ps.setString(7,chkodate);
			ps.setInt(8,id);
			
			psu =  ps.executeUpdate();
			cn.close();
		} catch (Exception e1) { System.out.println(e1); return 0;}
		return psu;
	}
	
	public int update(String rn){
		int psu = 0;
		try{
			cn = cn();
			PreparedStatement ps = cn.prepareStatement("UPDATE `guestinfo` SET guestname=?, lastname=?, sflag=?, roomnum=?, acctnum=?, promocode=?, chkodate=? WHERE `roomnum`=?");
			
			ps.setString(1,guestname);
			ps.setString(2,lastname);
			ps.setString(3,sflag);
			ps.setString(4,roomnum);
			ps.setString(5,acctnum);
			ps.setString(6,promocode);
			ps.setString(7,chkodate);
			ps.setString(8,rn);
			
			psu =  ps.executeUpdate();
			cn.close();
		} catch (Exception e1) { System.out.println(e1); return 0;}
		return psu;
	}
	public int update(String nrn, String rid, String orn){
		int psu = 0;
		try{
			cn = cn();
			PreparedStatement ps = cn.prepareStatement("UPDATE `guestinfo` SET `roomnum`=? WHERE `roomnum`=? AND `acctnum`=?");
			
			ps.setString(1,nrn);
			ps.setString(2,orn);
			ps.setString(3,rid);
			
			psu =  ps.executeUpdate();
			cn.close();
		} catch (Exception e1) { System.out.println(e1); return 0;}
		return psu;
	}
	
}
