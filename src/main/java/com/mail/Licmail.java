package com.mail;

import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.*;

import com.alps.Dao;

import javax.mail.PasswordAuthentication;


public class Licmail {
	
	static Dao dao = new Dao();
	
	final static String userName = "ebahnsolutions@gmail.com";  // GMail user name (just the part before "@gmail.com")
	final static String password = "ebahn123"; // GMail password
    final static String RECIPIENT = "gadanyaa@yahoo.com";
    //final static String msg_body = dao.getLicenseMail();
    public static String [] to = dao.getRecipients();
   
	//{ RECIPIENT };
    
    public static void main(String[] args) {
    	String x = "test event";
    	String emailbody = "Hi "+x+"<br> You receive this Email because an event has been booked on Alps Gateway in <b>"+x+"</b> with your name and email address.<br><br>Below is the detail of your Event as Booked. "
				+ " Event Name: "+x+"<br>Company Name: "+x+"<br>Start Date: "+x+"<br>End Date: "+x+"<br>Venue: "+x+"<br>Duration: "+x+"<br>No of People: "+x+"<br>Charge: "+x+"<br><h2>Wireless Connection Info: </h2><br>Plan Name: "+x+"<br>Download Speed: "+x+"<br>Upload Speed: "+x+"<br>Username: "+x+"<br>Password: "+x+"<br>"
				+"<br><p>Please be informed that this is a machine generated Email, Do not reply. <br><br>Please contact <a href='ebahn-solutions.com' target='_blank'>eBahn Solutions sdn bhd</a> or email us at: ebahnsolution@gmail.com."
				+ "<br><br>You can also call us at 01123765837.</p><p>Thank You.</p> ";
        Licmail lm = new Licmail();
        lm.sendForEvent("dgreat91@gmail.com",emailbody);
    }

    public void sendFromGMail() {
    	
    	final String msg_body = dao.getLicenseMail();
    	
    	Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.starttls.enable", "true") ;
        properties.put("mail.smtp.auth", "true") ;

        Session session = Session.getInstance(properties,new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(userName, password);
            }

        });

        try{
            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(userName));
            for(int i=0; i < to.length - 1; i++){
            	message.setRecipients(Message.RecipientType.TO,
                                  InternetAddress.parse(to[i]));
            }
            message.setSubject("Alps Gateway License Notification");
            //message.setContent("<h:body><div><img src='http://drive.google.com/file/d/0BxeB6ZSGhmMcUEh1QzVfOGJNOXM/view?usp=sharing'></img></div><div align='justify'>"+msg_body+"</div></body>","text/html;     charset=utf-8");
            BodyPart messageBodyPart = new MimeBodyPart();

            // Fill the message
            messageBodyPart.setContent("<h:body align='justify'><div><img src='http://drive.google.com/file/d/0BxeB6ZSGhmMcUEh1QzVfOGJNOXM/view?usp=sharing'></img></div><div align='justify'>"+msg_body+"</div></body>","text/html;     charset=utf-8");
            
            // Create a multipar message
            Multipart multipart = new MimeMultipart();

            // Set text message part
            multipart.addBodyPart(messageBodyPart);

            // Part two is attachment
            messageBodyPart = new MimeBodyPart();
            String filename = "AlpsLog 2015-11-23.txt";
            DataSource source = new FileDataSource(filename);
            messageBodyPart.setDataHandler(new DataHandler(source));
            messageBodyPart.setFileName(filename);
            multipart.addBodyPart(messageBodyPart);

            // Send the complete message parts
            message.setContent(multipart );
            
            Transport.send(message);
            System.out.print("Successfully Sent");
        }catch(MessagingException
               messageException){
            throw new RuntimeException(messageException);
        }

    }
    
    public void sendForEvent(String evtmail, String mailbody) {
    	
    	int x = to.length - 1;
    	System.out.print("evtmail"+x);
		to[x]=evtmail;
		for(int i=0; i < to.length; i++){
			System.out.println(to[i]);
		}
		
		final String msg_body = dao.getEventMail();
		
    	Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.starttls.enable", "true") ;
        properties.put("mail.smtp.auth", "true") ;

        Session session = Session.getInstance(properties,new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(userName, password);
            }

        });

        try{
            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(userName));
            for(int i=0; i < to.length; i++){
            	message.setRecipients(Message.RecipientType.TO,
                                  InternetAddress.parse(to[i]));
            }
            message.setSubject("Alps Event Booking Notification");
            //message.setContent("<h:body><div><img src='http://drive.google.com/file/d/0BxeB6ZSGhmMcUEh1QzVfOGJNOXM/view?usp=sharing'></img></div><div align='justify'>"+msg_body+"</div></body>","text/html;     charset=utf-8");
            BodyPart messageBodyPart = new MimeBodyPart();

            // Fill the message
            messageBodyPart.setContent("<h:body align='justify'><div><img src='http://drive.google.com/file/d/0BxeB6ZSGhmMcUEh1QzVfOGJNOXM/view?usp=sharing'></img></div><div align='justify'>"+msg_body+"</div></body>","text/html;     charset=utf-8");
            
            // Create a multipar message
            Multipart multipart = new MimeMultipart();

            // Set text message part
            multipart.addBodyPart(messageBodyPart);

            // Part two is attachment
            messageBodyPart = new MimeBodyPart();
            //String filename = "AlpsLog 2015-11-23.txt";
            //DataSource source = new FileDataSource(filename);
           // messageBodyPart.setDataHandler(new DataHandler(source));
            //messageBodyPart.setFileName(filename);
            multipart.addBodyPart(messageBodyPart);

            // Send the complete message parts
            message.setContent(multipart );
            
            Transport.send(message);
            System.out.print("Successfully Sent");
        }catch(MessagingException
               messageException){
            throw new RuntimeException(messageException);
        }

    }
    
    public void sendLicenseAct() {
    	
    	final String msg_body = dao.getEventMail();
    	
    	Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.starttls.enable", "true") ;
        properties.put("mail.smtp.auth", "true") ;

        Session session = Session.getInstance(properties,new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(userName, password);
            }

        });

        try{
            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(userName));
            for(int i=0; i < to.length - 1; i++){
            	message.setRecipients(Message.RecipientType.TO,
                                  InternetAddress.parse(to[i]));
            }
            message.setSubject("Alps Gateway License Notification");
            //message.setContent("<h:body><div><img src='http://drive.google.com/file/d/0BxeB6ZSGhmMcUEh1QzVfOGJNOXM/view?usp=sharing'></img></div><div align='justify'>"+msg_body+"</div></body>","text/html;     charset=utf-8");
            BodyPart messageBodyPart = new MimeBodyPart();

            // Fill the message
            messageBodyPart.setContent("<h:body align='justify'><div><img src='http://drive.google.com/file/d/0BxeB6ZSGhmMcUEh1QzVfOGJNOXM/view?usp=sharing'></img></div><div align='justify'>"+msg_body+"</div></body>","text/html;     charset=utf-8");
            
            // Create a multipar message
            Multipart multipart = new MimeMultipart();

            // Set text message part
            multipart.addBodyPart(messageBodyPart);

            // Part two is attachment
            messageBodyPart = new MimeBodyPart();
            String filename = "AlpsLog 2015-11-23.txt";
            DataSource source = new FileDataSource(filename);
            messageBodyPart.setDataHandler(new DataHandler(source));
            messageBodyPart.setFileName(filename);
            multipart.addBodyPart(messageBodyPart);

            // Send the complete message parts
            message.setContent(multipart );
            
            Transport.send(message);
            System.out.print("Successfully Sent");
        }catch(MessagingException
               messageException){
            throw new RuntimeException(messageException);
        }

    }
    

}