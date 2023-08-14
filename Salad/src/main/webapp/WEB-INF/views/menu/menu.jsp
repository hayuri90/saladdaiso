<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- css 적용 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- 하유리: CSS 링크 수정(23.07.31.) -->
    <link href="resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="resources/css/footer.css" rel="stylesheet" type="text/css">
    <link href="resources/css/menu.css" rel="stylesheet" type="text/css">
    <title>메뉴 고르기</title>

</head>
<body>
<div class="content1">
	<div class="menu_content">										<!-- 하유리: 제목 <div> 추가(23.07.29.) -->
    	<h1 class="menu-h1">MENU</h1>						<!-- 하유리: 텍스트 수정(23.07.29.) -->
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
	
    <%-- 김동혁 수정 ( 리스트 출력 )(23.07.14.)--%>
    <div class="listBox">
        <c:forEach var="prod" items="${prodList}" varStatus="prodNum">
        <c:if test="${prodNum.index >= 0 && prodNum.index <= 8 || prodNum.index >= 9 && prodNum.index <= 11}">
            <%-- 채소 타이틀 출력 --%>
            <c:if test="${prodNum.index == 0}">
                <h2 class="menu-h2">#채소</h2>				<!-- 하유리: 텍스트 수정(23.07.29.) -->
            </c:if>
            <%-- 육류 타이틀 출력 --%>
            <c:if test="${prodNum.index == 9}">
                <h2 class="menu-h3">#육류</h2>				<!-- 하유리: 텍스트, 클래스명 수정(23.07.29.) -->
            </c:if>
            <c:if test="${prodNum.index mod 3 == 0}">		
                <br>
            </c:if>
            <button type="button" class="prodBox modal-nutrient" data-prodnum="${prodNum.index}" data-toggle="modal" data-target="#myModal">
                <div class="prodP">
                    <div class="prodP_imgBox">
                        <img class="prodP_img" src="${prod.prodImageUrl}${prod.prodImageName}"/>
                    </div>
                    <div class="prodTextBox">
                        <p class="prodPText">${prod.prodName}</p>
                        <p class="prodPText"> ₩ ${prod.prodPrice}</p>
                    </div>
                    <div class="prodModalBox">
                        <!-- 모달 버튼 / 김동혁 추가 (23.07.18) -->

                    </div>
                    <!-- <div class="prodAddCart prodListBox">
                        <button type="button" class="btn btn-primary">
                            추가
                        </button>
                    </div> -->
                </div>
            </button>
            </c:if>
        </c:forEach>
    </div>
</div>

<!-- 모달 / 김동혁 추가 (23.07.18) -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">영양 정보</h4>
            </div>
            <div class="modal-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th>영양소</th>
                        <th>단위</th>
                        <!-- 필요한 만큼 열을 추가하세요 -->
                    </tr>
                    </thead>
                    <tbody id="dataBody">
                    <!-- DB 조회 결과를 동적으로 추가할 위치입니다 -->
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <select name="prod-count" id="prod-count">
                    <option value="default">-- 수량선택 --</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>
                <button type="button" class="btn btn-default" data-dismiss="modal" id="modal-addcart">장바구니 담기</button>	<!-- 하유리: 텍스트 수정(23.07.27.) -->          
                <button type="button" class="btn btn-default" data-dismiss="modal" id="modal-close">닫기</button>
            </div>
        </div>
    </div>
</div> <%-- 모달 end --%>

<script>
    /* 모달 Ajax 스크립트 / 김동혁 추가 (23.07.18) */
    $(document).ready(function() {
        let selectedProdNum;

        // 모달 버튼 클릭시 값 대입
        $('.modal-nutrient').on('click', function() {
            selectedProdNum = $(this).data('prodnum') + 1;
        });

        $('#modal-addcart').on('click', function() {
            var prodCount = $('#prod-count').val();

            $.ajax({
                url: '${contextPath}/addCart',
                type: 'POST',
                data: {prodNum : selectedProdNum, cartCount : prodCount},
                dataType: 'json',
                success: function (response) {
                    alert('장바구니에 담았습니다.');
                },
                error: function () {
                    alert('비회원 상태입니다.\n로그인 창으로 넘어갑니다.');
                    location.href = '${contextPath}/user/loginForm.do';
                }
            });
        });

        $('#modal-close').on('click', function () {
           var dataBody = $('#dataBody');
           dataBody.empty();
           var prodCount = $('#prod-count');
           prodCount.val('default');
        });

        $('#myModal').on('hidden.bs.modal', function () {
            var dataBody = $('#dataBody');
            dataBody.empty();
            var prodCount = $('#prod-count');
            prodCount.val('default');
        });

        // 모달이 열릴 때 Ajax 요청을 보내서 DB 조회 결과를 가져옵니다.
        $('#myModal').on('shown.bs.modal', function() {
            // let prodNum = $(this).data('prodnum');
            console.log(selectedProdNum);

            $.ajax({
                url: '${contextPath}/detail',
                type: 'GET',
                data: {prodNum : selectedProdNum},
                dataType: 'json',
                success: function(response) {
                    var dataBody = $('#dataBody');
                    dataBody.empty();

                    // DB 조회 결과를 테이블에 동적으로 추가합니다.
                    // for (var i = 0; i < response.length; i++) {
                    //     var row = $('<tr>');
                    //     row.append($('<td>').text(response[i].column1));
                    //     row.append($('<td>').text(response[i].prodNum));
                    //     // 필요한 만큼 열을 추가하세요
                    //
                    //     dataBody.append(row);
                    // }

                    // 영양소 테이블 출력
                    for(var i = 0; i < 7; i++) {
                        var row = $('<tr>');
                        if(i == 0) {
                            row.append($('<td>').text('칼로리'));
                            row.append($('<td>').text(response.kcal));
                        } else if(i == 1) {
                            row.append($('<td>').text('탄수화물'));
                            row.append($('<td>').text(response.carbohydrates));
                        } else if(i == 2) {
                            row.append($('<td>').text('당'));
                            row.append($('<td>').text(response.sugar));
                        } else if(i == 3) {
                            row.append($('<td>').text('단백질'));
                            row.append($('<td>').text(response.protein));
                        } else if(i == 4) {
                            row.append($('<td>').text('지방'));
                            row.append($('<td>').text(response.fat));
                        } else if(i == 5) {
                            row.append($('<td>').text('포화지방'));
                            row.append($('<td>').text(response.saturated_fat));
                        } else if(i == 6) {
                            row.append($('<td>').text('나트륨'));
                            row.append($('<td>').text(response.natrium));
                        }
                        dataBody.append(row);
                    }
                },
                error: function() {
                    alert('DB 조회에 실패했습니다.');
                }
            });
        });
    });
</script>
</body>
</html>