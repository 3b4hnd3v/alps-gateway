package test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.file.*;
import java.util.Arrays;

import javax.servlet.ServletContext;

import org.apache.commons.lang3.ArrayUtils;

public class test {
	public static void main(String[] args) {
		/*try{
		Path c = download("http://update.alpsgateway.com/files/image.zip", "C:/Users/USER/Desktop/Alps/");
		System.out.print(c);
		}catch(MalformedURLException mue){System.out.print(mue);}
		catch(IOException ioe){System.out.print(ioe);}*/
		int[] reserved = {1313, 13131, 8080, 8001, 8000, 1212, 8728, 8729};
		String options = "";
        for(int i = 1024; i < 49151; i++){
        	if(!ArrayUtils.contains( reserved, 1)){
        		options = options+"\n"+"<option value='"+i+"'>"+i+"</option>";
        		
        	}
        }
        System.out.println(options);
	}
	public static Path download(String sourceUrl,
	        String targetDirectory) throws MalformedURLException, IOException
	{
		
	    URL url = new URL(sourceUrl);

	    String fileName = "runwar.zip";
	    System.out.print(fileName);

	    Path targetPath = new File(targetDirectory + fileName).toPath();

	    Files.copy(url.openStream(), targetPath,
	            StandardCopyOption.REPLACE_EXISTING);

	    return targetPath;
	}
	
	public void writeFile(){
		FileOutputStream fop = null;
		File file;
		String content = "This is the text content";

		try {

			file = new File("C:/Users/USER/Desktop/Alps/errors.txt");
			fop = new FileOutputStream(file);

			// if file doesnt exists, then create it
			if (!file.exists()) {
				file.createNewFile();
			}

			// get the content in bytes
			byte[] contentInBytes = content.getBytes();

			fop.write(contentInBytes);
			fop.flush();
			fop.close();

			System.out.println("Done");

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (fop != null) {
					fop.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}