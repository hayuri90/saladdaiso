<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <!-- 부트스트랩 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- CSS -->
    <link href="resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="resources/css/footer.css" rel="stylesheet" type="text/css">
    <link href="resources/css/event.css" rel="stylesheet" type="text/css">
</head>

<body>		
	<div class="event_sub">
		<p class="event_text1">EVENT</p>
	</div>
		
	<div class="eventBanner_wrap">
		<div class="margin">
			<div class="bannerRow">
				<div class="banner">
					<div class="banner_img">
						<img style="width: 300px" src="${contextPath}/resources/image/event/eventBanner9.png" alt="신규회원 무료배송 이벤트 이미지 배너" />
					</div>
					<div class="banner_content">
						<p class="content_sub">신규회원 무료배송 이벤트</p>
						<p class="content_brand">SALAD DAISO</p>		
					</div>
				</div>
				
				<div class="banner">
					<div class="banner_img">
						<img style="width: 300px" src="${contextPath}/resources/image/event/eventBanner8.png" alt="전품목 50% 할인 이벤트 배너"/>
					</div>
					<div class="banner_content">
						<p class="content_sub">전품목 50% 할인 이벤트 </p>	
						<p class="content_brand">SALAD DAISO</p>	
					</div>
				</div>
				
				<div class="banner">
					<div class="banner_img">
						<img class="" style="width: 300px" src="${contextPath}/resources/image/event/eventBanner7.png" alt="베스트리뷰 커피 증정 이벤트 배너" />
					</div>
					<div class="banner_content">
						<p class="content_sub">베스트리뷰 커피 증정 이벤트</p>
						<p class="content_brand">SALAD DAISO</p>
					</div>
				</div>
			</div>
				
			<div class="bannerRow">
				<div class="banner">
					<div class="banner_img">
						<img class="" style="width: 300px" src="${contextPath}/resources/image/event/eventBanner6.png" alt="여름쿠폰 증정 이벤트 배너" />
					</div>
					<div class="banner_content">	
						<p class="content_sub">여름쿠폰 증정 이벤트</p>
						<p class="content_brand">SALAD DAISO</p>		
					</div>
				</div>
					
				<div class="banner">
					<div class="banner_img">
						<img class="" style="width: 300px" src="${contextPath}/resources/image/event/eventBanner5.png" alt="인스타그램 인증 이벤트 당첨자발표 배너" />
					</div>
					<div class="banner_content">	
						<p class="content_sub">[당첨자발표] 인스타그램 인증 이벤트</p>
						<p class="content_brand">SALAD DAISO</p>		
					</div>
				</div>
				
				<div class="banner">
					<div class="banner_img">
						<img class="" style="width: 300px" src="${contextPath}/resources/image/event/eventBanner4.png" alt="인스타그램 인증샷 이벤트 배너" />
					</div>
					<div class="banner_content">	
						<p class="content_sub">인스타그램 인증샷 이벤트</p>
						<p class="content_brand">SALAD DAISO</p>		
					</div>
				</div>
			</div>
				
			<div class="bannerRow">
				<div class="banner">
					<div class="banner_img">
						<img class="" style="width: 300px" src="${contextPath}/resources/image/event/eventBanner3.png" alt="가정의 달 기획전 배너" />
					</div>
					<div class="banner_content">	
						<p class="content_sub">가정의 달 기획전</p>
						<p class="content_brand">SALAD DAISO</p>		
					</div>
				</div>
					
				<div class="banner">
					<div class="banner_img">
						<img class="" style="width: 300px" src="${contextPath}/resources/image/event/eventBanner2.png" alt="봄 세일 기획전 배너" />
					</div>
					<div class="banner_content">	
						<p class="content_sub">샐러드다이소 봄 세일 기획전</p>
						<p class="content_brand">SALAD DAISO</p>		
					</div>
				</div>
				
				<div class="banner">
					<div class="banner_img">
						<img class="" style="width: 300px" src="${contextPath}/resources/image/event/eventBanner1.png" alt="오픈기념 빅세일 배너" />
					</div>
					<div class="banner_content">	
						<p class="content_sub">샐러드다이소 오픈기념 빅세일</p>
						<p class="content_brand">SALAD DAISO</p>	
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>