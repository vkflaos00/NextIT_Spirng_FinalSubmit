package com.legend.conv.gift.vo;

public class ItemVO {
	 	private String itemName;
	    private int quantity;
	    private int totalAmount;
	    
		public ItemVO(String itemName, int quantity, int totalAmount) {
			this.itemName = itemName;
			this.quantity = quantity;
			this.totalAmount = totalAmount;
		}
		public ItemVO() {
		}
		
		public String getItemName() {
			return itemName;
		}
		public void setItemName(String itemName) {
			this.itemName = itemName;
		}
		public int getQuantity() {
			return quantity;
		}
		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}
		public int getTotalAmount() {
			return totalAmount;
		}
		public void setTotalAmount(int totalAmount) {
			this.totalAmount = totalAmount;
		}
		@Override
		public String toString() {
			return "ItemVO [itemName=" + itemName + ", quantity=" + quantity + ", totalAmount=" + totalAmount + "]";
		}
	    
	    
}
