package com.cronjob;

import java.net.InetAddress;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import com.alps.Dao;
import com.alps.DateUtils;
import com.alps.Db;
import com.alps.Gateway;
import com.urlcon.UrlCon;

public class SubBills {
	
    private final Timer timer = new Timer();
    private final int minutes;
    DateUtils g = new DateUtils();
    Dao dao = new Dao();
    Db db = new Db();
    UrlCon http = new UrlCon();
	static Connection cn = null;

    public SubBills(int minutes) {
        this.minutes = minutes;
    }
    
    public SubBills() {
        this.minutes = 1440;
    }

    public void start() {
    	System.out.println("Subscriber Billing Started");
        timer.schedule(new TimerTask() {
            public void run() {
            	GenerateBills();
            }
            private void GenerateBills() {
                //System.out.println("Your egg is ready!");
                
                try {
                	cn = db.cn();
        			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `subscribers`");
        			while(rs.next()){
            			String sid = rs.getString("id");
            			String exb = rs.getString("curr_bill");
            			String planid = rs.getString("plan");
            			HashMap<String, String> subplan = subPlan(planid);
            			String today = DateUtils.NowBill();
            			String nxtbil = DateUtils.NextBill(Integer.parseInt(subplan.get("duration")));
            			if(exb.equalsIgnoreCase(today)){
            				//new bill
            				boolean bill = dao.addBilling(sid, subplan.get("id"), subplan.get("amount"), subplan.get("duration"));
            				if(bill){
            					setNextBill(sid, nxtbil);
            				}
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
    	SubBills eggTimer = new SubBills(1);
        eggTimer.start();
    }
    
    public void setNextBill(String sid, String nxtbil){
    	try {
    		cn = db.cn();
			cn.createStatement().execute("UPDATE `subscribers` SET curr_bill='"+nxtbil+"' WHERE `id`="+sid);
			cn.close();
            //System.out.println("User Update!");

		} catch (Exception e) { e.printStackTrace(); } 
    	
    }
    
    public HashMap<String, String> subPlan(String param){
		HashMap<String, String> hm = new HashMap<String, String>();
		try { 
			cn = db.cn();
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM subplans WHERE name='"+param+"'");
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			if(rs.next()){
				// The column count starts from 1
				for (int i = 1; i <= columnCount; i++ ) {
				  String name = rsmd.getColumnName(i);
				  String val = rs.getString(name);
				  //System.out.println(name+" = "+val);
				  hm.put(name, val);
				}
			}
			rs.close();
			cn.close();
		} catch(Exception e4) { System.out.println(e4); }
		return hm;
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