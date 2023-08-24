package com.legend.conv.card.vo;

import java.util.List;

public class CardVO {
	
	private String convType;
	private String cardTitle;
	private String cardDiscount;
	private String cardContent;
	private String cardNotice;
	private String cardSrc;
	private List<CardVO> cardList;
	
	public CardVO(String convType, String cardTitle, String cardDiscount, String cardContent, String cardNotice,
			String cardSrc, List<CardVO> cardList) {
		this.convType = convType;
		this.cardTitle = cardTitle;
		this.cardDiscount = cardDiscount;
		this.cardContent = cardContent;
		this.cardNotice = cardNotice;
		this.cardSrc = cardSrc;
		this.cardList = cardList;
	}

	public CardVO() {}

	public String getConvType() {
		return convType;
	}

	public void setConvType(String convType) {
		this.convType = convType;
	}

	public String getCardTitle() {
		return cardTitle;
	}

	public void setCardTitle(String cardTitle) {
		this.cardTitle = cardTitle;
	}

	public String getCardDiscount() {
		return cardDiscount;
	}

	public void setCardDiscount(String cardDiscount) {
		this.cardDiscount = cardDiscount;
	}

	public String getCardContent() {
		return cardContent;
	}

	public void setCardContent(String cardContent) {
		this.cardContent = cardContent;
	}

	public String getCardNotice() {
		return cardNotice;
	}

	public void setCardNotice(String cardNotice) {
		this.cardNotice = cardNotice;
	}

	public String getCardSrc() {
		return cardSrc;
	}

	public void setCardSrc(String cardSrc) {
		this.cardSrc = cardSrc;
	}

	public List<CardVO> getCardList() {
		return cardList;
	}

	public void setCardList(List<CardVO> cardList) {
		this.cardList = cardList;
	}

	@Override
	public String toString() {
		return "CardVO [convType=" + convType + ", cardTitle=" + cardTitle + ", cardDiscount=" + cardDiscount
				+ ", cardContent=" + cardContent + ", cardNotice=" + cardNotice + ", cardSrc=" + cardSrc + ", cardList="
				+ cardList + "]";
	}
	
	
}
