package com.cronjob;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import com.alps.Dao;
import com.alps.Gateway;

public class DailySession {
	private final Timer timer = new Timer();
    private final int minutes;
    private Gateway g = new Gateway();
    private Dao dao = new Dao();    
    private final String session_expiry = dao.getSetting("session_expiry");
    private final String freeuser = dao.getSetting("free_user");

    public DailySession(int minutes) {
        this.minutes = minutes;
    }
    public void start() {
    	System.out.println("Daily Session Thread Started");
    	try {
	        timer.schedule(new TimerTask() {
	            public void run() {
	            	checkDailySession();
	            }
	            private void checkDailySession() {
	            	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
	            	String time_now = sdf.format(new Date());
	            	
	            	System.out.println("Check By : "+time_now+" Against "+session_expiry);
	            	System.out.println("Check User : "+freeuser);
	            	if(time_now.equals(session_expiry)){
	            		clearActive();
	            		clearCookies();
	            	}
	            	// Start a new thread
	            	start();
	            }
	        }, minutes * 60 * 1000, minutes * 60 * 1000);
    	}catch(Exception e){}
    }
    public static void main(String[] args) {
    	DailySession eggTimer = new DailySession(1);
        eggTimer.start();
    }
    private void clearActive(){
    	try{
    		for (Map<String,String> mp : g.activeUsers()) {
			    System.out.println(mp);
			  	String s = mp.get(".id");
			  	String u = mp.get("user");
       			if(u.equals(freeuser)){
       				g.removeActiveUser(s);
       			}
    		}
    	}catch(Exception e){}
    }
    
    private void clearCookies(){
    	try{
    		for (Map<String,String> mp : g.cookies()) {
			    System.out.println(mp);
			  	String s = mp.get(".id");
			  	String u = mp.get("user");
       			if(u.equals(freeuser)){
       				g.removeCookie(s);
       			}
    		}
    	}catch(Exception e){}
    }
}