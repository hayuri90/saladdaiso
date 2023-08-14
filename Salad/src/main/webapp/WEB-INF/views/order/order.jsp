<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="totalPrice" value="0"/> <!-- 총가격 변수 초기화 -->
<c:set var="shippingCost" value="3000"/> <!-- 배송비 변수 초기화 -->
<!DOCTYPE html>
<html>
<head>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <link href="resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="resources/css/footer.css" rel="stylesheet" type="text/css">
    <meta charset="UTF-8">
	<!-- 하유리: CSS 링크 수정(23.08.01.) -->
   	<link href="resources/css/header.css" rel="stylesheet" type="text/css">
   	<link href="resources/css/footer.css" rel="stylesheet" type="text/css">
   	<link href="resources/css/order/order.css" rel="stylesheet" type="text/css">
    <title>주문하기</title>
</head>
<body>
<main>
    <p class="p2">주문 / 결제</p>

	<!-- 하유리: 배송주소, 연락처, 요청사항 placeholder 띄어쓰기 수정(23.08.01.) -->
    <form action="${contextPath}/payment" method="post">
        <p class="h3">구매자 정보</p>
        <!-- <hr> -->								<!-- 하유리: 주석 처리(23.08.01.) -->
        <div class="info-block to">
            <div class="line">
                <div class="line-title"><label for="name">이름</label></div>
                <div class="line-content"><input type="text" name="username" id="username" value="${userVO.userName}"
                                                 required>
                    <input type="text" name="ordererName" value="${userVO.userName}" hidden>
                </div>
            </div>
            <div class="line">
                <div class="line-title"><label for="address">배송주소</label></div>
                <div class="line-content"><input type="text" name="useraddress" id="useraddress"
                                                 value="${userVO.userAddress1} ${userVO.userAddress2}" required>
                </div>
            </div>
            <div class="line">
                <div class="line-title"><label for="phoneNb">연락처</label></div>
                <div class="line-content"><input type="text" name="userphone" id="userphoneNb" maxlength="11"
                                                 value="${userVO.userPhone}" required>
                    <input type="text" name="ordererPhone" value="${userVO.userPhone}" hidden>
                </div>
            </div>
        </div>
        <p class="h3">받는 사람 정보  
              <button type="button" id="copyButton" class="info-setting">구매자정보와 동일</button>		<!-- 하유리: 텍스트 수정(23.08.01.) -->
        </p>
        <!-- <hr> -->								<!-- 하유리: 주석 처리(23.08.01.) -->
        <div class="info-block to">
            <div class="line">
                <div class="line-title"><label for="name">이름</label></div>
                <div class="line-content"><input type="text" name="destName" id="name" placeholder="받으실 분의 이름을 입력하세요"
                                                 required>
                </div>
            </div>
            <div class="line">
                <div class="line-title"><label for="address">배송주소</label></div>
                <div class="line-content"><input type="text" name="destLoc" id="address" placeholder="배송주소를 입력하세요"
                                                 required>
                </div>
            </div>
            <div class="line">
                <div class="line-title"><label for="phoneNb">연락처</label></div>
                <div class="line-content"><input type="text" name="destPhone" id="phoneNb" maxlength="11"
                                                 placeholder="'-' 없이 입력하세요" required>
                </div>
            </div>
            <div class="line">
                <div class="line-title"><label for="memo">배송시 요청사항</label></div>
                <div class="line-content"><input type="text" name="memo" id="memo" placeholder="요청사항을 입력해주세요" required autocomplete="none">		<!-- 하유리: 자동완성기능 끄기(23.08.02.) -->
                </div>
            </div>
        </div>
<p class="h3">결제 상품 목록</p>
<!-- <hr> -->								<!-- 하유리: 주석 처리(23.08.01.) -->
        <div class="item-box">
            <c:forEach items="${orderList}" var="cartList" varStatus="listStatus">
                <div class="info-block order-list">		<!-- 하유리: 클래스명 추가(23.08.01.) -->
                    <div class="line">
                        <div class="line-title">상품정보 </div>
                        <div class="line-content">상품명: <b>${cartList.prodName}</b></div>		<!-- 하유리: '상품명: ' 텍스트, <b> 추가(23.08.01.) -->
                            <%--                        <input type="text" value="${cartList.prodName}" name="" hidden>--%>
                        <div class="line-content">수량: <b>${cartList.cartCount}</b></div>			<!-- 하유리: '상품명: ' 텍스트, <b> 추가(23.08.01.) -->
                            <%--                        <input type="text" value="${cartList.cartCount}" hidden>--%>
                        <div class="line-content">상품가격: <b>${cartList.prodPrice}원</b></div>	<!-- 하유리: '상품명: ' 텍스트, <b>, '원' 추가(23.08.01.) -->
                            <%--                        <input type="text" value="${cartList.prodPrice}" hidden>--%>
                    </div>
                    <!-- 다른 속성들도 필요하면 여기에 추가 -->
                        <%-- cartList의 가격을 totalPrice에 더함 --%>
                    <c:set var="totalPrice" value="${totalPrice + (cartList.prodPrice * cartList.cartCount)}"/>

                    <%-- 장바구니에 담긴 상품 정보들 Controller로 전송 --%>
<%--                    <c:set var="CL_prodName${listStatus.index}" value="${cartList.prodName}"></c:set>--%>
                    <input type="text" name="CL_prodName${listStatus.index}" value="${cartList.prodName}" hidden>
<%--                    <c:set var="CL_cartCount${listStatus.index}" value="${cartList.cartCount}"></c:set>--%>
                    <input type="text" name="CL_cartCount${listStatus.index}" value="${cartList.cartCount}" hidden>
<%--                    <c:set var="CL_prodPrice${listStatus.index}" value="${cartList.prodPrice}"></c:set>--%>
                    <input type="text" name="CL_prodPrice${listStatus.index}" value="${cartList.prodPrice}" hidden>

                    <%-- 최대 반복수(listCount) Controller로 넘기기 --%>
                    <c:if test="${listStatus.last}">
                        <c:set var="listCount" value="${listStatus.index + 1}"></c:set>
                        <input type="text" name="listCount" value="${listCount}" hidden>
                    </c:if>
                </div>

            </c:forEach>
            <input type="text" value="${totalPrice + 3000}" name="totalPrice" hidden>
        </div>

        <p class="h3 pay-info">결제 정보</p>		<!-- 하유리: 클래스명 추가(23.08.01.) -->
        <!-- <hr> -->											<!-- 하유리: 주석 처리(23.08.01.) -->
        <div class="info-block">
            <div class="line">
                <div class="line-title">총상품가격</div>
                <div class="line-price"><fmt:formatNumber value="${totalPrice}" pattern="###,###원"/></div>
            </div>
            <div class="line">
                <div class="line-title">배송비</div>
                <div class="line-price">3,000원</div>
            </div>
            <div class="line">
                <div class="line-title">총결제금액</div>
                <div class="line-price" style="color: #d12420;"><fmt:formatNumber value="${totalPrice+shippingCost}"
                                                                  pattern="###,###원"/></div>	<!-- 하유리: 금액 폰트색 지정(23.07.31.) -->
            </div>									
            <div class="line">
                <div id="radioLine"class="line-title">결제방법</div>
                <div class="line-content">
                    <div class="line pay option">		<!-- 하유리: 클래스명 'option' 추가(23.08.01.) -->
                        <input type="radio" id="transfer" name="purchaseType" value="transfer" disabled>
                        <label class="radiolabel" for="transfer">계좌이체</label>

                        <input type="radio" id="credit-card" name="purchaseType" value="credit" checked>
                        <label class="radiolabel" for="credit-card">신용/체크카드</label>

                        <input type="radio" id="corporation-card" name="purchaseType" value="corporation" disabled>
                        <label class="radiolabel" for="corporation-card">법인카드</label>

                        <input type="radio" id="phone" name="purchaseType" value="phone" disabled>
                        <label class="radiolabel" for="phone">휴대폰</label>

                        <input type="radio" id="deposit-without-passbook" name="payment" value="depositWithout"
                               disabled>
                        <label class="radiolabel" for="deposit-without-passbook">무통장입금(가상계좌)</label>
                    </div>
                    <div class="line pay">
                            <div class="line-card">카드번호</div>
                        <div class="form-input">		<!-- 하유리: 카드번호 사이 '-', 자동완성 끄기 추가(23.08.01.) -->
                            <input type="text2" id="card" name="cardNum1" size="2" minlength="4" maxlength="4" required autocomplete='off'>-
                            <input type="text2" name="cardNum2" size="2" minlength="4" maxlength="4" required autocomplete='off'>-
                            <input type="text2" name="cardNum3" size="2" minlength="4" maxlength="4" required autocomplete='off'>-
                            <input type="text2" name="cardNum4" size="2" minlength="4" maxlength="4" required autocomplete='off'>
                        </div>
                        </div>
                        <div class="line pay">
                            <div class="line-card">유효기간</div>
                        
                        <div class="form-input">		<!-- 하유리: 자동완성 끄기 추가(23.08.01.) -->
                            <input type="text3" id="period" name="period1" size="2" minlength="2" maxlength="2" placeholder="mm" 
                                   required autocomplete='off'> /
                            <input type="text3" name="period2" size="2" minlength="2" maxlength="2" placeholder="yy" required autocomplete='off'>
                        </div>
                        </div>
                        <div class="line pay cvcNum">
                            <div id="CVC" class="line-card">CVC</div>
                        
                        <div class="form-input">		<!-- 하유리: 자동완성 끄기 추가(23.08.01.) -->
                            <input type="text4" id="cvc" name="cvc" minlength="3" maxlength="3" required placeholder="3자리" autocomplete='off'>
                        </div>
                        </div>
<%--                        <input type="submit" id="button" hidden>--%>
                    </div>
                </div>
            </div>
        </div>
        <input type="text" name="orderStatus" value="결제완료" hidden>

<%--        <label for="button">결제하기</label>--%>
        <input id="payment" type="submit" value="결제하기">
    </form>
</main>

<script>
    // 버튼 클릭 시 입력 내용 복사
    $('#copyButton').on('click', function () {
        var username = $('#username').val();
        var useraddress = $('#useraddress').val();
        var userphoneNb = $('#userphoneNb').val();
        // 원본 입력란의 내용을 가져와서 목적지 입력란에 설정합니다
        $('#name').val(username);
        $('#address').val(useraddress);
        $('#phoneNb').val(userphoneNb);

    });
</script>
</body>
</html>