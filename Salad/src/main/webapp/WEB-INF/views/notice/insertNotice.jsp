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
    <!-- <link href="../resources/css/notice.css" rel="stylesheet" type="text/css"> -->
	<style>
	
		/* 폰트 */
 		@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
	
		/* 하유리: 공지페이지 제목 수정(23.07.29.) */
		.notice_sub {
			margin: 50px 0;
			padding: 178px 0 24px 0;			/* 하유리: 헤더 영역만큼 아래로 내림(23.07.25.) */
		}													/* 하유리: 제목 주변 여백 수정(23.07.29.)  */
		
		/* 하유리: 공지페이지 제목 수정(23.07.29.)  */
		.notice_text {
		 	font-family: 'Noto Sans KR', sans-serif;
			font-size: 32px;							/* 하유리: 폰트 크기 수정(23.07.29.) */
			font-weight: 700;
			line-height: 1.2;
		  	letter-spacing: -1px;					/* 하유리: 제목 자간 수정(23.07.29.) */
		}
	
		.container {
			width: 100%;
/*			display: flex;
			justify-content: center; */
			text-align: center;
			font-family: 'Noto Sans KR', sans-serif;
 			font-size: 14px;
			margin: 0 auto;
			padding-bottom: 10px;				/* 하유리: 수정/삭제 버튼-footer 사이 여백 추가(23.07.30.) */
		}
		
		/* 중앙정렬 */
		.insert_table {
			width: 100%;
			display: flex;
			justify-content: center;
		}
		
		/* 하유리: 행 간격 띄우기(23.07.17.) */
		.insert_table table {
			text-align: left;	/* th 왼쪽정렬 */
			border-collapse: separate;
			border-spacing: 10px 20px;
			margin-top: -21px;						/* 하유리: 테이블 위쪽 여백 줄이기(23.07.30.) */
		}
	
		/* 하유리: 글자-input박스 간 간격(23.07.17.) */
		.insert_table th {
			font-weight: normal;
			flex: left;
			padding-right: 100px;
			font-size: 14px;
		}
		
		/* 하유리: input box, textarea */
		.insert_input, textarea {					/* 하유리: 클래스명 수정(23.07.31.) */
			padding: 5px 5px;
			font-size: 14px;							/* 하유리: 폰트 크기 추가(23.07.31.) */
		}
		
		/* 하유리: 파일업로드 부분(23.07.31.) */
		.insert_file {
			padding: 8px;							/* 하유리: 파일 업로드 input 가운데 배열(23.07.31.) */
		}
		
		/* input, textarea 스타일 지정 */
		.insert_table input {
			border: 1px solid #e3e3e3;
			border-radius: 5px;
			width: 640px;
			height: 44px;
		}
		
		.insert_table textarea {
			border: 1px solid #e3e3e3;
			border-radius: 5px;
			width: 640px;
			height: 250px;
		}
		
		/* input, textarea 클릭 시 생기는 테두리 스타일 지정(23.07.17.)  */
		input:focus{
			outline: 1px solid #000;
		}
		
		textarea:focus {
			outline: 1px solid #000;
		}
		
		.insert_btn {
			float: right;
			padding-right: 10px;
		}
	
		.writeBtn{
			margin: 0px 0px 60px 0px;
			padding: 5px 10px;
			border-radius: 5px;
			border-style: none;
			background-color:#128853;
			color: #fff;
			float: right;
			margin-left: 4px;						/* 하유리: 버튼 사이 간격 수정(23.07.30.) */
			float: center;
		}
		
		.writeBtn:focus {
			outline: none;							/* 하유리: 버튼 클릭 시 생기는 테두리 없애기(23..07.31.) */
		}
	</style>

	<script>
		/* 하유리: 파일 업로드 input 가운데 배열(23.07.31.) */
		var cnt=1;	//파일업로드 name값을 다르게 하는 변수
		function fn_addFile(){	//파일추가를 클릭하면 동적으로 파일업로드 추가(name의 속성값으로 'file'+cnt를 설정하여 값을 다르게 해줌')
			$("#d_file").append("<br>"+"<input style='padding: 8px;' type='file' name='file"+cnt +"' />");
			cnt++;
		}
	</script>

</head>

<body>

	<div class="container mt-3">
		<!-- 제목: 변경(23.07.21.) -->
		<!-- 하유리: 필요없는 부분 삭제(23.07.30.) -->
		<div class="notice_sub">								<!-- 하유리: 클래스명 변경(23.07.30.) -->
			<p class="notice_text">NOTICE</p>		<!-- 하유리: 클래스명 변경(23.07.30.) -->
		</div>
	
		<!-- 게시판 -->
		<div class="insert_table">
			<form action="<c:url value='/notice/insert'/>" method="POST"  enctype="multipart/form-data">
				<table>
				<!-- 하유리: 필요 없는 부분  주석(23.07.30.) -->
 					<!-- <tr>
						<th>주문상품</th>
						<td>	<input class="insert_input" name="orderList" required autocomplete="off" width="440px" disabled/></td>
					</tr> -->
				
 					<tr>
						<th>작성자</th>
						<td>	
							<!-- 하유리: 세션에 저장된 id값 가져오기(23.07.18.) -->
							<input class="insert_input" name="userId"  type="text" value="${user.userId}" required autocomplete="off" readonly="readonly">
						</td>
					</tr>
		
					<tr>
						<th>제목</th>
						<td>	
							<input class="insert_input" name="title" type="text" placeholder="제목을 입력해 주세요." 
							required autocomplete="off"></td>
					</tr>
					
					<tr>
						<th>내용</th>
						<td>
							<textarea class="insert_input" name="content" cols="50" rows="10" placeholder="내용을 입력해 주세요." 
							required autocomplete="off"></textarea>
						</td>
					</tr>
					
					<tr>
						<th class="inputArea">이미지 업로드</th>
						<td>	
								<input type="button" name="file"value="파일 추가" onClick="fn_addFile()">	<!-- 파일추가 클릭 시 동적으로 파일업로드 추가 -->
								<div id="d_file">	<!-- 자바스크립트를 이용해 <div> 안에 파일 업로드 추가 -->
								</div>
						</td>
					</tr>			
				</table>
				
				<div class="insert_btn">
					<button class="writeBtn" type="submit">글등록</button>
					<button class="writeBtn" type="reset" >초기화</button>
					<button class="writeBtn" type="button" onClick="location.href='${contextPath}/review/list'">글목록</button>
				</div>
			</form>
		</div>
	</div>
	
</body>
</html>