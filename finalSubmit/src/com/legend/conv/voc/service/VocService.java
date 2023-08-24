package com.legend.conv.voc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.legend.conv.attach.dao.IAttachDAO;
import com.legend.conv.attach.vo.AttachVO;
import com.legend.conv.common.vo.PagingVO;
import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.exception.BizNotFoundException;
import com.legend.conv.member.vo.MemberVO;
import com.legend.conv.voc.dao.IVocDAO;
import com.legend.conv.voc.vo.VocSearchVO;
import com.legend.conv.voc.vo.VocVO;

@Service
public class VocService {

	@Autowired
	IVocDAO dao;
	
	@Autowired
	IAttachDAO attachDao;

	public void registerVOC(VocVO vo) throws BizNotEffectedException {
		// System.out.println("voc service 작동중");
		String no = dao.getKey();
		
		List<AttachVO> attachList = vo.getVocAttach();
		if (attachList != null && attachList.size() > 0) {
			
			for (AttachVO attach : attachList) {
				attach.setAtchParentNo(no);
				attach.setAtchAuthor(vo.getVocMail());
				System.out.println("attach 서비스 계층 registerVOC 작동중 :"+attachList.toString());
				System.out.println("attach 서비스 계층 attach.sdf:" + attach.toString());
				attachDao.insertAttach(attach);
			}
		}
		
		vo.setVocNo(no);
		System.out.println(vo.toString());
		int cnt = dao.registerVOC(vo);
		
		if (cnt != 1) {
			throw new BizNotEffectedException();
		}

		
		
	}

	public HashMap<String, Object> selectVOC(String memMail) {
		// Check if memMail is null (user not logged in)
		if (memMail == null) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("error", "로그인이 필요합니다.");
			return map;
		}

		PagingVO pagingVO = new PagingVO();
		int totalRowCount = dao.getTotalRowCount(memMail);
		pagingVO.setTotalRowCount(totalRowCount);
		pagingVO.setRowSizePerPage(3);
		pagingVO.pageSetting();

		HashMap<String, Object> map = new HashMap<>();
		try {
			ArrayList<VocVO> vocList = dao.selectVOC(memMail);
			map.put("vocList", vocList);
			map.put("pagingVO", pagingVO);

			boolean hasNullVocMail = false;
			if (vocList == null) {
				hasNullVocMail = true;
			}

			if (hasNullVocMail) {
				map.put("error", "로그인이 필요합니다");
			}

			return map;
		} catch (NullPointerException e) {
			// 처리할 내용이 있다면 추가
			map.put("error2", "other error");
			return map;
		}
	}
	
	// vocList 뽑기
	public List<VocVO> getVocList(VocSearchVO vocSearchVO) throws BizNotFoundException {
		int totalProcessCount = dao.getTotalProcessCount(vocSearchVO);
		vocSearchVO.setTotalRowCount(totalProcessCount);
		vocSearchVO.pageSetting();
		// System.out.println("vocSearchVO.toString() : "+vocSearchVO.toString());

		List<VocVO> vocList = dao.getVocList(vocSearchVO);

		if (vocList == null) {
			throw new BizNotFoundException();
		}

		return vocList;
	}
	
	public AttachVO takePicture(String vocNo) {
		AttachVO vo = dao.takePicture(vocNo);
		return vo;
	}


}