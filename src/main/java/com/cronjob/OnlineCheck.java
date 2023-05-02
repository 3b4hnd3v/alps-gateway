package com.cronjob;

import java.net.InetAddress;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import com.alps.Dao;
import com.alps.Db;
import com.alps.Gateway;
import com.urlcon.UrlCon;

public class OnlineCheck {
	
    private final Timer timer = new Timer();
    private final int minutes;
    Gateway g = new Gateway();
    Dao dao = new Dao();
    Db db = new Db("jdbc:mysql://localhost/alpsgateway" , "ebahn", "ebahn");
    UrlCon http = new UrlCon();
	static Connection cn = null;

    public OnlineCheck(int minutes) {
        this.minutes = minutes;
    }

    public void start() {
    	System.out.println("Thread Started");
        timer.schedule(new TimerTask() {
            public void run() {
                checkOnlineUser();
            }
            private void checkOnlineUser() {
                //System.out.println("Your egg is ready!");
                String s = dao.getSetting("daily_cap");
                //System.out.println(s);
                int limit = Integer.valueOf(s);
                try {
                	cn = db.cn();
        			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `onlinusers` WHERE `status`=1");
        			while(rs.next()){
            			int ouid = rs.getInt("id");
            			String mac = rs.getString("mac_address").toString();
            			try{
	            			if (!g.isActive(mac)){
	            				updateUserStatus(ouid);
	            			}
            			}catch (Exception e) { e.printStackTrace(); } 
        			}
        			
        			for (Map<String,String> mp : g.activeUsers()) {
        				String ut = mp.get("uptime");
        				System.out.println("UT "+ut);
        				ut = ut.replace("h", ":");
        				ut = ut.replace("m", ":");
        				ut = ut.replace("s", "");
        				float hrs = getHours(ut);
        				if(hrs > limit){
        					g.removeActiveUser(mp.get(".id"));
        				}
        			}
        			
        			cn.close();
        		} catch (Exception e) { e.printStackTrace(); } 
                
                // Start a new thread to play a sound...
                start();
            }
        }, minutes * 60 * 1000);
    }

    public static void main(String[] args) {
    	OnlineCheck eggTimer = new OnlineCheck(1);
        eggTimer.start();
    }
    
    public void updateUserStatus(int ouid){
    	try {
    		cn = db.cn();
			cn.createStatement().execute("UPDATE `onlinusers` SET logout=CURRENT_TIMESTAMP, `status`=0 WHERE `id`="+ouid);
			cn.close();
            //System.out.println("User Update!");

		} catch (Exception e) { e.printStackTrace(); } 
    	
    }
    
    public float getHours(String ut){
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

}