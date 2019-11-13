package com.boot.finalpro.ckedit;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class CkeditorImgUploadController {

	@PostMapping(value = "imgUpload.do")
	public void imgUpload(HttpServletRequest req,HttpServletResponse resp, @RequestParam MultipartFile upload) {
		
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		
        String fileName =  System.currentTimeMillis()+upload.getOriginalFilename();
        System.out.println("filename : " +fileName);
        
        //upload 경로설정 .. tomcat 경로
        String uploadPath = req.getServletContext().getRealPath("uploadImg");
        System.out.println("uploadPath : " + uploadPath);

        //파일 업로드 할때에는 경로와 파일 네임을 같이 올린다..
        byte[] bytes;
   try {
      bytes = upload.getBytes();
      out = new FileOutputStream(new File(uploadPath +"\\"+fileName));
      out.write(bytes);
    
        
        
        String callback = req.getParameter("CKEditorFuncNum");
        
        printWriter = resp.getWriter();
        //String fileUrl = request.getServletContext().getRealPath("upload") + "\\"+ fileName;
          String fileUrl = "uploadImg/" + fileName;
       
   //     System.out.println("fileUrl : " + fileUrl);
  
       printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
            + callback
            + ",'"
            + fileUrl
            + "','이미지를 업로드 하였습니다.'"
            + ")</script>");
     //  System.out.println("collback : " + callback );
     printWriter.flush();

    }catch(IOException e){
        e.printStackTrace();
    } finally {
 }
	}
}
