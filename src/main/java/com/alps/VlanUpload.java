package com.alps;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Iterator;
 
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
 
/**
 * A dirty simple program that reads an Excel file.
 * @author Anas (dgreat)
 *
 */
public class VlanUpload {
	String location;
	String filedir;
    public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getFiledir() {
		return filedir;
	}
	public void setFiledir(String filedir) {
		this.filedir = filedir;
	}
	public static void main(String[] args) throws IOException {
    	VlanUpload vu = new VlanUpload();
    	vu.vlanFromExcel("C:/Users/USER/Desktop/Alps/VlanListTemplate.xlsx");
    }
    public void vlanFromExcel(String vfile){
    	Location loc = new Location();
    	String vname="",vid="0x0badf00d",location="",interf="LAN";
        String excelFilePath = vfile;
        try{
        	FileInputStream inputStream = new FileInputStream(new File(excelFilePath));
        
	        Workbook workbook = new XSSFWorkbook(inputStream);
	        Sheet firstSheet = workbook.getSheetAt(0);
	        Iterator<Row> iterator = firstSheet.iterator();
	         
	        while (iterator.hasNext()) {
	            Row nextRow = iterator.next();
	            Iterator<Cell> cellIterator = nextRow.cellIterator();
	            int i=0;
	            while (cellIterator.hasNext()) { 
	                Cell cell = cellIterator.next();
	                //System.out.print(cell.getStringCellValue());
	                switch (cell.getCellType()) {
	                    case Cell.CELL_TYPE_STRING:
	                    	if(i == 1){
	                    		//System.out.print(i);
	                    		vname = cell.getStringCellValue();
	                    	}else{
	                    		//System.out.print(i);
	                        	location = cell.getStringCellValue();
	                    	}
	                        //System.out.print(cell.getStringCellValue());
	                        break;
	                    case Cell.CELL_TYPE_BOOLEAN:
	                        System.out.print(cell.getBooleanCellValue());
	                        break;
	                    case Cell.CELL_TYPE_NUMERIC:
	                    	DecimalFormat df = new DecimalFormat("###.#");
	                    	vid = String.valueOf(df.format(cell.getNumericCellValue()));
	                        //System.out.print(String.valueOf(df.format(cell.getNumericCellValue())));
	                        //System.out.print(String.valueOf(cell.getNumericCellValue()).replace(".", ":").split(":")[0]);
	                        break;
	                }
	                i++;
	                //System.out.print(" - ");
	            }
	            
	            if(!vid.equals("0x0badf00d")){
	            	//addVlan&addPort
	            	System.out.println("vid = "+vid+"  vname = "+vname+"  location = "+location);
		            System.out.println();
	            	if(loc.addVlan(vid, vname, interf, "enabled").equals("Yes")){
	            		loc.addPort(vname, location);
	            	}
	            }else{System.out.println("vid = "+vid+"  vname = "+vname+"  location = "+location);}

	        }
	         
	        workbook.close();
	        inputStream.close();
        }catch(IOException e){
        	System.out.print(e);
        }
        
	    }
        
}