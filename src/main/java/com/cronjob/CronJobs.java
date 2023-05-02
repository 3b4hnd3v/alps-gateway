package com.cronjob;

import java.util.HashMap;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.alps.Dao;
import com.pms.powerpro.PmsBilling;
import com.pms.powerpro.PowerProPost;

/**
 * Application Lifecycle Listener implementation class CronJobs
 *
 */
public class CronJobs implements ServletContextListener {
	Dao d = new Dao();
    /**
     * Default constructor. 
     */
    public CronJobs() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  { 
        // TODO Auto-generated method stub
    	PowerProPost ppp = new PowerProPost();
    	OnlineCheck oc = new OnlineCheck(5);
    	Schedule b = new Schedule(1);
    	AutoBackUp ab = new AutoBackUp();
    	SubBills sb = new SubBills();
    	Object ap = null;
    	HashMap<String, String> apms = new HashMap<String, String>();
    	String acpms = d.getSetting("active_pms");
    	if(String.valueOf(acpms).equalsIgnoreCase("internal")){
    		apms = d.getActivePms();
    		if(apms.containsKey("name")){
    			String name = apms.get("name");
    			switch (name) {
	    	         case "PowerPro":
	    	             ap = new PowerProPost(5);
	    	             break;
	    	         default:
	    	        	 System.out.print("No PMS");
    			}
    		}
    	}
    	if(true){
    		if(String.valueOf(acpms).equalsIgnoreCase("internal")){
    			
    			String name = apms.get("name");
    			switch (name) {
	    	         case "PowerPro":
	    	        	 ((PowerProPost) ap).start();
	    	             break;
	    	         default:
	    	        	 System.out.print("No PMS");
    			}
    		}
	        oc.start();
	        ab.start();
	        sb.start();
	        b.start();
    	}
        System.out.println("Cron Started");
    }
	
}
