package com.ftp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.ResultSet;

import org.apache.commons.net.PrintCommandListener;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;

import com.alps.Db;

import static org.junit.Assert.assertTrue;
 
public class UpdateFTP {
	Db db = new Db("jdbc:mysql://localhost/alpsgateway" , "ebahn", "ebahn");
	static Connection cn = null;
	
	public UpdateFTP() {
		cn = db.cn();
	}
	public static void main(String[] args) {
		UpdateFTP uf = new UpdateFTP();
		uf.editFTP("hotspot", "#bar");
	}
	
	public boolean changeIp(String newip){
		boolean result = false;
		
		try {
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `users`");
			//go throu folder list
			while(rs.next()){
				String r = rs.getString("email");
				editFTP(r, newip);
			}
			}catch(Exception e){}
		
		return result;
		
	}
	
	public boolean editLocal(String fold, String newip){
		boolean result = false;
		String [] files={"errors.txt","alogin.htm","status.htm","logout.htm"};
		
		for(String file:files){
			Path path = Paths.get("C:/Users/USER/Desktop/Alps/"+file);
			Charset charset = StandardCharsets.UTF_8;
			try {
				String content = new String(Files.readAllBytes(path), charset);
				content = content.replaceAll("foo", "bar");
				Files.write(path, content.getBytes(charset));
				
				result = true;
			} catch (IOException e) {
				result = false;
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	public boolean editFTP(String fold, String newip){
		boolean result = false;
		String [] files={"errors.txt","alogin.htm","status.htm","logout.htm"};
		
		for(String file:files){
			try{
			URL url = new URL("ftp://admin:a@172.27.5.86/"+fold+"/errors.txt");
			//InputStream in = url.openStream();
			
			URLConnection conn = url.openConnection();
			conn.setDoOutput(true);
			OutputStream out = conn.getOutputStream();
			String content = out.toString()+"ANAS GADANYA";
			
			content = content.replaceAll("#foo", "#bar");
			byte[] contentInBytes = content.getBytes();

			System.out.println(content);
			out.write(contentInBytes);
			out.flush();
			out.close();
				
				result = true;
			} catch (IOException e) {
				result = false;
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	
}
