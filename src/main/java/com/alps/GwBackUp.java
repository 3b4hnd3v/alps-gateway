package com.alps;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.ftp.FTPFunctions;

import me.legrange.mikrotik.ApiConnection;

public class GwBackUp {	
	
	
	static Dao dao = new Dao();
	static String ip = dao.getip();
	//String pass = "admin";
	static String pass = dao.getPass();
	//String user = "";
	static String user = dao.getUser();
	//String ip = "172.27.5.99";
	public GwBackUp(){
		
	}
	
	public boolean create(String name){
		boolean res = false;
		try{
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.setTimeout(60000);
			con.login(user,pass); 			
			List<Map<String, String>> rs = con.execute("/system/backup/save name="+name);
			if(rs != null){res = true;}
		}catch(Exception e){e.printStackTrace();}
		return res;
	}
	
	public boolean restore(String name){
		boolean res = false;
		try{
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			con.setTimeout(600);
			List<Map<String, String>> rs = con.execute("/system/backup/load name="+name);
			if(rs != null){res = true;}
		}catch(Exception e){}
		return res;
	}
	
	public void download(String name){
		 try {
			 FTPFunctions ftpobj = new FTPFunctions(ip, 21, user, pass);
			 ftpobj.downloadFTPFile(name, "/home/alps/ALPS/Backup/"+name);
		 } catch (Exception e) {
	            e.printStackTrace();
	        }
	}
	public void upload(String local, String fname){
		try {
			 FTPFunctions ftpobj = new FTPFunctions(ip, 21, user, pass);
			 ftpobj.uploadFTPFile(local, fname, "/");
		 } catch (Exception e) {
	            e.printStackTrace();
	        }
	}
	public ArrayList<String> list(){
		ArrayList<String> al = new ArrayList<String>();   
		try {
			 FTPFunctions ftpobj = new FTPFunctions(ip, 21, user, pass);
			 al = ftpobj.listFTPFiles("/");
		} catch (Exception e) {e.printStackTrace();}
		return al;
	}
	public boolean isGot(String filename){
		boolean res = false;
		try{
			String dircheck = "/home/alps/ALPS/Backup/"+filename;
			File f = new File(dircheck);

			  if(f.exists()){
				  res = true;
			  }else{
				  res = false;
			  }
		}catch (Exception e) {e.printStackTrace();}
		return res;
	}
	public static void main(String[] args){
		GwBackUp gb = new GwBackUp();
		gb.create("test1");
	}

}
