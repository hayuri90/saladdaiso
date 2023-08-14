package com.proj.salad.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.proj.salad.mypage.dao.MyPageDAO;
import com.proj.salad.mypage.vo.MyPageVO;
import com.proj.salad.order.vo.OrderVO;
import com.proj.salad.user.vo.UserVO;

@Service("myPageService")
@Transactional(propagation=Propagation.REQUIRED)
public class MyPageServiceImpl implements MyPageService {

	@Autowired  //의존성주입
	private MyPageDAO myPageDAO;
	
	//회원정보상세
	@Override
	public UserVO myDetailInfo(String userId) throws DataAccessException {
		return myPageDAO.selectMyDetailInfo(userId);
	}

	//회원정보수정
	//Controller에서 보내는 파라미터들을 modifyMyInfo(Map userMap) 로 받고
	@Override
	public UserVO modifyMyInfo(Map userMap) throws DataAccessException {
		String userId=(String) userMap.get("userId");  //userMap에서 userId를 찾아
		myPageDAO.updateMyInfo(userMap);  //modifyMyInfo(Map userMap) 받은 userMap을 DAO로 보내줌
		return myPageDAO.selectMyDetailInfo(userId);  //찾은 userId의 정보를 반환
	}

	//회원정보탈퇴
	@Override
	public int removeUser(String userId) throws DataAccessException {
		int result=myPageDAO.deleteUser(userId);  //찾은 userId를 삭제
		return  result;
	}

	//주문내역 리스트
	@Override
	public List<MyPageVO> listMyOrderHistory(Map dateMap) throws Exception {
		return myPageDAO.selectMyOrderHistoryList(dateMap);
	}

	//주문취소 표시
	@Override
	public void cancelOrder(int orderNum) throws Exception {
		myPageDAO.updateMyOrderCancel(orderNum);
	}

	
}
