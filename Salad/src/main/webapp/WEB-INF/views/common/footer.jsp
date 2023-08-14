<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%  request.setCharacterEncoding("UTF-8"); %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>하단 부분</title>
	<!-- css 적용 -->
	 <link href="resources/css/style.css" rel="stylesheet" type="text/css" >
	 <link href="resources/css/footer.css" rel="stylesheet" type="text/css" >
</head>

<body>
	<!-- 하유리: footer 전체적으로 수정(23.07.26.)(23.07.29.) -->
	<div class="footer_wrapper">
		<!-- 하유리: 로고 부분(23.07.29.) -->
		<div class="footer_logo">
			<img width="200px" src="${contextPath}/resources/image/common/footer/logo2.png"/>
		</div>
		
		<!-- 하유리: 회사 정보 부분(23.07.29.) -->
		<div class="footer_info">
			<ul class="company_terms">
				<li><a href="${contextPath}/terms"><b>이용약관</b></a>｜<li>
				<li><a href="${contextPath}/policy"><b>개인정보처리방침</b></a></li>
			</ul>
			<ul class="company_info">
				<li>상호: ㈜샐러드다이소｜대표: 홍길동</li>
				<li>주소: 대전광역시 광역시 계룡로 637 정일빌딩 7층
					  <a href="${contextPath}/map"><img width="18px" src="${contextPath}/resources/image/common/footer/magnifier.png"/></a>
				</li>
				<li>대표전화: 1234-1234｜이메일: shop@saladdaiso.co.k</li>
				<li>사업자등록번호: 123-45-67890</li>
			</ul>
			<p>Copyright <b>© saladdaiso Corp.</b> All rights Reserved</p>
		</div>
		
		<!-- 하유리: 메뉴 부분 추가(23.07.29.) -->
		<div class="footer_menu">
			<ul>
				<li><b>사이트맵</b></li>
			</ul>
			<ul class="siteMap">
				<li><a href="${contextPath}/menu">MENU</a></li>
				<li><a href="${contextPath}/review/list">REVIEW</a></li>
				<li><a href="${contextPath}/notice/list">NOTICE</a></li>
				<li><a href="${contextPath}/map">LOCATION</a></li>
				<li><a href="${contextPath}/event">EVENT</a></li>
			</ul>
		</div>
		
		<!-- 하유리: SNS 로고 부분(23.07.29.) -->
		<div class="footer_sns">
			<ul>
				<li><a href="#"><img width="18px" src="${contextPath}/resources/image/common/footer/instagram_logo.svg"/></a></li>
				<li><a href="#"><img width="20px" src="${contextPath}/resources/image/common/footer/youtube_logo.svg"/></a></li>
				<li><a href="#"><img width="12px" src="${contextPath}/resources/image/common/footer/facebook_logo.svg"/></a></li>
			</ul>
		</div>
	</div>
</body>
</html>