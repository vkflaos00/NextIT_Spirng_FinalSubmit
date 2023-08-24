package com.legend.conv.gift.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.legend.conv.gift.dao.IGiftDAO;
import com.legend.conv.gift.vo.CartVO;
import com.legend.conv.gift.vo.GiftVO;
import com.legend.conv.gift.vo.HitVO;
import com.legend.conv.gift.vo.SearchVO;

@Service
public class GiftService {
	
	@Autowired
	IGiftDAO dao;

	public List<GiftVO> getGiftList(SearchVO searchVO) throws Exception {
		if (searchVO.getSearchBtn() == null) {
			int totalRowCount = dao.getTotalRowCount(searchVO);
			searchVO.setTotalRowCount(totalRowCount);
			searchVO.pageSetting();
			
			List<GiftVO> giftList = dao.getGiftList(searchVO);
			return giftList;
		} else if (searchVO.getSearchBtn().equals("searchBtn2")) {
			int totalRowCount = dao.getTotalRowCount(searchVO);
			searchVO.setTotalRowCount(totalRowCount);
			searchVO.pageSetting();
			
			List<GiftVO> giftList = dao.getGiftList2(searchVO);
			return giftList;
		} else if (searchVO.getSearchBtn().equals("searchBtn3")) {
			int totalRowCount = dao.getTotalRowCount(searchVO);
			searchVO.setTotalRowCount(totalRowCount);
			searchVO.pageSetting();
			
			List<GiftVO> giftList = dao.getGiftList3(searchVO);
			return giftList;
		} else if (searchVO.getSearchBtn().equals("searchBtn4") && searchVO.getId() != null) {
			int totalRowCount = dao.getTotalRowCount4(searchVO);
			searchVO.setTotalRowCount(totalRowCount);
			searchVO.pageSetting();
			
			List<GiftVO> giftList = dao.getGiftList4(searchVO);
			return giftList;
		} else if (searchVO.getSearchBtn().equals("searchBtn4") && searchVO.getId() == null) {
			List<GiftVO> giftList = new ArrayList<>();
			return giftList;
		}else {
			int totalRowCount = dao.getTotalRowCount(searchVO);
			searchVO.setTotalRowCount(totalRowCount);
			searchVO.pageSetting();
			
			List<GiftVO> giftList = dao.getGiftList(searchVO);
			return giftList;
		}
	}

	// 추천수
	public void hitGift(Integer giftNo) {
		dao.hitGift(giftNo);
	}

	public void hitCancelGift(Integer giftNo) {
		dao.hitCancelGift(giftNo);
	}

	public Boolean hitCheck(String id, Integer giftNo) {
		System.out.println("서비스 id: " + id);
		HitVO hitCheck = dao.checkHit(id, giftNo);

		if (hitCheck == null) {
			return false;
		}
		String hitYn = hitCheck.getHitYn();
		if (hitYn.equals("Y")) {
			return true;
		}
		return false;
	}

	public Boolean hitEdit(String id, Integer giftNo) {
		System.out.println("서비스 id: " + id);
		HitVO hitCheck = dao.checkHit(id, giftNo);

		if (hitCheck == null) {
			dao.writeHit(id, giftNo);
			return true;
		} else {
			String hitYn = hitCheck.getHitYn();
			if (hitYn.equals("N")) {
				dao.editHit(id, giftNo);
				return true;
			}
			dao.editHit(id, giftNo);
			return false;
		}
	}

	public List<GiftVO> getCartList(SearchVO searchVO) throws Exception {

		int totalRowCount = dao.getTotalRowCountCart(searchVO);

		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();

		List<GiftVO> cartList = dao.getCartList(searchVO);

		return cartList;
	}

	public List<GiftVO> getCart(SearchVO searchVO) throws Exception {
		List<GiftVO> cartList = dao.getCartList(searchVO);
		return cartList;
	}
	
	public void insertCart(CartVO cart) {
		Integer cartCount = dao.checkCart(cart);

		if (cartCount != null) {
			dao.updateCartCount(cart);
		} else {
			dao.insertCart(cart);
		}

	}

	public void deleteCart(CartVO cart) {
		dao.deleteCart(cart);
	}

	public void countCart(CartVO cart) {
		dao.countCart(cart);
	}

	public void countGift(GiftVO gift) {
		dao.countGift(gift);
	}



}
