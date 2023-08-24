package com.legend.conv.gift.vo;

import java.sql.Date;


public class KakaoPayApprovalVO {
	
	  private String aid, tid, cid, sid;
	    private String partner_order_id, partner_user_id, payment_method_type;
	    private KakaoAmountVO amount;
	    private KakaoCardVO card_info;
	    private String item_name, item_code, payload;
	    private Integer quantity, tax_free_amount, vat_amount;
	    private Date created_at, approved_at;
		public KakaoPayApprovalVO(String aid, String tid, String cid, String sid, String partner_order_id,
				String partner_user_id, String payment_method_type, KakaoAmountVO amount, KakaoCardVO card_info,
				String item_name, String item_code, String payload, Integer quantity, Integer tax_free_amount,
				Integer vat_amount, Date created_at, Date approved_at) {
			super();
			this.aid = aid;
			this.tid = tid;
			this.cid = cid;
			this.sid = sid;
			this.partner_order_id = partner_order_id;
			this.partner_user_id = partner_user_id;
			this.payment_method_type = payment_method_type;
			this.amount = amount;
			this.card_info = card_info;
			this.item_name = item_name;
			this.item_code = item_code;
			this.payload = payload;
			this.quantity = quantity;
			this.tax_free_amount = tax_free_amount;
			this.vat_amount = vat_amount;
			this.created_at = created_at;
			this.approved_at = approved_at;
		}
		public KakaoPayApprovalVO() {
			super();
		}
		public String getAid() {
			return aid;
		}
		public void setAid(String aid) {
			this.aid = aid;
		}
		public String getTid() {
			return tid;
		}
		public void setTid(String tid) {
			this.tid = tid;
		}
		public String getCid() {
			return cid;
		}
		public void setCid(String cid) {
			this.cid = cid;
		}
		public String getSid() {
			return sid;
		}
		public void setSid(String sid) {
			this.sid = sid;
		}
		public String getPartner_order_id() {
			return partner_order_id;
		}
		public void setPartner_order_id(String partner_order_id) {
			this.partner_order_id = partner_order_id;
		}
		public String getPartner_user_id() {
			return partner_user_id;
		}
		public void setPartner_user_id(String partner_user_id) {
			this.partner_user_id = partner_user_id;
		}
		public String getPayment_method_type() {
			return payment_method_type;
		}
		public void setPayment_method_type(String payment_method_type) {
			this.payment_method_type = payment_method_type;
		}
		public KakaoAmountVO getAmount() {
			return amount;
		}
		public void setAmount(KakaoAmountVO amount) {
			this.amount = amount;
		}
		public KakaoCardVO getCard_info() {
			return card_info;
		}
		public void setCard_info(KakaoCardVO card_info) {
			this.card_info = card_info;
		}
		public String getItem_name() {
			return item_name;
		}
		public void setItem_name(String item_name) {
			this.item_name = item_name;
		}
		public String getItem_code() {
			return item_code;
		}
		public void setItem_code(String item_code) {
			this.item_code = item_code;
		}
		public String getPayload() {
			return payload;
		}
		public void setPayload(String payload) {
			this.payload = payload;
		}
		public Integer getQuantity() {
			return quantity;
		}
		public void setQuantity(Integer quantity) {
			this.quantity = quantity;
		}
		public Integer getTax_free_amount() {
			return tax_free_amount;
		}
		public void setTax_free_amount(Integer tax_free_amount) {
			this.tax_free_amount = tax_free_amount;
		}
		public Integer getVat_amount() {
			return vat_amount;
		}
		public void setVat_amount(Integer vat_amount) {
			this.vat_amount = vat_amount;
		}
		public Date getCreated_at() {
			return created_at;
		}
		public void setCreated_at(Date created_at) {
			this.created_at = created_at;
		}
		public Date getApproved_at() {
			return approved_at;
		}
		public void setApproved_at(Date approved_at) {
			this.approved_at = approved_at;
		}
		@Override
		public String toString() {
			return "KakaoPayApprovalVO [aid=" + aid + ", tid=" + tid + ", cid=" + cid + ", sid=" + sid
					+ ", partner_order_id=" + partner_order_id + ", partner_user_id=" + partner_user_id
					+ ", payment_method_type=" + payment_method_type + ", amount=" + amount + ", card_info=" + card_info
					+ ", item_name=" + item_name + ", item_code=" + item_code + ", payload=" + payload + ", quantity="
					+ quantity + ", tax_free_amount=" + tax_free_amount + ", vat_amount=" + vat_amount + ", created_at="
					+ created_at + ", approved_at=" + approved_at + "]";
		}
	    
	    
}
