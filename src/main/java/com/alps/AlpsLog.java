package com.alps;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import com.alps.Dao;

public class AlpsLog {
	
	public AlpsLog() {
		
	}
	
	public static void main(String[] args) {
		System.out.println("hi");
		
		AlpsLog al = new AlpsLog();
		al.listLog("/home/ebahn/ALPS/log");
		//al.addLog("more action");
		
	}
	
	public void addLog(String action) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat dateFormat1 = new SimpleDateFormat("dd-MMM-YYYY HH:MM:ss");
		Date date = new Date();
		String today = dateFormat.format(date);
		String logtime = dateFormat1.format(date);
		String daylog = "AlpsLog "+today+".txt";
		Dao dao = new Dao();
		String logdir = dao.getSetting("log_location");
		String logfile = logdir + daylog;
		String content = logtime+":"+action;
		System.out.println(logfile);
		try {
			File file = new File(logfile);

			// if file doesnt exists, then create it
			if (!file.exists()) {
				//System.out.println("Create new");
				file.createNewFile();
				FileWriter fw = new FileWriter(file.getAbsoluteFile());
				BufferedWriter bw = new BufferedWriter(fw);
				bw.write(content);
				bw.newLine();
				bw.flush();
				bw.close();
			}else{
				//System.out.println("Existing");
				try {
					PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(logfile, true)));
				    out.println(content);
				    out.flush();
				    out.close();
				}catch (IOException e) {
					e.printStackTrace();
				}
			}

			//System.out.println("Done");

		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	public List<File> listLog(String pathto){
		List<File> results = new ArrayList<File>();
	
	
		File[] files = new File(pathto).listFiles();
		//If this pathname does not denote a directory, then listFiles() returns null. 
	
		for (File file : files) {
		    if (file.isFile()) {
		    	System.out.println(file.getName());
		    	System.out.println(file.getAbsolutePath());
		    	System.out.println(file.lastModified());
		    	System.out.println(file.length()+" bytes");
		        results.add(file);
		    }
		}
		return results;
	}

}
