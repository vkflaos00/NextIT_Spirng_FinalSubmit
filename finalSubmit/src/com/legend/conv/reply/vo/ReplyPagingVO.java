package com.legend.conv.reply.vo;

import java.util.List;

import com.legend.conv.common.vo.PagingVO;

public class ReplyPagingVO extends PagingVO{
	
	private String replyCate;
	private String replyParentno;
	private List<ReplyVO> replyList;
	
	public ReplyPagingVO() {
	}

	public ReplyPagingVO(String replyCate, String replyParentno, List<ReplyVO> replyList) {
		super();
		this.replyCate = replyCate;
		this.replyParentno = replyParentno;
		this.replyList = replyList;
	}

	@Override
	public String toString() {
		return "ReplyPagingVO [replyCate=" + replyCate + ", replyParentno=" + replyParentno + ", replyList=" + replyList
				+ "]" + super.toString();
	}

	public String getReplyCate() {
		return replyCate;
	}

	public void setReplyCate(String replyCate) {
		this.replyCate = replyCate;
	}

	public String getReplyParentno() {
		return replyParentno;
	}

	public void setReplyParentno(String replyParentno) {
		this.replyParentno = replyParentno;
	}

	public List<ReplyVO> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<ReplyVO> replyList) {
		this.replyList = replyList;
	}
	
}
