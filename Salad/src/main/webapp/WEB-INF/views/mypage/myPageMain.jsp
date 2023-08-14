<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<!-- css 적용 -->
<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
<link href="../resources/css/header.css" rel="stylesheet"
	type="text/css">
<link href="../resources/css/footer.css" rel="stylesheet"
	type="text/css">
<link href="../resources/css/mypage/myPageMain.css" rel="stylesheet"
	type="text/css">

<%-- 폰트 적용 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Open+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

</head>
<body>
	<!-- 정렬 수정(23.08.12.) -->
	<div class="mymain_total">
		<!-- 광고(23.08.11.) -->
		<div class="ad">
			<a href="${contextPath}/event">
				<img class="ad_img" src="${contextPath}/resources/image/common/side/ad.png"/>
			</a>
			<div class="ad_div">
				<a href="${contextPath }/menu"><p>구매하기</p></a>
				<a href="${contextPath }/notice/list"><p style="border-top: 1px solid #e2e2e2;">공지확인</p></a>
			</div>
		</div>
		<!-- 하유리: 클래스에 따옴표 없어서 수정(23.08.02.) -->
		<div class="myinfo_container">
			<h1 class="myinfo">#나의 정보</h1>
			<br>
			<table class="myinfo_table">
				<tr>
					<td class="myinfo_td_title">이름</td>
					<td class="myinfo_td"><strong>${user.userName}</strong></td>
				</tr>
				<tr>
					<td class="myinfo_td_title">이메일</td>
					<td class="myinfo_td"><strong>${user.userEmail}</strong></td>
				</tr>
				<tr>
					<td class="myinfo_td_title">연락처</td>
					<td class="myinfo_td"><strong>${user.userPhone }</strong></td>
				</tr>
				<tr>
					<td class="myinfo_td_title_add">주소지</td>
					<td class="myinfo_td_add">기본 주소: &nbsp;&nbsp; <strong>${user.userAddress1 }</strong>
						<br> 상세 주소: &nbsp;&nbsp; <strong>${user.userAddress2 }</strong>
					</td>
				</tr>
			</table>
		</div>

		<div class="new_order_container">
			<h1 class="new_order">#최근주문내역</h1>
			<form method="post" id="orderhis_Form">
				<table>
					<tbody>
						<!-- 주문일자 검색 추가 23.07.30 서승희 -->
						<%-- <tr>
					<td><select name="curYear">
							<c:forEach var="i" begin="0" end="5">
								<c:choose>
									<c:when test="${endYear==endYear-i }">
										<option value="${endYear}" selected>${endYear}</option>
									</c:when>
									<c:otherwise>
										<option value="${endYear-i }">${endYear-i }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select>년 <select name="curMonth">
							<c:forEach var="i" begin="1" end="12">
								<c:choose>
									<c:when test="${endMonth==i }">
										<option value="${i }" selected>${i }</option>
									</c:when>
									<c:otherwise>
										<option value="${i }">${i }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select>월 <select name="curDay">
							<c:forEach var="i" begin="1" end="31">
								<c:choose>
									<c:when test="${endDay==i }">
										<option value="${i }" selected>${i }</option>
									</c:when>
									<c:otherwise>
										<option value="${i }">${i }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select>일
					&nbsp;이전&nbsp; --%>
						<%-- 	<td>
					<input type="button" onClick="search_order_history('${fixedSearchPeriod }') " value="조회" />
					</td> --%>
						</tr>
						<tr>
							<td class="my_a">
								<a href="javascript:search_order_history('today')">
									<img src="${contextPath}/resources/image/search/btn_search_one_day.jpg">
								</a> 
								<a href="javascript:search_order_history('three_day')"> 
									<img src="${contextPath}/resources/image/search/btn_search_3_day.jpg">
								</a> 
								<a href="javascript:search_order_history('one_week')"> 
									<img src="${contextPath}/resources/image/search/btn_search_1_week.jpg">
								</a> 
								<a href="javascript:search_order_history('one_month')"> 
									<img src="${contextPath}/resources/image/search/btn_search_1_month.jpg">
								</a> 
								<a href="javascript:search_order_history('three_month')"> 
									<img src="${contextPath}/resources/image/search/btn_search_3_month.jpg">
								</a> 
								<a href="javascript:search_order_history('six_month')"> 
									<img src="${contextPath}/resources/image/search/btn_search_6_month.jpg">
								</a> <!-- 	&nbsp;까지 조회 -->
							</td>
						</tr>
						<br>

					</tbody>
				</table>
				<!-- <div class="clear"></div> -->
			</form>
			<table class="list_order_view">
				<tbody align="center">
					<tr style="background: lightgray">
						<td class="list_order_title" width="120px">주문일자</td>
						<td class="list_order_title" width="120px">주문번호</td>
						<!-- <td  width="120px">주문상품/수량</td> -->
						<td class="list_order_title" width="120px">주문자</td>
						<td class="list_order_title" width="120px">주문가격</td>
						<td class="list_order_title" width="120px">주문상태</td>
						<td class="list_order_title" width="120px">주문취소</td>
					</tr>
					<%-- 주문내역이 비어있을 경우 --%>
					<c:choose>
						<c:when test="${ empty myOrderHistList  }">
							<tr>
								<td colspan=6 class="fixed" align="center">
									<!-- 23.08.01 colspan 수정 --> <strong>주문한 상품이 없습니다.</strong>
								</td>
							</tr>
						</c:when>
						<%-- 주문 테이블 목록 출력 --%>
						<c:otherwise>
							<c:forEach var="item" items="${myOrderHistList }" varStatus="i">
								<tr>
									<td class="my_page_td">${item.orderCreateTimestamp}</td>
									<td class="my_page_td td-bold">
										<a href='${contextPath}/mypage/orderInfo/${item.orderNum}'>${item.fakeOrderNum }</a>
									</td>
									<td class="my_page_td">${item.ordererName}</td>
									<td class="my_page_td">
										<p class="my_page_price">
											<fmt:formatNumber value="${item.totalPrice}" pattern="#,###" />원
										</p>
									</td>
									<td class="my_page_td">
										<c:if test="${item.orderStatus == '결제완료'}">${item.orderStatus}</c:if>
										<c:if test="${item.orderStatus == '취소완료'}">
											<p class=" my_page_td_cancel">${item.orderStatus}</p>
										</c:if>
									</td>
									<td class="my_page_td">
										<c:if test="${item.orderStatus=='결제완료'}">
											<input type="button" class="my_page_cancel" onclick="fn_cancel_order('${item.orderNum}')" value="주문취소" />
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<!-- <br><br> -->
	<!-- 하유리: 주석 처리(23.08.02.) -->
	<!-- <h1>계좌내역</h1><br>
<div class="pay_form" align="center">
<table border=1  width=70%  cellpadding=10 cellspacing=10>
  <tr>
    <td align="center">
	   예치금 &nbsp;&nbsp;  <strong>5000원</strong>
   </td>
    <td align="center">
	   쇼핑머니 &nbsp;&nbsp; <strong>1000원</strong>
   </td>
   </tr>
   <tr>
    <td align="center">
	   쿠폰 &nbsp;&nbsp;  <strong>3000원</strong>
   </td>
    <td align="center">
	   포인트 &nbsp;&nbsp; <strong>2000원</strong>
   </td>
   </tr>
   <tr>
    <td align="center">
	   상품권 &nbsp;&nbsp;  <strong>10000원</strong>
   </td>
    <td align="center">
		디지털머니 &nbsp;&nbsp; <strong>3000원</strong>
   </td>
   </tr>
</table>
</div>
 <br><br> -->

	<!-- 주문취소 -->
	<c:if test="${message=='cancel_order'}">
		<script>
			window.onload = function() {
				init();
			}

			function init() {
				alert("주문을 취소했습니다."); // 사용자가 주문 취소를 눌렀을 경우
			}
		</script>
	</c:if>

	<script>
		//주문취소
		function fn_cancel_order(orderNum) {
			var answer = confirm("주문을 취소하시겠습니까?");
			if (answer == true) {
				var formObj = document.createElement("form");
				var i_orderNum = document.createElement("input");

				i_orderNum.name = "orderNum";
				i_orderNum.value = orderNum;

				formObj.appendChild(i_orderNum);
				document.body.appendChild(formObj);
				formObj.method = "post";
				formObj.action = "${contextPath}/mypage/cancelMyOrder.do";
				formObj.submit();
			}
		}

		//주문검색일자
		function search_order_history(fixedSearchPeriod) {
			var formObj = document.createElement("form");
			var i_fixedSearch_period = document.createElement("input");

			i_fixedSearch_period.name = "fixedSearchPeriod";
			i_fixedSearch_period.value = fixedSearchPeriod;

			formObj.appendChild(i_fixedSearch_period);
			document.body.appendChild(formObj);
			formObj.method = "get";
			formObj.action = "${contextPath}/mypage/myPageMain.do";
			formObj.submit();
		}
	</script>


</body>
</html>
