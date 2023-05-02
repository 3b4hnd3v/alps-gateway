package com.api.graphing;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbCon {
	String dburl = "jdbc:mysql://localhost/alpsgateway?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT";
	String dbuser = "ebahn";
	String dbpass = "ebahn";
	
	public DbCon() {
		//
	}
	
	public static void main(String[] args) {
		DbCon db = new DbCon();

	}
	
	public Connection cn() { return connect(dburl, dbuser, dbpass); }
	
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
