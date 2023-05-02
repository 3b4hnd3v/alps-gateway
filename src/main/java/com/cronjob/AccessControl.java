package com.cronjob;

import java.sql.Connection;
import java.util.Date;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import com.alps.Dao;
import com.alps.DateUtils;
import com.alps.Gateway;

public class AccessControl{
	private final int minutes;
	Gateway g = new Gateway();
    Dao dao = new Dao();
	static Connection cn = null;
	
	public AccessControl(int minutes) {
        this.minutes = minutes;
    }
	
	public AccessControl() {
        this.minutes = 1;
    }
	
	public void startTask() {
		System.out.println("Access Control Started on " + new Date());
		TimerTask repeatedTask = new TimerTask() {
	        public void run() {
	            System.out.println("Access Control Check performed on " + new Date());
	            completeTask();
	        }
	    };
	    Timer timer = new Timer("Timer");
	     
	    long delay  = 60000L;
	    long period = minutes * 60 * 1000L;
	    timer.scheduleAtFixedRate(repeatedTask, delay, period);
	}

    private void completeTask() {
    	String s = dao.getSetting("daily_cap");
        String session_expiry = dao.getSetting("session_expiry");
        String freeuser = dao.getSetting("free_user");
        int limit = Integer.valueOf(s);
        try {
        	for (Map<String,String> mp : g.activeUsers()) {
				String ut = mp.get("uptime");
				System.out.println("Uptime - "+ut+" of "+limit+" Hours");
				ut = ut.replace("h", ":");
				ut = ut.replace("m", ":");
				ut = ut.replace("s", "");
				float hrs = getHours(ut);
				if(hrs > limit){
					g.removeActiveUser(mp.get(".id"));
				}
			}
        	
        	String time_now = DateUtils.nowTime();
        	System.out.println("Check By : "+time_now+" Against "+session_expiry);
        	System.out.println("Check User : "+freeuser);
        	if(!session_expiry.equalsIgnoreCase("Never") && time_now.equals(session_expiry)){
        		clearActive(freeuser);
        		clearCookies(freeuser);
        	}
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
    
    private  float getHours(String ut){
    	float hours = 0;
    	try {
    		if(ut.length()>8){
    			String[] uts = ut.split(" ");
    			String day = uts[0].substring(0, 1);
    			String times = uts[1];
    			String[] time = times.split(":");
    			hours = (float) ((Integer.parseInt(day)*24.0)+Integer.parseInt(time[0])+(Integer.parseInt(time[1])/60.0)+(Integer.parseInt(time[2])/(60.0*60.0)));
    		}else if(ut.length()>5 && ut.length()<8){
    			String[] time = ut.split(":");
    			hours = (float) (Integer.parseInt(time[0])+(Integer.parseInt(time[1])/60.0)+(Integer.parseInt(time[2])/(60.0*60.0)));
    		}
    		//System.out.println(hours);
    	}catch (Exception e) { e.printStackTrace(); } 
    	return hours;
    }
    
    private void clearActive(String fu){
    	try{
    		for (Map<String,String> mp : g.activeUsers()) {
			    //System.out.println(mp);
			  	String s = mp.get(".id");
			  	String u = mp.get("user");
       			if(u.equals(fu)){
       				g.removeActiveUser(s);
       			}
    		}
    	}catch(Exception e){System.out.println(e);}
    }
    
    private void clearCookies(String fu){
    	try{
    		for (Map<String,String> mp : g.cookies()) {
			    //System.out.println(mp);
			  	String s = mp.get(".id");
			  	String u = mp.get("user");
       			if(u.equals(fu)){
       				g.removeCookie(s);
       			}
    		}
    	}catch(Exception e){System.out.println(e);}
    }
    public static void main(String[] args) {
    	AccessControl ac = new AccessControl();
    	ac.startTask();
    }

}
