package com.alps;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class ComExec {

	public static void main(String[] args) {

		ComExec obj = new ComExec();

		String domainName = "google.com";
		
		//in mac oxs
		//String command = "ping -c 3 " + domainName;
		
		//in windows
		String command = "ping -n 3 " + domainName;
		//String command = "./C:/Users/USER/Desktop/Alps/runwar.sh";
		//command = command.replace("/", "\")
		String output = obj.executeCommand(command);

		System.out.println(output);

	}

	private String executeCommand(String command) {

		StringBuffer output = new StringBuffer();

		Process p;
		try {
			p = Runtime.getRuntime().exec(command);
			p.waitFor();
			BufferedReader reader = 
                            new BufferedReader(new InputStreamReader(p.getInputStream()));

                        String line = "";			
			while ((line = reader.readLine())!= null) {
				output.append(line + "\n");
			}

		} catch (Exception e) {e.printStackTrace();}

		return output.toString();

	}
	
	public boolean comExec(String command) {
		boolean result = false;
		Process p;
		try {
			p = Runtime.getRuntime().exec(command);
			p.waitFor();
			
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}

		return result;

	}
}