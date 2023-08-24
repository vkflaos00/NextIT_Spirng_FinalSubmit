package com.legend.conv.voc.vo;

import java.util.HashMap;
import java.util.List;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import com.legend.conv.attach.vo.AttachVO;
import com.legend.conv.common.vo.PagingVO;

public class VocVO {
	private String vocNo;
	
	@Size(min = 5, max = 200, message ="제목은 5자 이상 200자 이내로 작성해주세요" 
			, groups = {VocPop.class})
	private String vocTitle;
	
	@NotEmpty(message = "로그인 되어있지 않습니다. 로그인 해주세요")
	private String vocMail;
	
	@NotEmpty(message = "글 분류 코드를 선택해주세요")
	private String vocCategory;
	
	@Size(min = 1, max = 5000, message = "내용은 5000글자 이내로 작성해주세요", groups = VocPop.class)
	private String vocContent;
	
	private String vocRegDate;
	
	private int process;
	
	private String rnum;
	
	private String memId;  // VOC 리스트 확인시 ID까지 같이 확인을 위해 넣기
	
	private List<AttachVO> vocAttach;
	
	private MultipartFile mul;
	
	private List<MultipartFile> fileList;
	
	private String attachNo;


	

	@Override
	public String toString() {
		return "VocVO [vocNo=" + vocNo + ", vocTitle=" + vocTitle + ", vocMail=" + vocMail + ", vocCategory="
				+ vocCategory + ", vocContent=" + vocContent + ", vocRegDate=" + vocRegDate + ", process=" + process
				+ ", rnum=" + rnum + ", memId=" + memId + ", vocAttach=" + vocAttach + ", mul=" + mul + ", fileList="
				+ fileList + ", attachNo=" + attachNo + "]";
	}

	public MultipartFile getMul() {
		return mul;
	}

	public void setMul(MultipartFile mul) {
		this.mul = mul;
	}

	public List<MultipartFile> getFileList() {
		return fileList;
	}

	public void setFileList(List<MultipartFile> fileList) {
		this.fileList = fileList;
	}

	public String getAttachNo() {
		return attachNo;
	}

	public void setAttachNo(String attachNo) {
		this.attachNo = attachNo;
	}

	public List<AttachVO> getVocAttach() {
		return vocAttach;
	}

	public void setVocAttach(List<AttachVO> vocAttach) {
		this.vocAttach = vocAttach;
	}

	public int getProcess() {
		return process;
	}

	public void setProcess(int process) {
		this.process = process;
	}

	public String getVocNo() {
		return vocNo;
	}

	public void setVocNo(String vocNo) {
		this.vocNo = vocNo;
	}

	public String getVocTitle() {
		return vocTitle;
	}

	public void setVocTitle(String vocTitle) {
		this.vocTitle = vocTitle;
	}

	public String getVocMail() {
		return vocMail;
	}

	public void setVocMail(String vocMail) {
		this.vocMail = vocMail;
	}

	public String getVocCategory() {
		return vocCategory;
	}

	public void setVocCategory(String vocCategory) {
		this.vocCategory = vocCategory;
	}

	public String getVocContent() {
		return vocContent;
	}

	public void setVocContent(String vocContent) {
		this.vocContent = vocContent;
	}

	public String getVocRegDate() {
		return vocRegDate;
	}

	public void setVocRegDate(String vocRegDate) {
		this.vocRegDate = vocRegDate;
	}

	public String getRnum() {
		return rnum;
	}

	public void setRnum(String rnum) {
		this.rnum = rnum;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	
	

}
