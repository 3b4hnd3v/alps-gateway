package com.alps;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.file.*;

import org.apache.commons.net.util.Charsets;

public class Update {
	public static void main(String[] args) {
		Update upd = new Update();
		try{
			Path c = upd.download("http://update.alpsgateway.com/files/db.txt", System.getProperty("user.dir")+"/update/", "db.txt");
			System.out.println(c);
		}catch(MalformedURLException mue){System.out.println(mue);}
		catch(IOException ioe){System.out.println(ioe);}
		
		try{
			
			String c = upd.readFile(System.getProperty("user.dir")+"/update/db.txt", Charset.defaultCharset());
			System.out.println(c.split("##")[0]);
			Dao dao = new Dao();
			boolean x = dao.runSQLCom(c.split("##")[0]);
			System.out.println(x);
		}catch(IOException ioe){System.out.println(ioe);}
		
	}
	public Path download(String sourceUrl,
	        String targetDirectory, String filename) throws MalformedURLException, IOException
	{
		
	    URL url = new URL(sourceUrl);

	    String fileName = filename;
	    System.out.println(fileName);

	    Path targetPath = new File(targetDirectory + fileName).toPath();

	    Files.copy(url.openStream(), targetPath,
	            StandardCopyOption.REPLACE_EXISTING);

	    return targetPath;
	}
	
	public boolean updateDb(String dbfile){
		boolean result = false;
		boolean finalresult = true;
		try{
			String c = readFile(System.getProperty("user.dir")+"/update/db.txt", Charset.defaultCharset());
			String[] commands = c.split("##");
			Dao dao = new Dao();
			for(int i=0; i < commands.length; i++){
				result = dao.runSQLCom(commands[i]);
				finalresult = finalresult && result;
				System.out.println(result+" && "+finalresult);
			}
		}catch(IOException ioe){System.out.println(ioe);}
		return finalresult;
	}
	
	public String readFile(String path, Charset encoding) 
			  throws IOException 
			{
			  byte[] encoded = Files.readAllBytes(Paths.get(path));
			  return new String(encoded, encoding);
			}

}
