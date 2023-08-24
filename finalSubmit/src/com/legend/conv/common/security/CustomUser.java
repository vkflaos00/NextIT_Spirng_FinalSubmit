package com.legend.conv.common.security;

import java.util.Arrays;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.legend.conv.member.vo.MemberVO;


public class CustomUser extends User {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public CustomUser(MemberVO member) {
		super(member.getId()
				, member.getPw()
				, Arrays.asList(new SimpleGrantedAuthority("ROLE_" + member.getRole())));
		
		logger.info(Arrays.asList(new SimpleGrantedAuthority("ROLE_" + member.getRole())).toString());
	}
}
