package com.proj.salad.cart.dao;

import com.proj.salad.cart.vo.CartListVO;
import com.proj.salad.cart.vo.CartVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CartDAOImpl implements CartDAO {
    @Autowired
    SqlSession sqlSession;
    @Override
    public void addCart(CartVO cartVO) throws DataAccessException {
        sqlSession.selectOne("mapper.cart.addCart", cartVO);
        System.out.println("장바구니 추가 완료");
    }

    @Override
    public List<CartListVO> cartById(String userId) throws DataAccessException {
        System.out.println("장바구니 물품 조회 : " + userId);

        return sqlSession.selectList("mapper.cart.cartById", userId);
    }

    @Override
    public void delCart(int cartNum) throws DataAccessException {
        System.out.println("장바구니 1개 삭제 메소드 실행 시작");
        sqlSession.delete("mapper.cart.delCartOne", cartNum);
        System.out.println("장바구니 1개 삭제 메소드 실행 완료");
    }

    @Override
    public void updateCart(CartVO cartVO) throws DataAccessException {
        System.out.println("장바구니 1개 수정 메소드 시작");
        sqlSession.update("mapper.cart.updateCartOne", cartVO);
    }

}
