package com.alps;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VBox {
	String vboxmanage = "/Applications/VirtualBox.app/Contents/MacOS/VBoxManage";

	public static void main(String[] args) {
		String out = "";
		VBox vbox = new VBox();
		out = vbox.startgateway("vm");
		
		System.out.println(out);
		// ssh admin@192.168.43.96

	}
	
	public String start(String vm) {
		String rt = "";
		StringBuffer output = new StringBuffer();
		String vboxmanage = "/Applications/VirtualBox.app/Contents/MacOS/VBoxManage";
		try {
		   Process p = Runtime.getRuntime().exec(vboxmanage+" startvm "+vm+" --type headless");
		   p.waitFor();
		   BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
		        String line = "";         
		        while ((line = reader.readLine())!= null) 
		        {
		      output.append(line + "\n");
		   }
		 } catch (Exception e) 
		{
		   e.printStackTrace();
		}

		rt = output.toString();
		
		
		return rt;
	}
	
	public String stop(String vm) {
		String rt = "";
		StringBuffer output = new StringBuffer();
		String vboxmanage = "/Applications/VirtualBox.app/Contents/MacOS/VBoxManage";
		try {
		   Process p = Runtime.getRuntime().exec(vboxmanage+" controlvm "+vm+" poweroff");
		   p.waitFor();
		   BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
		        String line = "";         
		        while ((line = reader.readLine())!= null) 
		        {
		      output.append(line + "\n");
		   }
		 } catch (Exception e) 
		{
		   e.printStackTrace();
		}

		rt = output.toString();
		
		
		return rt;
	}
	
	public String login(String vm) {
		String rt = "";
		StringBuffer output = new StringBuffer();
		String vboxmanage = "/Applications/VirtualBox.app/Contents/MacOS/VBoxManage";
		String[] cmd = {
				vboxmanage,"controlvm vm keyboardputscancode 1e 9e",
				//vboxmanage+" controlvm vm keyboardputscancode 9e",
				};
		try {
		   Process p = Runtime.getRuntime().exec("/Applications/VirtualBox.app/Contents/MacOS/VBoxManage controlvm vm keyboardputscancode 1e 9e 20 a0 32 b2 17 97 31 b1 1c 9c");
		   p.waitFor();
		   BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
		        String line = "";         
		        while ((line = reader.readLine())!= null) 
		        {
		      output.append(line + "\n");
		   }
		 } catch (Exception e) 
		{
		   e.printStackTrace();
		}

		rt = output.toString();
		
		
		return rt;
	}
	
	public String keyboad(String vm) {
		String rt = "";
		StringBuffer output = new StringBuffer();
		
		String[] cmd = {
"/Applications/VirtualBox.app/Contents/MacOS/VBoxManage controlvm vm keyboardputscancode 1e 9e 20 a0 32 b2 17 97 31 b1 1c 9c",
"/Applications/VirtualBox.app/Contents/MacOS/VBoxManage controlvm vm keyboardputscancode 1c 9c",
"/Applications/VirtualBox.app/Contents/MacOS/VBoxManage controlvm vm keyboardputscancode 1c 9c",
				//vboxmanage+" controlvm vm keyboardputscancode 9e",
				};
		try {
		   Process p = Runtime.getRuntime().exec(cmd);
		   p.waitFor();
		   BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
		        String line = "";         
		        while ((line = reader.readLine())!= null) 
		        {
		      output.append(line + "\n");
		   }
		 } catch (Exception e) 
		{
		   e.printStackTrace();
		}

		rt = output.toString();
		
		
		return rt;
	}
	
	public String startgateway(String vm) {
		String rt = "";
		try {
            Process p = Runtime.getRuntime().exec("/Applications/VirtualBox.app/Contents/MacOS/VBoxManage startvm "+vm+" --type headless");
            p.waitFor();
            Thread.sleep(10000);
            System.out.println(convertStreamToString(p.getInputStream()));
            
            p = Runtime.getRuntime().exec("/Applications/VirtualBox.app/Contents/MacOS/VBoxManage controlvm vm keyboardputscancode 1e 9e 20 a0 32 b2 17 97 31 b1");
            p.waitFor();
            p = Runtime.getRuntime().exec("/Applications/VirtualBox.app/Contents/MacOS/VBoxManage controlvm vm keyboardputscancode 1c 9c");
            p.waitFor();
            System.out.println(convertStreamToString(p.getInputStream()));
            p = Runtime.getRuntime().exec("/Applications/VirtualBox.app/Contents/MacOS/VBoxManage controlvm vm keyboardputscancode 1c 9c");
            p.waitFor();
            System.out.println(convertStreamToString(p.getInputStream()));
            p = Runtime.getRuntime().exec("/Applications/VirtualBox.app/Contents/MacOS/VBoxManage controlvm vm keyboardputscancode 1c 9c");
            p.waitFor();


//            String adapt = "VBoxManage modifyvm " + name + " --bridgeadapter1 \"" + ADAPTER + "\"";
//            System.out.println(adapt);
//            p = Runtime.getRuntime().exec(adapt);
//            p.waitFor();
//            System.out.println(VirtualMachineImpl.convertStreamToString(p.getInputStream()));
        } catch (Exception ex) {
        	System.out.println(ex);
            Logger.getLogger(VBox.class.getName()).log(Level.SEVERE, null, ex);
        }
		
		return rt;
	}
	
	public String convertStreamToString(InputStream is)
            throws IOException {
        //
        // To convert the InputStream to String we use the
        // Reader.read(char[] buffer) method. We iterate until the
        // Reader return -1 which means there's no more data to
        // read. We use the StringWriter class to produce the string.
        //
        if (is != null) {
            Writer writer = new StringWriter();
 
            char[] buffer = new char[1024];
            try {
                Reader reader = new BufferedReader(
                        new InputStreamReader(is, "UTF-8"));
                int n;
                while ((n = reader.read(buffer)) != -1) {
                    writer.write(buffer, 0, n);
                }
            } finally {
                is.close();
            }
            return writer.toString();
        } else {        
            return "";
        }
    }
	
	

}
