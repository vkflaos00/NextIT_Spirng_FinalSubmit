package com.legend.conv.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.legend.conv.attach.dao.IAttachDAO;
import com.legend.conv.attach.vo.AttachVO;
import com.legend.conv.common.util.ConvSMSUtils;
import com.legend.conv.exception.BizDuplicateKeyException;
import com.legend.conv.exception.BizMailAuthException;
import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.exception.BizNotFoundException;
import com.legend.conv.member.dao.IMemberDAO;
import com.legend.conv.member.vo.AgeChartVO;
import com.legend.conv.member.vo.MailAuthVO;
import com.legend.conv.member.vo.MemberSearchVO;
import com.legend.conv.member.vo.MemberVO;
import com.legend.conv.member.vo.RegionChartVO;

import oracle.net.aso.m;

@Service
public class MemberService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	IMemberDAO dao;

	@Autowired
	IAttachDAO atchdao;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	// 회원가입 처리
	public void registerMember(MemberVO member)
			throws BizDuplicateKeyException, BizNotEffectedException, BizMailAuthException {
		MemberVO vo = dao.getMember(member.getId());
		if ( vo != null) {
			throw new BizDuplicateKeyException();
		}
		
		MemberVO mail = dao.getMember(member.getMail());
		if ( mail !=null) {
			throw new BizDuplicateKeyException();
		}
		String encodePw = passwordEncoder.encode(member.getPw());
		member.setPw(encodePw);

		dao.registMember(member);

		if (member.getId() != null && !member.getId().equals("")) {
			int rowCount = dao.checkMailAuth(member.getMail());

			if (rowCount != 1) {
				throw new BizMailAuthException();
			}
		}

		List<AttachVO> attachList = member.getAttachList();

		if (attachList != null && attachList.size() > 0) {
			for (AttachVO attach : attachList) {
				attach.setAtchParentNo(member.getId());
				attach.setAtchAuthor(member.getId());
				atchdao.insertAttach(attach);
			}
		}
	}

	// 로그인
	MemberVO vo = null;

	public MemberVO getMember(MemberVO member) throws Exception {

		MemberVO result = dao.getMember(member);
		System.out.println("Service:" + result);

		if (result == null) {
			throw new Exception("아이디 혹은 비밀번호가 틀립니다.");
		} else {
			return result;

		}

	}

	public boolean loginCheck(MemberVO member, HttpServletRequest request, HttpServletResponse response) {
		
		// 1. 아이디로 조회해서 값을 가져온다.
		// 2. 가져온데이터에 비번을 사용자가 입력한 비번이랑 매칭시킨다.
		
		System.out.println(member.getId());
		MemberVO mem = dao.loginCheck(member); 
		System.out.println(member.getPw()+" : "+ mem.getPw());
		
		boolean match = passwordEncoder.matches(member.getPw(), mem.getPw());
		System.out.println("match" + match);
		return match;
	}
	// 회원가입 아이디 중복 체크

	public boolean idCheck(String id) {

		int cnt = dao.idCheck(id);

		if (cnt == 0) {
			return true;
		}

		return false;
	}
	// 회원가입 메일 중복 체크

	public boolean mailCheck(String mail) {

		int cnt = dao.mailCheck(mail);

		if (cnt == 0) {
			return true;
		}

		return false;
	}
	// 메일 주소
	public void registerMailAuth(String mailAdd, String authKey) {
		MailAuthVO mailAuth = dao.getMailAuth(mailAdd);
		if (mailAuth == null) {
			dao.insertMailAuth(mailAdd, authKey);
		} else {
			dao.updateMailAuth(mailAdd, authKey);
		}

	}

	public boolean authKeyCompare(MailAuthVO mailAuthVO) {

		MailAuthVO vo = dao.getMailAuth(mailAuthVO.getMailAdd());

		if (vo == null) {
			return false;

		} else {
			if (vo.getAuthKey().equals(mailAuthVO.getAuthKey())) {
				dao.completeAuth(mailAuthVO.getMailAdd());
				return true;
			} else {
				return false;
			}
		}

	}

	public MemberVO getMember(String id) throws Exception {

		MemberVO member = dao.getMember(id);

		if (member == null) {
			throw new Exception();
		}

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("id", id);
		map.put("atchCategory", "PROFILEPHOTO");

		Integer atchNo = atchdao.getAttachNo(map);

		member.setAtchNo(atchNo);

		return member;
	}

	// 회원수정
	public void editMember(MemberVO member) {
		dao.editMember(member);
	}

	// 회원삭제
	public void delMember(MemberVO member) {
		dao.delMember(member);
	}

	// 지역별 이용자수 뽑기

	public List<AgeChartVO> ageChartData() {
		return dao.ageChartData();
	}

	public List<RegionChartVO> regionChartData() {
		return dao.regionChartData();

	}

	// memberList 뽑기
	public List<MemberVO> getMemberList(MemberSearchVO searchVO) throws BizNotFoundException {
		int totalRowCount = dao.getTotalRowCount(searchVO);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		System.out.println("searchVO.toString() : " + searchVO.toString());

		List<MemberVO> memberList = dao.getMemberList(searchVO);

		if (memberList == null) {
			throw new BizNotFoundException();
		}

		return memberList;
	}

	// 비밀번호 재설정을 위한 문자 인증 코드 전송
	public String sendRandomMessage(String tel) {
		ConvSMSUtils message = new ConvSMSUtils();
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}
		System.out.println("회원가입 문자 인증 => " + numStr);

		message.send_msg(tel, numStr);

		return numStr;
	}

	// 새로운 비밀번호 설정
	public void resetPassword(String tel, String newPassword) throws Exception {
		MemberVO member = dao.gethp(tel);
		if (member == null) {
			throw new Exception("가입된 전화번호가 아닙니다.");
		}

		// 비밀번호를 새로운 비밀번호로 변경하고 저장
		String encodePw = passwordEncoder.encode(newPassword);
		logger.info("새로운 비밀번호로 변경 후: " + encodePw);
		member.setPw(encodePw);
		dao.editMember(member);
	}

	// 가입된 전화번호 확인
	public boolean isRegisteredTel(String tel) {
		try {
			MemberVO member = dao.gethp(tel);
			return member != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@Transactional
	public void deleteUsersWithReason(List<String> userIDs, String deletionReason) {
	    logger.info("userIDs :" + userIDs);
	    
	    for (String userIDStr : userIDs) {
	        try {
	            
	            // 회원 삭제 정보 업데이트
	            int rowsUpdated = dao.deleteMember(userIDStr);
	            if (rowsUpdated > 0) {
	                // 회원 삭제 사유 추가
	                dao.deletionReason(userIDStr, deletionReason);
	            }
	        } catch (NumberFormatException e) {
	            logger.error("Invalid userID: " + userIDStr);
	        }
	    }
	}

}
