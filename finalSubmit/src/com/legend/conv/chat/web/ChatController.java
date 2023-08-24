package com.legend.conv.chat.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.legend.conv.chat.service.ChatService;
import com.legend.conv.chat.vo.ChatUserVO;
import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.product.service.ProductService;
import com.legend.conv.product.vo.ProductVO;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ChatService chatService;
	
	@RequestMapping(value="/chat", method = RequestMethod.GET)
	public String startChat(String itemNo, ChatUserVO chatUserVO, HttpSession session, Model model) {
		
		try {
			ProductVO product = productService.getProduct(itemNo);
			model.addAttribute("product", product);
			
			chatService.createChatRoomAndAddUser(itemNo, chatUserVO, session);
			
			logger.info(chatUserVO.getRoomId());
			model.addAttribute("roomId", chatUserVO.getRoomId());
			
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
		}
		
		// 웹소켓 채팅 화면으로 이동
		return "/chat/chat";
	}
	
	@RequestMapping(value = "/chatClose", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> chatClose(@RequestParam String id , @RequestParam String roomId) {
	    logger.info("id AND roomId : " + id + ","+ roomId);
		Map<String, Object> resultMap = new HashMap<>();
	    
	    try {
	        // 채팅방 종료 로직 수행
	        chatService.userExitChatRoom(roomId, id);
	        
	        // 성공 시
	        resultMap.put("success", true);
	        resultMap.put("message", "채팅방이 종료되었습니다.");
	    } catch (Exception e) {
	        // 실패 시
	        resultMap.put("success", false);
	        resultMap.put("message", "채팅방 종료 중 오류가 발생했습니다.");
	    }
	    
	    return resultMap;
	}

}
