package com.legend.conv.attach.web;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.legend.conv.attach.service.AttachService;
import com.legend.conv.attach.vo.AttachVO;

@Controller
public class AttachController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private AttachService attachService;
	
	@RequestMapping("/attach/download/{atchNo:^[0-9]+$}")
	public void attachDownload(@PathVariable int atchNo
			, HttpServletResponse resp) throws Exception {
		logger.info("AttachController attachDownload atchNo : "+ atchNo);
		
		 AttachVO attach = attachService.getAttach(atchNo);
		 String originalName = attach.getAtchOriginalName();
		 originalName = URLEncoder.encode(originalName, "utf-8");
		 System.out.println("originalName: "+ originalName);
		 String filePath = attach.getAtchPath();
		 String fileName = attach.getAtchFileName();
		 
		 File file = new File(filePath, fileName);
		 
		 if(file.isFile()) {
			 resp.setHeader("Content-type", "application/octect-stream");
			 resp.setHeader("Content-Disposition", "attachment; filename=\"" + originalName +"\"");
			 resp.setHeader("Pragma", "no-cache;");
			 resp.setHeader("Expires", "-1");
			 FileInputStream fis = new FileInputStream(file);
			 FileCopyUtils.copy(fis, resp.getOutputStream());
			 
		 }
	}

}
