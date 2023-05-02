<%@page import="com.itextpdf.text.Document,
com.itextpdf.text.Paragraph,
com.itextpdf.text.pdf.PdfWriter,
com.itextpdf.text.pdf.PdfPTable,
com.itextpdf.text.pdf.PdfPCell,
com.itextpdf.text.Image,
java.net.URL,com.itextpdf.text.Chunk,
com.itextpdf.text.Element,
com.itextpdf.text.Font,
java.sql.*,java.util.*,java.io.*,
com.itextpdf.text.Phrase"%>
<%! 
public String dbhost="127.0.0.1", dbport="3306", dbname="alpsgateway", dbuser="ebahn", dbpass="ebahn";
public static Connection cn = null, cn1 = null;
%>
<%! 
public Connection connect() {
	Properties prop = new Properties();
	
	try { Class.forName("com.mysql.jdbc.Driver");
	cn = DriverManager.getConnection("jdbc:mysql://"+dbhost+":"+dbport+"/"+dbname, dbuser, dbpass);
	} catch(Exception e) { System.out.println(e); }
	return cn;
}
%>
<%! public String eid="",venue="",venueno="",evn="",comp="",cont="",phone="",email="",stdate="",puser="",ppass="",endate="",days="",dayrate="",pax="",paxrate="",total1="",plan="",planname="",prof="",planid="",lbi="",lbo=""; 
	public double subtotal=0.00,total=0.00,subtax=0.00;
%>
<%
if(request.getParameter("pid") != null){
String item = request.getParameter("pid");
connect();
	 try {
		ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `mr_purchase` WHERE `id`="+item);
	  	
	  	while(rs.next()){
	  		eid=rs.getString("id");
	  		venue=rs.getString("mr_name");
	  		venueno=rs.getString("mr_id");
	  		evn=rs.getString("description");
	  		comp=rs.getString("company_name");
	  		cont=rs.getString("contact_person");
	  		phone=rs.getString("contact_phone");
	  		email=rs.getString("contact_email");
	  		stdate=rs.getString("start_date");
	  		puser=rs.getString("username");
	  		ppass=rs.getString("password");
	  		endate=rs.getString("end_date");
	  		pax=rs.getString("connections");
	  		plan=rs.getString("plan_name");
	  	}
	  	
		ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `mr_purchase_line` WHERE `purchase`="+item);
	  	
	  	while(rs1.next()){
	  		total=rs1.getDouble("amount");
	  		total1= String.valueOf(total);
	  	}
	  	
	cn.close();
  } catch(Exception e) {System.out.print(e);}
}
%>
<%
try{
String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
response.setContentType("application/pdf");
Document document = new Document();
PdfWriter.getInstance(document, response.getOutputStream());
document.open();
document.addTitle("Conferennce Room Event");

Font font1 = new Font(Font.FontFamily.HELVETICA  , 20, Font.BOLD);
Font font2 = new Font(Font.FontFamily.TIMES_ROMAN, 10);
Font font3 = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD);

Image image2 = Image.getInstance(url+"/dist/img/alpslogo.png");
image2.setAbsolutePosition(10f, 785f);
image2.scaleAbsolute(100f, 50f);
document.add(image2);

Paragraph paragraph = new Paragraph(50);
paragraph.setSpacingAfter(25);
paragraph.setSpacingBefore(25);
paragraph.setAlignment(Element.ALIGN_CENTER);


document.add(new Chunk("                         Event Schedule and Billing", font1));

document.add(new Paragraph(""));
   
Phrase phrase = new Phrase(50);
Chunk chunk = new Chunk(" ");
phrase.add(chunk);
document.add(phrase);
PdfPTable table = new PdfPTable(3);
table.setWidthPercentage(100);
table.setSpacingBefore(10f);
table.setSpacingAfter(10f);

table.addCell(new PdfPCell(new Phrase("S.No", font3)));
table.addCell(new PdfPCell(new Phrase("Item", font3)));
table.addCell(new PdfPCell(new Phrase("Description", font3)));

table.addCell(new PdfPCell(new Phrase("1",font2)));
table.addCell(new PdfPCell(new Phrase("Event No",font3)));
table.addCell(new PdfPCell(new Phrase(eid , font2)));

table.addCell(new PdfPCell(new Phrase("2",font2)));
table.addCell(new PdfPCell(new Phrase("Event Description",font3)));
table.addCell(new PdfPCell(new Phrase(evn , font2)));

table.addCell(new PdfPCell(new Phrase("3",font2)));
table.addCell(new PdfPCell(new Phrase("Organiser",font3)));
table.addCell(new PdfPCell(new Phrase(comp , font2)));

table.addCell(new PdfPCell(new Phrase("4",font2)));
table.addCell(new PdfPCell(new Phrase("Contact Person",font3)));
table.addCell(new PdfPCell(new Phrase(cont , font2)));

table.addCell(new PdfPCell(new Phrase("5",font2)));
table.addCell(new PdfPCell(new Phrase("Phone Number",font3)));
table.addCell(new PdfPCell(new Phrase(phone , font2)));

table.addCell(new PdfPCell(new Phrase("6",font2)));
table.addCell(new PdfPCell(new Phrase("Email Address",font3)));
table.addCell(new PdfPCell(new Phrase(email , font2)));

table.addCell(new PdfPCell(new Phrase("7",font2)));
table.addCell(new PdfPCell(new Phrase("Conference Room Number",font3)));
table.addCell(new PdfPCell(new Phrase(venueno , font2)));

table.addCell(new PdfPCell(new Phrase("8",font2)));
table.addCell(new PdfPCell(new Phrase("Conference Room Name",font3)));
table.addCell(new PdfPCell(new Phrase(venue , font2)));

table.addCell(new PdfPCell(new Phrase("9",font2)));
table.addCell(new PdfPCell(new Phrase("Start On",font3)));
table.addCell(new PdfPCell(new Phrase(stdate , font2)));

table.addCell(new PdfPCell(new Phrase("10",font2)));
table.addCell(new PdfPCell(new Phrase("End On",font3)));
table.addCell(new PdfPCell(new Phrase(endate , font2)));

table.addCell(new PdfPCell(new Phrase("11",font2)));
table.addCell(new PdfPCell(new Phrase("Connections",font3)));
table.addCell(new PdfPCell(new Phrase(pax , font2)));

table.addCell(new PdfPCell(new Phrase("12",font2)));
table.addCell(new PdfPCell(new Phrase("Username",font3)));
table.addCell(new PdfPCell(new Phrase(puser , font2)));

table.addCell(new PdfPCell(new Phrase("13",font2)));
table.addCell(new PdfPCell(new Phrase("Password",font3)));
table.addCell(new PdfPCell(new Phrase(ppass , font2)));

table.addCell(new PdfPCell(new Phrase("14",font2)));
table.addCell(new PdfPCell(new Phrase("Total Charges",font3)));
table.addCell(new PdfPCell(new Phrase(total1 , font2)));

float[] columnWidths = new float[] {10f, 25f, 50f};
table.setWidths(columnWidths);
document.add(table);

document.add(new Paragraph(""));
Phrase phrase1 = new Phrase(50);
Chunk chunk1 = new Chunk("*Total Charges inclusive of 6% Government Tax");
phrase1.add(chunk1);
document.add(phrase1);

document.add(new Paragraph(" "));
document.add(new Paragraph(" "));
document.add(new Paragraph(" "));
document.add(new Paragraph(" "));
document.add(new Paragraph(" "));
document.add(new Paragraph(" "));
document.add(new Paragraph("----------------------------                                                                            -------------------------------"));
document.add(new Paragraph(" "));
document.add(new Paragraph("Date:-----------------                                                                                   Date:------------------"));
document.close();
} catch(Exception e) {System.out.print(e);}
%>