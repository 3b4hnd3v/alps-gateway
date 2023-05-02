package com.pms.powerpro;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PowerPro
 */
public class PowerPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
	PResponse pr = new PResponse();
	PmsEntry pe = new PmsEntry();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PowerPro() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String x = request.getRequestURI();
		
		if(x.equals("/PowerPro")){
			response.getWriter().append("PowerPro PMS Interface Status Active");
		}else{
			System.out.println(request.getQueryString());
			Map<String,String> parms = pr.queryToMap(request.getQueryString());
			String event = parms.get("Event").toString();
			System.out.println("PMS Activity "+event);
			String success="Fail";
			switch (event.toString()) {
				case "CHECKIN":
					pe.setGuestname(parms.get("FirstName"));
	         		pe.setLastname(parms.get("LastName"));
	         		pe.setLanguage(parms.get("language"));
	         		pe.setSflag(parms.get("VIP"));
	         		pe.setRoomnum(parms.get("Room"));
	         		pe.setAcctnum(parms.get("ReservationID"));
	         		pe.setPromocode(parms.get("InternetAccess"));
	         		//pe.setChkodate("NA");
		  		    if(pe.add()>0){
		  		    	success = "Success";
		  		    }
		  		break;
				case "CHECKOUT":
		  	    	String roomnum = parms.get("Room");
		  	    	String resvid = parms.get("ReservationID");
		  	    	if(pe.delete(roomnum, resvid)){
		  	    		success = "Success";
		  	    	}
		  	    break;
				case "ROOMCHANGE":
		  	    	String nrn = parms.get("Room");
		  	    	String orn = parms.get("MoveFrom");
		  	    	String rid = parms.get("ReservationID");
		  	    	if(pe.update(nrn, rid, orn)>0){
		  		    	success = "Success";
		  		    }
		  	    break;
				case "GUESTCHANGE":
					pe.setGuestname(parms.get("FirstName"));
	         		pe.setLastname(parms.get("LastName"));
	         		pe.setLanguage(parms.get("language"));
	         		pe.setSflag(parms.get("VIP"));
	         		pe.setRoomnum(parms.get("Room"));
	         		pe.setAcctnum(parms.get("ReservationID"));
	         		pe.setPromocode(parms.get("InternetAccess"));
	         		//pe.setChkodate("NA");
		  		    if(pe.update(parms.get("Room"))>0){
		  		    	success = "Success";
		  		    }
				break;
			}
			if(success.equalsIgnoreCase("Success")){
				String okResp = pr.OKResponse();
				response.getWriter().append(okResp.toString());
		        System.out.println("eBahn >> Response 'OK' sent to PMS!");
			}
			//else{}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
