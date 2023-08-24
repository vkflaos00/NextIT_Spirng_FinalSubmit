package com.legend.conv.gift.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.legend.conv.gift.service.GiftService;
import com.legend.conv.gift.service.KakaoPayService;
import com.legend.conv.gift.vo.CartVO;
import com.legend.conv.gift.vo.GiftVO;
import com.legend.conv.gift.vo.ItemVO;
import com.legend.conv.gift.vo.SearchVO;
import com.legend.conv.member.vo.MemberVO;

@Controller
public class KaKaoPayController {

	
	@Autowired
	private KakaoPayService kakaoPayService;

	@Autowired
	GiftService giftService;

	@GetMapping("/kakaoPay")
	public void kakaoPayGet() {

	}

	@RequestMapping("/kakaoPay")
	@ResponseBody
	public String kakaoPay(@RequestBody List<ItemVO> selectedItems, Model model) {
		System.out.println("selectedItems" + selectedItems);

		String redirectUrl = kakaoPayService.kakaoPayReady(selectedItems);
		return redirectUrl;

	}

	@GetMapping("/gift/kakaoPaySuccess")
	public void kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model, HttpSession session,
			SearchVO searchVO) {
		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = login.getId();
		searchVO.setId(id);

		List<GiftVO> cartList = null;
		try {
			cartList = giftService.getCartList(searchVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("cartList", cartList);
		model.addAttribute("info", kakaoPayService.kakaoPayInfo(pg_token));
	}
}
