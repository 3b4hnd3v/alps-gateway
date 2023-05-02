package com.cronjob;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;

import com.alps.Dao;
import com.alps.DateUtils;
import com.alps.GwBackUp;

public class AutoBackUp {
	String filename;
    private final Timer timer = new Timer();
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
    int minutes = 60;
    Dao rs = new Dao();
    Date but = new Date();
    String client = rs.getDashValue("client").replaceAll("\\s","").toLowerCase();
    public AutoBackUp() {
    	
    }
    
    public void start() {
    	//System.out.println("Thread Started");
        timer.schedule(new TimerTask() {
            public void run() {
            	doBackUp();
            }
            private void doBackUp() {
                //System.out.println("Your egg is ready!");lastbackup
                try {
                		String lbu = rs.getDashValue("lastbackup");
                		String abu = rs.getDashValue("autobackup");
        				Date lb = formatter.parse(lbu);
        				System.out.println(lbu+"=="+abu+"=="+lb);
        				if(DateUtils.isBeforeDay(lb,Calendar.getInstance().getTime())||DateUtils.isToday(lb)){
        					System.out.println("is before day or today");
        					if(abu.equalsIgnoreCase("daily")){
        						System.out.println("daily");
        						if(DateUtils.isWithinDaysFuture(lb, 1)){
        							dailyBckup();
        						}
        					}else if(abu.equalsIgnoreCase("weekly")){
        						if(DateDiff(lb,Calendar.getInstance().getTime()) >= 7){
        							System.out.println("is time for weekly");
        							weeklyBckup();
        						}
        					}else if(abu.equalsIgnoreCase("monthly")){
        						if(DateDiff(lb,Calendar.getInstance().getTime()) >= 31){
        							monthlyBckup();
        						}
        					}else if(YearDiff(lb,Calendar.getInstance().getTime())>=1){
        						yearlyBckup();
        					}
        				}
        		} catch (Exception e) { e.printStackTrace(); } 
                // Start a new thread to play a sound...
                if(client != null){
                	start();
                }
            }
        }, minutes * 60 * 1000);
    }
    private boolean dailyBckup(){
    	boolean ret = false;
    	try {
    		filename = client+"_"+formatter.format(but)+"_BCKUP";
    		GwBackUp gb = new GwBackUp();
    		if(gb.create(filename)){
    			rs.updateDash("last_bckup", formatter.format(but)+"");
    		}
    	}catch (Exception e) { e.printStackTrace(); } 
    	return ret;
    }
    private boolean weeklyBckup(){
    	boolean ret = false;
    	try {
    		filename = client+"_"+formatter.format(but)+"_BCKUP";
    		GwBackUp gb = new GwBackUp();
    		if(gb.create(filename)){
    			rs.updateDash("lastbackup",formatter.format(but)+"");
    		}
    	}catch (Exception e) { e.printStackTrace(); } 
    	return ret;
    }
    private boolean monthlyBckup(){
    	boolean ret = false;
    	try {
    		filename = client+"_"+formatter.format(but)+"_BCKUP";
    		GwBackUp gb = new GwBackUp();
    		if(gb.create(filename)){
    			rs.updateDash("last_bckup", formatter.format(but));
    		}
    	}catch (Exception e) { e.printStackTrace(); } 
    	return ret;
    }
    private boolean yearlyBckup(){
    	boolean ret = false;
    	try {
    		filename = client+"_"+formatter.format(but)+"_BCKUP";
    		GwBackUp gb = new GwBackUp();
    		if(gb.create(filename)){
    			rs.updateDash("last_bckup", formatter.format(but));
    		}
    	}catch (Exception e) { e.printStackTrace(); } 
    	return ret;
    }
    private long DateDiff(Date d1, Date d2){
    	long diff = 0;
    	try {
    	    diff = d2.getTime() - d1.getTime();
    	    System.out.println ("Days: " + TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS));
    	} catch (Exception e) {e.printStackTrace();}
    	return TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
    }
    private long YearDiff(Date d1, Date d2){
    	long diff = 0;
    	try {
    		Calendar cal = Calendar.getInstance();
    		Calendar cal1 = Calendar.getInstance();
    	    cal.setTime(d1);
    	    cal1.setTime(d2);
    	    int year = cal.get(Calendar.YEAR);
    	    int year1 = cal1.get(Calendar.YEAR);
    	    diff = year1 - year;
    	} catch (Exception e) {e.printStackTrace();}
    	return diff;
    }
    public static void main(String[] args) {
    	
    }
}
