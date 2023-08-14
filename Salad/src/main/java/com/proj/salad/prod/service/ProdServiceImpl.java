package com.proj.salad.prod.service;

import java.util.List;

import com.proj.salad.prod.vo.NutrientVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.proj.salad.prod.dao.ProdDAOImpl;
import com.proj.salad.prod.vo.ProdVO;

/* 김동혁 - Service 추가 */
@Service
public class ProdServiceImpl {
//    @Autowired
//    ProdVO prodVO;
//    @Autowired
//    NutrientVO nutrientVO;
    @Autowired
    SqlSession sqlSession;
    @Autowired
    ProdDAOImpl prodDAOImpl;
    public List<ProdVO> selectProdList() throws DataAccessException {
        List list = prodDAOImpl.selectProdList();
        return list;
    }

    /* 영양소 Select 서비스 / 김동혁 추가 (23.07.18) */
    public NutrientVO selectProdNutrient(int prodNum) throws DataAccessException {
        System.out.println("영양소 서비스");
        NutrientVO nutrientVO = prodDAOImpl.selectProdNutrient(prodNum);
        return nutrientVO;
    }
}
