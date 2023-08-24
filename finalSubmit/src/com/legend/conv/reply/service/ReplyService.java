package com.legend.conv.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.reply.dao.IReplyDAO;
import com.legend.conv.reply.vo.ReplyPagingVO;
import com.legend.conv.reply.vo.ReplyVO;

@Service
public class ReplyService {
	
	@Autowired
	private IReplyDAO dao;
	
	public void replyRegister(ReplyVO reply) throws BizNotEffectedException {
		int cnt = dao.replyRegister(reply);
		System.out.println("replyService replyRegister cnt:" + cnt);
		
		if(cnt != 1) {
			throw new BizNotEffectedException();
		}
	}
	
	public List<ReplyVO> getReplyListByParent(ReplyPagingVO replyPagingVO) {
		
		
		int totalRowCount = dao.getTotalRowCount(replyPagingVO);
		System.out.println("ReplyService totalRowCount:" + totalRowCount);
		replyPagingVO.setTotalRowCount(totalRowCount);
		replyPagingVO.pageSetting();
		
		List<ReplyVO> replyList = dao.getReplyListByParent(replyPagingVO);
		System.out.println("dao replyList" + replyList.toString());
		return replyList;
	}
	
	public void replyDelete(ReplyVO reply) throws BizNotEffectedException {
		int cnt = dao.replyDelete(reply);
		if(cnt != 1) {
			throw new BizNotEffectedException();
		}
	}
	
	public void replyUpdate(ReplyVO reply) throws BizNotEffectedException {
		int cnt = dao.replyUpdate(reply);
		if(cnt != 1) {
			throw new BizNotEffectedException();
		}
	}
}
