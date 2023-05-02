/**
 * @author Anas 
 * @twitter @anas_emtee
 */
package com.alps;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import me.legrange.mikrotik.ApiConnection;
import me.legrange.mikrotik.ApiConnectionException;
import me.legrange.mikrotik.MikrotikApiException;
import me.legrange.mikrotik.ResultListener;

public class TrafficMonitor {
	static Dao dao = new Dao();
	PrimeCounter pc = new PrimeCounter();
	static String ip = dao.getip();//ip 
	static String pass = dao.getPass();//pass
	static String user = dao.getUser();//user
	
	public static void main(String[] args) {
		System.out.println(ip+"="+pass+"="+user);
		TrafficMonitor tm = new TrafficMonitor();
		List<Map<String, String>> rs = tm.monitor("LAN");
		for (Map<String,String> r : rs) {
			System.out.println(r);
		}
	}
	
	public boolean isActive(String interf){
		boolean res = false;
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/interface/print where name="+interf);
			if(!rs.isEmpty()){
				res = true;
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return res;
	}
	
	public List<Map<String, String>> monitor(String interf){
		final List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
		
		if(isActive(interf)){
			try {
				ApiConnection con = ApiConnection.connect(ip); // connect to router
				con.setTimeout(60000);
				con.login(user,pass); 
				long start = System.currentTimeMillis();
				System.out.println( start / 1000000);
				String tag = con.execute("/interface/monitor-traffic interface="+interf, 
					      new ResultListener() {

								public void receive(Map<String, String> result) {
					            	
					            		//System.out.println("result: "+result);
					            		rs.add(result);
					            		//dataset.setValue(Integer.parseInt(packets), "Bandwidth(Packets)", module);
					            		
					            }

					           public void error(MikrotikApiException e) {
					               System.out.println("An error occurred: " + e.getMessage());
					           }

					           public void completed() {
					                System.out.println("Asynchronous command has finished"); 
					                
					           }

					        }
					  );
					pc.countPrimes(1000000);
					long end = System.currentTimeMillis();
					System.out.println( end / 1000000);
					System.out.println((end - start) / 1000000);
					con.cancel(tag);
					con.close();
			} catch(Exception e1) { e1.printStackTrace(); }
			
		}
		
		return rs;
	}
	
}
