package com.legend.conv.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.legend.conv.attach.service.AttachService;
import com.legend.conv.attach.vo.AttachVO;

@RestController
public class ConvImageLoader {
	
	@Autowired
	private AttachService attachService;
	
	@RequestMapping(value = "/image/{atchNo:^[0-9]+$}", method = RequestMethod.GET)
	public byte[] getImageByteArray(@PathVariable("atchNo") int atchNo) 
			throws Exception {
		
		AttachVO attach;
		FileInputStream fis = null;
		byte[] byteData = null;
		
		try {
			attach = attachService.getAttach(atchNo);
			String filePath = attach.getAtchPath();
			String fileName = attach.getAtchFileName();
		 
			fis = new FileInputStream(filePath + File.separator + fileName);
			byteData = IOUtils.toByteArray(fis);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try {fis.close();}catch(IOException e) {e.printStackTrace();}
		}
		return byteData;
	}
}
