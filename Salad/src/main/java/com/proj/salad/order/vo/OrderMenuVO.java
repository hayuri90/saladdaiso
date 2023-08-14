package com.proj.salad.order.vo;

import lombok.Data;
import org.springframework.stereotype.Component;

/* 김동혁 추가(23.07.24) */
@Data
@Component
public class OrderMenuVO {
    private int orderMenuNum;
    private int orderNum;
    private String userId;
    private String menuName;
    private int menuCount;

    public int getOrderMenuNum() {
        return orderMenuNum;
    }

    public void setOrderMenuNum(int orderMenuNum) {
        this.orderMenuNum = orderMenuNum;
    }

    public int getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(int orderNum) {
        this.orderNum = orderNum;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public int getMenuCount() {
        return menuCount;
    }

    public void setMenuCount(int menuCount) {
        this.menuCount = menuCount;
    }

    @Override
    public String toString() {
        return "OrderMenuVO{" +
                "orderMenuNum=" + orderMenuNum +
                ", orderNum=" + orderNum +
                ", userId='" + userId + '\'' +
                ", menuName='" + menuName + '\'' +
                ", menuCount=" + menuCount +
                '}';
    }
}
