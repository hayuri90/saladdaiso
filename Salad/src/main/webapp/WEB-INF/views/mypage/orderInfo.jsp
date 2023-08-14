<%-- jsp 기본 템플릿입니다. --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <link href="../../resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="../../resources/css/footer.css" rel="stylesheet" type="text/css">
    <link href="../../resources/css/mypage/orderInfo.css" rel="stylesheet" type="text/css">
    
    <!-- 사이드 css 맞추기 위해 추가로 넣음 23.07.30 서승희  -->
    <link href="../../resources/css/style.css" rel="stylesheet" type="text/css" >
	 <link href="../../resources/css/mypage/side.css" rel="stylesheet" type="text/css">
	 
    <%-- 폰트 적용 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Open+Sans:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <style>
        /* css 적용 부분 */
	/*.odl-container{    임시 */
        /* padding-top: 178px;    하유리: 헤더 영역만큼 아래로 내림(23.07.27.) */
   /*    .order-info-table{
      font-size:13px;
      } */
    </style>
    <title>주문 상세 정보</title>

</head>
<body>
    <div class="odl-container">
        <div class="odl-sub">
            <p class="odl-text1">주문정보</p>
        </div>
        <table class="order-info-table" align="center">
            <tr>
                <td class="order-info-td-title oi-border-top" colspan="1">주문번호</td>
                <td class="order-info-td" colspan="1"><input class="content_input" type="text" value="${orderInfo.fakeOrderNum}" disabled/>
                    </td>
            </tr>
            <tr>
                <td class="order-info-td-title">주문일자</td>
                <td class="order-info-td"><input class="content_input" type="text" value="${orderInfo.orderCreateTimestamp}" disabled/>
                    </td>

            </tr>
            <tr>
                <td class="order-info-td-title oi-border-top">배송 예정 일자</td>
                <td class="order-info-td"><input class="content_input" type="text" value="${orderInfo.prodDeliveryDate}" disabled/>
                    </td>
            </tr>
            <tr>
                <td class="order-info-td-title">주문자 이름</td>
                <td class="order-info-td"><input class="content_input" type="text" value="${orderInfo.ordererName}" disabled/>
                    </td>

            </tr>
            <tr>
                <td class="order-info-td-title">주문 상태</td>
                <td class="order-info-td"><input class="content_input" type="text" value="${orderInfo.orderStatus}" disabled/>
                    </td>
            </tr>
            <tr>
                <td class="order-info-td-title length">상품 목록</td>
                <td class="order-info-td" colspan="3">
                    <div class="order-info-menuList">
                        <c:forEach var="menuList" items="${infoMenuList}" varStatus="listStatus">

                            ${menuList.menuName} x ${menuList.menuCount} 개<br>
                        </c:forEach>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="order-info-td-title odl-last" colspan="2">
                    <c:if test="${orderInfo.orderStatus == '결제완료' and orderInfo.reviewStatus == 0}">
                        <button class="orderInfo-review-btn" data-orderNum="${orderNum}" onclick="redirectToReviewPage()">리뷰작성</button>
                    </c:if>
                </td>
            </tr>
        </table>

    </div>

<script>
    function redirectToReviewPage() {
        var orderNum = event.target.getAttribute('data-orderNum'); // orderNum 변수에 값을 할당 (서버에서 렌더링할 때 해당 값으로 대체됩니다.)
        const contextPath = '${contextPath}'; // contextPath 변수에 값을 할당 (서버에서 렌더링할 때 해당 값으로 대체됩니다.)
        const url = contextPath + '/review/insert?orderNum=' + orderNum; // URL에 orderNum 파라미터를 추가하여 완성

        // 리뷰 작성 페이지로 이동
        window.location.href = url;
    }
</script>
</body>
</html>
