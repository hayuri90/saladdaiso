<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- 날짜 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<!-- CSS -->
    <link href="../resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="../resources/css/footer.css" rel="stylesheet" type="text/css">
	<link href="../resources/css/review.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div class="review_sub">
		<p class="review_text">REVIEW</p>
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
	
	<!-- 게시판 -->
	<div class="container mt-3">
		<!-- 검색(23.08.29.) -->
		<div class="search">
			<div class="search-form">
				<select class="searchType" name="searchType">
					<option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
					<option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
					<option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
					<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
				</select>
				<input type="text" class="search-bar" id="keywordInput" name="keyword" placeholder="검색" autocomplete="off" value="${scri.keyword}"/>	
				<button type="submit" class="search-btn" value=""><img src="${contextPath}/resources/image/common/footer/magnifier.png"/></button>	<!-- button태그로 변경, value값 제거, 이미지 추가(23.08.11.) -->			
			</div>
		</div>
		<table class="table table-hover">
			<thead class="table_tread" style="text-align: center;">
	    		<tr style="border-top: 1px solid #000; border-bottom: 1px solid #000;"> 
					<th scope="col" width="15%">글 번호</th>
			      	<th scope="col" width="41%">제목</th>
			      	<th scope="col" width="16%">작성자</th>
			      	<th scope="col" width="15%">작성일</th>
			      	<th scope="col" width="15%">조회수</th>
			    </tr>
	  		</thead>
	  		<tbody>
		  		<c:choose>
					<c:when test="${!empty reviewList}">
						<c:forEach items="${reviewList }" var="review" varStatus="reviewStatus">
				    		<tr>
				    			<!-- 글 번호 -->
				    			<th scope="row">
									<span>${review.re_articleNO }</span>
				    			</th>
				    			<!-- 글 제목 -->
				    			<td class="re_title" align="left">
					    			<c:choose>					    				
					    				<c:when test="${review.level>1 }"> <!-- 답변 표시 -->
					    					<c:forEach begin="1" end="${review.level }" step="2">
					    						<span style="padding-left: 25px"></span>
					    					</c:forEach>
					    					<span style="font-size:15px; color:#128853;">➥</span>
					    					<a href="${contextPath}/review/content?re_articleNO=${review.re_articleNO }"><c:out value="${review.re_title}" /></a>
					    				</c:when>
										<c:otherwise> <!-- 최신글 표시 -->
										    <c:set var="now" value="<%=new java.util.Date()%>" /><!-- 현재시간 -->
										    <c:set var="oneDayMillis" value="86400000" /><!-- 1일을 밀리초로 변환 -->
										
										    <c:set var="timeDiff" value="${now.time - review.re_writeDate.time}" /><!-- 현재시간과 게시글 작성일의 시간 차이 -->
										
										    <c:if test="${timeDiff <= oneDayMillis}"><!-- 하루동안 new 표시 -->
										        <a href="${contextPath}/review/content?re_articleNO=${review.re_articleNO}">${review.re_title}</a>
										        <img src="${contextPath}/resources/image/review/new.png" width="32px" alt="new" />
										    </c:if>
										    <c:if test="${timeDiff > oneDayMillis}">
										        <a href="${contextPath}/review/content?re_articleNO=${review.re_articleNO}">${review.re_title}</a>
										    </c:if>
										</c:otherwise>
					    			</c:choose>				    			
				    			</td>
				    			<!-- 작성자 -->
								<td>${review.userId }</td>
								<!-- 작성일자 -->
								<td><fmt:formatDate value="${review.re_writeDate }" pattern="yyyy.MM.dd"/></td>
								<!-- 조회수 -->
								<td><c:out value="${review.re_viewCnt }"/></td>
				    		</tr>
				    	</c:forEach>
				    </c:when>
				    <c:otherwise>
						<tr>
							<td colspan="5">등록된 글이 없습니다.</td>
						</tr>
					</c:otherwise>  
				</c:choose>
	  		</tbody>
		</table>
		
		<!-- 페이징 -->
		<div class="pagination">
			<!-- 이전 버튼 -->
			<c:if test="${pageMaker.prev}">
            	<a href="${pageMaker.makeSearch(pageMaker.startPage-1)}">&laquo;</a></li>
            </c:if>
              	
			<!-- 각 번호 페이지 버튼 -->				
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="curPage">
				<c:if test="${select != curPage }">
					<a href="${pageMaker.makeSearch(curPage)}">${curPage}</a>
				</c:if>
				<c:if test="${select == curPage }">
					<a class="active" href="${pageMaker.makeSearch(curPage)}">${curPage}</a>
				</c:if>
			</c:forEach>
			
			<!-- 다음페이지 버튼 -->
            <c:if test="${pageMaker.next && pageMaker.endPage>0}">
                <a href="${pageMaker.makeSearch(pageMaker.endPage+1)}">&raquo;</a>
            </c:if>  
			<form id="moveForm" method="get">
				<input type="hidden" name="curPage" value="${pageMaker.criteria.curPage }">
				<input type="hidden" name="postsPerPage" value="${pageMaker.criteria.postsPerPage }">
			</form>
		</div>
		
		<!-- 글쓰기 버튼  -->
		<div>
			<!-- 하유리: 로그인한 사용자만 글쓰기 버튼 활성화(23.07.18.) -->
			<c:if test="${isLogOn==true && user!=null}">
				<button class="writeBtn" type="button" onClick="handleButtonClick()">글쓰기</button>
			</c:if>
		</div>
	</div>

	<script>
		function handleButtonClick() {
			// 경고창 띄우기
			if (true) {
				alert("주문하신 상품을 선택해주세요.")
				// 사용자가 확인 버튼을 누른 경우 페이지 이동
				const contextPath = '${contextPath}'; // 여기에 원하는 경로를 입력하세요
				const insertUrl = contextPath + '/mypage/orderList';
				window.location.href = insertUrl;
			} else {
				// 사용자가 취소 버튼을 누른 경우 아무 작업 없음
				// 필요에 따라 취소 버튼을 눌렀을 때의 동작을 추가할 수 있습니다.
			}
		}
		
		//jQuery를 이용하여 검색기능 구현(23.08.29.)
	 	$(function(){
			$('.search-btn').click(function(){	//검색버튼 눌렀을 때
				var keyword = document.getElementById("keywordInput");	//input박스에 해당하는 변수 선언
				if(keyword.value.length==0){	//검색어가 입력이 안 되었다면
					alert('검색어를 입력하세요.');	//경고창 출력
					return false;				//또는 e.priventDefault(); 입력하여 이벤트 중단
				} else {
					self.location = "searchList"
						+ '${pageMaker.makeQuery(1)}'
						+ "&searchType="
						+ $("select option:selected").val()
						+ "&keyword="
						+ encodeURIComponent($('#keywordInput').val());
					}
			});
		}); 
	</script>
</body>
</html>