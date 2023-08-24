package com.legend.conv.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.legend.conv.member.vo.AgeChartVO;
import com.legend.conv.member.vo.MailAuthVO;
import com.legend.conv.member.vo.MemberSearchVO;
import com.legend.conv.member.vo.MemberVO;
import com.legend.conv.member.vo.RegionChartVO;

@Mapper
public interface IMemberDAO {

	//	회원가입 진행(INSERT)
	public int registMember (MemberVO member);
	
	// 로그인 진행(SELECT)
	public MemberVO getMember(MemberVO member);
	
	// 회원가입 아이디 중복체크(SELECT)
	public int idCheck(String id); 
	// 회원가입 이메일 중복체크(SELECT)
	public int mailCheck(String mail); 
	
	// 회원정보 가져오기

	public MailAuthVO getMailAuth(String mailAdd);
	
	public MemberVO gethp(String hp);
	
	public void insertMailAuth(@Param("mailAdd") String mailAdd, @Param("authKey") String authKey);
	
	public void updateMailAuth(@Param("mailAdd") String mailAdd, @Param("authKey") String authKey);
	
	public void completeAuth(String mailAdd);
	
	public int checkMailAuth(String mail);
	
	// 회원정보 수정(UPDATE)
	public int editMember(MemberVO member);
	
	// 회원정보 삭제(DELETE)
	public int delMember(MemberVO member);
	
	// 지역별 회원자수 뽑기
	public List<RegionChartVO> regionChartData();
	
	// 멤버 리스트 뽑기
	public List<MemberVO> getMemberList(MemberSearchVO searchVO);
	
	// 멤버 전체 수 조회
	public int getTotalRowCount(MemberSearchVO searchVO);

	public MemberVO getMember(String id);

	public MemberVO loginCheck(MemberVO member); 
	
	public List<AgeChartVO> ageChartData();
	
	// 회원삭제 사유 추가
	public int deletionReason(@Param("id") String id, @Param("deletionReason") String deletionReason);
	
	// 회원 삭제 정보 업데이트
	public int deleteMember(String id);
}
