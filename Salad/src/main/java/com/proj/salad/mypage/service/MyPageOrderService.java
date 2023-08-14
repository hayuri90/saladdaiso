package com.proj.salad.mypage.service;

import com.proj.salad.mypage.vo.OrderInfoVO;
import com.proj.salad.mypage.vo.OrderListVO;
import com.proj.salad.order.vo.OrderMenuVO;
import org.springframework.dao.DataAccessException;

import java.util.List;

public interface MyPageOrderService {
    public List<OrderListVO> selectOrderList(String userName) throws DataAccessException;
    public OrderInfoVO selectOrderOne(int orderNum) throws DataAccessException;
    public List<OrderMenuVO> selectOrderMenu(int orderNum) throws DataAccessException;
    public int updateOrderStatus(int orderNum) throws DataAccessException;
    public List<OrderListVO> selectCanceledList(String userName) throws DataAccessException;
}
