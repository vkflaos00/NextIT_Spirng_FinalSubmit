package com.legend.conv.gift.vo;

public class CartVO {

	private int cartNo;
	private String cartId;
	private int cartParentNo;
	private int cartCount;
	
	public CartVO(int cartNo, String cartId, int cartParentNo, int cartCount) {
		this.cartNo = cartNo;
		this.cartId = cartId;
		this.cartParentNo = cartParentNo;
		this.cartCount = cartCount;
	}
	
	public CartVO() {
	}
	
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public String getCartId() {
		return cartId;
	}
	public void setCartId(String cartId) {
		this.cartId = cartId;
	}
	public int getCartParentNo() {
		return cartParentNo;
	}
	public void setCartParentNo(int cartParentNo) {
		this.cartParentNo = cartParentNo;
	}
	public int getCartCount() {
		return cartCount;
	}
	public void setCartCount(int cartCount) {
		this.cartCount = cartCount;
	}
	@Override
	public String toString() {
		return "CartVO [cartNo=" + cartNo + ", cartId=" + cartId + ", cartParentNo=" + cartParentNo + ", cartCount="
				+ cartCount + "]";
	}
	
}
