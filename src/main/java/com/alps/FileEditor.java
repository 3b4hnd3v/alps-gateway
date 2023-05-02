package com.alps;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import com.alps.Dao;

public class FileEditor {
	
	Dao dao = new Dao();
	public boolean editIpScr(String newip,String newsmask,String newnetmask,String newgateway,String newbroadcast,String currip,String cursmask,String curnetmask,String curgateway,String curbroadcast){
		boolean result = false;
		
		Path path = Paths.get(dao.getIpPath());
		Charset charset = StandardCharsets.UTF_8;
		try {
			String content = new String(Files.readAllBytes(path), charset);
			content = content.replaceAll(currip, newip);
			content = content.replaceAll(curnetmask, newnetmask);
			content = content.replaceAll(curgateway, newgateway);
			content = content.replaceAll(curbroadcast, newbroadcast);
			Files.write(path, content.getBytes(charset));
			
			result = true;
		} catch (IOException e) {result = false;e.printStackTrace();return result;}

		return result;
	}
		

}
