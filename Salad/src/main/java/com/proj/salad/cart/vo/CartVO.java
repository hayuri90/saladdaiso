package com.proj.salad.cart.vo;

import lombok.Data;
import org.springframework.stereotype.Component;

/* 김동혁 VO 추가 (23.07.19) */
@Data
@Component("CartVO")
public class CartVO {
    private String userId;
    private int prodNum;
    private int cartCount;
    private int cartNum;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getProdNum() {
		return prodNum;
	}
	public void setProdNum(int prodNum) {
		this.prodNum = prodNum;
	}
	public int getCartCount() {
		return cartCount;
	}
	public void setCartCount(int cartCount) {
		this.cartCount = cartCount;
	}
	public int getCartNum() {
		return cartNum;
	}
	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}
	@Override
	public String toString() {
		return "CartVO [userId=" + userId + ", prodNum=" + prodNum + ", cartCount=" + cartCount + ", cartNum=" + cartNum
				+ "]";
	}
    
    
}
