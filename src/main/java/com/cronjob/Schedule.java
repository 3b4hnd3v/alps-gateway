package com.cronjob;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import com.alps.Bypass;
import com.alps.Dao;
import com.alps.DateUtils;
import com.alps.Db;
import com.alps.Gateway;

public class Schedule {
	private final Timer timer = new Timer();
    private final int minutes;
    Gateway g = new Gateway();
    Dao dao = new Dao();
    Bypass b = new Bypass();
    
    static Connection cn = null;

    public Schedule(int minutes) {
        this.minutes = minutes;
    }
    public void start() {
    	System.out.println("Schedule Thread Started");
        timer.schedule(new TimerTask() {
            public void run() {
            	bypassSched();
            }
            private void bypassSched() {
            	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
            	SimpleDateFormat sdd = new SimpleDateFormat("dd-MM-yyyy");
            	String str = sdf.format(new Date());
            	String sdt = sdd.format(new Date());
            	String day = DateUtils.CurrentDay();
            	System.out.println(" Check By : "+sdt+" - "+str+" - "+day);
            	activateDaily(day, str);
            	suspendDaily(day, str);
            	activatePeriod(sdt);
            	suspendPeriod(sdt);
            	// Start a new thread
            	start();
            	
            }
        }, minutes * 60 * 1000);
    }
    public static void main(String[] args) {
    	Schedule eggTimer = new Schedule(1);
        eggTimer.start();
    }
    public boolean activateDaily(String day, String time){
    	boolean ret = false;
    	try{
    		for (Bypass mp : b.checkSchedule(day, time)) {
       			String id = String.valueOf(mp.getId());
       			String dev = mp.getDevice();
       			String mac = mp.getMac();
       			String rate = mp.getRate();
       			String st = mp.getStart();
       			String en = mp.getEnd();
       			String it = mp.getItem();
       			String dip = g.leaseIP(mac);
       			System.out.print(dev+" : "+mac+" : "+dip);
       			if(!it.equals("None")){
       				g.enableBypassed(it);
       			}else if(dip!=null){
       				if(g.bypassHost(mac,"Schedule "+it)){
       					g.queueBypassed(mac, dip, rate);
       					String i = g.getBypassId(mac);
       					b.setBypassItem(id, i);
       				}
       			}
       			
    		}
    	}catch(Exception e){}
    	return ret;
    }
    
    public boolean suspendDaily(String day, String time){
    	boolean ret = false;
    	try{
    		for (Bypass mp : b.checkSchedule(day, time)) {
       			String dev = mp.getDevice();
       			String mac = mp.getMac();
       			String st = mp.getStart();
       			String en = mp.getEnd();
       			String it = mp.getItem();
       			//String dip = g.leaseIP(mac);
       			if(!it.equals("None")){
       				g.disableBypassed(it);
       			}
       			System.out.print(dev+" : "+mac);
       			
    		}
    	}catch(Exception e){}
    	return ret;
    }
    
    public boolean activatePeriod(String period){
    	boolean ret = false;
    	try{
    		for (Bypass mp : b.getBy("start", period)) {
       			String id = String.valueOf(mp.getId());
       			String dev = mp.getDevice();
       			String mac = mp.getMac();
       			String rate = mp.getRate();
       			String st = mp.getStart();
       			String en = mp.getEnd();
       			String it = mp.getItem();
       			String dip = g.leaseIP(mac);
       			System.out.print(dev+" : "+mac+" : "+dip);
       			if(!it.equals("None")){
       				g.enableBypassed(it);
       			}else if(dip!=null){
       				if(g.bypassHost(mac,"Schedule "+it)){
       					g.queueBypassed(mac, dip, rate);
       					String i = g.getBypassId(mac);
       					b.setBypassItem(id, i);
       				}
       			}
       			
    		}
    	}catch(Exception e){}
    	return ret;
    }
    
    public boolean suspendPeriod(String period){
    	boolean ret = false;
    	try{
    		for (Bypass mp : b.getBy("end", period)) {
       			String dev = mp.getDevice();
       			String mac = mp.getMac();
       			String st = mp.getStart();
       			String en = mp.getEnd();
       			String it = mp.getItem();
       			//String dip = g.leaseIP(mac);
       			if(!it.equals("None")){
       				g.disableBypassed(it);
       			}
       			System.out.print(dev+" : "+mac);
       			
    		}
    	}catch(Exception e){}
    	return ret;
    }
}