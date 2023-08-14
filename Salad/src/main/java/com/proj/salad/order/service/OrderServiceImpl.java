package com.proj.salad.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.proj.salad.cart.vo.CartListVO;
import com.proj.salad.order.dao.OrderDAOImpl;
import com.proj.salad.order.vo.AccountVO;
import com.proj.salad.order.vo.OrderMenuVO;
import com.proj.salad.order.vo.OrderVO;

@Service
public class OrderServiceImpl implements OrderService{
	@Autowired
	OrderDAOImpl orderDAO;

	@Override
	public List<CartListVO> getOrderList(String userId) throws DataAccessException {
		List<CartListVO> orderlist = orderDAO.selectOrderList(userId);
		return orderlist;
	}
		@Override
		public void newOrder(OrderVO orderVO) throws DataAccessException {
			orderDAO.newOrder(orderVO);
		}

		@Override
		public void newOrderMenu(OrderMenuVO orderMenuVO) throws DataAccessException {
			orderDAO.newOrderMenu(orderMenuVO);
		}

		@Override
		public void deleteCartList(String userId) throws DataAccessException {
			orderDAO.deleteCartList(userId);
	}
		
		@Override
		public void newAccount(AccountVO accountVO) throws DataAccessException{
			orderDAO.newAccount(accountVO);
			
		}
		@Override
		public List<OrderVO> orderTime() throws DataAccessException{
			List<OrderVO> orderTime = orderDAO.orderTime();
			return orderTime;
		}



}
