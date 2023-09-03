<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <!-- 부트스트랩 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="../resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="../resources/css/footer.css" rel="stylesheet" type="text/css">
    <link href="../resources/css/review/reviewContent.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div class="container mt-3">
		<div class="review_sub">
			<p class="review_text1">REVIEW</p>
		</div>
	
		<!-- 게시판 -->
		<div class="insert_table">
			<form action="<c:url value='/review/update'/>" method="POST" enctype="multipart/form-data">
				<input name="re_articleNO" type="hidden" value="${review.re_articleNO }">
				<table>
					<%-- 김동혁: 답글형은 주문번호 숨김 처리 --%>
					<c:if test="${review.re_fakeOrderNum != null}">
						<tr>
							<th>주문상품</th>
							<td>
								<input class="insert_input" name="orderList" value="${review.re_fakeOrderNum}" width="440px" 
								 	   required readOnly autocomplete="off" />
							</td>
						</tr>
					</c:if>
 					<tr>
						<th>작성자</th>
						<td>	
							<input type="text" class="insert_input" name="userId" value="${review.userId }" 
								   placeholder="이름을 입력해 주세요." required readOnly autocomplete="off">
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>	
							<input type="text" class="insert_input" name="re_title" value="${review.re_title }" 
								   placeholder="제목을 입력해 주세요." required autocomplete="off"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea class="insert_input" name="re_content" cols="50" rows="10" placeholder="내용을 입력해 주세요." 
									  required autocomplete="off">${review.re_content }</textarea>
						</td>
					</tr>
					<tr>
						<th>이미지 업로드</th>
						<td>
							<!-- <input type="file" class="insert_file" multiple="multiple"> -->
							<c:choose>
								<c:when test="${empty review.re_imageFileList}">
									<div class="insert_input_file">
										<div id="d_file"></div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="insert_input_file">
										<c:forEach items="${review.re_imageFileList}" var="re_imageFileList">
											<div class="imgFile">
												<input type="text" class="review_imgName" id="review_imgName" name="review_image" value="${re_imageFileList.re_originalFileName}" disabled/>
												<button class="fileDelete"><img src="${contextPath}/resources/image/review/delete_icon.png" /></button>
											</div>
										</c:forEach>
										<div id="d_file"></div>	<!-- 자바스크립트를 이용해 <div> 안에 파일 업로드 추가 -->
									</div>
								</c:otherwise>
							</c:choose>
							<input class="insert_input" type="button" name="file" value="파일 추가" onClick="fn_addFile()">	<!-- 파일추가 클릭 시 동적으로 파일업로드 추가 -->
						</td>
					</tr>			
				</table>
				
				<div class="update_btn_wrap">
					<div class="update_btn1">
						<button class="writeBtn" type="button" onClick="location.href='${contextPath}/review/list'">글목록</button>
					</div>
					<div class="update_btn2">
						<button class="writeBtn" type="submit">글등록</button>
						<button class="writeBtn" type="reset" >초기화</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<script>
		/* 하유리: 파일 업로드 input 가운데 배열(23.07.31.) */
		var cnt=1;	//파일업로드 name값을 다르게 하는 변수
		function fn_addFile(){	//파일추가를 클릭하면 동적으로 파일업로드 추가(name의 속성값으로 'file'+cnt를 설정하여 값을 다르게 해줌')
			$("#d_file").append("<input style='padding: 5px 0; display:flex;' type='file' name='file"+cnt +"' />");
			cnt++;
		}
		
		/* 입력내용에 따라 input 너비 조절 */
		var resizable = function(el, factor) {
			var unit = Number(factor) || 7.7;
			function resize() {
				el.style.width = ((el.value.length+1) * unit) + 'px'
			}
			var e = 'keyup,keypress,focus,blur,change'.split(',');
			for (var i in e)
				el.addEventListener(e[i],resize,false);
			resize();
		}
		resizable(document.getElementById('review_imgName'), 10);		
	</script>
	
</body>
</html>