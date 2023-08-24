package com.legend.conv.reply.vo;

public class ReplyVO {
	
	private int replyNo;                       /* 댓글번호 */
	private String replyCate;              /* 분류(BOARD, PDS, FREE, ...) */
	private String replyParentno;              /* 부모 번호 */
	private String replyMemId;                 /* 작성자ID */
	private String replyContent;               /* 댓글 내용 */
	private String regDate;               /* 댓글 등록일자 */
	
	public ReplyVO() {
	}

	public ReplyVO(int replyNo, String replyCate, String replyParentno, String replyMemId, String replyContent,
			String regDate) {
		super();
		this.replyNo = replyNo;
		this.replyCate = replyCate;
		this.replyParentno = replyParentno;
		this.replyMemId = replyMemId;
		this.replyContent = replyContent;
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "ReplyVO [replyNo=" + replyNo + ", replyCate=" + replyCate + ", replyParentno=" + replyParentno
				+ ", replyMemId=" + replyMemId + ", replyContent=" + replyContent + ", regDate=" + regDate + "]";
	}

	public int getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
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

	public String getReplyMemId() {
		return replyMemId;
	}

	public void setReplyMemId(String replyMemId) {
		this.replyMemId = replyMemId;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	
}
