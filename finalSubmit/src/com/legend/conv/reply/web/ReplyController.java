package com.legend.conv.reply.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.member.vo.MemberVO;
import com.legend.conv.reply.service.ReplyService;
import com.legend.conv.reply.vo.ReplyPagingVO;
import com.legend.conv.reply.vo.ReplyVO;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping("/replyRegister")
	public String replyRegister(ReplyVO reply) {
		System.out.println("replyRegister reply.toString():" + reply.toString());
		
		try {
			replyService.replyRegister(reply);
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
		}
		
		return "/product/productDetailView";
	}
	
	@RequestMapping("/replyList")
	public String replyList(@ModelAttribute("replyPagingVO") ReplyPagingVO replyPagingVO) {
		
		System.out.println("ReplyController replyList reply.toString():"+replyPagingVO.toString());
		List<ReplyVO> replyList = replyService.getReplyListByParent(replyPagingVO);
		replyPagingVO.setReplyList(replyList);
		System.out.println("replyPagingVO"+replyPagingVO);
		
		if(replyPagingVO.getReplyCate().equals("BOARD")) {
			return "/board/part/reply"; 
		}else {
			return "/product/part/reply";
		}
	}
	
	@RequestMapping("/replyDelete")
	@ResponseBody
	public Map<String, Object> replyDelete(ReplyVO reply, HttpSession session) {
		System.out.println("ReplyController replyDelete reply.toString():"+ reply.toString());
		
		// 작성자가 맞는지 검증
		MemberVO member = (MemberVO) session.getAttribute("login");
		System.out.println("replyDelete member.getId():" + member.getId());
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(reply.getReplyMemId() != null && reply.getReplyMemId().contentEquals(member.getId())) {
			try {
				replyService.replyDelete(reply);
				map.put("result", true);
			} catch (BizNotEffectedException e) {
				e.printStackTrace();
				map.put("result", false);
			}
		}
		return map;
	}
	
	@RequestMapping("/replyUpdate")
	@ResponseBody
	public Map<String, Object> replyUpdate(@ModelAttribute ReplyVO reply, HttpSession session) {
		System.out.println("ReplyController replyUpdate reply.toString():" + reply.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			replyService.replyUpdate(reply);
			map.put("result", true);
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
			map.put("result", false);
		}
		return map;
	}
}
