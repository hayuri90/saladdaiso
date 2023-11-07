<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%  request.setCharacterEncoding("UTF-8"); %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  	<!-- CSS -->
	<link href="resources/css/header.css" rel="stylesheet" type="text/css" >
	<link href="resources/css/footer.css" rel="stylesheet" type="text/css" >
	<link href="resources/css/main.css" rel="stylesheet" type="text/css" >
  	<title>메인 페이지</title>	
</head>

<body>
	<!-- 하유리: 슬라이드 배너(23.07.14.) -->
	<div class="section">
		<input type="radio" name="slide" id="slide1" checked>
		<input type="radio" name="slide" id="slide2">
		<input type="radio" name="slide" id="slide3">
		<div class="slideWrap">
			<ul class="slideBannerList">
				<!-- 하유리: 이미지 간 간격을 없애기 위해 </li>사용하지 않음 -->
				<li><img class="slideBanner" src="${contextPath}/resources/image/main/slideBanner1.png" alt="메인배너1: 내입에 딱맞는 샐러드 조합 찾기"/>
				<li><img class="slideBanner" src="${contextPath}/resources/image/main/slideBanner2.png" alt="메인배너2: 당일주문, 당일생산 원칙 준수"/>
				<li><img class="slideBanner" src="${contextPath}/resources/image/main/slideBanner3.png" alt="메인배너3: 샐러드 체험단 모집 배너"/>
			</ul>
			<div class="slideControl">	<!-- 슬라이드배너 이동 -->
				<div class="control1">	<!-- label for="input의 id값"으로 input-label 연결 > label 안의 이미지 클릭 시 input이 체크됨  -->
					<label for="slide3" class="left"></label>
					<label for="slide2" class="right"></label>
				</div>
				<div class="control2">
					<label for="slide1" class="left"></label>
					<label for="slide3" class="right"></label>
				</div>
				<div class="control3">
					<label for="slide2" class="left"></label>
					<label for="slide1" class="right"></label>
				</div>
			</div>
		</div>
	</div>
	<div class="content1">
		<!-- 광고(23.08.11.) -->
		<div class="ad">
			<a href="${contextPath}/event">
				<img class="ad_img" src="${contextPath}/resources/image/common/side/ad.png" alt="오늘의 이벤트 슬라이드 광고"/>
			</a>
			<div class="ad_div">
				<a href="${contextPath }/menu"><p>구매하기</p></a>
				<a href="${contextPath }/notice/list"><p style="border-top: 1px solid #e2e2e2;">공지확인</p></a>
			</div>
		</div>
	
		<!-- 김동혁: 리스트 출력(23.07.14.)-->
		<div class="mainProd_wrap">
			<div class="margin">
				<!-- 1번째 열 -->
				<h3 class="prod_sub" style="padding-left: 99px;">판매량이 증명하는 추천상품🏆️</h3><br>
				<div class="prodRow" style="padding-left: 97px;">		
					<!-- 추천상품01 -->
					<div class="prod" name="13">
						<div class="prod_img">		<!-- 추천상품01 이미지 -->
							<img src="${contextPath}/resources/image/main/main_prod01.png" alt="닭가슴살, 옥수수"/>
						</div>
						<div class="prod_content">	<!-- 추천상품01 이름 -->
							<p class="prod_content_sub">닭가슴살 옥수수 톡톡 샐러드</p>
							<div>																			
								<span class="content_discount">20%</span>			
								<span class="content_price">₩11,900</span>									
							</div>																			
							<div class="content_cost">						
								<span>₩14,280</span>											
							</div>
						</div>
						<div class="mainBtn">
							<img class="wishBtn" src="${contextPath}/resources/image/main/cart.png" alt="장바구니 담기 버튼" />
							<p class="addToCart">담기</p>
						</div>
					</div>
					
					<!-- 추천상품02 -->
					<div class="prod" name="14">
						<div class="prod_img">		<!-- 추천상품02 이미지 -->
							<img src="${contextPath}/resources/image/main/main_prod04.png" alt="계란, 칠리빈" />
						</div>
						<div class="prod_content">	<!-- 추천상품02 이름 -->
							<p class="prod_content_sub">단백질+단백질 샐러드</p>
							<div>																			
								<span class="content_discount">20%</span>			
								<span class="content_price">₩11,900</span>									
							</div>																			
							<div class="content_cost">						
								<span>₩14,280</span>											
							</div>
						</div>
						<div class="mainBtn">
							<img class="wishBtn" src="${contextPath}/resources/image/main/cart.png" alt="장바구니 담기 버튼"/>
							<p class="addToCart">담기</p>
						</div>
					</div>
					
					<!-- 추천상품03 -->
					<div class="prod" name="15">
						<div class="prod_img">		<!-- 추천상품03 이미지 -->
							<img src="${contextPath}/resources/image/main/main_prod06.png" alt="칠리빈, 두부" />
						</div>
						<div class="prod_content">	<!-- 추천상품03 이름 -->
							<p class="prod_content_sub">칠리빈 두부샐러드</p>
							<div>																			
								<span class="content_discount">20%</span>			
								<span class="content_price">₩11,900</span>									
							</div>																			
							<div class="content_cost">						
								<span>₩14,280</span>											
							</div>
						</div>
						<div class="mainBtn">
							<img class="wishBtn" src="${contextPath}/resources/image/main/cart.png" alt="장바구니 담기 버튼" />
							<p class="addToCart">담기</p>
						</div>
					</div>
				</div>
				
				<!-- 2번째 열 -->
				<h3 class="prod_sub padding">단백질 듬뿍! 닭가슴살 샐러드🐔</h3><br>
				<div class="prodRow">
					<!-- 추천상품04 -->
					<div class="prod" name="16">
						<div class="prod_img">		<!-- 추천상품04 이미지 -->
							<img src="${contextPath}/resources/image/main/main_prod02.png" alt="닭가슴살, 토마토" />
						</div>
						<div class="prod_content">	<!-- 추천상품04 이름 -->
							<p class="prod_content_sub">훈제 닭가슴살 토마토 샐러드</p>
							<div>																			
								<span class="content_discount">20%</span>			
								<span class="content_price">₩11,900</span>									
							</div>																			
							<div class="content_cost">						
								<span>₩14,280</span>											
							</div>
						</div>
						<div class="mainBtn">
							<img class="wishBtn" src="${contextPath}/resources/image/main/cart.png" alt="장바구니 담기 버튼" />
							<p class="addToCart">담기</p>
						</div>
					</div>
					
					<!-- 추천상품05 -->
					<div class="prod" name="17">
						<div class="prod_img">		<!-- 추천상품05 이미지 -->
							<img src="${contextPath}/resources/image/main/main_prod09.png" alt="닭가슴살, 계란" />
						</div>
						<div class="prod_content">	<!-- 추천상품05 이름 -->
							<p class="prod_content_sub">닭가슴살 에그 샐러드</p>
							<div>																			
								<span class="content_discount">20%</span>			
								<span class="content_price">₩11,900</span>									
							</div>																			
							<div class="content_cost">						
								<span>₩14,280</span>											
							</div>
						</div>
						<div class="mainBtn">
							<img class="wishBtn" src="${contextPath}/resources/image/main/cart.png" alt="장바구니 담기 버튼" />
							<p class="addToCart">담기</p>
						</div>
					</div>				
					
					<!-- 추천상품06 -->
					<div class="prod" name="18">
						<div class="prod_img">		<!-- 추천상품06 이미지 -->
							<img src="${contextPath}/resources/image/main/main_prod03.png" alt="닭가슴살, 두부" />
						</div>
						<div class="prod_content">	<!-- 추천상품06 이름 -->
							<p class="prod_content_sub">닭가슴살 두부 샐러드</p>
							<div>																			
								<span class="content_discount">20%</span>			
								<span class="content_price">₩11,900</span>									
							</div>																			
							<div class="content_cost">						
								<span>₩14,280</span>											
							</div>		
						</div>
						<div class="mainBtn">
							<img class="wishBtn" src="${contextPath}/resources/image/main/cart.png" alt="장바구니 담기 버튼" />
							<p class="addToCart">담기</p>
						</div>
					</div>
				</div>
				
				<!-- 3번째 열 -->
				<h3 class="prod_sub padding">색다른 샐러드를 원한다면?🥦</h3><br>
				<div class="prodRow">
					<!-- 추천상품07 -->
					<div class="prod" name="19">
						<div class="prod_img">		<!-- 추천상품07 이미지 -->
							<img src="${contextPath}/resources/image/main/main_prod07.png" alt="계란, 베이컨" />
						</div>
						<div class="prod_content">	<!-- 추천상품07 이름 -->
							<p class="prod_content_sub">에그베이컨 샐러드</p>
							<div>																				
								<span class="content_discount">20%</span>			
								<span class="content_price">₩11,900</span>									
							</div>
							<div class="content_cost">
								<span>₩14,280</span>											
							</div>
						</div>
						<div class="mainBtn">
							<img class="wishBtn" src="${contextPath}/resources/image/main/cart.png" alt="장바구니 담기 버튼" />
							<p class="addToCart">담기</p>
						</div>
					</div>
					
					<!-- 추천상품08 -->
					<div class="prod" name="20">
						<div class="prod_img">		<!-- 추천상품08 이미지 -->
							<img src="${contextPath}/resources/image/main/main_prod08.png" alt="새우, 토마토" />
						</div>
						
						<div class="prod_content">	<!-- 추천상품08 이름 -->
							<p class="prod_content_sub">새우 듬뿍 쉬림프 샐러드</p>
							<div>																			
								<span class="content_discount">20%</span>			
								<span class="content_price">₩11,900</span>									
							</div>																			
							<div class="content_cost">						
								<span>₩14,280</span>											
							</div>
						</div>
						<div class="mainBtn">
							<img class="wishBtn" src="${contextPath}/resources/image/main/cart.png" alt="장바구니 담기 버튼" />
							<p class="addToCart">담기</p>
						</div>
					</div>
					
					<!-- 추천상품09 -->
					<div class="prod" name="21">
						<div class="prod_img">		<!-- 추천상품09 이미지 -->
							<img src="${contextPath}/resources/image/main/main_prod05.png" alt="훈제연어, 오이, 올리브" />
						</div>
						<div class="prod_content">	<!-- 추천상품09 이름 -->
							<p class="prod_content_sub">훈제연어 샐러드</p>
							<div>																			
								<span class="content_discount">20%</span>			
								<span class="content_price">₩11,900</span>									
							</div>																			
							<div class="content_cost">						
								<span>₩14,280</span>											
							</div>
						</div>
						<div class="mainBtn">
							<img class="wishBtn" src="${contextPath}/resources/image/main/cart.png" alt="장바구니 담기 버튼" />
							<p class="addToCart">담기</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	    $(document).ready(function () {
	        $(".mainBtn").on("click", function () {
	            var prodName = $(this).closest(".prod").attr("name");
	            $.ajax({
	                url: '${contextPath}/mainAddCart',
	                type: "post",
	                data: { prodNum: prodName },
	                success: function (response) {
	                    if (response === "success") {
	                        alert("장바구니에 성공적으로 담았습니다.");
	                    } else if (response === "login_fail") {
	                    	alert('비회원 상태입니다.\n로그인 창으로 넘어갑니다.');
	                        location.href = '${contextPath}/user/loginForm.do';
	                    } else {
	                        alert("담기 실패");
	                    }
	                },
	                error: function () {
	                	alert('비회원 상태입니다.\n로그인 창으로 넘어갑니다.');
	                    location.href = '${contextPath}/user/loginForm.do';
	                }
	            });
	        });
	    });
	</script>
</body>
</html>