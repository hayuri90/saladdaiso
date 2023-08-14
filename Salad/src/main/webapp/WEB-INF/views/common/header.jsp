<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<!-- 	<link href="/css/header.css" rel="stylesheet" type="text/css" > -->
	<!-- 하유리: CSS 링크 수정(23.07.31.) -->
	<link href="../resources/css/style.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/header.css" rel="stylesheet" type="text/css" >

	<meta charset="UTF-8">
	<title>헤더</title>
</head>

<body>
	<div class="header_outside">
		
		<!-- 하유리: 최상단 배너(23.07.14.) -->
		<div id="topBanner">
			<div>
				<p>내 맘대로 골라담는 샐러드키트</p>
			</div>
			<span class="closeBtn" onclick="this.parentElement.style.display='none'">	<!-- 이벤트창 닫기 -->
				<a href="#none" title="이벤트 닫기"><img src="${contextPath}/resources/image/main/closeBtn.png"/></a>
			</span>
		</div>
	
		<!-- 하유리: 메뉴(23.07.12.) -->
		<div class="header_inside">
			<div class="header_top_content">
				<!-- 로고 -->
				<div class="header_logo">
					<a href="${contextPath}/main.do">
						<img style="height: 80px" src="${contextPath}/resources/image/main/logo.png" />	<!-- 하유리: 로고 파일명 수정(23.07.14.) -->
					</a>
				</div>	
				
				<!-- 메인메뉴 -->
				<div class="mainMenu">
					<ul class="list2">
						<%-- 김동혁: 메뉴 앵커 주소 수정(23.07.14) --%>
						<li><a href="${contextPath}/menu">메뉴</a></li>
						<!-- 하유리: 메뉴 위치 수정(23.07.14.) -->
						<li><a href="${contextPath}/review/list">리뷰</a></li>
						<li><a href="${contextPath}/notice/list" class="">공지</a></li>
						<li><a href="${contextPath}/event">이벤트</a></li>		<!-- 하유리: 이벤트↔위치 순서 변경(23.07.29.) -->
						<li><a href="${contextPath}/map">위치</a></li>
					</ul>
				</div>
			
				<!-- 회원메뉴 -->
				<div class="memberMenu">
					<ul class="list1">
						<!-- 서승희 수정(23.07.16.) 하유리 수정(23.07.30.) -->
						<c:choose>
							<c:when test="${isLogOn==true && user != null }">
								<div class="userMenu">
									<p>${user.userName } 님</p>	<!-- 하유리: userName과 님 사이에 공백 추가(23.07.30.) -->
									<p><a href="${contextPath}/user/logout.do"><img width="18px" src="${contextPath}/resources/image/common/header/logout3.png"/></a></p>	<!-- 로그아웃 -->
								</div>
								<div class="functionMenu">
									<ul>
										<li><a href="${contextPath}/mypage/myPageMain.do"><img width="25px" src="${contextPath}/resources/image/common/header/mypage2.png"/></a></li>	<!-- 마이페이지 -->
										<li><a href="${contextPath}/cart"><img class="cart_icon" width="30px" src="${contextPath}/resources/image/common/header/cart.png"/></a></li>	<!-- 장바구니 -->
										<li><a href="${contextPath}/mypage/orderList"><img width="26px" src="${contextPath}/resources/image/common/header/buyList.png"/></a></li>	<!-- 구매목록 -->
									</ul>
								</div>
							</c:when>
							<c:otherwise>
								<li><a href="${contextPath}/user/loginForm.do">로그인&nbsp;&nbsp;</a></li>		<!-- 하유리: 텍스트 수정(23.07.30.) -->
								<li><a href="${contextPath}/user/userForm.do">&nbsp;&nbsp;회원가입</a></li> 	<!-- 하유리: 텍스트 수정(23.07.30.) -->
							</c:otherwise>
						</c:choose>
					</ul>
				</div>

			</div>
			
		</div>
	</div>

</body>
</html>