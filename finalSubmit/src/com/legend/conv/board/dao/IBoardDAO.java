package com.legend.conv.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.legend.conv.board.vo.BoardVO;
import com.legend.conv.board.vo.HitVO;
import com.legend.conv.common.vo.SearchVO;

@Mapper
public interface IBoardDAO {

	//게시글 목록 조회(SELECT)
	public List<BoardVO> getBoardList(SearchVO searchVO);

	//게시글 등록(INSERT)
	public int writeBoard(BoardVO board);

	//게시글 조회(SELECT)
	public BoardVO getBoard(String boNo);
	
	//게시글 조회수 증가(UPDATE)
	public int hitCnt(String boNo);
	
	//게시글 수정(UPDATE)
	public int modBoard(BoardVO board);
	
	//게시글 삭제(DELETE)
	public int delBoard(BoardVO board);
	
	//검색
	public int getTotalRowCount(SearchVO searchVO);
	
	//관리자 체크
	public int checkAdmin(BoardVO board);
	
	String getFreeBoardKey();
	
	//추천
	public int hitBoard(String boNo);

	public int hitCancelBoard(String boNo);

	public int writeHit(@Param("id")String id, @Param("boNo")String boNo);

	public int editHit(String id);

	public HitVO checkHit(@Param("id")String id, @Param("boNo")String boNo);

	public void hitCheckBoard(String hitYn);
	
	public List<BoardVO> likeBoardList(BoardVO boardVO);
}
