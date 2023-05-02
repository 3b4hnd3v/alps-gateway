package com.alps;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class License {

    public static void main(String[] args) {
        
    	String generated = generateLicense("EBAHN Technology","Fri, 25 Dec 2015 23:40:18 GMT");
        System.out.println(generated);
    }
    
    public static String generateLicense(String company, String expiry) {
		
		String passwordToHash = company.concat(expiry);
        String generatedLicense = null;
        try {
            // Create MessageDigest instance for MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            //Add password bytes to digest
            md.update(passwordToHash.getBytes());
            //Get the hash's bytes
            byte[] bytes = md.digest();
            //This bytes[] has bytes in decimal format;
            //Convert it to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< bytes.length ;i++)
            {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            //Get complete hashed password in hex format
            //long timestamp = System.currentTimeMillis()/1000;
            DateFormat dateFormat = new SimpleDateFormat("EEE, dd MMM yyyy hh:mm:ss z");
            Date date = dateFormat.parse(expiry);
            long unixTime = (long) date.getTime()/1000;
            String s = String.valueOf(unixTime);
            generatedLicense = sb.toString()+"-"+s;
			
		} catch (Exception e) { e.printStackTrace(); } 
			
		return generatedLicense;
	}
    
    public static String activeLicense(String licstr) {
		
        String activeLicense = null;
        try {
            
			
		} catch (Exception e) { e.printStackTrace(); } 
			
		return activeLicense;
	}

}
