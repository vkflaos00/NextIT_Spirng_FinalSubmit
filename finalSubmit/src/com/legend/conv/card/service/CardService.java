package com.legend.conv.card.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.legend.conv.card.dao.ICardDAO;
import com.legend.conv.card.vo.CardVO;

@Service
public class CardService {
	
	@Autowired
	ICardDAO dao;

	public List<CardVO> getCardList(CardVO cardVO) {
		return dao.getCardList(cardVO);
	}
	
	
	
}
