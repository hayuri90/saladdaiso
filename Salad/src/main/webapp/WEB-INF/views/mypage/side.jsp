<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!-- 서승희 23.07.25 전체 수정 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>사이드 부분</title>
 <!-- css 적용 -->
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
					<h3 class="list_sub">주문관리</h3>		<!-- 하유리: 클래스명 변경(23.07.31.) -->
					<!-- <br> -->
					<ul>
						<li><a href="${contextPath}/mypage/myPageMain.do">- 최근주문내역</a></li>			<!-- 하유리: <br> 제거(23.07.31.) -->
						<%-- <li><a href="${contextPath}/mypage/myOrderDetail.do">반품/교환 신청 및 조회</a></li><br> --%>
						<li><a href="${contextPath}/mypage/orderList">- 나의주문내역</a></li>						<!-- 하유리: <br> 제거(23.07.31.) -->
						<li><a href="${contextPath}/mypage/canceledList">- 취소주문내역</a></li><br>
					</ul>
				</li>															<!-- 하유리: <br> 제거(23.07.31.) -->
				<li>
					<h3 class="list_sub">정보관리</h3>		<!-- 하유리: 클래스명 변경(23.07.31.) -->
					<!-- <br> -->										<!-- 하유리: <br> 제거(23.07.31.) -->
					<ul>
						<li><a href="${contextPath}/mypage/myDetailInfo.do">- 회원정보변경</a></li><br>
						<!-- <li><a href="#">개인정보 동의내역</a></li><br>
						<li><a href="#">회원탈퇴</a></li><br> -->
					</ul>
				</li>

				<!-- <div> -->
 				<li>
					<h2 class="list_sub">공지</h2>			<!-- 하유리: 클래스명 변경(23.07.31.) -->
					<!-- <br> -->										<!-- 하유리: <br> 제거(23.07.31.) -->
						<ul class="notice_hid">						<!-- 하유리: <p>태그의 클래스명 <ul>태그 클래스명으로 이동(23.07.31.) -->
							<%-- <c:forEach  var="i" begin="1" end="3" step="1"> --%>
							<li><p>
								<%-- <a href="${contextPath}/notice/list">[안내] 샐러드다이소 시스템 점검 안내${ i}</a> --%>
								<a href="${contextPath}/notice/content?articleNO=205">- 6월 서비스 점검 안내</a>						<!-- 하유리: 글 번호 수정(23.08.02.) -->
								</p></li>
								<li><p>
								<%-- <a href="${contextPath}/notice/list">[안내] 샐러드다이소 시스템 점검 안내${ i}</a> --%>
									<a href="${contextPath}/notice/content?articleNO=204">- 인스타 이벤트 당첨안내</a>
									</p></li>
								<li><p>
								<%-- <a href="${contextPath}/notice/list">[안내] 샐러드다이소 시스템 점검 안내${ i}</a> --%>
									<a href="${contextPath}/notice/content?articleNO=203">- 5월 배송 휴무 안내</a>
									</p></li>
									<%-- 	</c:forEach> --%>
						</ul>
				</li>
				<!-- </div> -->
				<!-- <br> -->			<!-- 하유리: <br> 제거(23.07.31.) -->

				<%-- <div class="clear"></div>
				<div id="banner">
					<a href="${contextPath}/event/eventPage"><img width="190" height="163" src="${contextPath}/resources/image/n-pay.jpg"> </a>
				</div><br> --%>
				<%-- <div id="banner">
					<a href="#"><img width="190" height="104" src="${contextPath}/resources/image/call_center_logo.jpg"></a>
				</div> --%>
  			</c:when>
		</c:choose>	
	</ul>
</nav><br>
</body>
</html>