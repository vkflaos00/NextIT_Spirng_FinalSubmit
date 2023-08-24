package com.legend.conv.notice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.legend.conv.attach.dao.IAttachDAO;
import com.legend.conv.attach.vo.AttachVO;
import com.legend.conv.member.vo.MemberVO;
import com.legend.conv.notice.dao.INoticeDAO;
import com.legend.conv.notice.vo.HitVO;
import com.legend.conv.notice.vo.NoticeVO;
import com.legend.conv.notice.vo.SearchVO;

@Service
public class NoticeService {

	@Autowired
	INoticeDAO dao;

	@Autowired
	IAttachDAO attachDao;

	// 공지 목록 조회
	public List<NoticeVO> getNoticeList(SearchVO searchVO) throws Exception {

		int totalRowCount = dao.getTotalRowCount(searchVO);

		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		
		List<NoticeVO> noticeList = dao.getNoticeList(searchVO);

		if (noticeList == null) {
			throw new Exception();
		}
		return noticeList;
	}
	
	// 글등록
	public void writeNotice(NoticeVO notice) throws Exception {

		int noticeNo = dao.getNoticeKey();
		System.out.println("writeNotice noticeNo: " + noticeNo);
		notice.setNoticeNo(noticeNo);

		int resultCnt = dao.writeNotice(notice);

		if (resultCnt != 1) {
			throw new Exception();
		}

		List<AttachVO> attachList = notice.getAttachList();
		if (attachList != null && attachList.size() > 0) {
			for (AttachVO attach : attachList) {
				String parentNo = String.valueOf(noticeNo);
				attach.setAtchParentNo(parentNo);
				attach.setAtchAuthor("ADMIN");

				attachDao.insertAttach(attach);
			}
		}
	}

	// 게시글 상세조회
	public NoticeVO getNotice(int noticeNo) throws Exception {
		
		NoticeVO notice = dao.getNotice(noticeNo);
		if (notice == null) {
			throw new Exception("존재하지 않는 글입니다.");
		}
		
		System.out.println("dao.getNotice : "+ notice);
		String boNo = String.valueOf(noticeNo); 
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boNo", boNo);
		map.put("atchCategory", "NOTICE");

		Integer atchNo = attachDao.getAttachNo(map); 
		notice.setAtchNo(atchNo);
		System.out.println("dao.atchNo : "+ atchNo);
	
		List<AttachVO> attachList = attachDao.getAttachList(boNo, "NOTICE");
		
		notice.setAttachList(attachList);
		return notice;
	}

	// 게시글 수정
	public void editNotice(NoticeVO notice) throws Exception {
		String noticeContent = notice.getNoticeContent();
		NoticeVO vo = dao.getNotice(notice.getNoticeNo());
		vo.setNoticeContent(noticeContent);
		System.out.println("editNoticeVO " + vo );

		int resultCnt = dao.editNotice(notice);
		if (resultCnt != 1) {
			throw new Exception();
		}

		// 기존 파일정보 삭제
		int[] delAtchNos = notice.getDelAtchNos();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("delAtchNos", delAtchNos);
		if (delAtchNos != null && delAtchNos.length > 0) {
			attachDao.deleteAttaches(map);
		}
		// 신규 파일 정보 추가
		List<AttachVO> attachList = notice.getAttachList();
		if (attachList != null && attachList.size() > 0) {
			for (AttachVO attach : attachList) {

				String strParentNo = String.valueOf(notice.getNoticeNo());
				attach.setAtchParentNo(strParentNo);
				attach.setAtchAuthor("ADMIN");

				attachDao.insertAttach(attach);
			}
		}

	}

	// 게시글 삭제
	public void delNotice(int noticeNo) {
		dao.delNotice(noticeNo);
	}

	// 추천수
	public void hitNotice(int noticeNo) {
		dao.hitNotice(noticeNo);
	}

	public void hitCancelNotice(int noticeNo) {
		dao.hitCancelNotice(noticeNo);
	}

	public Boolean hitCheck(String id, int noticeNo) {
		System.out.println("서비스 id: " + id);
		HitVO hitCheck = dao.checkHit(id, noticeNo);
		
		if(hitCheck == null) {
			return false;
		}
		String hitYn = hitCheck.getHitYn();
		if (hitYn.equals("Y")) {
			return true;
		}
		return false;
	}

	public Boolean hitEdit(String id, int noticeNo) {
		System.out.println("서비스 id: " + id);
		HitVO hitCheck = dao.checkHit(id, noticeNo);

		if (hitCheck == null) {
			dao.writeHit(id, noticeNo);
			return true;
		} else {
			String hitYn = hitCheck.getHitYn();
			if (hitYn.equals("N")) {
				dao.editHit(id, noticeNo);
				return true;
			}
			dao.editHit(id, noticeNo);
			return false;
		}
	}

	public void noticeCount(int noticeNo) {
		dao.countNotice(noticeNo);
	}


}
