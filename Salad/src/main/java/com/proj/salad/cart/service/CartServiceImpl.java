package com.proj.salad.cart.service;

import com.proj.salad.cart.dao.CartDAOImpl;
import com.proj.salad.cart.vo.CartListVO;
import com.proj.salad.cart.vo.CartVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

/* 김동혁 Service 추가 (23.07.19) */
@Service
public class CartServiceImpl implements CartService {
    @Autowired
    CartDAOImpl cartDAO;
    @Override
    public void addCart(CartVO cartVO) throws DataAccessException {
        System.out.println("addCart 서비스 실행");
        cartDAO.addCart(cartVO);
    }

    @Override
    public List<CartListVO> cartById(String userId) throws DataAccessException {
        return cartDAO.cartById(userId);
    }

    @Override
    public void delCart(int cartNum) throws DataAccessException {
        cartDAO.delCart(cartNum);
    }

    @Override
    public void updateCart(CartVO cartVO) throws DataAccessException {
        cartDAO.updateCart(cartVO);
    }
}
