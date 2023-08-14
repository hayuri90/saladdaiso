package com.proj.salad.prod.dao;

import java.util.List;

import com.proj.salad.prod.vo.NutrientVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.proj.salad.prod.vo.ProdVO;

/* 김동혁 - DAO 추가 */
@Repository("prodDAO")
public class ProdDAOImpl implements ProdDAO {
    @Autowired
    private SqlSession sqlSession;

    public List<ProdVO> selectProdList() throws DataAccessException {
        List<ProdVO> list = sqlSession.selectList("mapper.prod.selectProdList");
        return list;
    }

    /* 영양소 Select DAO / 김동혁 추가 (23.07.18) */
    public NutrientVO selectProdNutrient(int prodNum) throws DataAccessException {
        System.out.println("영양소 DAO");
        NutrientVO nutrientVO = sqlSession.selectOne("mapper.prod.selectProdNutrient", prodNum);
        return nutrientVO;
    }


}
