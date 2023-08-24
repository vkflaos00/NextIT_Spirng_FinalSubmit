package com.legend.conv.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.legend.conv.attach.dao.IAttachDAO;
import com.legend.conv.attach.vo.AttachVO;
import com.legend.conv.board.dao.IBoardDAO;
import com.legend.conv.board.vo.BoardVO;
import com.legend.conv.board.vo.HitVO;
import com.legend.conv.common.vo.SearchVO;

@Service
public class BoardService {
	@Autowired
	IBoardDAO dao;

	@Autowired
	IAttachDAO attachDao;

	// 게시글 목록 조회
	public List<BoardVO> getBoardList(SearchVO searchVO) throws Exception {

		int totalRowCount = dao.getTotalRowCount(searchVO);

		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		System.out.println("searchVO.toString() " + searchVO.toString());

		// searchVO와 함께 boardVO를 Map으로 묶어서 전달
		BoardVO boardVO = new BoardVO();
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("searchVO", searchVO);
		paramMap.put("boardVO", boardVO);

		List<BoardVO> BoardList = dao.getBoardList(searchVO);

		if (BoardList == null) {
			throw new Exception();
		}

		return BoardList;
	}

	// 게시글 등록
	public void writeBoard(BoardVO board) throws Exception {
		// TODO Auto-generated method stub

		String boNo = dao.getFreeBoardKey();
		System.out.println("writeBoard : " + boNo);
		board.setBoNo(boNo);

		int resultCnt = dao.writeBoard(board);

		if (resultCnt != 1) {
			throw new Exception();
		}

		List<AttachVO> attachList = board.getAttachList();
		if (attachList != null && attachList.size() > 0) {
			for (AttachVO attach : attachList) {
				attach.setAtchParentNo(boNo);
				attach.setAtchAuthor(board.getId());

				System.out.println("getId"+ board.getId());
				attachDao.insertAttach(attach);
				System.out.println("attachList : " + attachList);
			}
		}
	}

	// 게시글 조회
	public BoardVO getBoard(String boNo) throws Exception {
		
		System.out.println("boNo:" + boNo);
		
		BoardVO board = dao.getBoard(boNo);
		if (board == null) {
			throw new Exception("존재하지 않는 게시글입니다.");
		}

		//Map<String, Object> map = new HashMap<String, Object>();
		//int atchNo = attachDao.getAttachNo(map);
		/*
		 * if(atchNo == null) { return board; }
		 */
		//board.setAtchNo(atchNo);
		List<AttachVO> attachList = attachDao.getAttachList(boNo, "BOARD");
		board.setAttachList(attachList);

		//System.out.println("atchNo : " + atchNo);
		return board;
	}

	// 게시글 조회수 증가
	public int hitCnt(String boNo) {
		return dao.hitCnt(boNo);
	}

	// 게시글 수정
	public void modBoard(BoardVO board) throws Exception {
		
		BoardVO vo = dao.getBoard(board.getBoNo());

		System.out.println("board : " + board);
		if (vo == null) {
			throw new Exception();
		}
		int resultCnt = dao.modBoard(board);
		if (resultCnt != 1) {
			throw new Exception();
		}

		System.out.println("board.getId()" + board.getId());
		// 기존 파일정보 삭제
		int[] delAtchNos = board.getDelAtchNos();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("delAtchNos", delAtchNos);
		if (delAtchNos != null && delAtchNos.length > 0) {
			attachDao.deleteAttaches(map);
		}

		// 신규 파일 정보 추가
		List<AttachVO> attachList = board.getAttachList();
		if (attachList != null && attachList.size() > 0) {
			for (AttachVO attach : attachList) {
				attach.setAtchParentNo(board.getBoNo());
				attach.setAtchAuthor(board.getId());
				attachDao.insertAttach(attach);
			}
		}

	}

	// 게시글 삭제
	public void delBoard(BoardVO board) throws Exception {
		BoardVO vo = dao.getBoard(board.getBoNo());
		if (vo == null) {
			throw new Exception();
		}

		int resultCnt = dao.delBoard(board);
		if (resultCnt != 1) {
			throw new Exception();
		}
	}

	// 추천
	public void hitBoard(String boNo) {
		dao.hitBoard(boNo);
	}

	public void hitCancelBoard(String boNo) {
		dao.hitCancelBoard(boNo);
	}

	public Boolean hitCheck(String id, String boNo) {
		System.out.println("서비스 id: " + id);
		HitVO hitCheck = dao.checkHit(id, boNo);

		if (hitCheck == null) {
			return false;
		}
		String hitYn = hitCheck.getHitYn();
		if (hitYn.equals("Y")) {
			return true;
		}
		return false;
	}

	public Boolean hitEdit(String id, String boNo) {
		System.out.println("서비스 id: " + id);
		HitVO hitCheck = dao.checkHit(id, boNo);

		if (hitCheck == null) {
			dao.writeHit(id, boNo);
			return true;
		} else {
			String hitYn = hitCheck.getHitYn();
			if (hitYn.equals("N")) {
				dao.editHit(id);
				return true;
			}
			dao.editHit(id);
			return false;
		}
	}

	public List<BoardVO> likeBoardList(BoardVO boardVO) {
		return dao.likeBoardList(boardVO);
	}

}
