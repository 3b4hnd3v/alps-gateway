package com.alps;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Db {
	
	static String dburl = "jdbc:mysql://localhost/alpsgateway";
	static String dbuser = "ebahn";
	static String dbpass = "ebahn";
	
	public Db() {
		
	}
	
	public Connection cn() { 
		return connect(dburl, dbuser, dbpass);
	}

	public Db(String dburl, String dbuser, String dbpass) {
		this.dburl = dburl;
		this.dbuser = dbuser;
		this.dbpass = dbpass;
		connect(dburl, dbuser, dbpass);
	}
	
	public Connection connect() {
		Connection conn = null;
		try { 
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dburl, dbuser, dbpass); 
		} catch (SQLException e) { 
			System.out.println(e); 
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return conn;
	}

	Connection connect(String dburl, String dbuser, String dbpass) {
		Connection conn = null;
		try { 
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dburl, dbuser, dbpass); 
		} catch (SQLException e) { 
			System.out.println(e); 
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return conn;
	}

}
