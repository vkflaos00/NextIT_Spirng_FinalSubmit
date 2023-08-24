package com.legend.conv.message.vo;

public class MessageVO {
	private String idAdd;
	private String hpAdd;
	private String key;
	private int isKey;
	
	
	
	
	public MessageVO() {}


	public MessageVO(String idAdd, String hpAdd, String key, int isKey) {
		super();
		this.idAdd = idAdd;
		this.hpAdd = hpAdd;
		this.key = key;
		this.isKey = isKey;
	}


	@Override
	public String toString() {
		return "MessageVO [idAdd=" + idAdd + ", hpAdd=" + hpAdd + ", key=" + key + ", isKey=" + isKey + "]";
	}


	public String getIdAdd() {
		return idAdd;
	}


	public void setIdAdd(String idAdd) {
		this.idAdd = idAdd;
	}


	public String getHpAdd() {
		return hpAdd;
	}


	public void setHpAdd(String hpAdd) {
		this.hpAdd = hpAdd;
	}


	public String getKey() {
		return key;
	}


	public void setKey(String key) {
		this.key = key;
	}


	public int getIsKey() {
		return isKey;
	}


	public void setIsKey(int isKey) {
		this.isKey = isKey;
	}
	
	
	
	
	
	

}
