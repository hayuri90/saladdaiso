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
    <link href="../resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="../resources/css/footer.css" rel="stylesheet" type="text/css">
    <link href="../resources/css/mypage/orderList.css" rel="stylesheet" type="text/css">

    <%-- 폰트 적용 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Open+Sans:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <style>
        /* css 적용 부분 */

    </style>
    <title>주문 내역</title>

</head>
<body>
<%--<h1 class="test-h1">테스트!!</h1>--%>
<div class="odl-container">
    <p class="odl_sub">#나의 주문내역</p>					<!-- 하유리: 제목 추가(23.07.31.) -->
    <!-- <div class="odl-box"> -->			<!-- 하유리: 주석 처리(23.07.31.) -->

    <%--<div class="odl-1box">
        <div>

            <c:if test="${orderNum != list.orderNum}">
            <div id="odl-underbar"></div>
                ${list.orderNum}
        </div>
        <div>
            </c:if>
            <c:set var="orderNum" value="${list.orderNum}"/>

                ${list.menuName}
                <%-- 테스트 --%>
    <!-- </div> -->									<!-- 하유리: 주석 처리(23.07.31.) -->
    <!-- </div> -->										<!-- 하유리: 주석 처리(23.07.31.) -->

    <table class="odl-table">						<!-- 하유리: border="1" 삭제(23.07.31.) -->
        <th class="odl-table-th" width="15%">주문일자</th>
        <th class="odl-table-th" width="20%">주문번호</th>
        <th class="odl-table-th" width="13%">주문자이름</th>
        <th class="odl-table-th" width="13%">결제금액</th>
        <th class="odl-table-th" width="13%">주문상태</th>
        <th class="odl-table-th" width="13%">주문수정</th>
        <th class="odl-table-th" width="13%">리뷰작성</th>

        <c:forEach var="list" items="${orderList}" varStatus="listStatus">
            <tr>
                <td class="odl-table-td">${list.orderCreateTimestamp}</td>
                <td class="odl-table-td odl-td-pointer" onclick="location.href='${contextPath}/mypage/orderInfo/${list.orderNum}'">${list.fakeOrderNum}</td>
                <td class="odl-table-td">${list.ordererName}</td>
                <td class="odl-table-td old-td-price"><fmt:formatNumber value="${list.totalPrice}" pattern="#,###" />원</td>				<!-- 하유리: '원' 앞에 공백 삭제, class명 추가(23.07.31.) -->
                <td class="odl-table-td">
                    <!-- 하유리: 상태에 따라 폰트 색상 지정(23.07.31.) -->
                    <c:if test="${list.orderStatus == '결제완료'}">${list.orderStatus}</c:if>
                    <c:if test="${list.orderStatus == '취소완료'}"><p class="orderStatus">${list.orderStatus}</p></c:if>
                </td>
                <td class="odl-table-td">
                    <c:if test="${list.orderStatus == '결제완료' and list.reviewStatus == 0}">
                        <button class="odl-table-del" onclick="showConfirmation('${list.orderNum}')">주문취소</button>
                    </c:if>
                </td>
                <td class="odl-table-td">
                    <c:if test="${list.orderStatus == '결제완료'}">
                        <c:set var="orderNum" value="${list.orderNum}"/>
                        <c:if test="${list.reviewStatus == 0}">
                            <button class="odl-table-del" data-orderNum="${orderNum}" onclick="redirectToReviewPage()">리뷰작성</button>
                        </c:if>
                        <c:if test="${list.reviewStatus == 1}">
                            <button class="odl-table-review-done" data-orderNum="${orderNum}" onclick="redirectToReviewPage()" disabled>작성완료</button>
                        </c:if>
                    </c:if>
                </td>		<!-- 하유리: <td> 추가(23.07.31.) -->
            </tr>
        </c:forEach>
    </table><br>
    <!-- </div> -->	<!-- 하유리: 주석 처리(23.07.31.) -->
    <%--    <div class="odl-box2">--%>

    <%--    </div>--%>
</div>

<%-- 스크립트 --%>
<script>
    /* 주문 취소 버튼 스크립트 - 김동혁 추가(23.07.27) */
    function showConfirmation(orderNum) {
        // 주문수정 버튼을 눌렀을 때 실행될 함수
        var confirmation = confirm("주문번호 " + orderNum + "를 취소하시겠습니까?");

        if (confirmation) {
            // 사용자가 확인을 눌렀을 경우
            // 여기에 주문 취소 처리를 위한 Ajax 요청 또는 다른 로직을 추가할 수 있습니다.
            // alert("주문이 취소되었습니다.");

            $.ajax({
                type: "POST", // 또는 "GET" 등 HTTP 요청 방식을 선택합니다.
                url: "${contextPath}/mypage/cancelOrder", // 주문 취소를 처리할 서버의 URL을 입력합니다.
                data: {orderNum: orderNum}, // 주문 번호를 서버에 전달합니다.
                success: function (aaa) {
                    alert("주문이 취소되었습니다.");
                    location.href = "${contextPath}/mypage/orderList";
                    // 주문이 취소된 후 필요한 작업을 수행할 수 있습니다.
                    // 예를 들어, 주문 목록을 다시 로드하거나 특정 요소를 업데이트할 수 있습니다.
                },
                error: function (bbb) {
                    alert("주문 취소에 실패했습니다. 다시 시도해주세요.");
                }
            });
        } else {
            // 사용자가 취소를 눌렀을 경우
            // alert("주문 취소가 취소되었습니다.");
        }
    }

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
