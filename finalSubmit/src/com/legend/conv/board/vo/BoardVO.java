package com.legend.conv.board.vo;

import java.util.Arrays;
import java.util.List;

import com.legend.conv.attach.vo.AttachVO;

public class BoardVO {
	private String boNo;
	private String name;
	private String id;
	private String boTitle;
	private Category boCate; // boCate의 데이터 타입을 Category로 변경
	private String boContent;
	private String registDate;
	private String EditDate;
	private int Hit;   //조회수
	// rnum 추가
	private int rnum;
	// attachList 추가
	private List<AttachVO> attachList;
	// delAtchNos
	private int[] delAtchNos;
	private int boLike;  //좋아요
	
	
	public BoardVO() {}
	
	public BoardVO(String boNo, String name, String id, String boTitle, Category boCate, String boContent,
			String registDate, String editDate, int hit, int rnum, List<AttachVO> attachList,
			int[] delAtchNos, int boLike) {
		super();
		this.boNo = boNo;
		this.name = name;
		this.id = id;
		this.boTitle = boTitle;
		this.boCate = boCate;
		this.boContent = boContent;
		this.registDate = registDate;
		EditDate = editDate;
		Hit = hit;
		this.rnum = rnum;
		this.attachList = attachList;
		this.delAtchNos = delAtchNos;
		this.boLike = boLike;
	}
	public String getBoNo() {
		return boNo;
	}
	public void setBoNo(String boNo) {
		this.boNo = boNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBoTitle() {
		return boTitle;
	}
	public void setBoTitle(String boTitle) {
		this.boTitle = boTitle;
	}
	public Category getBoCate() {
		return boCate;
	}
	public void setBoCate(Category boCate) {
		this.boCate = boCate;
	}
	public String getBoContent() {
		return boContent;
	}
	public void setBoContent(String boContent) {
		this.boContent = boContent;
	}
	public String getRegistDate() {
		return registDate;
	}
	public void setRegistDate(String registDate) {
		this.registDate = registDate;
	}
	public String getEditDate() {
		return EditDate;
	}
	public void setEditDate(String editDate) {
		EditDate = editDate;
	}
	public int getHit() {
		return Hit;
	}
	public void setHit(int hit) {
		Hit = hit;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public List<AttachVO> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<AttachVO> attachList) {
		this.attachList = attachList;
	}
	public int[] getDelAtchNos() {
		return delAtchNos;
	}
	public void setDelAtchNos(int[] delAtchNos) {
		this.delAtchNos = delAtchNos;
	}
	public int getBoLike() {
		return boLike;
	}
	public void setBoLike(int boLike) {
		this.boLike = boLike;
	}

	@Override
	public String toString() {
		return "BoardVO [boNo=" + boNo + ", name=" + name + ", id=" + id + ", boTitle=" + boTitle + ", boCate=" + boCate
				+ ", boContent=" + boContent + ", registDate=" + registDate + ", EditDate=" + EditDate + ", Hit=" + Hit
				+ ", rnum=" + rnum + ", attachList=" + attachList + ", delAtchNos=" + Arrays.toString(delAtchNos)
				+ ", boLike=" + boLike + "]";
	}

	
	
	


}
