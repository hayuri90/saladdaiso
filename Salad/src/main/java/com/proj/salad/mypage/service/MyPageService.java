package com.proj.salad.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.proj.salad.mypage.vo.MyPageVO;
import com.proj.salad.order.vo.OrderVO;
import com.proj.salad.user.vo.UserVO;

public interface MyPageService {
	//회원정보상세
	public UserVO myDetailInfo(String userId) throws DataAccessException;
	//회원정보수정
	public UserVO modifyMyInfo(Map userMap) throws DataAccessException;
	//회원정보탈퇴
	public int removeUser(String userId)  throws DataAccessException;
	//주문내역 리스트
	public List<MyPageVO> listMyOrderHistory(Map dateMap) throws Exception;
	//주문취소 표시
	public void cancelOrder(int orderNum) throws Exception;
}
