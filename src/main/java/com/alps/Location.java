package com.alps;

import java.util.Map;

import com.alps.master.MasterApi;

import me.legrange.mikrotik.ApiConnection;

public class Location {
	static Dao dao = new Dao();
	Gateway g = new Gateway();
	static String ip = dao.getSetting("default_ip");
	static String pass = dao.getSetting("password");
	static String user = dao.getSetting("username");

	public static void main(String[] args) {
		Location loc = new Location();
		
		String locname = "Public";
		loc.setWanBalancing(locname);
		/**String vlanid = "999";
		String vlname = "test999";
		String poolname = "testpool";
		String addrange = "192.168.3.3-192.168.3.255";
		String ip = "192.168.3.2";
		String network = "192.168.3.0";
		String loginby = "http-chap,http-pap,cookie";
		String smask = "/24";
		String ldp = "hotspot2";
		
		String ipmask = ip+smask;
		String badip = ip.replace(".", ":");
		String[] ipchunk = badip.split(":");
		
  	  	System.out.println(ipchunk.length);
		String gwip = ipchunk[0]+"."+ipchunk[1]+"."+ipchunk[2]+".1";
		
		System.out.println("ip1="+ipchunk[0]);
		System.out.println("ip2="+ipchunk[1]);
		System.out.println("ip3="+ipchunk[2]);
		System.out.println("ip4="+ipchunk[3]);
		
		
		String dhcpname = locname+"dhcp";
		String pname = locname+"hsp";
		String sname = locname+"hotspot";
		String cto = "3d";
		
		System.out.println("gwip="+gwip);
		System.out.println("addrange="+addrange);
		
		String interf = "LAN";
		String netadd = network+smask;
		System.out.println("netadd="+netadd);

		//System.exit(1);
		loc.createBridge(locname);
		loc.addVlan(vlanid, vlname, interf, "enabled");
		loc.addPort(vlname, locname);
		loc.addPool(poolname, addrange, "none");
		loc.add_dhcp(dhcpname, locname, poolname, "00:10:00", "static");
		loc.add_DhcpNet(netadd, gwip, locname);
		loc.addAddress(locname, ipmask, network );
		loc.addhs_prof(pname, ip, ldp, loginby, cto);
		loc.addhs_server(sname, pname, locname, poolname, "1", "0", "0");**/
	}
	
	//Location Functions
	public String addVlan(String vid, String vn, String interf, String arp) {
		String result = "No";
		try {
			ApiConnection con = ApiConnection.connect(ip); 
			con.login(user,pass); 
			String command = "/interface/vlan/add vlan-id='"+vid+"' name='"+vn+"' interface='"+interf+"' loop-protect='on' arp='"+arp+"'";
			
			if(con.execute(command) != null){
				result = "Yes";
				System.out.println("DEBUG: command=" + command);
			}			
			
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("addvlan"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				result = "Exist";
			}
		}
		return result;
	}
	public boolean add_dhcp(String sname, String interf, String pool, String lease, String bootp) {
		boolean result = false;

		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/dhcp-server/add name='"+sname+"' interface='"+interf+"' address-pool='"+pool+"' lease-time='"+lease+"' bootp-support='"+bootp+"' disabled='false'";
			
			if(con.execute(command) != null){
				result = true;
				System.out.println("DEBUG: command=" + command);
			}
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("dhcpadd"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				result = true;
			}
			
		}
		return result;
	}
	public boolean add_DhcpNet(String address, String gateway, String loc) {
		boolean result = false;

		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/dhcp-server/network/add address='"+address+"' gateway='"+gateway+"' comment='"+loc+"'";
			
			if(con.execute(command) != null){
				result = true;
				System.out.println("DEBUG: command=" + command);
			}
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("dhcpnet"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				result = true;
			}
			
		}
		return result;
	}
	public boolean addPool(String name, String ranges, String nextpool) {
		boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String command = "";
			if(nextpool.equals("")){command = "/ip/pool/add name='"+name+"' ranges='"+ranges+"'";}
			else{command = "/ip/pool/add name='"+name+"' ranges='"+ranges+"' next-pool='"+nextpool+"'";}
			
			if(con.execute(command) != null){
				result = true;
				System.out.println("DEBUG: command=" + command);
			}
			System.out.println("DEBUG: command=" + command);
			con.close();
		} catch(Exception e1) { 
			System.out.println("dhcpnet"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				result = true;
			}
			
		}
		return result;
	}
	public boolean addhs_prof(String pname, String hsadd, String htmdir, String loginby, String cto) {
		boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/hotspot/profile/add name='"+pname+"' hotspot-address='"+hsadd+"' html-directory='"+htmdir+"' login-by='"+loginby+"' http-cookie-lifetime='"+cto+"'";
			
			if(con.execute(command) != null){
				result = true;
				System.out.println("DEBUG: command=" + command);
			}
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("dhcpnet"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				result = true;
			}
			
		}
		return result;
	}
	public boolean addhs_prof(String pname, String hsadd, String htmdir, String loginby, String cto, String rad, String dns, String cert, String rate) {
		boolean res = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/hotspot/profile/add name='"+pname+"' hotspot-address='"+hsadd+"' rate-limit='"+rate+"' html-directory='"+htmdir+"' login-by='"+loginby+"' use-radius='"+rad+"' dns-name='"+dns+"' ssl-certificate='"+cert+"' http-cookie-lifetime='"+cto+"'";
			
			res = con.execute(command) != null;
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("dhcpnet"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				res = true;
			}
		}
		return res;
	}
	public boolean addhs_server(String sname, String profile, String interf, String pool, String permac, String idle, String keepalive ) {
		boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); // log in to router
			String command = "/ip/hotspot/add name='"+sname+"' profile='"+profile+"' interface='"+interf+"' address-pool='"+pool+"' addresses-per-mac='"+permac+"' keepalive-timeout='"+keepalive+"' idle-timeout='"+idle+"' disabled='false'" ;
			
			if(con.execute(command) != null){
				result = true;
				System.out.println("DEBUG: command=" + command);
			}
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("hsserver"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				result = true;
			}
			
		}
		return result;
	}
    public boolean createBridge(String bname) {
    	boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/interface/bridge/add name='"+bname+"' arp=enabled";
			
			System.out.println("DEBUG: command=" + command);
			if(con.execute(command) != null){
				result = true;
				System.out.println("DEBUG: command=" + command);
			}
			
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("dhcpnet"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				//result = true;
			}
			
		}
		return result;
	}
    
    public boolean addPort(String interf, String bname) {
    	System.out.println("port to=" + bname);
    	boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/interface/bridge/port/add interface='"+interf+"' bridge='"+bname+"' auto-isolate=yes";
			
			if(con.execute(command) != null){
				result = true;
				System.out.println("DEBUG: command=" + command);
			}
			
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("port:"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				result = true;
			}
			
		}
		return result;
	}
    public boolean addAddress(String interf, String intip, String network ) {
    	boolean result = false;
    	System.out.println(interf+""+intip+""+network);
    	//locname, ip, netadd 
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/address/add address='"+intip+"' network='"+network+"' interface='"+interf+"'" ;
			
			if(con.execute(command) != null){
				result = true;
				System.out.println("DEBUG: command=" + command);
			}
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("dhcpnet"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				result = true;
			}
			
		}
		return result;
	}
    
    public boolean addMasqurade(String loc, String net) {
    	boolean result = false;
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/ip/firewall/nat/add action=masquerade chain=srcnat comment='"+loc+"' src-address='"+net+"'";
			
			if(con.execute(command) != null){
				result = true;
				System.out.println("DEBUG: command=" + command);
			}
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("Masq"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				result = true;
			}
			
		}
		return result;
	}
    
    public boolean setWanBalancing(String locname) {
    	boolean result = false;
    	
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			String gw_ports =  dao.getSetting("gateway_ports");
			int count = 0;
			for (Map<String,String> mp : g.ethernet()) {
				if(mp.get("name").contains("WAN")){
					String interfname = mp.get("name");
					//String command = "chain=prerouting action=accept dst-address="+network+" in-interface="+locname+"  log=no log-prefix=''" ;
					String command1 = "/ip/firewall/mangle/add chain=prerouting action=mark-connection new-connection-mark="+interfname+"_conn passthrough=yes dst-address-type=!local in-interface="+locname+" per-connection-classifier=both-addresses-and-ports:"+gw_ports+"/"+count+" comment='Modify Connection Mark coming from "+locname+" to "+interfname+"'";
					String command2 = "/ip/firewall/mangle/add chain=prerouting action=mark-routing new-routing-mark=to_"+interfname+" passthrough=yes in-interface="+locname+"  connection-mark="+interfname+"_conn comment='Route Packets coming from LAN under WAN_conn to "+interfname+"'" ;
					System.out.println("DEBUG: command=" + command1);
					System.out.println("DEBUG: command=" + command2);
					result = con.execute(command1) != null && con.execute(command2) != null;
					count =+ 1;
				}
			}
			con.close();
			
		} catch(Exception e1) { 
			System.out.println("Firewall Mangle"+e1); 
			if(String.valueOf(e1).contains("already") || String.valueOf(e1).contains("exists")){
				result = true;
			}
		}
		return result;
	}
    
	public void test() {
		
		try {
			ApiConnection con = ApiConnection.connect(ip); // connect to router
			con.login(user,pass); 
			
			String command = "/interface/bridge/remove .id=*19";
			
			System.out.println("DEBUG: command=" + command);
			//con.execute(command);
			
			
			con.close();
			
		} catch(Exception e1) { System.out.println(e1); }
		
	}

}
