<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- 하유리: contextPath 추가(23.08.02.) -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/header.css" rel="stylesheet" type="text/css">
<link href="resources/css/footer.css" rel="stylesheet" type="text/css">
<link href="resources/css/order/payment.css" rel="stylesheet"
	type="text/css">
<!-- 하유리: <style>태그 payment.css로 이동(23.08.02.) -->

<title>Insert title here</title>
</head>
<body>
	<main>
		<div class="complete_msg">
			<img src="${contextPath}/resources/image/order/complete.png" />		<!-- 하유리: 이미지 추가(23.08.02.) -->
			<p id="h1">${user.userId }님의 <b>주문이 완료</b>되었습니다.</p>					<!-- 하유리: 텍스트 수정(23.08.02.) -->
		</div>

		<!-- <p class="h3">주문 정보</p> -->														<!-- 하유리: 주석 처리(23.08.02.) -->
		<div class="info-block to">
			<div class="line">
				<div class="line-title">
					<label for="username">이름</label>
				</div>
				<div class="line-content">
					<label name="username" id="username">${userName}</label>
				</div>
			</div>
			<div class="line line-orderNum">															<!-- 하유리: 클래스명 추가(23.08.02.) -->
				<div class="line-title">
					<label for="orderNum">주문번호</label>
				</div>
				<div class="line-content">
					<label name="orderNum" id="orderNum">${randomNumber}</label>
				</div>
			</div>
			<div class="line">
				<div class="line-title">
					<label for="orderTime">주문일자</label>
				</div>
				<div class="line-content">
					<label name="orderTime" id="orderTime">${formattedOrderTime}</label>
				</div>
			</div>
		</div>
		
		<!-- 하유리: 버튼 추가(23.08.02.) -->
		<div class="payment_btn">
			<button type="button" onClick = "location.href = '${contextPath}/main.do' ">홈으로 이동</button>
			<button type="button" onClick = "location.href = '${contextPath}/mypage/orderList' ">주문내역 상세보기</button>
		</div>
	</main>
</body>
</html>