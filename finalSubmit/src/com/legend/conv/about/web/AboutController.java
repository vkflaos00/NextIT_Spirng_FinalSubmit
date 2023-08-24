package com.legend.conv.about.web;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.legend.conv.member.vo.MemberVO;

@Controller
public class AboutController {
	
	private final Logger logger
	= LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/shop")
	public String shop() {
		return "/about/shop";
	}
	
	
		
	
}
