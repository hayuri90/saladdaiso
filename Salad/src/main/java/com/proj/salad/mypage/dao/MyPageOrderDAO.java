package com.proj.salad.mypage.dao;

import com.proj.salad.mypage.vo.OrderInfoVO;
import com.proj.salad.mypage.vo.OrderListVO;
import com.proj.salad.order.vo.OrderMenuVO;
import org.springframework.dao.DataAccessException;

import java.util.List;

public interface MyPageOrderDAO {
    // 주문 목록 리스트
    public List<OrderListVO> selectOrderList(String userName) throws DataAccessException;
    // 주문 상세 페이지
    public OrderInfoVO selectOrderInfo(int orderNum) throws DataAccessException;
    // 주문 상세 메뉴
    public List<OrderMenuVO> selectOrderMenu(int orderNum) throws DataAccessException;
    // Ajax 주문 상태 취소로 변경
    public int updateOrderStatus(int orderNum) throws DataAccessException;
    // 주문 취소 목록 리스트
    public List<OrderListVO> selectCanceledList(String userName) throws DataAccessException;
}
