package com.proj.salad.cart.vo;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.sql.Date;

/* CartListVO : 제품 테이블,  */
@Data
@Component("CartListVO")
public class CartListVO {
    private int cartNum;
    private String userId;
    private int prodNum;
    private String prodName;
    private int prodPrice;
    private String prodDescription;
    private String prodBrand;
    private Date prodCreateTimestamp;
    private int prodDeliveryPrice;
    private int cartCount;

	// 이미지 테이블 Join 용 추가 - 김동혁
	private String prodImageUrl;
	private String prodImageName;
	private Date prodImageDate;

	public int getCartNum() {
		return cartNum;
	}
	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}
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
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdPrice() {
		return prodPrice;
	}
	public void setProdPrice(int prodPrice) {
		this.prodPrice = prodPrice;
	}
	public String getProdDescription() {
		return prodDescription;
	}
	public void setProdDescription(String prodDescription) {
		this.prodDescription = prodDescription;
	}
	public String getProdBrand() {
		return prodBrand;
	}
	public void setProdBrand(String prodBrand) {
		this.prodBrand = prodBrand;
	}
	public Date getProdCreateTimestamp() {
		return prodCreateTimestamp;
	}
	public void setProdCreateTimestamp(Date prodCreateTimestamp) {
		this.prodCreateTimestamp = prodCreateTimestamp;
	}
	public int getProdDeliveryPrice() {
		return prodDeliveryPrice;
	}
	public void setProdDeliveryPrice(int prodDeliveryPrice) {
		this.prodDeliveryPrice = prodDeliveryPrice;
	}
	public int getCartCount() {
		return cartCount;
	}
	public void setCartCount(int cartCount) {
		this.cartCount = cartCount;
	}

	public String getProdImageUrl() {
		return prodImageUrl;
	}

	public void setProdImageUrl(String prodImageUrl) {
		this.prodImageUrl = prodImageUrl;
	}

	public String getProdImageName() {
		return prodImageName;
	}

	public void setProdImageName(String prodImageName) {
		this.prodImageName = prodImageName;
	}

	public Date getProdImageDate() {
		return prodImageDate;
	}

	public void setProdImageDate(Date prodImageDate) {
		this.prodImageDate = prodImageDate;
	}

	@Override
	public String toString() {
		return "CartListVO{" +
				"cartNum=" + cartNum +
				", userId='" + userId + '\'' +
				", prodNum=" + prodNum +
				", prodName='" + prodName + '\'' +
				", prodPrice=" + prodPrice +
				", prodDescription='" + prodDescription + '\'' +
				", prodBrand='" + prodBrand + '\'' +
				", prodCreateTimestamp=" + prodCreateTimestamp +
				", prodDeliveryPrice=" + prodDeliveryPrice +
				", cartCount=" + cartCount +
				", prodImageUrl='" + prodImageUrl + '\'' +
				", prodImageName='" + prodImageName + '\'' +
				", prodImageDate=" + prodImageDate +
				'}';
	}
}
