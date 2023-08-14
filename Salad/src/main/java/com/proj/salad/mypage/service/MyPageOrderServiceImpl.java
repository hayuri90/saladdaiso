package com.proj.salad.mypage.service;

import com.proj.salad.mypage.dao.MyPageOrderDAOImpl;
import com.proj.salad.mypage.vo.OrderInfoVO;
import com.proj.salad.mypage.vo.OrderListVO;
import com.proj.salad.order.vo.OrderMenuVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MyPageOrderServiceImpl implements MyPageOrderService {
    @Autowired
    MyPageOrderDAOImpl myPageOrderDAO;
    @Override
    public List<OrderListVO> selectOrderList(String userName) throws DataAccessException {
        return myPageOrderDAO.selectOrderList(userName);
    }

    @Override
    public OrderInfoVO selectOrderOne(int orderNum) throws DataAccessException {
        return myPageOrderDAO.selectOrderInfo(orderNum);
    }

    @Override
    public List<OrderMenuVO> selectOrderMenu(int orderNum) throws DataAccessException {
        return myPageOrderDAO.selectOrderMenu(orderNum);
    }

    @Override
    public int updateOrderStatus(int orderNum) throws DataAccessException {
        return myPageOrderDAO.updateOrderStatus(orderNum);
    }

    @Override
    public List<OrderListVO> selectCanceledList(String userName) throws DataAccessException {
        return myPageOrderDAO.selectCanceledList(userName);
    }
}
