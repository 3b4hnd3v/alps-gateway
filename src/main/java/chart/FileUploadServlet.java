package chart;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.alps.Db;
import com.alps.LPContent;

public class FileUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    //String uploadPath = "/home/ivo/ACE/media/";
    // location to store file uploaded /home/ivo/ACE/media/ is ori
    //private static final String UPLOAD_DIRECTORY = "D:/upload";
 
    // upload settings
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 1000;  // 100MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 1000; // 400MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 1200; // 500MB
 
    /**
     * Upon receiving file upload submission, parses the request to read
     * upload data and saves the file on disk.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String returnurl = "captive.jsp", fname="", exfile="";
    	String uploadPath="", ctype="", cname="", cid="", captive="", operation="", fileact="";
    	int mid  = 0;
        // checks if the request actually contains upload file
        if (!ServletFileUpload.isMultipartContent(request)) {
            // if not, we stop here
            PrintWriter writer = response.getWriter();
            writer.println("Error: Form must has enctype=multipart/form-data.");
            writer.flush();
            return;
        }
 
        // configures upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // sets memory threshold - beyond which files are stored in disk
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // sets temporary location to store files
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
 
        ServletFileUpload upload = new ServletFileUpload(factory);
         
        // sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);
         
        // sets maximum size of request (include file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);
 
        // constructs the directory path to store upload file
        // this path is relative to application's directory
       // String uploadPath = UPLOAD_DIRECTORY;
         
    
 
        try {
            // parses the request's content to extract file data
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);
 
            if (formItems != null && formItems.size() > 0) {
                // iterates over form's fields
                for (FileItem item : formItems) {
                	if (item.isFormField()) {
                		String name = item.getFieldName();
                	    String value = item.getString();
                	    if(item.getFieldName().equals("imgloc")) { uploadPath=item.getString(); }
                	    if(name.equals("operation")) operation 	= value;
                	    if(name.equals("captive")) captive = value;
                	    if(name.equals("cid")) cid 	= value;
                	    if(name.equals("cname")) cname 	= value;
                	    if(name.equals("ctype")) ctype 		= value;
                	    if(name.equals("exfile")) exfile 	= value;                	    
                	    if(name.equals("cfile")) exfile 	= value;                	    
                	    if(name.equals("fileact")) fileact 	= value;                	    

                		System.out.println(name+"=="+value);
                    }else {
                    	if(operation.equals( "Add") || operation.equals("update")){
                    		try{
	                    		File f=new File(exfile);
	                    		f.delete();
                    		}catch (Exception ex) {System.out.println("No File To Delete");}
	                    	try{
		                        File uploadDir = new File(uploadPath);
		                        System.out.println(uploadPath);
		                        if (!uploadDir.exists()) { uploadDir.mkdir(); }
		                        
		                        String fileName = new File(item.getName()).getName();
		                        System.out.println(fileName.replace(".", "%").split("%")[0]);
		                        
		                        String newFname = fileName;
		                        System.out.println(newFname);
		                        fname = newFname;
		                        String filePath = uploadPath + File.separator + newFname;
		                        fname = "assets/img/"+newFname;
		                        File storeFile = new File(filePath);
		 
		                        // saves the file on disk
		                        item.write(storeFile);
		                        //request.setAttribute("message","Upload has been done successfully!");
	                    	}catch (Exception ex) {System.out.println("There was an error: " + ex);}
                    	}else{fname=exfile;System.out.println("What Operation: " + operation);}
                    }
                	
                }
            }
        } catch (Exception ex) {System.out.println("There was an error: " + ex.getMessage());}
        
        
                
        LPContent c = new LPContent();
        
        int act = c.update(cname, fname, cid);
        
        if(act != 0){
        	response.sendRedirect(returnurl+"?msg=Media Uploaded Successfully.&type=success");
        }else{
        	response.sendRedirect(returnurl+"?msg=Media Uploaded Successfully.&type=error");
        }
    }
    
    public void addChannel(String name, String url, String picname) {
    	String icon = "smb://192.168.0.3/ebahniptv/images/CH1.jpg";
    	System.out.println(name+"=="+url+"=="+icon);
    }
}