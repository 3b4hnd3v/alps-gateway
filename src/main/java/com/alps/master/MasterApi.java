package com.alps.master;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alps.PrimeCounter;

import me.legrange.mikrotik.ApiConnection;

public class MasterApi {
	PrimeCounter pc = new PrimeCounter();
	static Mao mao = new Mao();
	static String ip = mao.getSetting("default_ip");
	static String pass = mao.getSetting("password");
	static String user = mao.getSetting("username");
	
	
	public static void main(String[] args) {
		System.out.print(ip+pass+user);
		MasterApi g = new MasterApi();
		//for (Map<String,String> r : g.interfaces()){
			//System.out.println(r);
			//gt.changeWg("172.27.5.98", r.get(".id"));
		//}
		//g.changeMangleRule("babes", "WAN");
		//g.dePrioritize("WAN2");
		//g.changeRouteRule("172.27.5.1", "WAN");
		//g.DnsAttack("enable");
		System.out.println(g.DNSRuleStatus());
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
			rs = con.execute("/interface/ethernet/print detail where name='"+name+"'");
			System.out.println(rs);
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
	
	public boolean changeIp(String ident, String name, String ipadd, String network, String defgateway, String dns) {
		boolean success = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/ip/address/set address="+ipadd+" network="+network+" interface="+name+" .id="+ident;
			String command1 = "/ip/route/add gateway="+defgateway;
			String command2 = "/ip/dns/set servers="+dns+","+defgateway;
			
			if(con.execute(command1) != null){
				System.out.println("DEBUG: command1=" + command1);
				success = true;
			}
			if(con.execute(command2) != null){
				System.out.println("DEBUG: command2=" + command2);
				success = true;
			}
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
	public boolean changeMaster(String name, String ipadd, String network, String defgateway) {
		boolean success = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/ip/address/add address="+ipadd+" network="+network+" interface='"+name+"'";
			String command1 = "/ip/route/add gateway="+defgateway;
			
			if(con.execute(command1) != null){
				System.out.println("DEBUG: command1=" + command1);
				success = true;
			}
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
		String ret = null;
		String comment = "DefaultLoadBalancing"+interf;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/firewall/mangle/print where comment='"+comment+"'");
			Map<String, String> r = rs.get(0);
			System.out.print(r);
			ret = r.get(".id");
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return ret;
	}
	public String getForwardingRule(String interf){
		String ret = null;
		String df = "DefaultForwarding"+interf;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/firewall/nat/print where comment='"+df+"'");
			Map<String, String> r = rs.get(0);
			System.out.print(r);
			ret = r.get(".id");
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return ret;
	}
	public String getPriorityRule(String interf){
		String ret = null;
		String comment = "DefaultPriority"+interf;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/firewall/mangle/print where comment='"+comment+"'");
			Map<String, String> r = rs.get(0);
			System.out.print(r);
			ret = r.get(".id");
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
