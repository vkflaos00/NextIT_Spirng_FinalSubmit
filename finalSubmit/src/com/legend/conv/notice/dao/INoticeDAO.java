package com.legend.conv.notice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.legend.conv.member.vo.MemberVO;
import com.legend.conv.notice.vo.HitVO;
import com.legend.conv.notice.vo.NoticeVO;
import com.legend.conv.notice.vo.SearchVO;

@Mapper
public interface INoticeDAO {
	
	//공지 목록 조회
	public List<NoticeVO> getNoticeList(SearchVO searchVO);
	
	//페이지 카운트
	public int getTotalRowCount(SearchVO searchVO);
	
	//게시글등록
	public int writeNotice(NoticeVO notice);
	
	int getNoticeKey();
	
	//게시글 상세내용
	public NoticeVO getNotice(int noticeNo);
	
	//게시글 수정
	public int editNotice(NoticeVO notice);
	
	//게시글 삭제
	public int delNotice(int noticeNo);
	
	public int countNotice(int noticeNo);
	
	//추천 업로드
	public int hitNotice(int noticeNo);

	public int hitCancelNotice(int noticeNo);

	public int writeHit(@Param("id")String id, @Param("noticeNo")int noticeNo);

	public int editHit(@Param("id")String id, @Param("noticeNo")int noticeNo);

	public HitVO checkHit(@Param("id")String id, @Param("noticeNo")int noticeNo);

	public void hitCheckNotice(String hitYn);

}
