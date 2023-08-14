package com.proj.salad.order.vo;


import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component("AccountVO")
public class AccountVO {
	private int OrderAccountNum; // 기본키
	private int OrderNum; // 외래키
	private String accountNumber; // 계좌 번호
	private String accountPeriod; // 유효날짜
	private String accountCVC; // CVC
	private String accountName; // 예금주
	private String purchaseType; // 결제수단

	public int getOrderAccountNum() {
		return OrderAccountNum;
	}

	public void setOrderAccountNum(int orderAccountNum) {
		OrderAccountNum = orderAccountNum;
	}

	public int getOrderNum() {
		return OrderNum;
	}

	public void setOrderNum(int orderNum) {
		OrderNum = orderNum;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getAccountPeriod() {
		return accountPeriod;
	}

	public void setAccountPeriod(String accountPeriod) {
		this.accountPeriod = accountPeriod;
	}

	public String getAccountCVC() {
		return accountCVC;
	}

	public void setAccountCVC(String accountCVC) {
		this.accountCVC = accountCVC;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getPurchaseType() {
		return purchaseType;
	}

	public void setPurchaseType(String purchaseType) {
		this.purchaseType = purchaseType;
	}

	@Override
	public String toString() {
		return "AccountVO{" +
				"OrderAccountNum=" + OrderAccountNum +
				", OrderNum=" + OrderNum +
				", accountNumber='" + accountNumber + '\'' +
				", accountPeriod='" + accountPeriod + '\'' +
				", accountCVC='" + accountCVC + '\'' +
				", accountName='" + accountName + '\'' +
				", purchaseType='" + purchaseType + '\'' +
				'}';
	}
}
