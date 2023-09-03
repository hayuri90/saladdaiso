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
    <link href="../resources/css/review/reviewContent.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div class="container mt-3">
		<div class="review_sub">
			<p class="review_text1">REVIEW</p>
		</div>
		<!-- 게시판 -->
		<div class="reply_table">
			<form action="<c:url value='/review/reply'/>" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="re_articleNO" value="${review.re_articleNO }">
				<table>				
 					<tr>
						<th>작성자</th>
						<td>	
							<input type="text" class="insert_input" name="userId" value="${user.userId }" autocomplete="off" required readonly disabled>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>	
							<input type="text" class="insert_input" name="re_title" placeholder="제목을 입력해 주세요." autocomplete="off" required>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea class="insert_input" name="re_content" cols="50" rows="10" placeholder="내용을 입력해 주세요." autocomplete="off" required></textarea>
						</td>
					</tr>
					<tr>
						<th class="inputArea">이미지 업로드</th>
						<td>
							<div id="insert_file"></div>	<!-- 자바스크립트를 이용해 <div> 안에 파일 업로드 추가 -->
							<input class="insert_input" type="button" name="file" value="파일 추가" onClick="fn_addFile()">	<!-- 파일추가 클릭 시 동적으로 파일업로드 추가 -->
						</td>
					</tr>			
				</table>
				
				<!-- 버튼 -->
				<div class="reply_btn_wrap">
					<div class="reply_btn1">
						<button class="replyBtn" type="button" onClick="location.href='${contextPath}/review/list'">글목록</button>
					</div>	
					<div class="reply_btn2">
						<button class="replyBtn" type="submit">답변 등록</button>
						<button class="replyBtn" type="reset" >초기화</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script>
		/* 하유리: 파일 업로드 input 가운데 배열(23.07.31.) */
		var cnt=1;	//파일업로드 name값을 다르게 하는 변수
		function fn_addFile(){	//파일추가를 클릭하면 동적으로 파일업로드 추가(name의 속성값으로 'file'+cnt를 설정하여 값을 다르게 해줌')
			$("#insert_file").append("<input style='padding: 5px 0; display:flex;' type='file' name='file"+cnt +"' />");
			cnt++;
		}
	</script>
</body>
</html>