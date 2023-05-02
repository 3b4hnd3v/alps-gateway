package com.api.graphing;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbPms {
	String dburl = "jdbc:mysql://localhost/pms";
	String dbuser = "ebahn";
	String dbpass = "ebahn";
	
	public DbPms() {
		//
	}
	
	public static void main(String[] args) {
		DbPms db = new DbPms("jdbc:mysql://localhost/pms" , "ebahn", "ebahn");

	}
	
	public Connection cn() { return connect(dburl, dbuser, dbpass); }

	public DbPms(String dburl, String dbuser, String dbpass) {
		this.dburl = dburl;
		this.dbuser = dbuser;
		this.dbpass = dbpass;
		connect(dburl, dbuser, dbpass);
	}
	
	public Connection connect() {
		Connection conn = null;
		try { conn = DriverManager.getConnection(dburl, dbuser, dbpass); } catch (SQLException e) { System.out.println(e); }	
		return conn;
	}

	Connection connect(String dburl, String dbuser, String dbpass) {
		Connection conn = null;
		try { conn = DriverManager.getConnection(dburl, dbuser, dbpass); } catch (SQLException e) { System.out.println(e); }	
		return conn;
	}

}
