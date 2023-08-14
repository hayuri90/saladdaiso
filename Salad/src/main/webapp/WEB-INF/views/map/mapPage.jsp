<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%  request.setCharacterEncoding("UTF-8"); %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<meta charset="UTF-8">
  	<title>메인 페이지</title>
  	<script src="http://code.jquery.com/jquery-latest.js"></script>
  		<!-- 하유리: CSS 링크 수정(23.07.31.) -->
	<link href="resources/css/header.css" rel="stylesheet" type="text/css">
	<link href="resources/css/footer.css" rel="stylesheet" type="text/css">
	<link href="resources/css/map/mapPage.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div class="map_wrap">
		<!-- 하유리: 제목 -->
		<div class="map_sub">
			<p class="map_text">LOCATION</p>
		</div>
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
		
		<!-- 지도 -->
		<div class="map">
	    	<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1606.9516013539273!2d127.39177363581646!3d36.33889575396106!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3565495aa4f4a533%3A0x5cc2266528d5079e!2z7JWE7J207Yuw7Iqk7L-o7KCV67O067O07Zi46rWQ7Jyh7JuQ!5e0!3m2!1sko!2skr!4v1690480630851!5m2!1sko!2skr" 
	    	allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
	   	</div>
	   	<div>
	   		<span class="map_info_span">샐러드다이소 안내</span>
	   	</div>
	   	
	   	<!-- 안내사항 -->
	   	<div class="map_info">
		   	<ul class="flexBox">
				<li>
					<dl>
						<dt class="sTitle bullet">주소 / 전화번호</dt>
						<dd><strong>주소</strong> : (03087) 대전광역시 광역시 계룡로 637 정일빌딩 7층</dd>
						<dd><strong>전화</strong> : 042-123-1234</dd>
						<dd><strong>팩스</strong> : 042-123-4567</dd>
						<dd><strong>메일</strong> : saladdaiso@shop.co.kr</a></dd>
					</dl>
				</li>
				<!-- <li>
					<dl>
						<dt class="sTitle bullet">Contact</dt>
						<dd><strong>Address</strong> : 637, Gyeryong-ro, Seo-gu, Daejeon, Republic of Korea</dd>
						<dd><strong>For Enquiries</strong> : +82-42-123-1234</dd>
						<dd><strong>E-mail</strong> : saladdaiso@shop.co.kr</a></dd>
					</dl>
				</li> -->
				<li>
					<dl>
						<dt class="sTitle bullet">영업시간</dt>
						<dd class="sTitle_margin">월-금, 오전 09시–오후 06시(연휴, 공휴일 제외)</dd>
						<dt class="sTitle bullet">주차요금</dt>
						<dd>무료</dd>
					</dl>
				</li>
				<!-- <li>
					<dl>
						<dt class="sTitle bullet">Opening Hours</dt>
						<dd>Monday–Friday, 9am–6pm(Excluding holidays and holidays)</dd>
						<dt class="sTitle bullet">Parking fee</dt>
						<dd>Free</dd>
					</dl>
				</li> -->
			</ul>
		</div>
   </div>
</body>
</html>