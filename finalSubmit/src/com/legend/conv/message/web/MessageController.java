package com.legend.conv.message.web;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping("/Message")
	public String Message(@RequestParam(required = false) String message) {
		System.out.println(message);
	return "login/forgotPassword";	
	}

	
}
