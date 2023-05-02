package com.pms.powerpro;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.CharacterData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import com.sun.org.apache.xml.internal.security.utils.Base64;

public class PowerProPost {
	private final Timer timer = new Timer();
    private final int minutes;
    PmsBilling pb = new PmsBilling();
    
	public PowerProPost(int minutes) {
        this.minutes = minutes;
    }
	public PowerProPost() {
        this.minutes = 5;
    }
	public void start() {
    	System.out.println("PMS Thread Started");
        timer.schedule(new TimerTask() {
            public void run() {
            	pmsBilling();
            }
            private void pmsBilling() {
            	List<PmsBilling> lpb = pb.getBy("status", "0");
            	String ibc = "300";
            	for(PmsBilling pi:lpb){
            		String billurl = "http://127.0.0.1:1968/api/1.0/xml/PostCharge"+
            		     "?userid=TEST"+
            		     "&key=RTWSALBEQTQGH9RD5PXV9BB"+
            		     "&Room="+pi.getRoomno()+
            		     "&Category="+ibc+
            		     "&Remark=ALPS Billing"+
            		     "&Reference="+pi.getTransid()+
            		     "&Amount="+pi.getPrice()+
            		     "&SourceID=0";
            		if(postBill(billurl)){
            			pb.changeStatus(String.valueOf(pi.getId()));
            		}
            	}
            }
        }, minutes * 60 * 1000);
	}
    
	public boolean postBill(String webPage){
		boolean res = false;
		try {
			String name = "TEST";
			String password = "123";
			String authString = name + ":" + password;
			System.out.println("auth string: " + authString);
			String authEncBytes = Base64.encode(authString.getBytes());
			String authStringEnc = new String(authEncBytes);
			System.out.println("Base64 encoded auth string: " + authStringEnc);
	
			URL url = new URL(webPage);
			URLConnection urlConnection = url.openConnection();
			urlConnection.setRequestProperty("Authorization", "Basic " + authStringEnc);
			InputStream is = urlConnection.getInputStream();
			InputStreamReader isr = new InputStreamReader(is);
	
			int numCharsRead;
			char[] charArray = new char[1024];
			StringBuffer sb = new StringBuffer();
			while ((numCharsRead = isr.read(charArray)) > 0) {
				sb.append(charArray, 0, numCharsRead);
			}
			String result = sb.toString();
			System.out.println(result);				
		    DocumentBuilder db = null;
			try {
				db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			} catch (ParserConfigurationException e) {
				e.printStackTrace();
			}
		    InputSource is2 = new InputSource();
		    is2.setCharacterStream(new StringReader(result));

		    Document doc = db.parse(is2);
		    NodeList nodes = doc.getElementsByTagName("PINS_APIResponse");

		    for (int i = 0; i < nodes.getLength(); i++) {
			      Element element = (Element) nodes.item(i);	
			      NodeList name2 = element.getElementsByTagName("Message");
			      Element line = (Element) name2.item(0);
			      String pmsresponse = getCharacterDataFromElement(line);
			      
			      System.out.println("Message: " +pmsresponse );
			      	String ok="OK";
				    if (pmsresponse.equals(ok)){
				    	  res = true;
				    }
			} 
		}catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	

		return res;
	}
	
	public static String getCharacterDataFromElement(Element e) {
	    Node child = e.getFirstChild();
	    if (child instanceof CharacterData) {
	      CharacterData cd = (CharacterData) child;
	      return cd.getData();
	    }
	    return "";
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
