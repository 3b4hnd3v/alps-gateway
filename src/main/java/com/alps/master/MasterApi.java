package com.alps.master;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import com.alps.*;

import me.legrange.mikrotik.ApiConnection;
import me.legrange.mikrotik.MikrotikApiException;
import me.legrange.mikrotik.ResultListener;

public class MasterApi {
	PrimeCounter pc = new PrimeCounter();
	static Mao mao = new Mao();
	static String ip = mao.getSetting("default_ip");
	static String pass = mao.getSetting("password");
	static String user = mao.getSetting("username");
	final String[] complete = {"0"};
	
	
	public static void main(String[] args) {
		//System.out.print(ip+pass+user);
		MasterApi g = new MasterApi();
		//for (Map<String,String> r : g.interfaces()){
			//System.out.println(r);
			//gt.changeWg("172.27.5.98", r.get(".id"));
		//}
		//g.changeMangleRule("babes", "WAN");
		//g.dePrioritize("WAN2");
		//g.changeRouteRule("172.27.5.1", "WAN");
		//g.DnsAttack("enable");
		//tool ip-scan address-range=192.168.3.252 duration=20s interface=LAN
		System.out.println(g.hostScan("192.168.3.1-192.168.3.254", "50", "LAN"));
	}
	
	public List<Map<String, String>> interfaces() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.setTimeout(60000);
			con.login(user,pass); 
			rs = con.execute("/interface/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> ethernet() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/interface/ethernet/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> ethernet(String name) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/interface/ethernet/print detail where name="+name);
			//System.out.println(rs);
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> ipaddress() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/address/print");
			
			Collections.sort(rs, new MapComparator("interface"));
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> interfadd(String intname) {
		List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/address/print where interface='"+intname+"'");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> interfRoute(String intname) {
		List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/route/print where gateway='"+intname+"'");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> WBRoute(String intname) {
		List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String com = "DefaultLoadBalancing"+intname;
			rs = con.execute("/ip/route/print where comment='"+com+"'");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public boolean changeIp(String ident, String name, String ipadd, String network, String defgateway) {
		boolean success = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/ip/address/set address="+ipadd+" network="+network+" interface="+name+" .id="+ident;
			//String command1 = "/ip/route/add gateway="+defgateway;
			//String command2 = "/ip/dns/set servers="+dns+","+defgateway;
			
			/*if(con.execute(command1) != null){
				System.out.println("DEBUG: command1=" + command1);
				success = true;
			} Uncomment To Add Route On IP Change
			
			if(con.execute(command2) != null){
				System.out.println("DEBUG: command2=" + command2);
				success = true;
			}*/
			if(con.execute(command)!= null){
				System.out.println("DEBUG: command=" + command);
				success = true;
			}
				
			con.close();
			System.out.println("DEBUG: Ip Change Done");
		} catch(Exception e1) { 
			System.out.println("aaa"+e1);
			success = true;
		}
		return success;
	}
	public boolean portForwarding(String interf, String remote, String remPort, String local, String locPort, String comment, String devmac) {
		boolean success = false;
		String remoteonly = remote.split("/")[0];
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command1 = "/ip/firewall/nat/add action=dst-nat chain=dstnat comment='"+comment+"' protocol=tcp dst-address="+remoteonly+"/32 dst-port="+remPort+"  to-addresses="+local+" to-ports="+locPort+" log=true log-prefix='"+comment+"'";
			String command2 = "/ip/firewall/nat/add action=src-nat chain=srcnat comment='"+comment+"' protocol=tcp src-address="+local+"/32 src-port="+locPort+" to-addresses="+remoteonly+" log=true log-prefix='"+comment+"'";
			
			if(con.execute(command1) != null && con.execute(command2) != null){
				String command3 = "/ip/hotspot/ip-binding/add address="+local+" mac-address="+devmac+" type=bypassed comment="+comment;
				con.execute(command3);
				System.out.println("DEBUG: command1=" + command1);
				System.out.println("DEBUG: command2=" + command2);
				success = true;
			}
			con.close();
		} catch(Exception e1) { 
			System.out.println("letout"+e1);
			success = true;
		}
		return success;
	}
	
	public boolean letMeOut(String interf, String remote, String local, String comment, String defgateway) {
		boolean success = false;
		String remoteonly = remote.split("/")[0];
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/ip/address/add address="+remote+" interface='"+interf+"' comment='"+comment+"'";
			String command1 = "/ip/firewall/nat/add action=dst-nat chain=dstnat comment='"+comment+"' dst-address="+remoteonly+"/32  to-addresses="+local+" log=true log-prefix='"+comment+"'";
			String command2 = "/ip/firewall/nat/add action=src-nat chain=srcnat comment='"+comment+"' src-address="+local+"/32 to-addresses="+remoteonly+" log=true log-prefix='"+comment+"'";
			
			if(con.execute(command) != null && con.execute(command1) != null && con.execute(command2) != null){
				System.out.println("DEBUG: command=" + command);
				System.out.println("DEBUG: command1=" + command1);
				System.out.println("DEBUG: command2=" + command2);
				success = true;
			}
			con.close();
		} catch(Exception e1) { 
			System.out.println("letout"+e1);
			success = true;
		}
		return success;
	}
	public boolean removeLmoIP(String comment) {
		boolean success = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			
			List<Map<String, String>> rs = con.execute("/ip/address/print where comment='"+comment+"'");
			for(Map<String, String> i : rs) {
				String id = i.get(".id");
				System.out.println("DEBUG: Remove"+id);
				String command = "/ip/address/remove .id="+id;
				success = con.execute(command) != null;
			}
			con.close();
		} catch(Exception e1) { System.out.println("letout"+e1); }
		return success;
	}
	public boolean removeLmoNat(String comment) {
		boolean success = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			
			List<Map<String, String>> rs = con.execute("/ip/firewall/nat/print where comment='"+comment+"'");
			for(Map<String, String> i : rs) {
				String id = i.get(".id");
				System.out.println("DEBUG: Remove"+id);
				String command = "/ip/firewall/nat/remove .id="+id;
				success = con.execute(command) != null;
			}
			con.close();
		} catch(Exception e1) { System.out.println("letout"+e1); }
		return success;
	}
	public boolean changeDns(String newip, String did){
		boolean res = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/ip/dns/static/set address="+newip+" .id="+did;
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command)!=null){
				res = true;
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	public void addAddress(String interf, String intip, String network ) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/address/add address="+intip+" network="+network+" interface="+interf ;
			
			con.execute(command);
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	
	public String getMangleRule(String interf){
		String ret = "0";
		String comment = "DefaultLoadBalancing"+interf;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/firewall/mangle/print where comment='"+comment+"'");
			if(rs.size() > 0) {
				Map<String, String> r = rs.get(0);
				//System.out.print(r);
				ret = r.get(".id");
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return ret;
	}
	public List<Map<String,String>> getForwardingRules(){
		List<Map<String,String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			rs = con.execute("/ip/firewall/nat/print");
			
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return rs;
	}
	public String getForwardingRule(String interf, String df){
		String ret = "0";
		String dfc = df+""+interf;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/firewall/nat/print where comment='"+dfc+"'");
			if(rs.size() > 0) {
				Map<String, String> r = rs.get(0);
				//System.out.print(r);
				ret = r.get(".id");
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return ret;
	}
	public String WBRoute(String intname, String compr) {
		String ret = "0";
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String com = compr+""+intname;
			List<Map<String,String>> rs = con.execute("/ip/route/print where comment='"+com+"'");
			if(rs.size() > 0) {
				Map<String, String> r = rs.get(0);
				//System.out.print(rs);
				ret = r.get(".id");
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return ret;
	}
	public String getRoute(String interf){
		String ret = "0";
		String df = "DefaultRoute"+interf;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/route/print where comment='"+df+"'");
			if(rs.size() > 0) {
				Map<String, String> r = rs.get(0);
				//System.out.print(r);
				ret = r.get(".id");
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return ret;
	}
	
	public String getPriorityRule(String interf){
		String ret = "0";
		String comment = "DefaultPriority"+interf;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/firewall/mangle/print where comment='"+comment+"'");
			if(rs.size() > 0) {
				Map<String, String> r = rs.get(0);
				//System.out.print(r);
				ret = r.get(".id");
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return ret;
	}
	public boolean changeForwardingRule(String newip, String dfid, String rule){
		boolean res = false;
		String command = "";
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			//dst-address to-addresses
			if(rule.equalsIgnoreCase("dfi")){
				command = "/ip/firewall/nat/set dst-address="+newip+" .id="+dfid;
			}else if(rule.equalsIgnoreCase("dfo")){
				command = "/ip/firewall/nat/set to-addresses="+newip+" .id="+dfid;
			}
			
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command)!=null){
				res = true;
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	public boolean changeRoute(String gway, String ident){
		boolean res = false;
		String command = "";
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 		
			command = "/ip/route/set gateway="+gway+" .id="+ident;
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command)!=null){
				res = true;
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	public boolean changeMangleRule(String ipnet, String ident){
		boolean res = false;
		String command = "";
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 			
			
			command = "/ip/firewall/mangle/set dst-address='"+ipnet+"' .id="+ident;
			
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command)!=null){
				res = true;
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	public boolean changeRouteRule(String gway, String interf){
		boolean res = false;
		String command = "";
		String comment = "DefaultLoadBalancing"+interf;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 		
			List<Map<String,String>> rs = con.execute("/ip/route/print where comment='"+comment+"'");
			for(Map<String, String> r:rs){
				String ident = r.get(".id");
				command = "/ip/route/set gateway="+gway+" .id="+ident;
				System.out.println("DEBUG: command=" + command);
				if(con.execute(command)!=null){
					res = true;
				}
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	
	public boolean prioritize(String item) {
		boolean ret = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/firewall/mangle/enable .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command)!=null){
				ret = true;
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		return ret;
	}
	public boolean dePrioritize(String intname) {
		boolean ret = false;
		ArrayList<String> wans = WANs();
		wans.remove(intname);
		System.out.println(wans.toString());
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			for(String s:wans){
				String pr = getPriorityRule(s);
				String command = "/ip/firewall/mangle/disable .id="+pr;
				System.out.println("DEBUG: command=" + command);
				ret = con.execute(command)!=null;
			}
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		return ret;
	}
	public ArrayList<String> WANs(){
		ArrayList<String> wans = new ArrayList<String>();
		try {
			String s = mao.getSetting("multiwan");
			for(int i=1; i<=Integer.parseInt(s); i++){
				if(i==1){wans.add("WAN");}
				else{wans.add("WAN"+(i-1));}
			}
			
		}catch(Exception e1) { System.out.println(e1); }
		return wans;
	}
	public boolean enableInterface(String item) {
		boolean ret = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/interface/enable .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command)!=null){
				ret = true;
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		return ret;
	}
	public boolean DnsAttack(String action) {
		boolean ret = false;
		try {
			boolean res = false;
			String command = "";
			String comment = "default DNS Protection";
			try {
				ApiConnection con = ApiConnection.connect(ip); 
				con.login(user,pass); 		
				List<Map<String,String>> rs = con.execute("/ip/firewall/filter/print where comment='"+comment+"'");
				for(Map<String, String> r:rs){
					String ident = r.get(".id");
					command = "/ip/firewall/filter/"+action+" .id="+ident;
					System.out.println("DEBUG: command=" + command);
					if(con.execute(command)!=null){
						res = res && true;
					}
				}
				con.close();
			} catch(Exception e1) { System.out.println(e1); }
			ret = res;
			
		} catch(Exception e1) { System.out.println(e1); }
		return ret;
	}
	public boolean DNSRuleStatus(){
		boolean ret = true;
		String df = "default DNS Protection";
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/firewall/filter/print where comment='"+df+"'");
			for(Map<String, String> r : rs){
				
				ret = ret && Boolean.valueOf(r.get("disabled"));
				//System.out.println(ret);
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return ret;
	}
	public List<Map<String,String>> getNetWatch(){
		List<Map<String,String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			rs = con.execute("/tool/netwatch/print");
			
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return rs;
	}
	public boolean addNetWatchX(String host, String to, String interval, String mac, String notes){
		boolean res = false;
		String command = "";
		String up_url = "http://192.168.3.253/alpsTools/notify_monitor.php?q=monitor_up&host="+host+"&notes="+notes;
		String down_url = "http://192.168.3.253/alpsTools/notify_monitor.php?q=monitor_down&host="+host+"&notes="+notes;
		String up = "/tool fetch http-method=get mode=http url="+up_url;
		String down = "/tool fetch http-method=get mode=http url="+down_url;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			//dst-address to-addresses
			command = "/tool/netwatch/add host="+host+" timeout="+to+" interval="+interval+" interval="+mac+" up-script='"+up+"' down-script='"+down+"'";
			
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command)!=null){
				res = true;
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	public boolean addNetWatch(String host, String to, String interval, String mac, String notes, boolean internal){
		boolean res = false;
		String command = "";
		String url = "http://192.168.3.253/alpsTools/notify_monitor.php";
		String up_url = "http-method=post http-content-type=\"application/json\" http-data=\"{\\\"q\\\":\\\"monitor_up\\\",\\\"host\\\":\\\""+host+"\\\",\\\"notes\\\":\\\""+notes+"\\\"}\"";
		String down_url = "http-method=post http-content-type=\"application/json\" http-data=\"{\\\"q\\\":\\\"monitor_down\\\",\\\"host\\\":\\\""+host+"\\\",\\\"notes\\\":\\\""+notes+"\\\"}\"";
		String up = "/tool fetch mode=http url="+url+" "+up_url;
		String down = "/tool fetch mode=http url="+url+" "+down_url;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			//dst-address to-addresses
			command = "/tool/netwatch/add host="+host+" timeout="+to+" interval="+interval+" comment="+mac+" up-script='"+up+"' down-script='"+down+"' comment="+notes;
			String command1 = "/ip/hotspot/ip-binding/add address="+host+" mac-address="+mac+" type=bypassed comment="+notes;
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command)!=null){
				if(internal) {
					con.execute(command1);
				}
				res = true;
			}
			con.close();
		} catch(Exception e1) { 
			System.out.println(e1);
			if(String.valueOf(e1).contains("client already exists")) {
				res = true;
			}
		}
		return res;
	}
	public boolean removeNetWatch(String id){
		boolean res = false;
		String command = "";
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 

			command = "/tool/netwatch/remove .id="+id;
			
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command)!=null){
				res = true;
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	public List<Map<String, String>> traceRoute(String address, String duration){
		//System.out.println(address+" == "+duration); 
		final List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
		ApiConnection con = null;
		String tag="";
		
		try { 
			con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			//con.setTimeout(60000); 			
			//long start = System.currentTimeMillis();
			//System.out.println( start / 1000000);
			tag = con.execute("/tool/traceroute address='"+address+"' duration="+duration+"s", 
				new ResultListener() {
					public void receive(Map<String, String> result) {
						rs.add(result);
						//System.out.println(result); 
					}
					
					public void error(MikrotikApiException e) {
						System.out.println("An error occurred: " + e.getMessage());
					}
					public void completed() {
						System.out.println("Asynchronous command has finished"); 
						complete[0]="1";
					}       
				}
			);
			pc.countPrimes(Integer.valueOf(duration)*10000);
			
			con.cancel(tag);
			con.close();			
		} catch(Exception e1) { e1.printStackTrace(); }
					
		return rs;
	}
	public List<Map<String, String>> hostScan(String addRange, String duration, String interf){
		//System.out.println(address+" == "+duration); 
		final List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
		ApiConnection con = null;
		String tag="";
		
		try { 
			con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			//con.setTimeout(60000); 			
			//long start = System.currentTimeMillis();
			//System.out.println( start / 1000000);
			//tool ip-scan address-range=192.168.3.252 duration=20s interface=LAN
			tag = con.execute("/tool/ip-scan address-range='"+addRange+"' duration="+duration+"s interface="+interf, 
				new ResultListener() {
					public void receive(Map<String, String> result) {
						rs.add(result);
						//System.out.println(result); 
					}
					public void error(MikrotikApiException e) {
						System.out.println("An error occurred: " + e.getMessage());
					}
					public void completed() {
						System.out.println("Asynchronous command has finished"); 
						complete[0]="1";
					}       
				}
			);
			pc.countPrimes(Integer.valueOf(duration)*10000);
			endTag(con, tag);
			/*con.cancel(tag);
			con.close();*/			
		} catch(Exception e1) { e1.printStackTrace(); }
					
		return rs;
	}
	private boolean endTag(ApiConnection c, String t) {
		boolean x = false;
		try {
			if(complete[0] == "1"){
				System.out.println("Now Closing In Grace"); 
				c.cancel(t);
				c.close();
				x = true;
			}else {
				pc.countPrimes(100);
				endTag(c, t);
			}
		} catch(Exception e1) { e1.printStackTrace(); }
		return x;
		
	}
	public boolean reboot() {
		boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			con.execute("/system/reboot");
			result = true;
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); return result;}
		return result;
	}
	
}
