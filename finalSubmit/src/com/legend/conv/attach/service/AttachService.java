package com.legend.conv.attach.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.legend.conv.attach.dao.IAttachDAO;
import com.legend.conv.attach.vo.AttachVO;

@Service
public class AttachService {
	
	@Autowired
	private IAttachDAO dao;
	
	public AttachVO getAttach(int atchNo) throws Exception {
		
		AttachVO attach = dao.getAttach(atchNo);
		if(attach == null) {
			throw new Exception();
		}
		return attach;
	}
	
}
