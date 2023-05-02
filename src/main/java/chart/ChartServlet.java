package chart;

import java.awt.BasicStroke;
import java.awt.Color;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.alps.Dao;
import com.alps.Gateway;
import com.alps.TrafficMonitor;

import me.legrange.mikrotik.ApiConnection;
import me.legrange.mikrotik.MikrotikApiException;
import me.legrange.mikrotik.ResultListener;

public class ChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String dbhost="127.0.0.1", dbport="3306", dbname="alpsgateway", dbuser="ebahn", dbpass="ebahn";
	static Connection cn = null;
	static Dao dao = new Dao();
	Gateway gt = new Gateway();
	TrafficMonitor tm = new TrafficMonitor();
	static String ip = dao.getSetting("default_ip");
	static String pass = dao.getSetting("password");
	static String user = dao.getSetting("username");
	public Connection connect() {
		
		try { Class.forName("com.mysql.jdbc.Driver");
		cn = DriverManager.getConnection("jdbc:mysql://"+dbhost+":"+dbport+"/"+dbname, dbuser, dbpass);
		} catch(Exception e) { System.out.println(e); }
		return cn;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		connect();
		String type = "";
		int width = 500, height = 500;
		try{
			type = request.getParameter("type");
			width = Integer.parseInt(request.getParameter("w"));
			height = Integer.parseInt(request.getParameter("h"));
			System.out.println(type);
		}catch(Exception e){
			width = 500;
			height = 500;
		}
		
		

		response.setContentType("image/png");

		OutputStream outputStream = response.getOutputStream();
		JFreeChart chart = null;
		if(type.equals("socialuser")) {
			String uid = request.getParameter("user");
			String cid = request.getParameter("cli");
			chart = socialuser(uid, cid); }
		else if(type.equals("locbanup")) { chart = locationBandwidthUp(); }
		else if(type.equals("locbandown")) { chart = locationBandwidthDown(); }
		else if(type.equals("vlbanup")) { chart = vlanBandwidthUp(); }
		else if(type.equals("vlbandown")) { chart = vlanBandwidthDown(); }
		else if(type.equals("locdrop")) { chart = locationBandwidthDrop(); }
		else if(type.equals("vldrop")) { chart = vlanBandwidthDrop(); }
		else if(type.equals("ds")) { chart = main_Graph(); }
		else { chart = vodChart(); }
		
		ChartUtilities.writeChartAsPNG(outputStream, chart, width, height);

	}

	public JFreeChart socialuser(String uid, String cid) {
		

		DefaultPieDataset dataset = new DefaultPieDataset();
		
		try{
		   String jsonurl = dao.getSetting("socurl");
		
		   String url = jsonurl+"?cli="+URLEncoder.encode(cid, "UTF-8")+"&username="+URLEncoder.encode(uid, "UTF-8");
		   //System.out.println(url);
		   String recv;
		   String recvbuff = "";
		   URL jsonpage = new URL(url);
		   URLConnection urlcon = jsonpage.openConnection();
		   BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream()));
			
		   
		   while ((recv = buffread.readLine()) != null){
		    recvbuff += recv;
		    
		   
		   }
		   buffread.close();
		   
		   Object obj=JSONValue.parse(recvbuff);
		   //System.out.println(recvbuff);

		   JSONArray array=(JSONArray)obj;
		   for(int i=1; i< array.size(); i++){
			  
			   JSONObject obj2=(JSONObject)array.get(i);
			   String location = obj2.get("location").toString();
			   String login = obj2.get("visit").toString();
			   
			   dataset.setValue(location, Integer.parseInt(login));
			   
		   }
		} catch(Exception e) { System.out.println(e);}
		
		boolean legend = true;
		boolean tooltips = false;
		boolean urls = false;

		JFreeChart chart = ChartFactory.createPieChart("User Login", dataset, legend, tooltips, urls);

		chart.setBorderPaint(Color.blue);
		chart.setBorderStroke(new BasicStroke(5.0f));
		chart.setBorderVisible(true);
		return chart;
		
		
	}
	
	public JFreeChart locationBandwidthUp() {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		try { 
			for (Map<String,String> r : gt.interfaces()) {
				String type = r.get("type");
				if(type.equals("bridge")){
					String name = r.get("name");
					String module = StringUtils.left(name,3);
					String packets = r.get("rx-packet");
						
					dataset.setValue(Integer.parseInt(packets), "Bandwidth(Packets)", module);
				}
		}
		
			
		} catch(Exception e2) { System.out.println(e2); }
		
		JFreeChart chart = ChartFactory.createBarChart(
				"", "Locations", "Packets", dataset,
				PlotOrientation.VERTICAL, false, true, false);
		chart.setBackgroundPaint(Color.LIGHT_GRAY);
		chart.getTitle().setPaint(Color.blue);
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.red);

		return chart;
	}
	
	public JFreeChart vlanBandwidthUp() {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		try { 
			for (Map<String,String> r : gt.interfaces()) {
				String type = r.get("type");
				if(type.equals("vlan")){
					String name = r.get("name");
					String module = StringUtils.right(name,3);
					String packets = r.get("rx-packet");
						
					dataset.setValue(Integer.parseInt(packets), "Bandwidth(Packets)", module);
				}
		}
		
			
		} catch(Exception e2) { System.out.println(e2); }
		
		JFreeChart chart = ChartFactory.createBarChart(
				" ", "VLANs", "Packets", dataset,
				PlotOrientation.VERTICAL, false, true, false);
		chart.setBackgroundPaint(Color.white);
		chart.getTitle().setPaint(Color.blue);
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.red);

		return chart;
	}
	public JFreeChart locationBandwidthDown() {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		try { 
			for (Map<String,String> r : gt.interfaces()) {
				String type = r.get("type");
				if(type.equals("bridge")){
					String name = r.get("name");
					String module = StringUtils.left(name,3);
					String packets = r.get("tx-packet");
						
					dataset.setValue(Integer.parseInt(packets), "Bandwidth(Packets)", module);
				}
		}
		
			
		} catch(Exception e2) { System.out.println(e2); }
		
		JFreeChart chart = ChartFactory.createBarChart(
				" ", "Location", "Packets", dataset,
				PlotOrientation.VERTICAL, false, true, false);
		chart.setBackgroundPaint(Color.white);
		chart.getTitle().setPaint(Color.blue);
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.red);

		return chart;
	}
	
	public JFreeChart vlanBandwidthDown() {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		try { 
			for (Map<String,String> r : gt.interfaces()) {
				String type = r.get("type");
				if(type.equals("vlan")){
					String name = r.get("name");
					String module = StringUtils.right(name,3);
					String packets = r.get("tx-packet");
						
					dataset.setValue(Integer.parseInt(packets), "Bandwidth(Packets)", module);
				}
			}
		
		} catch(Exception e2) { System.out.println(e2); }
		
		JFreeChart chart = ChartFactory.createAreaChart(
				" ", "VLANs", "Packets", dataset,
				PlotOrientation.VERTICAL, false, true, false);
		chart.setBackgroundPaint(Color.white);
		chart.getTitle().setPaint(Color.blue);
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.red);

		return chart;
	}
	public JFreeChart vlanBandwidthDrop() {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		try { 
			for (Map<String,String> r : gt.interfaces()) {
				String type = r.get("type");
				if(type.equals("vlan")){
					String name = r.get("name");
					String module = StringUtils.right(name,3);
					String packets = r.get("tx-drop");
						
					dataset.setValue(Integer.parseInt(packets), "Bandwidth(Packets)", module);
				}
		}
		
			
		} catch(Exception e2) { System.out.println(e2); }
		
		JFreeChart chart = ChartFactory.createBarChart(
				" ", "VLANs", "Packets", dataset,
				PlotOrientation.VERTICAL, false, true, false);
		chart.setBackgroundPaint(Color.white);
		chart.getTitle().setPaint(Color.blue);
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.red);

		return chart;
	}
	public JFreeChart locationBandwidthDrop() {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		try { 
			for (Map<String,String> r : gt.interfaces()) {
				String type = r.get("type");
				if(type.equals("bridge")){
					String name = r.get("name");
					String module = StringUtils.left(name,3);
					String packets = r.get("tx-drop");
					//System.out.print(name+""+packets);
					dataset.setValue(Integer.parseInt(packets), "Bandwidth(Packets)", module);
				}
		}
		
			
		} catch(Exception e2) { System.out.println(e2); }
		
		JFreeChart chart = ChartFactory.createAreaChart(
				" ", "Location", "Packets", dataset,
				PlotOrientation.VERTICAL, false, true, false);
		chart.setBackgroundPaint(Color.white);
		chart.getTitle().setPaint(Color.blue);
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.red);

		return chart;
	}
	
	public JFreeChart main_Graph() {
		final XYSeriesCollection dataset = new XYSeriesCollection();
		try { 
			
			for (Map<String,String> r : gt.interfaces()) {
				String name = r.get("name");
				if(name.equals("WAN")){
					System.out.println(name);
					//wan dataset
					final XYSeries wanIn = new XYSeries( "WAN IN" );
					final XYSeries wanOut = new XYSeries( "WAN OUT" );
					for (Map<String,String> wanr : tm.monitor(name)) {
						//System.out.println(wanr);
						wanIn.add(Integer.parseInt(wanr.get(".section")),Integer.parseInt(wanr.get("rx-packets-per-second")));
						wanOut.add(Integer.parseInt(wanr.get(".section")),Integer.parseInt(wanr.get("tx-packets-per-second")));
					}
					dataset.addSeries( wanIn );
					dataset.addSeries( wanOut );
				}
				else if(name.equals("WAN1")){
					//wan dataset
					final XYSeries wan1In = new XYSeries( "WAN1 IN" );
					final XYSeries wan1Out = new XYSeries( "WAN1 OUT" );
					for (Map<String,String> wanr : tm.monitor(name)) {
						//System.out.println(wanr);
						wan1In.add(Integer.parseInt(wanr.get(".section")),Integer.parseInt(wanr.get("rx-packets-per-second")));
						wan1Out.add(Integer.parseInt(wanr.get(".section")),Integer.parseInt(wanr.get("tx-packets-per-second")));
					}
					dataset.addSeries( wan1In );
				}
				else if(name.equals("WAN2")){
					//wan dataset
					final XYSeries wan2In = new XYSeries( "WAN2 IN" );
					final XYSeries wan2Out = new XYSeries( "WAN2 OUT" );
					for (Map<String,String> wanr : tm.monitor(name)) {
						//System.out.println(wanr);
						wan2In.add(Integer.parseInt(wanr.get(".section")),Integer.parseInt(wanr.get("rx-packets-per-second")));
						wan2Out.add(Integer.parseInt(wanr.get(".section")),Integer.parseInt(wanr.get("tx-packets-per-second")));
					}
					dataset.addSeries( wan2In );
					dataset.addSeries( wan2Out );
				}
				else if(name.equals("Master")){
					//wan dataset
					final XYSeries masterIn = new XYSeries( "Master IN" );
					final XYSeries masterOut = new XYSeries( "Master OUT" );
					for (Map<String,String> wanr : tm.monitor(name)) {
						//System.out.println(wanr);
						masterIn.add(Integer.parseInt(wanr.get(".section")),Integer.parseInt(wanr.get("rx-packets-per-second")));
						masterOut.add(Integer.parseInt(wanr.get(".section")),Integer.parseInt(wanr.get("tx-packets-per-second")));
					}
					dataset.addSeries( masterIn );
					dataset.addSeries( masterOut );
				}
				else if(name.equals("LAN")){
					System.out.println(name);
					//lan dataset
					final XYSeries lanIn = new XYSeries( "LAN - IN" );
					final XYSeries lanOut = new XYSeries( "LAN - OUT" );
					for (Map<String,String> wanr : tm.monitor(name)) {
						//System.out.println(wanr);
						lanIn.add(Integer.parseInt(wanr.get(".section")),Integer.parseInt(wanr.get("rx-packets-per-second")));
						lanOut.add(Integer.parseInt(wanr.get(".section")),Integer.parseInt(wanr.get("tx-packets-per-second")));
					}
					dataset.addSeries( lanIn );
					dataset.addSeries( lanOut );
				}
			}
			
		} catch(Exception e2) { System.out.println(e2); }
		
		JFreeChart xylineChart = ChartFactory.createXYLineChart(
		         "Bandwidth Utilization" ,
		         "Section" ,
		         "Packets per Second" ,
		         dataset ,
		         PlotOrientation.VERTICAL ,
		         true , true , false);
		         
		      final XYPlot plot = xylineChart.getXYPlot( );
		      XYLineAndShapeRenderer renderer = new XYLineAndShapeRenderer( );
		      xylineChart.setBackgroundPaint(Color.white);
		      xylineChart.getTitle().setPaint(Color.blue);
		      renderer.setSeriesPaint( 0 , Color.RED );
		      renderer.setSeriesPaint( 1 , Color.GREEN );
		      renderer.setSeriesPaint( 2 , Color.YELLOW );
		      renderer.setSeriesPaint( 3 , Color.DARK_GRAY );
		      renderer.setSeriesPaint( 4 , Color.CYAN );
		      renderer.setSeriesPaint( 5 , Color.pink );
		      renderer.setSeriesPaint( 6 , Color.BLACK );
		      renderer.setSeriesPaint( 7 , Color.BLUE );
		      renderer.setSeriesPaint( 8 , Color.MAGENTA );
		      renderer.setSeriesStroke( 0 , new BasicStroke( 3.0f ) );
		      renderer.setSeriesStroke( 1 , new BasicStroke( 3.0f ) );
		      renderer.setSeriesStroke( 2 , new BasicStroke( 2.0f ) );
		      renderer.setSeriesStroke( 3 , new BasicStroke( 2.0f ) );
		      renderer.setSeriesStroke( 4 , new BasicStroke( 2.0f ) );
		      renderer.setSeriesStroke( 5 , new BasicStroke( 2.0f ) );
		      renderer.setSeriesStroke( 6 , new BasicStroke( 2.0f ) );
		      renderer.setSeriesStroke( 7 , new BasicStroke( 2.0f ) );
		      renderer.setSeriesStroke( 8 , new BasicStroke( 2.0f ) );
		      plot.setRenderer( renderer ); 

		return xylineChart;
	}

	public JFreeChart dsChart() {
		DefaultPieDataset dataset = new DefaultPieDataset();
		dataset.setValue("TV CHannels", 23.3);
		dataset.setValue("VOD", 32.4);
		dataset.setValue("Digital Signage", 44.2);

		boolean legend = true;
		boolean tooltips = false;
		boolean urls = false;

		JFreeChart chart = ChartFactory.createPieChart("TV Channels Views", dataset, legend, tooltips, urls);

		chart.setBorderPaint(Color.GREEN);
		chart.setBorderStroke(new BasicStroke(5.0f));
		chart.setBorderVisible(true);

		return chart;
	}
	public JFreeChart vodChart() {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		try { ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM _vod"); 
		while (rs.next()){
		String title = rs.getString("name");
		String name = StringUtils.left(title,3);
		int wc = rs.getInt("watch");
		
		dataset.setValue(wc, "Watch Count", name);
		}} catch(Exception e2) { System.out.println(e2); }
		
		JFreeChart chart = ChartFactory.createBarChart(
				"eBahn IPTV VOD Watch", "Movie Name", "Watch Count", dataset,
				PlotOrientation.VERTICAL, false, true, false);
		chart.setBackgroundPaint(Color.white);
		chart.getTitle().setPaint(Color.blue);
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.red);

		return chart;
	}
	
	public JFreeChart moduleChart() {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		try { ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM _modules"); 
		while (rs.next()){
		String name = rs.getString("title");
		String module = StringUtils.left(name,3);
		int use = rs.getInt("usage");
			
		dataset.setValue(use, "Usage", module);
		}
			
		} catch(Exception e2) { System.out.println(e2); }
		
		JFreeChart chart = ChartFactory.createBarChart(
				" ", "Modules", "Usage", dataset,
				PlotOrientation.VERTICAL, false, true, false);
		chart.setBackgroundPaint(Color.white);
		chart.getTitle().setPaint(Color.blue);
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.red);

		return chart;
	}
	
	public JFreeChart tvChart() {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		
		try {
			ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `_channels`");
			while(rs.next()) {
				String name = rs.getString("name");
				String ch = StringUtils.left(name,2)+StringUtils.right(name,1);			
				int views = rs.getInt("watch");
				dataset.setValue(views, "No. of Views", ch);
			}
		} catch(Exception e1) {System.out.println(e1) ;}
		

		JFreeChart chart = ChartFactory.createBarChart("eBahnIPTV TV Channels Views", "TV Channels", "No. of Views", dataset,
				PlotOrientation.VERTICAL, false, true, false);
		chart.setBackgroundPaint(Color.gray);
		chart.getTitle().setPaint(Color.blue);
		CategoryPlot p = chart.getCategoryPlot();
		p.setRangeGridlinePaint(Color.red);

		return chart;
	}

}