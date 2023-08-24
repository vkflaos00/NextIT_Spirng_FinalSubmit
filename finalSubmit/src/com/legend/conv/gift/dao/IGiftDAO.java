package com.legend.conv.gift.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.legend.conv.gift.vo.CartVO;
import com.legend.conv.gift.vo.GiftVO;
import com.legend.conv.gift.vo.HitVO;
import com.legend.conv.gift.vo.SearchVO;

@Mapper
public interface IGiftDAO {

	public List<GiftVO> getGiftList(SearchVO searchVO);
	
	public int getTotalRowCount(SearchVO searchVO);

	//추천 업로드
	public int hitGift(Integer giftNo);

	public int hitCancelGift(Integer giftNo);

	public int writeHit(@Param("id")String id, @Param("giftNo")Integer giftNo);

	public int editHit(@Param("id")String id, @Param("giftNo")Integer giftNo);

	public HitVO checkHit(@Param("id")String id, @Param("giftNo")Integer giftNo);

	public void hitCheckGift(String hitYn);


	public List<GiftVO> getCartList(SearchVO searchVO);

	public int getTotalRowCountCart(SearchVO searchVO);

	public void insertCart(CartVO cart);

	public Integer checkCart(CartVO cart);

	public void updateCartCount(CartVO cart);

	public void deleteCart(CartVO cart);

	public void countCart(CartVO cart);

	public List<GiftVO> getGiftList2(SearchVO searchVO);

	public List<GiftVO> getGiftList3(SearchVO searchVO);

	public List<GiftVO> getGiftList4(SearchVO searchVO);

	public void countGift(GiftVO gift);

	public int getTotalRowCount4(SearchVO searchVO);
	
	
}
