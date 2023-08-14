package com.proj.salad.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.proj.salad.mypage.vo.MyPageVO;
import com.proj.salad.order.vo.OrderVO;
import com.proj.salad.user.vo.UserVO;

@Repository("myPageDAO")
public class MyPageDAOImpl implements MyPageDAO {

	@Autowired   //의존성주입
	private SqlSession sql;
	
	//회원정보상세
	@Override
	public UserVO selectMyDetailInfo(String userId) throws DataAccessException {
		UserVO userVO = (UserVO) sql.selectOne("mapper.mypage.selectMyDetailInfo",userId);
		return userVO;
	}

	//회원정보수정
	@Override
	public void updateMyInfo(Map userMap) throws DataAccessException {
		//userMap에 담긴 파라미터들은 mypage.xml에 mapper.mypage라는 namespace에 
		//아이디가 updateMyInfo인 쿼리에 파라미터들을 넣어줍니다.
		sql.update("mapper.mypage.updateMyInfo", userMap);
	}

	//회원정보탈퇴
	@Override
	public int deleteUser(String userId) throws DataAccessException {
		int result=sql.delete("mapper.mypage.deleteUser",userId);
		return result;
	}
	
	//주문내역 리스트
	@Override
	public List<MyPageVO> selectMyOrderHistoryList(Map dateMap) throws DataAccessException {
		List<MyPageVO> myOrderHistList=(List) sql.selectList("mapper.mypage.selectMyOrderHistoryList",dateMap);
		return myOrderHistList;
	}
	
	//주문취소
	@Override
	public void updateMyOrderCancel(int orderNum) throws DataAccessException {
		sql.update("mapper.mypage.updateMyOrderCancel",orderNum);
	}
	
}
