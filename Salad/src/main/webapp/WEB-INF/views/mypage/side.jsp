<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사이드 부분</title>
	<!-- CSS -->
	<link href="../resources/css/style.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/mypage/side.css" rel="stylesheet" type="text/css" >
</head>
<body>
	<nav class="side_nav">
		<br><br>
		<p class="mypage_sub">마이페이지</p>
		<ul class="side_ul">
			<c:choose>
		  		<c:when test="${side_menu=='my_page' }">
					<li>
						<h3 class="list_sub">주문관리</h3>
						<ul>
							<li><a href="${contextPath}/mypage/myPageMain.do">- 최근주문내역</a></li>
							<li><a href="${contextPath}/mypage/orderList">- 나의주문내역</a></li>
							<li><a href="${contextPath}/mypage/canceledList">- 취소주문내역</a></li><br>
						</ul>
					</li>
					<li>
						<h3 class="list_sub">정보관리</h3>	
						<ul>
							<li><a href="${contextPath}/mypage/myDetailInfo.do">- 회원정보변경</a></li><br>
						</ul>
					</li>
	 				<li>
						<h2 class="list_sub">공지</h2>
						<ul class="notice_hid">
							<li>
								<p><a href="${contextPath}/notice/content?articleNO=205">- 6월 서비스 점검 안내</a></p>
							</li>
							<li>
								<p><a href="${contextPath}/notice/content?articleNO=204">- 인스타 이벤트 당첨안내</a></p>
							</li>
							<li>
								<p><a href="${contextPath}/notice/content?articleNO=203">- 5월 배송 휴무 안내</a></p>
							</li>
						</ul>
					</li>
	  			</c:when>
			</c:choose>	
		</ul>
	</nav>
	<br>
</body>
</html>