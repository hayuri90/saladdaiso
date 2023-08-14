package com.proj.salad.order.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.proj.salad.cart.vo.CartListVO;
import com.proj.salad.order.vo.AccountVO;
import com.proj.salad.order.vo.OrderMenuVO;
import com.proj.salad.order.vo.OrderVO;

public interface OrderService {
	public List<CartListVO> getOrderList(String userId) throws DataAccessException;

	public void newOrder(OrderVO orderVO) throws DataAccessException;

	public void newOrderMenu(OrderMenuVO orderMenuVO) throws DataAccessException;

	public void deleteCartList(String userId) throws DataAccessException;

	public void newAccount(AccountVO accountVO)throws DataAccessException;

	public List<OrderVO> orderTime() throws DataAccessException;

}
