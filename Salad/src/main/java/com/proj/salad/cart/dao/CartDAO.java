package com.proj.salad.cart.dao;

import com.proj.salad.cart.vo.CartListVO;
import com.proj.salad.cart.vo.CartVO;
import org.springframework.dao.DataAccessException;

import java.util.List;

public interface CartDAO {
    public void addCart(CartVO cartVO) throws DataAccessException;
    public List<CartListVO> cartById(String userId) throws DataAccessException;
    public void delCart(int cartNum) throws DataAccessException;
    public void updateCart(CartVO cartVO) throws DataAccessException;
}
