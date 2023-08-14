package com.proj.salad.prod.vo;

import lombok.Data;
import org.springframework.stereotype.Component;

/* 영양소 VO / 김동혁 추가 (23.07.18) */
/* Lombok 미적용시 Getter Setter 생성해주세요!! */
@Data
@Component
public class NutrientVO {
    private int prodNum;
    private double kcal;
    private double carbohydrates;
    private double sugar;
    private double protein;
    private double fat;
    private double saturated_fat;
    private double natrium;
	public int getProdNum() {
		return prodNum;
	}
	public void setProdNum(int prodNum) {
		this.prodNum = prodNum;
	}
	public double getKcal() {
		return kcal;
	}
	public void setKcal(double kcal) {
		this.kcal = kcal;
	}
	public double getCarbohydrates() {
		return carbohydrates;
	}
	public void setCarbohydrates(double carbohydrates) {
		this.carbohydrates = carbohydrates;
	}
	public double getSugar() {
		return sugar;
	}
	public void setSugar(double sugar) {
		this.sugar = sugar;
	}
	public double getProtein() {
		return protein;
	}
	public void setProtein(double protein) {
		this.protein = protein;
	}
	public double getFat() {
		return fat;
	}
	public void setFat(double fat) {
		this.fat = fat;
	}
	public double getSaturated_fat() {
		return saturated_fat;
	}
	public void setSaturated_fat(double saturated_fat) {
		this.saturated_fat = saturated_fat;
	}
	public double getNatrium() {
		return natrium;
	}
	public void setNatrium(double natrium) {
		this.natrium = natrium;
	}
	@Override
	public String toString() {
		return "NutrientVO [prodNum=" + prodNum + ", kcal=" + kcal + ", carbohydrates=" + carbohydrates + ", sugar="
				+ sugar + ", protein=" + protein + ", fat=" + fat + ", saturated_fat=" + saturated_fat + ", natrium="
				+ natrium + "]";
	}
  
}
