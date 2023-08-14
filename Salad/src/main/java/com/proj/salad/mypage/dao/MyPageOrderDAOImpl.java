package com.proj.salad.mypage.dao;

import com.proj.salad.mypage.vo.OrderInfoVO;
import com.proj.salad.mypage.vo.OrderListVO;
import com.proj.salad.order.vo.OrderMenuVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MyPageOrderDAOImpl implements MyPageOrderDAO{
    @Autowired
    SqlSession sqlSession;
    @Override
    public List<OrderListVO> selectOrderList(String userName) throws DataAccessException {
        System.out.println("selectOrderList DAO 실행");
        return sqlSession.selectList("mapper.orderList.selectOrderList", userName);
    }

    @Override
    public OrderInfoVO selectOrderInfo(int orderNum) throws DataAccessException {
        return sqlSession.selectOne("mapper.orderList.selectOrderInfo", orderNum);
    }

    @Override
    public List<OrderMenuVO> selectOrderMenu(int orderNum) throws DataAccessException {
        return sqlSession.selectList("mapper.orderList.selectOrderMenu", orderNum);
    }

    @Override
    public int updateOrderStatus(int orderNum) throws DataAccessException {
        return sqlSession.update("mapper.orderList.updateOrderStatus", orderNum);
    }

    @Override
    public List<OrderListVO> selectCanceledList(String userName) throws DataAccessException {
        return sqlSession.selectList("mapper.orderList.selectCanceledList",userName);
    }
}
