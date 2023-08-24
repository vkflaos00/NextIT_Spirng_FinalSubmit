package com.legend.conv.card.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.legend.conv.card.vo.CardVO;

@Mapper
public interface ICardDAO {

	List<CardVO> getCardList(CardVO cardVO);

	
}
