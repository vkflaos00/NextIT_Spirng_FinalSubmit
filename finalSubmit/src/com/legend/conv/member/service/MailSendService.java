package com.legend.conv.member.service;

import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class MailSendService {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	public String sendAuthMail(String mailAdd) {
		// 이메일 주소가 비어 있거나 null인지 검사
		if (!StringUtils.hasText(mailAdd)) {
			logger.error("Invalid email address: " + mailAdd);
			return "false";
		}
		
		String authKey = getKey(6);
		
		logger.info("authKey : " + authKey);
		
		MimeMessage mailMessage = mailSender.createMimeMessage();
		
		String mailContent = "인증번호 : " + authKey;
		
		try {
			mailMessage.setSubject("Conv 가입 확인 이메일 인증번호", "utf-8");
			mailMessage.setText(mailContent, "utf-8", "html");
			mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(mailAdd));
			
			mailSender.send(mailMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
			return "false";
		}
		
		return authKey;
	}
	
	private String getKey(int size) {
		Random random = new Random();
		String key = "";
		
		for (int i = 0; i < size; i++) {
			int ran = random.nextInt(10);
			key += ran;
		}
		
		return key;
	}
}
