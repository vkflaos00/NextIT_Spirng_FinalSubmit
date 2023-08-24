package com.legend.conv.gift.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.legend.conv.gift.service.GiftService;
import com.legend.conv.gift.vo.CartVO;
import com.legend.conv.gift.vo.GiftVO;
import com.legend.conv.gift.vo.SearchVO;
import com.legend.conv.member.vo.MemberVO;

@Controller
public class GiftController {

	
	@Autowired
	GiftService giftService;

	@RequestMapping("/giftView")
	public String giftView(Model model, SearchVO searchVO, HttpSession session) {
		try {
			MemberVO login = (MemberVO) session.getAttribute("login");
			String id = null;
			List<GiftVO> cartList = null;

			if(login != null) {
				id	= login.getId();
				searchVO.setId(id);
				cartList = giftService.getCartList(searchVO);
			}
			List<GiftVO> giftList = giftService.getGiftList(searchVO);
			model.addAttribute("giftList", giftList);
			 
			model.addAttribute("cartList", cartList);
		} catch (Exception e) {
			model.addAttribute("e", e);
			e.printStackTrace();
		}

		return "/gift/giftView";
	}

	@RequestMapping(value = "/giftHit")
	@ResponseBody
	public String giftHit(HttpSession session, Integer giftNo, HttpServletRequest request, Model model) {

		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = login.getId();
		System.out.println("giftHit giftNo : " + giftNo);
		giftService.hitCheck(id, giftNo);

		giftService.hitGift(giftNo);

		return "redirect:/giftView";

	}

	@RequestMapping(value = "/giftHitCancel")
	@ResponseBody
	public String giftHitCancel(@RequestParam("giftNo") Integer giftNo, HttpSession session, HttpServletRequest request,
			Model model) {
		System.out.println("hitCancelGift");

		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = login.getId();

		giftService.hitCheck(id, giftNo);

		giftService.hitCancelGift(giftNo);

		return "redirect:/giftView";
	}

	@RequestMapping(value = "/giftHitEdit")
	@ResponseBody
	public Boolean giftHitEdit(@RequestParam("giftNo") Integer giftNo, HttpSession session, HttpServletRequest request,
			Model model) {

		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = login.getId();
		System.out.println("loginId임 : " + id);

		Boolean hitYn = giftService.hitEdit(id, giftNo);

		return hitYn;
	}

	@RequestMapping(value = "/giftHitCheck")
	@ResponseBody
	public List<Boolean> giftHitCheck(@RequestBody List<Integer> giftNoArray, HttpSession session) {

		MemberVO login = (MemberVO) session.getAttribute("login");
		System.out.println("giftHitCheck giftNoArray : " + giftNoArray);
		String id = null;
		if (login != null) {
			id = login.getId();
		}
		List<Boolean> hitResults = new ArrayList<>();

		for (Integer giftNo : giftNoArray) {
			boolean hitResult = giftService.hitCheck(id, giftNo);
			hitResults.add(hitResult);
		}

		System.out.println("hitResults : " + hitResults);
		return hitResults;
	}

	@RequestMapping("/cartView")
	public String cartView(Model model, HttpSession session, SearchVO searchVO) {
		try {
			MemberVO login = (MemberVO) session.getAttribute("login");
			String id = login.getId();
			searchVO.setId(id);

			List<GiftVO> cartList = giftService.getCartList(searchVO);
			model.addAttribute("cartList", cartList);
		} catch (Exception e) {
			model.addAttribute("e", e);
			e.printStackTrace();
		}

		return "/gift/cartView";
	}

	@RequestMapping("/buyDo")
	public String buyDo(Model model) {
		System.out.println("buyDo");

		return "/gift/buyDo";
	}

	@RequestMapping("/insertCart")
	@ResponseBody
	public List<GiftVO> insertCart(@RequestBody List<CartVO> cartVO, SearchVO searchVO, HttpSession session) {
		for (CartVO cart : cartVO) {
			giftService.insertCart(cart);
		}
		
			MemberVO login = (MemberVO) session.getAttribute("login");
			String id = null;
			List<GiftVO> cartList = null;

			if(login != null) {
				id	= login.getId();
				searchVO.setId(id);
				try {
					cartList = giftService.getCartList(searchVO);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		return cartList;
	}

	@RequestMapping("/deleteCart")
	@ResponseBody
	public List<GiftVO> deleteCart(@RequestBody List<CartVO> cartVO, SearchVO searchVO, HttpSession session) {
		for (CartVO cart : cartVO) {
			giftService.deleteCart(cart);
		}
		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = null;
		List<GiftVO> cartList = null;

		if(login != null) {
			id	= login.getId();
			searchVO.setId(id);
			try {
				cartList = giftService.getCartList(searchVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	return cartList;
	}

	@RequestMapping("/countCart")
	public String countCart(@RequestBody List<CartVO> cartVO) {
		System.out.println("cart: " + cartVO);

		for (CartVO cart : cartVO) {
			giftService.countCart(cart);
		}

		return "redirect:/cartView";
	}

	@RequestMapping("/giftCount")
	public String giftCount(@RequestBody List<GiftVO> giftVO) {
		System.out.println("giftVO: " + giftVO);

		for (GiftVO gift : giftVO) {
			System.out.println("gift controller : " + gift);
			giftService.countGift(gift);
		}

		return "redirect:/cartView";
	}
}
