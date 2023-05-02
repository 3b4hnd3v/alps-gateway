package com.alps;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class User {
	Db db = new Db();
	static Connection cn = null;
	
	public User() {
		cn = db.cn();
	}
	
	public int id;
	public String name;
	public String username;
	public String password;
	public String email;
	public String department;
	public String role;
	
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
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	
	public boolean addUser(){
		boolean result = false;
		
		try{
			PreparedStatement ps1 = cn.prepareStatement("INSERT INTO `users` (`username`, `password`, `name`, `email`, `department`, `role`) "
					+ "VALUES(?, ?, ?, ?, ?, ?)");
			ps1.setString(1,username);
			ps1.setString(2,password);
			ps1.setString(3,name);
			ps1.setString(4,email);
			ps1.setString(5,department);
			ps1.setString(6,role);
			
			if(ps1.executeUpdate() == 1){
				result = true;
			}
		}catch(Exception e){System.out.println(e);}
		
		return result;
		
	}
	
	public boolean update(){
		boolean result = false;
		
		try{
			PreparedStatement ps1 = cn.prepareStatement("UPDATE `users` SET `username`=?, `password`=?, `name`=?, `email`=?, `department`=?, `role`=? WHERE `user_id`=?");
			ps1.setString(1,username);
			ps1.setString(2,password);
			ps1.setString(3,name);
			ps1.setString(4,email);
			ps1.setString(5,department);
			ps1.setString(6,role);
			ps1.setInt(7,id);
			
			if(ps1.executeUpdate() == 1){
				result = true;
			}
		}catch(Exception e){System.out.println(e);}
		
		return result;
		
	}
	
	public ArrayList<User> getAllUsers(){
		ArrayList<User> allUsers = new ArrayList<User>();
		User us = new User();
		try {
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `users`");
			while (rs.next()){
				us.setId(rs.getInt("user_id"));
				us.setName(rs.getString("name"));
				us.setUsername(rs.getString("username"));
				us.setPassword(rs.getString("password"));
				us.setEmail(rs.getString("email"));
				us.setDepartment(rs.getString("department"));
				us.setRole(rs.getString("role"));
				allUsers.add(us);
			}
			System.out.println(allUsers.size());
		} catch(Exception e) { System.out.println(e); }
		return allUsers;
		
	}
	
	public User getUser(int id){
		User user = new User();
		try {
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `users` where `user_id`="+id);
			while (rs.next()){
				user.setId(rs.getInt("user_id"));
				user.setName(rs.getString("name"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setDepartment(rs.getString("department"));
				user.setRole(rs.getString("role"));
			}
		} catch(Exception e) { System.out.println(e); }
		return user;
	}
	public User getLogged(String username, String password, String name){
		User user = new User();
		try {
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `users` WHERE `name`='"+name+"' AND `username`='"+username+"' AND `password`='"+password+"'");
			while (rs.next()){
				user.setId(rs.getInt("user_id"));
				user.setName(rs.getString("name"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setDepartment(rs.getString("department"));
				user.setRole(rs.getString("role"));
			}
		} catch(Exception e) { System.out.println(e); }
		return user;
	}
	public boolean delete(int id){
		boolean result = false;
		try {
			cn.createStatement().execute("DELETE FROM `users` WHERE `user_id`="+id);
			result = true;
				
		} catch (Exception e) { e.printStackTrace(); } 
		return result;
	}
	public static void main(String args[]){
		User us = new User();
		ArrayList<User> x = us.getAllUsers();
		User us1 = x.get(4);

		System.out.println(us1.getRole());

	}

}
