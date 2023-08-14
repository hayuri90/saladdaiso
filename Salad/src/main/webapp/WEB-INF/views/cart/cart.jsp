<%-- jsp 기본 템플릿입니다. --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"   isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
	<%-- 폰트 적용 --%>
  	<link rel="preconnect" href="https://fonts.googleapis.com">
  	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Open+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

  	<script src="http://code.jquery.com/jquery-latest.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- 하유리: CSS 링크 수정(23.07.31.) -->
   	<link href="resources/css/header.css" rel="stylesheet" type="text/css">
   	<link href="resources/css/footer.css" rel="stylesheet" type="text/css">
   	<link rel="stylesheet" href="resources/css/cart/cart.css" type="text/css">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  	<!-- 하유리: <style> 태그 비어있어서 삭제(23.08.01.) -->
  	<title>장바구니</title>
</head>

<%-- JSP 김동혁 추가 (23-07-21) --%>
<body>
  <div class="body-container">
    <div class="cart-container">
      <h1 class="text-h1 cart-h1 cart-stuff">장바구니</h1>
      <div class="cart-box cart-stuff">
        <div class="cart-list">
          <ul class="cart-list-ul">
            <%-- 장바구니가 비어있을 경우 --%>
            <c:if test="${empty cartList}">
              <div id="cart-null-div">
                <span id="cart-null">장바구니가 비어있습니다.</span>
              </div>
            </c:if>
            <%-- 장바구니 테이블 목록 출력 --%>
            <c:forEach var="cart" items="${cartList}" varStatus="cartStatus" >
              <li class="cart-list-li">
                <img id="cart-image" src="${cart.prodImageUrl}${cart.prodImageName}" />
                <span class="cart-list-span">${cart.prodName}</span>
                <input type="number" class="cart-count" value="${cart.cartCount}" min="1" max="10">
                <input type="button" class="cart-list-del" data-cartnum="${cart.cartNum}" value="삭제">
                <!-- 장바구니 아이템의 가격(단가 * 수량)을 저장하는 hidden input 추가 -->
                <input type="hidden" class="cart-price" value="${cart.prodPrice}">
              </li>
            </c:forEach>
              <%-- 밑 코드는 임시 데이터 출력 --%>
<%--            <li class="cart-list-li">--%>
<%--              <span class="cart-list-span">테스트 장바구니 1</span>--%>
<%--              <input class="cart-count" type="number" value="1" min="1" max="10">--%>
<%--              <input class="cart-list-del" type="button" value="삭제">--%>
<%--            </li>--%>
<%--            <li class="cart-list-li">--%>
<%--              <span class="cart-list-span">테스트 물건 2</span>--%>
<%--              <input class="cart-count" type="number" value="1" min="1" max="10">--%>
<%--              <input class="cart-list-del" type="button" value="삭제">--%>
<%--            </li>--%>
          </ul>
        </div>
        <div class="cart-sum">
          <c:if test="${not empty cartList}">
            <div id="cart-sum-title cart-margin">
              <span>상품 가격</span>
              <span> + </span>
              <span>배송비</span>
              <span> = </span>
              <span>총 가격</span>
            </div>
          </c:if>

          <c:if test="${not empty cartList}">
            <div class="cart-sum-res cart-margin">
            <span>
              <c:set var="sum" value="0" scope="session"></c:set>
              <c:forEach var="cart" items="${cartList}" varStatus="cartStatus">
                <c:set var="sum" value="${sum + (cart.prodPrice * cart.cartCount)}" scope="session"></c:set>
              </c:forEach>
              <fmt:formatNumber value="${sum}" pattern="#,###" />
            </span>
              <span> + </span>
                <span>3,000</span>
              <span> = </span>
              <span>
              <fmt:formatNumber value="${sum + 2500}" pattern="#,###" /> 원
              </span>
            </div>
          </c:if>
          <c:if test="${empty cartList}">
            <div class="cart-sum-res cart-margin">
              <span hidden>0 원</span>
            </div>
          </c:if>
        </div>
      </div>

      <div class="order cart-stuff">
        <button onclick="location.href='${contextPath}/order'" class="button-order">
          주문하기
        </button>
      </div>

    </div>
  </div>

<script>
  /* Script 김동혁 추가(23.07.20) */
  $(document).ready(function () {
    let cartNum;

    // 장바구니 삭제 버튼 클릭시 Ajax
    $('.cart-list-del').on('click', function () {
      cartNum = $(this).data('cartnum');
      let listItem = $(this).closest('.cart-list-li'); // 클릭한 삭제 버튼이 속한 li 선택
      let cartPrice = parseInt(listItem.find('.cart-price').val()); // 해당 아이템의 가격

      // Ajax로 cartNum 보내기
      $.ajax({
        url: '${contextPath}/delCart',
        type: 'GET',
        data: {cartNum : cartNum},
        dataType: 'json',
        success: function (response) {
          // alert('삭제했습니다.');
          listItem.remove();
          updateCartTotal(); // 장바구니 가격 계산
        },
        error: function () {
          alert('삭제 실패했습니다.');
        }
      });
    });

    ////

    function updateCartTotal() {
      var sum = 0;

      // 각 장바구니 아이템의 정보를 순회하며 가격과 수량을 곱하여 총 가격 계산
      $(".cart-list-li").each(function() {
        var price = parseFloat($(this).find(".cart-price").val());
        var quantity = parseInt($(this).find(".cart-count").val());
        sum += price * quantity;
      });

      // 배송비 제외한 가격 추가
      $(".cart-sum-res span:first-child").text(sum.toLocaleString());

      // 배송비 추가 (여기서는 하드코딩으로 3000을 사용합니다.)
      // sum += $(".delivery-price").value;
      sum += 3000;

      // 총 가격 출력
      $(".cart-sum-res span:last-child").text(sum.toLocaleString() + " 원");
    }

    // 페이지 로드 시에도 초기 총 가격 계산
    updateCartTotal();

    // 장바구니 수량 버튼 클릭 이벤트 처리
    $(".cart-count").on("change", function() {
      // 수량이 변경되면 총 가격 업데이트
      updateCartTotal();

      let listItem = $(this).closest('.cart-list-li'); // 변경한 수량이 속한 li 선택
      let cartNum = listItem.find('.cart-list-del').data('cartnum'); // 해당 아이템의 cartNum
      let cartCount = $(this).val(); // 변경된 수량

      // Ajax로 cartNum과 변경된 수량(cartCount) 보내기
      $.ajax({
        url: '${contextPath}/updateCart',
        type: 'GET',
        data: { cartNum: cartNum, cartCount: cartCount },
        dataType: 'json',
        success: function (response) {
          // alert('수량이 변경되었습니다.');
        },
        error: function () {
          alert('수량 변경에 실패했습니다.');
        }
      });
    });

  });
</script>
</body>
</html>
