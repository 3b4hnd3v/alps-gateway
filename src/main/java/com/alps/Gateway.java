package com.alps;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import me.legrange.mikrotik.ApiConnection;
import me.legrange.mikrotik.ApiConnectionException;
import me.legrange.mikrotik.MikrotikApiException;
import me.legrange.mikrotik.ResultListener;

public class Gateway {
	PrimeCounter pc = new PrimeCounter();
	static Dao dao = new Dao();
	static String ip = dao.getSetting("default_ip");
	static String pass = dao.getSetting("password");
	static String user = dao.getSetting("username");

	public static void main(String[] args) {
		System.out.println(ip+"="+pass+"="+user);
		Gateway gt = new Gateway();
		//gt.getForwardingRule("WANO");
		//gt.changeForwardingRule("172.27.5.105", "*76", "dfo");
		for (Map<String,String> r : gt.userprofile()){
			System.out.println(r.get("name")+" = "+r.get("advertise-url"));
			//gt.changeWg("172.27.5.98", r.get(".id"));
		}
		//gt.BHRuleStatusF();
		/*boolean y = gt.unBypassVlan("VLAN30");
		String[] port = gt.getVlanPort("VLAN30");
		System.out.println(port[0]);
		
		System.out.println(port[1]);
		System.out.println(port[2]);
		
		*/
		//gt.addWalledGarden2("www.ebahn-solutions.com","443","tcp");
		//gt.addWalledGarden("172.0.0.1","0-65535");
		//gt.test();
		//gt.resolveSite("*1A");
		//System.out.println(gt.removeFilter("*4u"));
		//gt.DosAttack("enable");
		//System.out.println(gt.DOSRuleStatus());

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
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> logs() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/log/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}

	public List<Map<String, String>> files() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/file/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> getIpByName(String name) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/address/print where interface="+name);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> getNetByName(String name) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/address/print where interface='"+name+"'");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}

	public List<Map<String, String>> arp() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/ip/arp/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> neighbors() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/ip/neighbor/print detail");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> lease() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/ip/dhcp-server/lease/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> pool() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/ip/pool/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> dhcpNet() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/ip/dhcp-server/network/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> services() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/service/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public Map<String, String> getCaptiveDns(String val){
		Map<String,String> r = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/dns/static/print where address="+val);
			r = rs.get(0);
			System.out.println(r);
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return r;
	}
	public Map<String, String> getDefaultDns(){
		Map<String,String> r = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/dns/static/print where name='alpscaptive.com'");
			r = rs.get(0);
			System.out.println(r);
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return r;
	}
	public void enableService(String item) {
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/service/enable .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void disableService(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			//con.execute("/system/reboot"); // execute a command
			//con.disconnect(); // disconnect from router
			String command = "/ip/service/disable .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public List<Map<String, String>> users() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			//con.execute("/system/reboot"); // execute a command
			//con.disconnect(); // disconnect from router
			
			rs = con.execute("/ip/hotspot/user/print");
			/**
			for (Map<String,String> r : rs) {
			 System.out.println(r);
			}
			*/
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> driver() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> activeUsers() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/hotspot/active/print");
			
			con.close();
			
		} catch(Exception e1) {  }
		
		return rs;
	}
	public boolean isActive(String mac) {
		boolean res = false;
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/ip/hotspot/active/print where mac-address="+mac);
			if(!rs.isEmpty()){
				res = true;
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return res;
	}
	public List<Map<String, String>> hosts() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/hotspot/host/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public void removeHost(String id) {
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			con.execute("/ip/hotspot/host/remove  .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void removeActiveUser(String id) {
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			con.execute("/ip/hotspot/active/remove .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void removeUser(String id) {
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			con.execute("/ip/hotspot/user/remove .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void enableUser(String id) {
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			con.execute("/ip/hotspot/user/set disabled=false .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void disableUser(String id) {
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			con.execute("/ip/hotspot/user/set disabled=true .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void removeUserProfile(String id) {
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			con.execute("/ip/hotspot/user/profile/remove .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public List<Map<String, String>> walledGarden() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/hotspot/walled-garden/ip/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> allWalledGarden(String item, String type) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String cond = "";
			if(type.equals("IP")){
				cond = "where dst-address='"+item+"'";
			}else if(type.equals("SITE")){
				cond = "where comment='"+item+"'";
			}else if(type.equals("SERVER")){
				cond = "where server='"+item+"'";
			}
			String command = "/ip/hotspot/walled-garden/print "+cond;
			
			System.out.println("DEBUG: command=" + command);
			rs = con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public void addWalledGarden(String host, String port) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/hotspot/walled-garden/ip/add dst-address='"+host+"' dst-port='"+port+"'";
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void addWalledGarden2(String site, String dport, String protocol) {
			
			try {
				ApiConnection con = ApiConnection.connect(ip); // connect to router
				con.login(user,pass); 
				String command = "";
				if(protocol.equals("")){
					command = "/ip/hotspot/walled-garden/ip/add dst-host="+site+" dst-port='"+dport+"'";
				}else if(dport.equals("")){
					command = "/ip/hotspot/walled-garden/ip/add dst-host="+site+" protocol='"+protocol+"'";
				}else{
					command = "/ip/hotspot/walled-garden/ip/add dst-host="+site+" dst-port='"+dport+"' protocol='"+protocol+"'";
				}
				System.out.println("DEBUG: command=" + command);
				con.execute(command);
				
				
				con.close();
				
			} catch(Exception e1) { System.out.println(e1); }
			
		}
	public void removeWalledGarden(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/hotspot/walled-garden/ip/remove .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void enableWalledGarden(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/hotspot/walled-garden/ip/set disabled=false .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void disableWalledGarden(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/hotspot/walled-garden/ip/set disabled=true .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void removeBridge(String item) {
			
			try {
				ApiConnection con = ApiConnection.connect(ip); // connect to router
				con.login(user,pass); 
				String command = "/interface/bridge/remove .id="+item;
				
				System.out.println("DEBUG: command=" + command);
				con.execute(command);
				
				
				con.close();
				
			} catch(Exception e1) { System.out.println(e1); }
			
	}
	public void enableInterface(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/interface/set disabled=false .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void disableInterface(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/interface/set disabled=true .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void enableIP(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/address/set disabled=false .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void disableIP(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/address/set disabled=true .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public List<Map<String, String>> getVlan() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/interface/vlan/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> getBrigeVlan(String loc) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/interface/bridge/port/print where bridge='"+loc+"'");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> getAllBrigeVlan() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/interface/bridge/port/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public String[] getVlanPort(String vname) {
		String[] res = new String[3];
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			List<Map<String, String>> rs = con.execute("/interface/bridge/port/print where interface="+vname);
			for (Map<String,String> r : rs) {
				res[0] = r.get(".id");
				res[1] = r.get("bridge");
				res[2] = r.get("comment");
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return res;
	}
	public void addVlan(String vid, String vn, String interf, String arp) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/interface/vlan/add vlan-id="+vid+" name="+vn+" interface="+interf+" arp="+arp;
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public boolean bypassVlan(String vname){
		boolean success = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String port[] = getVlanPort(vname);
			String pid = port[0];
			String ob = port[1];
			String command = "/interface/bridge/port/set bridge=Bypass comment='"+ob+"' .id='"+pid+"'";
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			success = true;
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return success;
	}
	public boolean unBypassVlan(String vname){
		boolean success = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String port[] = getVlanPort(vname);
			String pid = port[0];
			String ob = port[2];
			String command = "/interface/bridge/port/set bridge='"+ob+"' comment='' .id='"+pid+"'";
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			success = true;
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return success;
	}
	public boolean createPrepaidUser(String un, String pw, String prof, String upt, String svr) {
			boolean success = false;
			try {
				ApiConnection con = ApiConnection.connect(ip); 
				con.login(user,pass); 
				String command = "/ip/hotspot/user/add name="+un+" password="+pw+" profile="+prof+" limit-uptime="+upt+" limit-bytes-in=512k limit-bytes-out=512k server="+svr;
				
				System.out.println("DEBUG: command=" + command);
				con.execute(command);
				
				success = true;
				con.close();
				
			} catch(Exception e1) { System.out.println(e1); }
			return success;
		}
	public void createUser(String un, String pw, String prof, String upt, String svr, String ipadd, String mac, String lbi, String lbo, String lbt) {
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/ip/hotspot/user/add name='"+un+"' password='"+pw+"' profile='"+prof+"' limit-uptime='"+upt+"' server='"+svr+"' limit-bytes-in='"+lbi+"' limit-bytes-out='"+lbo+"' limit-bytes-total='"+lbt+"' address='"+ipadd+"' mac-address='"+mac+"'";
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
	}
	public void createUserProf(String name, String pool, String rate, String addcookie, String cookieto, String share, String statpage, String sessionto, String idleto, String keepal, String comment) {
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/ip/hotspot/user/profile/add name='"+name+"' address-pool='"+pool+"' rate-limit='"+rate+"' add-mac-cookie='"+addcookie+"' mac-cookie-timeout='"+cookieto+"' shared-users='"+share+"' open-status-page='"+statpage+"' session-timeout='"+sessionto+"' idle-timeout='"+idleto+"' keepalive-timeout='"+keepal+"'";
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
	}
	public void removeVlanByName(String item) {
		try {
			ApiConnection con = ApiConnection.connect(ip); 	
			con.login(user,pass); 
			List<Map<String,String>> rs = con.execute("/interface/vlan/print where name="+item);
			for(Map<String, String> r:rs){
				String vid = r.get(".id");
				removeVlan(vid);
			}
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void removePort(String item) {
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/interface/bridge/port/remove .id="+item;
			
			if(con.execute(command) != null){
				System.out.println("DEBUG: command=" + command);
			}
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void removeVlan(String id) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/interface/vlan/remove .id="+id;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void enableVlan(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			String command = "/interface/vlan/enable .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void disableVlan(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/interface/vlan/disable .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public boolean bypassHost(String item, String remark) {
		boolean res = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/hotspot/ip-binding/add mac-address="+item+" type=bypassed comment='"+remark+"'";
			
			System.out.println("DEBUG: command=" + command);
			res = con.execute(command)!=null;
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	
	public boolean updateBypass(String item, String remark) {
		boolean res = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/hotspot/ip-binding/set comment='"+remark+"' .id='"+item+"'";
			
			System.out.println("DEBUG: command=" + command);
			res = con.execute(command)!=null;
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	
	public boolean queueBypassed(String item, String dip, String updown){
		boolean res = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/queue/simple/add name='"+item+"' target='"+dip+"/32' max-limit='"+updown+"' limit-at='"+updown+"' total-max-limit='"+updown.split("/")[1]+"' total-limit-at='"+updown.split("/")[1]+"' comment='Throttled'";
			
			System.out.println("DEBUG: command=" + command);
			res = con.execute(command)!=null;
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	
	public List<Map<String, String>> getBypassed() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			
			rs = con.execute("/ip/hotspot/ip-binding/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public String getBypassId(String n) {
		String rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			
			List<Map<String, String>> lrs = con.execute("/ip/hotspot/ip-binding/print where mac-address='"+n+"'");
			for (Map<String,String> mp : lrs) {
				rs = mp.get(".id");
			}
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> getThrottled() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			
			rs = con.execute("/queue/simple/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public void enableBypassed(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/hotspot/ip-binding/enable .id="+item;
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
	}
	public void disableBypassed(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/hotspot/ip-binding/disable .id="+item;
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
	}
	public void removeBypassed(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/hotspot/ip-binding/remove .id="+item;
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
	}
	
	public void enableThrottle(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/queue/simple/enable .id="+item;
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
	}
	public void disableThrottle(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/queue/simple/disable .id="+item;
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
	}
	public void removeThrottle(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/queue/simple/remove .id="+item;
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
	}
	public String bypassThrottle(String name) {
		String s = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			List<Map<String, String>> rs = con.execute("/queue/simple/print where name="+name);
			for (Map<String,String> mp : rs) {
				s = mp.get(".id");
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return s;
	}
	public List<Map<String, String>> getPool(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			rs = con.execute("/ip/pool/print where .id="+id);
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return rs;
	}
	public List<Map<String, String>> getDNS(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			
			rs = con.execute("/ip/dns/static/print where .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public void addPool(String name, String ranges, String nextpool) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "";
			if(nextpool.equals("")){command = "/ip/pool/add name="+name+" ranges="+ranges;}
			else{command = "/ip/pool/add name="+name+" ranges="+ranges+" next-pool="+nextpool;}
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public boolean addDns(String dname, String addr, String ttl) {
		boolean ret = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "";
			command = "/ip/dns/static/add name="+dname+" address="+addr+" ttl="+ttl+" comment=static";
			
			System.out.println("DEBUG: command=" + command);
			ret = con.execute(command)!=null;
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		return ret;
	}
	public void editPool(String name, String ranges, String nextpool,String id) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "";
			if(nextpool.equals("")){command = "/ip/pool/set name='"+name+"' ranges="+ranges+"  .id="+id;}
			else{command = "/ip/pool/set name="+name+" ranges="+ranges+" next-pool='"+nextpool+"'  .id="+id;;}
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void deletePool(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/pool/remove .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void deleteLease(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/dhcp-server/lease/remove .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void deleteDNS(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/dns/static/remove .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void enableDNS(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/dns/static/enable .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void disableDNS(String item) {
	
	try {
		ApiConnection con = ApiConnection.connect(ip); // connect to router
		con.login(user,pass); 
		String command = "/ip/dns/static/disable .id="+item;
		
		System.out.println("DEBUG: command=" + command);
		con.execute(command);
		
		
		con.close();
		
	} catch(Exception e1) { System.out.println(e1); }
	
	}
	public void flushDNS() {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/dns/cache/flush";
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public List<Map<String, String>> cookies() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/hotspot/cookie/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> dns() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/dns/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> dnscache() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/dns/cache/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> staticdns() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/dns/static/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> servername() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/system/identity/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> licinfo() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/system/license/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> userprofile() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/hotspot/user/profile/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> gatewayplan() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/hotspot/user/profile/print where comment='Default Gateway Plan'");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> hsservers() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/hotspot/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> bridges() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/interface/bridge/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> hsserverprof() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/hotspot/profile/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> dhcp() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/dhcp-server/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> dhcpLease() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/dhcp-server/lease/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public String leaseIP(String mac) {
		String rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			List<Map<String, String>> r = con.execute("/ip/dhcp-server/lease/print where mac-address='"+mac+"'");
			for (Map<String,String> mp : r) {
				rs = mp.get("address");
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public void addInterface(String interf, String intname, String intip, String network ) {
			
			try {
				ApiConnection con = ApiConnection.connect(ip); // connect to router
				con.login(user,pass); 
				
				String command = "/ip/address/add address="+intip+" network="+network+" interface="+interf ;
				String command1 = "/ip/address/set [ find default-name="+interf+" ] name="+intname  ;
				
				if(con.execute(command) != null){
					System.out.println("DEBUG: command=" + command);
					con.execute(command1);
					
				}
				
				
				con.close();
				
			} catch(Exception e1) { System.out.println(e1); }
			
		}
	public void adddriver() {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/driver/add name=ne2k-isa io 0x280" ;
			
			con.execute(command);
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void addhs_server(String sname, String profile, String interf, String pool, String permac, String idle, String keepalive ) {
			
			try {
				ApiConnection con = ApiConnection.connect(ip); // connect to router
				con.login(user,pass); // log in to router
				String command = "/ip/hotspot/add name="+sname+" profile="+profile+" interface="+interf+" address-pool="+pool+" addresses-per-mac="+pool+" keepalive-timeout="+keepalive+" idle-timeout="+idle ;
				
				con.execute(command);
				con.close();
				
			} catch(Exception e1) { System.out.println(e1); }
			
	}
	public boolean addhs_prof(String pname, String hsadd, String htmdir, String loginby, String cto, String rad, String dns, String cert, String rate) {
		boolean res = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/hotspot/profile/add name='"+pname+"' hotspot-address='"+hsadd+"' rate-limit='"+rate+"' html-directory='"+htmdir+"' login-by='"+loginby+"' use-radius='"+rad+"' dns-name='"+dns+"' ssl-certificate='"+cert+"' http-cookie-lifetime='"+cto+"'";
			
			res = con.execute(command) != null;
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	public void add_dhcp(String sname, String interf, String pool, String lease, String bootp) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/dhcp-server/add name='"+sname+"' interface='"+interf+"' address-pool='"+pool+"' lease-time="+lease+" bootp-support="+bootp+" add-arp=yes";
			
			con.execute(command);
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void add_DhcpNet(String address, String gateway) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/dhcp-server/network/add name="+address+" interface="+gateway;
			
			con.execute(command);
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void enableHsserver(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/hotspot/set disabled=false .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void removeHsserver(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/hotspot/remove .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void disableHsserver(String item) {
			
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/hotspot/set disabled=true  .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void removeServerprof(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/hotspot/profile/remove numbers="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void removeCookie(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/hotspot/cookie/remove numbers="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void enableDhcp(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/dhcp-server/set disabled=false .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void removeDhcp(String item) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/dhcp-server/remove .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void disableDhcp(String item) {
			
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/dhcp-server/set disabled=true .id="+item;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void deletePurchase(String s) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/hotspot/user/remove .id="+s;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	//GET ONE
	public List<Map<String, String>> getUser(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			//con.execute("/system/reboot"); // execute a command
			//con.disconnect(); // disconnect from router
			
			rs = con.execute("/ip/hotspot/user/print where .id="+id);
			/**
			for (Map<String,String> r : rs) {
			 System.out.println(r);
			}
			*/
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> getUserProfile(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/hotspot/user/profile/print where .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> getWalledGardenSite(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/hotspot/walled-garden/ip/print where .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> getWalledGarden(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/hotspot/walled-garden/ip/print where .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> getWalledGardenBy(String par, String val) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/hotspot/walled-garden/ip/print where "+par+"='"+val+"'");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> getIpaddress(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/ip/address/print where .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> getHsServer(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/hotspot/print where .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> getHsServerProf(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/hotspot/profile/print where .id="+id);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> getInterface(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/interface/print where .id="+id);
			System.out.println(rs);
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	
	public List<Map<String, String>> getVlan(String id) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/interface/vlan/print where .id="+id);
			System.out.println(rs);
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}

	public void updateUser(String uid, String username, String password, String prof,String server, String upt, String ipadd, String mac, String lbi, String lbo, String lbt) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/hotspot/user/set name='"+username+"' password='"+password+"' profile='"+prof+"' server='"+server+"' limit-uptime='"+upt+"' limit-bytes-in='"+lbi+"' limit-bytes-out='"+lbo+"' limit-bytes-total='"+lbt+"' address='"+ipadd+"' mac-address='"+mac+"' .id="+uid;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void updateUserProf(String uid , String name, String pool, String rate, String addcookie, String cookieto, String share, String statpage, String sessionto, String idleto, String keepal) {
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "", mypool = "none";
			
			if(pool == null || pool.equals("")){mypool = "none";}else{mypool = pool;}
			command = "/ip/hotspot/user/profile/set name='"+name+"' address-pool='"+mypool+"' rate-limit='"+rate+"' add-mac-cookie='"+addcookie+"' mac-cookie-timeout="+cookieto+" shared-users='"+share+"' open-status-page='"+statpage+"' session-timeout='"+sessionto+"' idle-timeout='"+idleto+"' keepalive-timeout='"+keepal+"' .id="+uid;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public boolean updateWalledGarden(String wgid , String dstadd, String dstport, String action) {
		boolean res = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "";
			if(dstport.trim().length()>0){
				command = "/ip/hotspot/walled-garden/ip/set dst-address='"+dstadd+"' dst-port='"+dstport+"' action='"+action+"' .id="+wgid;
			}else{
				command = "/ip/hotspot/walled-garden/ip/set dst-address='"+dstadd+"' action='"+action+"' .id="+wgid;
			}
		    System.out.println("DEBUG: command=" + command);
			res = con.execute(command)!=null;
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	public boolean updateWalledGardenSite(String wgid , String dsthost, String dstport, String protocol, String comment, String action) {
		boolean res = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			String command = "";
			if(dstport.trim().length()>0){
				command = "/ip/hotspot/walled-garden/ip/set dst-host='"+dsthost+"' dst-port='"+dstport+"' protocol='"+protocol+"' comment='"+comment+"' action='"+action+"' .id="+wgid;
			}else{
				command = "/ip/hotspot/walled-garden/ip/set dst-host='"+dsthost+"' protocol='"+protocol+"' comment='"+comment+"' action='"+action+"' .id="+wgid;
			}
			System.out.println("DEBUG: command=" + command);
			res = con.execute(command)!=null;
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	public void updateHsserver(String hssid , String hssname, String hssprof, String hssint, String pool, String apm, String kato, String idleto) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/hotspot/set name="+hssname+" profile="+hssprof+" interface="+hssint+" address-pool="+pool+" addresses-per-mac="+apm+" keepalive-timeout="+kato+" idle-timeout="+idleto+" .id="+hssid;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void updateHsserverProf(String hspid , String hsprof, String hsadd, String htdir, String dnsname, String loginby, String cookieto, String smtps, String ratelim, String htproxy) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/hotspot/profile/set name='"+hsprof+"' hotspot-address='"+hsadd+"' html-directory='"+htdir+"' dns-name='"+dnsname+"' login-by='"+loginby+"' smtp-server='"+smtps+"' rate-limit='"+ratelim+"' http-proxy='"+htproxy+"' .id='"+hspid+"'";
			
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public boolean updateIpadd(String uid , String interf, String ipadd, String net) {
		boolean ret = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/address/set interface="+interf+" address="+ipadd+" network="+net+" .id="+uid;
			
			System.out.println("DEBUG: command=" + command);
			ret = con.execute(command) != null;
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		return ret;
	}
	public void addIpadd(String interf, String ipadd, String net) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/address/add interface='"+interf+"' address='"+ipadd+"' network='"+net+"'";
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public boolean updateInterface(String intid , String intname, String inttype, String mtu) {
		boolean ret = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/interface/set name="+intname+" type='"+inttype+"' mtu="+mtu+" .id="+intid;
			System.out.println("DEBUG: command=" + command);
			ret = con.execute(command) != null;
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		return ret;
	}
	public void updateVlan(String intid , String intname, String vlid, String inttype, String mtu) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/interface/vlan/set name='"+intname+"' vlan-id='"+vlid+"' mtu='"+mtu+"' .id="+intid;
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void resetPool(String id) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/pool/reset-counter .id="+id;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void resetInterface(String intid) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/interface/reset-counter  .id="+intid;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void resetUser(String uid) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			//con.execute("/system/reboot"); // execute a command
			//con.disconnect(); // disconnect from router
			String command = "/ip/hotspot/user/reset-counter  .id="+uid;
			
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void resetUserProf(String pid) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			//con.execute("/system/reboot"); // execute a command
			//con.disconnect(); // disconnect from router
			String command = "/ip/hotspot/user/profile/reset-counter  .id="+pid;
			
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void resetWalledGarden(String wgid) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			//con.execute("/system/reboot"); // execute a command
			//con.disconnect(); // disconnect from router
			String command = "/ip/hotspot/walled-garden/reset-counter  .id="+wgid;
			
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void resetHsserver(String hssid) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			//con.execute("/system/reboot"); // execute a command
			//con.disconnect(); // disconnect from router
			String command = "/ip/hotspot/reset-counter  .id="+hssid;
			
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void resetHsserverProf(String hspid) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/hotspot/reset-counter  .id="+hspid;
			
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void resetIpadd(String uid) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			//con.execute("/system/reboot"); // execute a command
			//con.disconnect(); // disconnect from router
			String command = "/ip/address/reset-counter  .id="+uid;
			
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void updateDNS(String servers, String arr , String mups, String qsto, String qtto, String csize, String cmttl) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/dns/set servers="+servers+" allow-remote-requests="+arr+" max-udp-packet-size="+mups+" query-server-timeout="+qsto+" query-total-timeout="+qtto+" cache-size="+csize+" cache-max-ttl="+cmttl;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public void updateDNSServer(String servers) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "/ip/dns/set servers="+servers;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public boolean changeIp(String ident, String name, String ipadd, String network, String defgateway) {
		boolean success = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/ip/address/set address="+ipadd+" network="+network+" interface="+name+" .id="+ident;
			String command1 = "/ip/route/add gateway="+defgateway;
			String command2 = "/ip/dns/set servers="+defgateway;
			
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
	public boolean changeWg(String newip, String wgid){
		boolean res = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/ip/hotspot/walled-garden/ip/set dst-address='"+newip+"' .id="+wgid;
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command)!=null){
				res = true;
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return res;
	}
	public boolean createVoucher(String un, String pw, String prof, String upt, String lbi, String lbo, String svr) {
		boolean success = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/ip/hotspot/user/add name='"+un+"' password='"+pw+"' profile='"+prof+"' limit-uptime='"+upt+"' limit-bytes-in='"+lbi+"' limit-bytes-out='"+lbo+"' server="+svr;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			success = true;
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		return success;
	}
    public void editDNS(String dname, String daddr, String dttl,String id) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
		
			String command = "/ip/dns/static/set name="+dname+" address="+daddr+" ttl="+dttl+" .id="+id;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
    public boolean checkUser(String uname, String upass) {
    	boolean check = false;
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/hotspot/user/print where name="+uname+" AND password="+upass);
			System.out.println(rs);
			if(rs.isEmpty()){
				check = false;
			}else{
				check = true;
				for (Map<String,String> r : rs) {
					System.out.println(r);
				}
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return check;
	}
    //Location Functions
    
    public void createBridge(String bname) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/interface/bridge/add name='"+bname+"' arp=enabled";
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
    
    public void addPort(String interf, String bname) {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/interface/vlan/remove .id=*19";
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
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
    
    public boolean multiWan(String script) {
		boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "system/backup/restore name="+script;
			
			if(con.execute(command) != null){
				result = true;
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1);result = false; }
		return result;
	}
    public boolean checkInActive(String uip) {
    	boolean check = false;
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/ip/hotspot/active/print where address="+uip);
			System.out.println(rs);
			if(rs.isEmpty()){
				check = false;
			}else{
				check = true;
				for (Map<String,String> r : rs) {
					System.out.println(r);
				}
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return check;
	}
    public boolean activateBackUp(String script) {
		boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "system/backup/restore name="+script;
			String command1 = "system/backup/restore name="+script;
			String command2 = "system/backup/restore name="+script;
			
			if(con.execute(command) != null){
				result = true;
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1);result = false; return result;}
		return result;
	}
    
    public String resolveSite(String site) {
		String siteip = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			List<Map<String, String>> rs = con.execute("/ping address="+site+" count=1");
			for (Map<String,String> r : rs) {
				System.out.println(r);
				siteip = r.get("host");
			}
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return siteip;
	}
    
    public List<Map<String, String>> firewallRules1(String tag) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/firewall/filter/print where log-prefix="+tag);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
    
    public List<Map<String, String>> firewallRules() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			
			rs = con.execute("/ip/firewall/filter/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
    
    public boolean addWebFilter(String address, String site) {
    	boolean result  = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/firewall/filter/add chain=forward dst-address="+address+" action=drop "
					+ "protocol=tcp port=80,443 comment="+site+" log=true log-prefix=webfil";
			
			if(con.execute(command)!=null){
				result = true;
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); return result;}
		return result;
	}
    
	public boolean addDevFilter(String mac) {
		boolean result  = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/firewall/filter/add chain=forward src-mac-address="+mac+" action=drop "
					+ "comment=devicefilter log=true log-prefix=macfil";
			
			if(con.execute(command)!=null){
				result = true;
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); return result;}
		return result;
	}
	public boolean addKeyFilter(String key) {
		boolean result  = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/firewall/filter/add chain=forward content="+key+" action=drop "
					+ "protocol=tcp port=80 comment=keyfilter log=true log-prefix=keyfil";
			
			if(con.execute(command)!=null){
				result = true;
			}
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); return result;}
		return result;
	}
	public boolean removeFilter(String id) {
		boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			if(con.execute("/ip/firewal/filter/remove .id="+id)!=null){
				result = true;
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); return result;}
		return result;
	}
	public boolean enableFilter(String id) {
		boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			if(con.execute("/ip/firewall/filter/set disabled=false .id="+id)!=null){
				result = true;
			}
			result = true;
			con.close();
			
		} catch(Exception e1) { System.out.println(e1);return result; }
		return result;
	}
	public boolean disableFilter(String id) {
		boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			con.execute("/ip/firewall/filter/set disabled=true .id="+id);
			result = true;
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); return result;}
		return result;
	}
	public void addBridge(String bname, String arp) {
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/interface/bridge/add name='"+bname+"' arp="+arp;
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
	}
	public String getForwardingRule(String interf){
		String ret = null;
		String df = "DefaultForward"+interf;
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
	public boolean DosAttack(String action) {
		boolean ret = false;
		try {
			boolean res = true;
			String command = "";
			String comment = "Default DOS protection";
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
	public boolean DDosAttack(String action) {
		boolean ret = false;
		try {
			boolean res = true;
			String command = "";
			String comment = "Default DDOS Protection";
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
	public boolean BlackHoleF(String action) {
		boolean ret = false;
		try {
			boolean res = true;
			String command = "";
			String comment = "Default BH Protection";
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
	public boolean BlackHoleA(String action) {
		boolean ret = false;
		try {
			boolean res = true;
			String command = "";
			String comment = "Default BH Protection";
			try {
				ApiConnection con = ApiConnection.connect(ip); 
				con.login(user,pass); 		
				List<Map<String,String>> rs = con.execute("/ip/firewall/address-list/print where comment='"+comment+"'");
				for(Map<String, String> r:rs){
					String ident = r.get(".id");
					command = "/ip/firewall/address-list/"+action+" .id="+ident;
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
	public boolean DOSRuleStatus(){
		boolean ret = true;
		String df = "Default DOS protection";
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
	public boolean BHRuleStatusF(){
		boolean ret = true;
		String df = "Default BH Protection";
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/firewall/filter/print where comment='"+df+"'");
			for(Map<String, String> r : rs){
				
				ret = ret && Boolean.valueOf(r.get("disabled"));
				System.out.println("F"+ret);
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return ret;
	}
	public boolean BHRuleStatusA(){
		boolean ret = true;
		String df = "Default BH Protection";
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			List<Map<String,String>> rs = con.execute("/ip/firewall/address-list/print where comment='"+df+"'");
			for(Map<String, String> r : rs){
				ret = ret && Boolean.valueOf(r.get("disabled"));
				System.out.println("A"+ret);
			}
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return ret;
	}
	public boolean DDOSRuleStatus(){
		boolean ret = true;
		String df = "Default DDOS Protection";
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
	public List<Map<String, String>> certs() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			rs = con.execute("/certificate/print");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public boolean setAds(String uid , String adstat, String adurl, String interval, String adto) {
		boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "";
			
			command = "/ip/hotspot/user/profile/set advertise='"+adstat+"' advertise-url='"+adurl+"' advertise-timeout='"+adto+"' .id="+uid;
			
			System.out.println("DEBUG: command=" + command);
			result = con.execute(command) != null;
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		return result;
	}
	public void adStat(String uid , String adstat) {
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "";
			
			command = "/ip/hotspot/user/profile/set advertise='"+adstat+"' .id="+uid;
			
			System.out.println("DEBUG: command=" + command);
			con.execute(command);
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}
	public List<Map<String, String>> quickCommand(String command) {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass);
			
			System.out.println("DEBUG: command=" + command);
			rs = con.execute(command);
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		return rs;
	}
	public List<Map<String, String>> interfRoute(String intname) {
		List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String com = "DefaultRoute"+intname;
			rs = con.execute("/ip/route/print where comment='"+com+"'");
			con.close();
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> interfRouteGw(String intname) {
		List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/ip/route/print where gateway='"+intname+"'");
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
	}
	public List<Map<String, String>> CPU() {
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/system/resource/cpu/print detail");
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
		return rs;
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
	public void test() {
		System.out.println("test");
		List<Map<String, String>> rs = null;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			rs = con.execute("/tool/torch");
			for (Map<String,String> r : rs) {
				System.out.println(r);
			}
			con.close();
		} catch(Exception e1) { e1.printStackTrace(); }
		
	}
	
	
	public void testCounter() {
		long start = System.currentTimeMillis();
		pc.countPrimes(1000000);
		long end = System.currentTimeMillis();
		System.out.println((end - start) / 1000000);
	}

}
