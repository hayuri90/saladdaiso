<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C/DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/XHTML1/DTD/xhtml1-transitional.dtd">
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
		<div class="insert_table">
			<form action="<c:url value='/review/insert'/>" method="POST" enctype="multipart/form-data"> <!-- <form>태그의 action속성은 실행할 controller의 메소드명과 일치 -->
																										<!-- 파일 업로드 시, enctype="multipart/form-data" 필수 -->
				<table>
					<tr>
						<%-- fakeOrderNum, orderNum 저장 - 김동혁 수정(23.08.01) --%>
						<th>주문번호</th>
						<td>
							<!-- ReviewController에서 model을 통해 주문번호를 가져와 출력 -->
							<input class="insert_input" value="${orderInfo.fakeOrderNum}" name="fakeOrderNum" width="440px" readOnly required autocomplete="off" />
							<input type="hidden" name="re_orderNum" value="${orderInfo.orderNum}" />
							<input type="hidden" name="re_fakeOrderNum" value="${orderInfo.fakeOrderNum}" />
						</td>
					</tr>				
 					<tr>
						<th>작성자</th>
						<td>	
							<!-- 하유리: 세션에 저장된 id값 가져오기(23.07.18.) -->
							<input type="text" class="insert_input" name="userId" value="${user.userId}" autocomplete="off" readonly required />
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
				
				<div class="insert_btn_wrap">
					<div class="insert_btn1">
						<button class="writeBtn" type="button" onClick="location.href='${contextPath}/review/list'">글목록</button>
					</div>
					<div class="insert_btn2">
						<button class="writeBtn" type="submit">글등록</button>
						<button class="writeBtn" type="reset" >초기화</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<script>
		/* 하유리: 파일 업로드 input 가운데 배열(23.07.31.) */
		var cnt=1;	//업로드파일의 name값을 다르게 하는 변수
		function fn_addFile(){	//파일추가를 클릭하면 동적으로 파일업로드 추가
			$("#insert_file").append("<input style='padding: 5px 0; display:flex;' type='file' name='file"+cnt +"' />"); //name의 속성값으로 'file'+cnt를 설정하여 값을 다르게 해줌
			cnt++;
		}
	</script>	
</body>
</html>