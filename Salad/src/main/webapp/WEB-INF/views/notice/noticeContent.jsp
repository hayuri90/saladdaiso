<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <!-- 부트스트랩 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- CSS -->
    <link href="../resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="../resources/css/footer.css" rel="stylesheet" type="text/css">
    <link href="../resources/css/notice.css" rel="stylesheet" type="text/css">
</head>

<body>		
	<div class="container1 mt-3">
		<div class="notice_sub">
			<p class="notice_text">NOTICE</p>
		</div>
		
		<!-- 게시판 -->
		<div class="content_table">
			<form action="<c:url value='/notice/update'/>" method="POST" enctype="multipart/form-data" role="form">
				<input name="articleNO" type="hidden" value="${notice.articleNO }" disabled>
				<table>				
 					<tr>
						<th>작성자</th>
						<td><input class="content_input" name="userId" type="text" value="${notice.userId }" disabled></td>
					</tr>		
					<tr>
						<th>제목</th>
						<td><input class="content_input" name="title" type="text"  value="${notice.title }" disabled></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea class="content_text" name="content" cols="50" rows="10" disabled>${notice.content }</textarea></td>
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
											<input type="text" class="notice_imgName" name="originalFileName" value="${imageFileList.originalFileName}" disabled/><br/>
											<img class="notice_preview" src="${contextPath}/notice/imgDown?storedFileName=${imageFileList.storedFileName}"
												 style="width:200px;"/><br/>
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
				<div class="content_btn1">
					<button type="button" class="contentBtn" onClick="location.href='${contextPath}/notice/list'">글목록</button>
				</div>
				<div class="content_btn2">
					<!-- 하유리: 작성자(admin)만 게시글만 수정, 삭제할 수 있도록 처리(23.07.18.) -->
					<c:if test="${user.userId == notice.userId }">
						<button type="button" class="contentBtn" onClick="location.href='${contextPath}/notice/insert'">글쓰기</button>
						<button type="button" class="contentBtn" onClick="location.href='${contextPath}/notice/update?articleNO=${notice.articleNO }'">수정</button>
						<button type="button" class="contentBtn" onClick="location.href='${contextPath}/notice/delete?articleNO=${notice.articleNO }'">삭제</button>
					</c:if>
				</div>
			</form>
		</div>
	</div>
</body>
</html>