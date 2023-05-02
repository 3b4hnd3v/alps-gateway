package com.pms.powerpro;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Text;

public class PResponse {
	long time = System.currentTimeMillis();
	java.sql.Timestamp timestamp = new java.sql.Timestamp(time);
	public String OKResponse(){
		String xmlString = "";
		try {
            //Creating an empty XML Document
            DocumentBuilderFactory dbfac = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = dbfac.newDocumentBuilder();
            Document doc = docBuilder.newDocument();
            //Creating the XML tree     
	  	   /* <PINS_APIResponse>
	  	      <Status ErrorCode="0">
	  	  	  <Message>OK</Message>
	  	  	  </Status>
	  	  	  </PINS_APIResponse>*/ 
            //create the root element and add it to the document
            Element root = doc.createElement("PINS_APIResponse");
            doc.appendChild(root);
            //create a comment and put it in the root element
            //Comment comment = doc.createComment("This is a comment");
            //root.appendChild(comment);	
            //create child element, add an attribute, and add to root
            Element child = doc.createElement("Status");
            child.setAttribute("ErrorCode", "0");
            root.appendChild(child);
            
            Element msg = doc.createElement("Message");
            Text text = doc.createTextNode("OK");
            msg.appendChild(text);          
            //add a text element to the child
            child.appendChild(msg);
            
            //Output the XML to a string
            //set up a transformer
            TransformerFactory transfac = TransformerFactory.newInstance();
            Transformer trans = transfac.newTransformer();
            trans.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
            trans.setOutputProperty(OutputKeys.INDENT, "yes");

            //create string from xml tree
            StringWriter sw = new StringWriter();
            StreamResult result = new StreamResult(sw);
            DOMSource source = new DOMSource(doc);
            trans.transform(source, result);
            xmlString = sw.toString();
            //print xml reply           
            //System.out.println("The Reply to PMS Server is :\n\n" + xmlString);
            
            System.out.println("eBahn >> Response 'OK' sent to PMS!");
        } catch (Exception e) {System.out.println(e);}
		return xmlString;
	}
	
	public Map<String, String> queryToMap(String query) throws UnsupportedEncodingException{
      Map<String, String> result = new HashMap<String, String>();
      for (String param : query.split("&")) {
          String pair[] = param.split("=");
          if (pair.length>1) {
              result.put(pair[0], URLDecoder.decode(pair[1], "UTF-8"));
          }else{
              result.put(pair[0], "");
          }
      }
      return result;
    }
	public void logActivity(String data) {
		String timestamp2 = timestamp+"";
		String filename = "PowerPro"+timestamp2.substring(0, 10);
		
		try{
    		File myFile =  new File(System.getProperty("user.dir")  + File.separator 
    		        + "\\log\\" + filename + ".txt");
    		  File parentDir = myFile.getParentFile();
    		  if(! parentDir.exists()) //check the dir if exists
    		      parentDir.mkdirs(); // create the dir if not exists
    		  if(!myFile.exists()){  // check the file if exists
      			myFile.createNewFile();//create the file if not exists
      		}
   	  
    		//true = append file
    		    FileWriter fileWritter = new FileWriter(myFile,true);
    			BufferedWriter bufferWritter = new BufferedWriter(fileWritter);    
    	        bufferWritter.write(data);
    	        bufferWritter.newLine();
    	        bufferWritter.close();
 
	        //System.out.println("Done");
 
    	}catch(IOException e){
    		e.printStackTrace();
    	}
	}

}
