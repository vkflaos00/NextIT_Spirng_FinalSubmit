package com.legend.conv.reply.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.legend.conv.reply.vo.ReplyPagingVO;
import com.legend.conv.reply.vo.ReplyVO;

@Mapper
public interface IReplyDAO {
	
	public int replyRegister(ReplyVO reply);
	
	public List<ReplyVO> getReplyListByParent(ReplyPagingVO replyPagingVO);

	public int getTotalRowCount(ReplyPagingVO replyPagingVO);
	
	public int replyDelete(ReplyVO reply);
	
	public int replyUpdate(ReplyVO reply);

	public int registerVOC();
}
