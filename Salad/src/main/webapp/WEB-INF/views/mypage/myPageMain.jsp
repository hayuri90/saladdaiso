<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<!-- 폰트 적용 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Open+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
    <!-- CSS -->
 	<link href="../resources/css/header.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/footer.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/mypage/myPageMain.css" rel="stylesheet" type="text/css" >
</head>

<body>
	<div class="mymain_total">
		<div class="myinfo_container">
			<h1 class="myinfo">#나의 정보</h1><br>
			<table class="myinfo_table">
		  		<tr>
		  			<td class="myinfo_td_title">이름</td>
		    		<td class="myinfo_td"><strong>${user.userName}</strong></td>
		    	</tr>
		    	<tr>
		    		<td class="myinfo_td_title">이메일</td>
		    		<td class="myinfo_td"><strong>${user.userEmail}</strong></td>
		   		</tr>
		   		<tr>
		    		<td class="myinfo_td_title">연락처</td>
		    		<td class="myinfo_td"><strong>${user.userPhone }</strong></td>
		   		</tr>
		   		<tr>
		    		<td class="myinfo_td_title lastRow">주소지</td>
		    		<td class="myinfo_td lastRow">
				 		기본 주소:&nbsp;&nbsp;<strong>${user.userAddress1 }</strong><br>
				 		상세 주소:&nbsp;&nbsp;<strong>${user.userAddress2 }</strong> 
		   			</td>
		   		</tr>
			</table>
		</div>
	
		<div class="new_order_container">
		<h1 class="new_order">#최근주문내역</h1>
			<form method="post" id="orderhis_Form">
				<table>
					<tbody>
						<tr>
							<td class="my_a">
								<a href="javascript:search_order_history('today')"> 
									<img src="${contextPath}/resources/image/search/btn_search_one_day.jpg">
								</a> 
								<a href="javascript:search_order_history('three_day')"> 
									<img src="${contextPath}/resources/image/search/btn_search_3_day.jpg">
								</a> 
								<a href="javascript:search_order_history('one_week')"> 
									<img src="${contextPath}/resources/image/search/btn_search_1_week.jpg">
								</a> 
								<a href="javascript:search_order_history('one_month')"> 
									<img src="${contextPath}/resources/image/search/btn_search_1_month.jpg">
								</a> 
								<a href="javascript:search_order_history('three_month')"> 
									<img src="${contextPath}/resources/image/search/btn_search_3_month.jpg">
								</a> 
								<a href="javascript:search_order_history('six_month')"> 
									<img src="${contextPath}/resources/image/search/btn_search_6_month.jpg">
								</a> 
							<!-- &nbsp;까지 조회 -->
							</td>
						</tr>
						<br>
					</tbody>
				</table>
			</form>
			<table class="list_order_view">
				<tbody align="center" >
					<tr style="background:lightgray" >
						<td class="list_order_title"   width="120px">주문일자</td>
						<td class="list_order_title"  width="120px">주문번호</td>
						<!-- <td  width="120px">주문상품/수량</td> -->
						<td class="list_order_title"  width="120px">주문자</td>
						<td class="list_order_title"  width="120px">주문가격</td>
						<td class="list_order_title"  width="120px">주문상태</td>
						<td class="list_order_title"  width="120px">주문취소</td>
					</tr>
					<%-- 주문내역이 비어있을 경우 --%>
					<c:choose>
						<c:when test="${ empty myOrderHistList }">
							<tr>
							    <td colspan=6 class="fixed" align="center"> <!-- 23.08.01 colspan 수정 -->
									  <strong>주문한 상품이 없습니다.</strong>
							    </td>
						  	</tr>
				        </c:when>
				        <%-- 주문 테이블 목록 출력 --%>
				        <c:otherwise>
				        	<c:forEach var="item" items="${myOrderHistList }"  varStatus="i">
						        <tr>
						        	<td class="my_page_td">${item.orderCreateTimestamp}</td>
									<td class="my_page_td td-bold"><a href='${contextPath}/mypage/orderInfo/${item.orderNum}'>${item.fakeOrderNum } </a> </td>
					               	<td class="my_page_td">${item.ordererName}</td>
					               	<td class="my_page_td"><p class="my_page_price"><fmt:formatNumber value="${item.totalPrice}" pattern="#,###" /> 원</p></td>
					               	<td class="my_page_td">
					                	<c:if test="${item.orderStatus == '결제완료'}">${item.orderStatus}</c:if>
					                	<c:if test="${item.orderStatus == '취소완료'}"><p class=" my_page_td_cancel">${item.orderStatus}</p></c:if>
					               	</td>
					               	<td class="my_page_td">
					               		<c:if test="${item.orderStatus=='결제완료'}">
					          				<input type="button" class="my_page_cancel" onclick="fn_cancel_order('${item.orderNum}')" value="주문취소"/>
					                    </c:if>
					                </td>
					          	</tr>
				         	</c:forEach>
					  	</c:otherwise>
				    </c:choose> 	   
				</tbody>
			</table>
		</div>
	</div>
	
	<!-- 주문취소 -->
	<c:if test="${message=='cancel_order'}">
		<script>
			window.onload=function(){
		  		init();
			}
		
			function init(){
				alert("주문을 취소했습니다.");  // 사용자가 주문 취소를 눌렀을 경우
			}
		</script>
	</c:if>

	<script>
		//주문취소
		function fn_cancel_order(orderNum){
			var answer=confirm("주문을 취소하시겠습니까?");
			if(answer==true){
				var formObj=document.createElement("form");
				var i_orderNum = document.createElement("input"); 
			    
				i_orderNum.name="orderNum";
				i_orderNum.value=orderNum;
				
			    formObj.appendChild(i_orderNum);
			    document.body.appendChild(formObj); 
			    formObj.method="post";
			    formObj.action="${contextPath}/mypage/cancelMyOrder.do";
			    formObj.submit();	
			}
		}
		
		//주문검색일자
		function search_order_history(fixedSearchPeriod) {
			var formObj = document.createElement("form");
			var i_fixedSearch_period = document.createElement("input");
			
			i_fixedSearch_period.name = "fixedSearchPeriod";
			i_fixedSearch_period.value = fixedSearchPeriod;
			
			formObj.appendChild(i_fixedSearch_period);
			document.body.appendChild(formObj);
			formObj.method = "get";
			formObj.action = "${contextPath}/mypage/myPageMain.do";
			formObj.submit();
		}
	</script>
</body>
</html>