package com.legend.conv.member.vo;

public class MailAuthVO {
	
	private String mailAdd;
	private String authKey;
	private int isAuth;
	
	
	public MailAuthVO() {}


	public MailAuthVO(String mailAdd, String authKey, int isAuth) {
		super();
		this.mailAdd = mailAdd;
		this.authKey = authKey;
		this.isAuth = isAuth;
	}


	@Override
	public String toString() {
		return "MailAuthVO [mailAdd=" + mailAdd + ", authKey=" + authKey + ", isAuth=" + isAuth + "]";
	}


	public String getMailAdd() {
		return mailAdd;
	}


	public void setMailAdd(String mailAdd) {
		this.mailAdd = mailAdd;
	}


	public String getAuthKey() {
		return authKey;
	}


	public void setAuthKey(String authKey) {
		this.authKey = authKey;
	}


	public int getIsAuth() {
		return isAuth;
	}


	public void setIsAuth(int isAuth) {
		this.isAuth = isAuth;
	}
	
	
	
	
	
	
	
}
