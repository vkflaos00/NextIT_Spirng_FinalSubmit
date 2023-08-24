package com.legend.conv.notice.vo;

import java.util.Arrays;
import java.util.List;

import com.legend.conv.attach.vo.AttachVO;

public class NoticeVO {
	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private String noticeAuthor;
	private String noticeDate;
	private int noticeHit;
	private List<AttachVO> attachList;
	private Integer atchNo;
	private int[] delAtchNos;
	private int noticeCount;
	private String noticeCategory;
	
	public NoticeVO() {}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getNoticeAuthor() {
		return noticeAuthor;
	}

	public void setNoticeAuthor(String noticeAuthor) {
		this.noticeAuthor = noticeAuthor;
	}

	public String getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}

	public int getNoticeHit() {
		return noticeHit;
	}

	public void setNoticeHit(int noticeHit) {
		this.noticeHit = noticeHit;
	}

	public List<AttachVO> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<AttachVO> attachList) {
		this.attachList = attachList;
	}

	public int getAtchNo() {
		return atchNo;
	}

	public void setAtchNo(Integer atchNo) {
		this.atchNo = atchNo;
	}

	public int[] getDelAtchNos() {
		return delAtchNos;
	}

	public void setDelAtchNos(int[] delAtchNos) {
		this.delAtchNos = delAtchNos;
	}

	public int getNoticeCount() {
		return noticeCount;
	}

	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
	}

	public String getNoticeCategory() {
		return noticeCategory;
	}

	public void setNoticeCategory(String noticeCategory) {
		this.noticeCategory = noticeCategory;
	}

	public NoticeVO(int noticeNo, String noticeTitle, String noticeContent, String noticeAuthor, String noticeDate,
			int noticeHit, List<AttachVO> attachList, Integer atchNo, int[] delAtchNos, int noticeCount,
			String noticeCategory) {
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeAuthor = noticeAuthor;
		this.noticeDate = noticeDate;
		this.noticeHit = noticeHit;
		this.attachList = attachList;
		this.atchNo = atchNo;
		this.delAtchNos = delAtchNos;
		this.noticeCount = noticeCount;
		this.noticeCategory = noticeCategory;
	}

	@Override
	public String toString() {
		return "NoticeVO [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", noticeAuthor=" + noticeAuthor + ", noticeDate=" + noticeDate + ", noticeHit=" + noticeHit
				+ ", attachList=" + attachList + ", atchNo=" + atchNo + ", delAtchNos=" + Arrays.toString(delAtchNos)
				+ ", noticeCount=" + noticeCount + ", noticeCategory=" + noticeCategory + "]";
	}


	
}
