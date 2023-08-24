package com.legend.conv.card.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.legend.conv.card.service.CardService;
import com.legend.conv.card.vo.CardVO;

@Controller
public class CardController {
	
	@Autowired
	CardService cardService;
	
	@RequestMapping("/cardMain")
	public String cardMain() {
		return "/card/cardMain";
	}
	
    @GetMapping("/card/{convType}")
    public ResponseEntity<List<CardVO>> getCardInfo(@PathVariable String convType) {
        CardVO cardVO = new CardVO();
        cardVO.setConvType(convType);
        List<CardVO> cardList = cardService.getCardList(cardVO);
        return new ResponseEntity<>(cardList, HttpStatus.OK);
    }
    
}
