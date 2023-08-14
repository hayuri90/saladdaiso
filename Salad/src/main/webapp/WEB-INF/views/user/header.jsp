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
	<!-- css 적용 -->
	<link href="../resources/css/style.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/header.css" rel="stylesheet" type="text/css" >
	<style>
	/* 서승희 로그인,회원가입 헤더부분 css 추가 수정(23.07.18)*/
	.header_inside{
	/* 로고+메뉴 양쪽 끝 정렬 */
	display: inline-block;

	/* 로고+메뉴 수직 중앙 정렬 */
	align-items: center;	
	}

	</style>
	<meta charset="UTF-8">
	<title>헤더</title>
	<style>
		
	</style>	
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
						<img style="height: 80px" src="${contextPath}/resources/image/main/logo.png" />
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
						<li><a href="${contextPath}/map">위치</a></li>
						<li><a href="${contextPath}/event">이벤트</a></li>
					</ul>
				</div>
			
				<!-- 서승희 회원메뉴 주석 처리(23.07.18) -->
				<%-- <!-- 회원메뉴 -->
				<div class="memberMenu">
					<ul class="list1">
						<!-- 서승희 수정(23.07.16) -->
					 <c:choose>
							<c:when test="${isLogOn==true && user != null }">
								<h3> <img src="${contextPath}/resources/image/person.png" size=10px/>${user.userName }님!</h3>
								<li><a href="${contextPath}/user/logout.do">로그아웃</a></li>
								<li><a href="${contextPath}/mypage/myDetailInfo.do">마이페이지</a></li>
								<li><a href="#" class="">장바구니</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${contextPath}/user/loginForm.do">로그인</a></li>
								<li><a href="${contextPath}/user/userForm.do">회원가입</a></li>
							</c:otherwise>
						</c:choose>
				  </ul>
				</div> --%>
				
			</div>
		</div>
	</div>
	<%-- <!-- 슬라이드 배너 -->
	<div>
		<img class="slideBanner" src="${contextPath}/resources/image/slideBanner4.png" />
	</div>
 --%>
<%-- 	<table border=0 width="100%">
		<tr>
			<td colspan="2" style=" height: 30px; background-color:#36DDA6"></td>
			<td style=" height: 30px; background-color:#36DDA6">
				<a href="#">로그인</a>
				<a href="#">회원가입</a>
				<a href="#">장바구니</a>
				<a href="#">장바구니</a>
				<a href="#">장바구니</a>
			</td>
		</tr>
		<tr>
			<td>
				<a href="${contextPath}/main.do">
					<!-- 로고 -->
					<img src="${contextPath}/resources/image/duke_swing.gif" />
				</a>
			</td>
			<td>
				<h1>
					<font size=30>스프링실습 홈페이지!!</font>
				</h1>
			</td>
			<td><a href="#"><h3>로그인</h3></a> 
			       
			<c:choose>
          		<c:when test="${isLogOn == true  && member!= null}">
            		<h3>환영합니다. ${member.name }님!</h3>
            		<a href="${contextPath}/member/logout.do"><h3>로그아웃</h3></a>
          		</c:when>
          		<c:otherwise>
	        		<a href="${contextPath}/member/loginForm.do"><h3>로그인</h3></a>
	      		</c:otherwise>
	   		</c:choose>
	   		</td>
		</tr>
	</table> --%>

</body>
</html>