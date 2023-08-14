package com.proj.salad.prod.vo;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.sql.Date;

/* 김동혁 - VO 추가 */
/* SHOP_PRODUCT, PROD_IMAGE 의 조인을 위해 VO 수정(23.07.14) */
@Data
@Component
public class ProdVO {
    private int prodNum;
    private String prodName;
    private int prodPrice;
    private String prodDescription;
    private String prodBrand;
    private Date prodCreateTimestamp;
    private int prodDeliveryPrice;
    private String prodImageUrl;
    private String prodImageName;
    private Date prodImageDate;
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
		return "ProdVO [prodNum=" + prodNum + ", prodName=" + prodName + ", prodPrice=" + prodPrice
				+ ", prodDescription=" + prodDescription + ", prodBrand=" + prodBrand + ", prodCreateTimestamp="
				+ prodCreateTimestamp + ", prodDeliveryPrice=" + prodDeliveryPrice + ", prodImageUrl=" + prodImageUrl
				+ ", prodImageName=" + prodImageName + ", prodImageDate=" + prodImageDate + "]";
	}
    
    
}
