<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- CSS -->
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
	
	<title>헤더</title>
</head>

<body>
	<div class="header_outside">
		
		<!-- 하유리: 최상단 배너(23.07.14.) -->
		<div id="topBanner">
			<div><p>내 맘대로 골라담는 샐러드키트</p></div>
			<span class="closeBtn" onclick="this.parentElement.style.display='none'">	<!-- 이벤트창 닫기 -->
				<a href="#none" title="이벤트 닫기"><img src="${contextPath}/resources/image/main/closeBtn.png"/></a>
			</span>
		</div>
	
		<!-- 하유리: 메뉴(23.07.12.) -->
		<div class="header_inside">
			<div class="header_top_content">
				<!-- 로고 -->
				<div class="header_logo">
					<a href="${contextPath}/main.do"><img style="height: 80px" src="${contextPath}/resources/image/main/logo.png" /></a>
				</div>	
				
				<!-- 메인메뉴 -->
				<div class="mainMenu">
					<ul class="list2">
						<%-- 김동혁: 메뉴 앵커 주소 수정(23.07.14.) --%>
						<li><a href="${contextPath}/menu">메뉴</a></li>
						<!-- 하유리: 메뉴 위치 수정(23.07.14.) -->
						<li><a href="${contextPath}/review/list">리뷰</a></li>
						<li><a href="${contextPath}/notice/list" class="">공지</a></li>
						<li><a href="${contextPath}/map">위치</a></li>
						<li><a href="${contextPath}/event">이벤트</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>