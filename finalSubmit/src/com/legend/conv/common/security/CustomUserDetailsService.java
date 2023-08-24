package com.legend.conv.common.security;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.legend.conv.member.dao.IMemberDAO;
import com.legend.conv.member.vo.MemberVO;


public class CustomUserDetailsService implements UserDetailsService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	private IMemberDAO dao;
	
	@Autowired
	private HttpServletRequest request;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		logger.info("CustomUserDetailsService loadUserByUsername username:" + username);
		
		MemberVO member = dao.getMember(username);
		
		if(member == null) {
			return null;
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("memberVO", member);
		
		return new CustomUser(member);  
	}

}
