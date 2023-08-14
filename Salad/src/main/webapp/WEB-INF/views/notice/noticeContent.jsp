<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- css 적용 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="../resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="../resources/css/footer.css" rel="stylesheet" type="text/css">
	<style>
		/* 폰트 */
 		@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
 		
		/* 하유리: 공지페이지 제목 수정(23.07.29.) */
		.notice_sub {
			margin: 50px 0;
			padding: 178px 0 24px 0;		/* 하유리: 헤더 영역만큼 아래로 내림(23.07.25.) */
		}												/* 하유리: 제목 주변 여백 수정(23.07.29.)  */
		
		/* 하유리: 공지페이지 제목 수정(23.07.29.)  */
		.notice_text {
		 	font-family: 'Noto Sans KR', sans-serif;
			font-size: 32px;						/* 하유리: 폰트 크기 수정(23.07.29.) */
			font-weight: 700;
			line-height: 1.2;
		  	letter-spacing: -1px;				/* 하유리: 제목 자간 수정(23.07.29.) */
		}
	
		.container {
			width: 100%;
/*			display: flex;
			justify-content: center; */
			text-align: center;
			font-family: 'Noto Sans KR', sans-serif;
 			font-size: 14px;
			margin: 0 auto;
			padding-bottom: 10px;			/* 하유리: 수정/삭제 버튼-footer 사이 여백 추가(23.07.30.) */
		}

		/* 중앙정렬 */
		.content_table {
			width: 100%;
			display: flex;
			justify-content: center;
		}
		
		/* 하유리: 행 간격 띄우기(23.07.17.) */
		.content_table table {
			text-align: left;	/* th 왼쪽정렬 */
			border-collapse: separate;
			border-spacing: 10px 20px;
			margin-top: -21px;			/* 하유리: 테이블 위쪽 여백 줄이기(23.07.30.) */
		}
	
		/* 하유리: 글자-input박스 간 간격(23.07.17.) */
		.content_table th {
			font-weight: normal;
			flex: left;
			padding-right: 100px;
		}
		
		.content_table input, textarea, .notice_preview {
			padding: 5px 5px;
		}
		
		.review_preview {
			margin-top: -5px;
		}
	
		/* input, textarea 스타일 지정 */
		.content_table .content_input {
			border: 1px solid #e3e3e3;
			border-radius: 5px;
			width: 640px;
			height: 44px;
		}
		
		.content_table .content_text {
			border: 1px solid #e3e3e3;
			border-radius: 5px;
			width: 640px;
			height: 250px;
		}
		
		.content_table .content_input_file {
			border: 1px solid #e3e3e3;
			border-radius: 5px;
			width: 640px;	
		}
		
		/* input, textarea 클릭 시 생기는 테두리 스타일 지정(23.07.17.)  */
		.content_text:focus{
			outline: 1px solid #000;
		}
		
		.content_input_file:focus {
			outline: 1px solid #000;
		}
		
		/* 업로드 이미지 파일이름 뜨는 input박스 */
		.notice_imgName {
			border: none;	/* 테두리 없애기 */
		}
		
		/* 버튼 */
		.content_btn1 {
			float: left;
			margin-left: 10px;
		}
		
		.content_btn2 {
			float: right;
			margin-right: 10px;
		}
	
		.contentBtn{
			margin: 0px 0px 60px 0px;
			padding: 5px 10px;
			border-radius: 5px;
			border-style: none;
			background-color:#128853;
			color: #fff;
		}
		
		.contentBtn:focus {
			outline: none;						/* 하유리: 버튼 클릭 시 생기는 테두리 없애기(23..07.31.) */
		}
		
	</style>
</head>

<body>		
	<div class="container mt-3">
		<!-- 하유리: 제목 변경(23.07.21.)(23.07.30.) -->
		<!-- 하유리: 필요없는 부분 삭제(23.07.30.) -->
		<div class="notice_sub">								<!-- 하유리: 클래스명 변경(23.07.30.) -->
			<p class="notice_text">NOTICE</p>		<!-- 하유리: 클래스명 변경(23.07.30.) -->
		</div>
		
		<!-- 게시판 -->
		<div class="content_table">
			<form action="<c:url value='/notice/update'/>" method="POST" enctype="multipart/form-data" role="form">
				<input name="articleNO" type="hidden" value="${notice.articleNO }" disabled>
				<table>
				<!-- 하유리: 필요 없는 부분  주석(23.07.30.) -->
 					<!-- <tr>
						<th>주문상품</th>
						<td>	<input class="content_input" name="orderList" type="text" disabled/></td>
					</tr> -->
				
 					<tr>
						<th>작성자</th>
						<td>	
							<input class="content_input" name="userId" type="text" value="${notice.userId }" disabled>
						</td>
					</tr>
		
					<tr>
						<th>제목</th>
						<td>	
							<input class="content_input" name="title" type="text"  value="${notice.title }" disabled></td>
					</tr>
					
					<tr>
						<th>내용</th>
						<td>
							<textarea class="content_text" name="content" cols="50" rows="10" disabled>${notice.content }</textarea>
						</td>
					</tr>
					
					<tr>
						<th>업로드 이미지</th>
						<td>	
								<c:choose>
									<c:when test="${empty notice.imageFileList}">
										<input class="content_input" name="orderList" type="text" disabled/>
									</c:when>
									<c:otherwise>
										<div class="content_input_file">
											<c:forEach items="${notice.imageFileList}" var="imageFileList">
												<input class="notice_imgName" name="originalFileName" type="text" value="${imageFileList.originalFileName}"  disabled/><br/>
												<img class="notice_preview" src="${contextPath}/notice/imgDown?storedFileName=${imageFileList.storedFileName}" style="width:200px;"/><br/>
											</c:forEach>
										</div>
									</c:otherwise>
								</c:choose>
							
						</td>					
					</tr>
								
					<tr>
						<th>조회수</th>
						<td><input class="content_input" name="viewCnt" value="${notice.viewCnt }" disabled></td>
					</tr>	
							
					<tr>
						<th>작성일</th>
						<td><input class="content_input" name="writeDate" value="${notice.writeDate }" disabled></td>
					</tr>		
						
				</table>
				
				<!-- 버튼 -->
				<!-- 하유리: 코드 수정(23.07.31.) -->
				<div> 
					<c:if test="${user.userId == 'admin' }">
						<div class="content_btn1">
							<button type="button" class="contentBtn" onClick="location.href='${contextPath}/notice/insert'">글쓰기</button>
							<button type="button" class="contentBtn" onClick="location.href='${contextPath}/notice/list'">목록</button>
						</div>
					</c:if>
					<c:if test="${user.userId != 'admin' }">
						<div class="content_btn2">
							<button type="button" class="contentBtn" onClick="location.href='${contextPath}/notice/list'">목록</button>
						</div>
					</c:if>
					</div>
					<div class="content_btn2">
						<!-- 하유리: 작성자(admin)만 게시글만 수정, 삭제할 수 있도록 처리(23.07.18.) -->
						<c:if test="${user.userId == notice.userId }">
							<button type="button" class="contentBtn" onClick="location.href='${contextPath}/notice/update?articleNO=${notice.articleNO }'">수정</button>
							<button type="button" class="contentBtn" onClick="location.href='${contextPath}/notice/delete?articleNO=${notice.articleNO }'">삭제</button>
						</c:if>
					</div>
				</div>
			</form>
		</div>
	</div>
	
</body>
</html>