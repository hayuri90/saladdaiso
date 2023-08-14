<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
 		
		/* 하유리: 리뷰페이지 제목 수정(23.07.29.) */
		.review_sub {
			margin: 50px 0;
			padding: 178px 0 24px 0;									/* 하유리: 헤더 영역만큼 아래로 내림(23.07.25.) */
		}																			/* 하유리: 제목 주변 여백 수정(23.07.29.)  */

		/* 하유리: 이벤트페이지 제목 수정(23.07.29.)  */
		.review_text1 {
		 	font-family: 'Noto Sans KR', sans-serif;
			font-size: 32px;													/* 하유리: 폰트 크기 수정(23.07.29.) */
			font-weight: 700;
			line-height: 1.2;
		  	letter-spacing: -1px;											/* 하유리: 제목 자간 수정(23.07.29.) */
		}
	
		.container {
			width: 100%;
/*			display: flex;
			justify-content: center; */
			text-align: center;
			font-family: 'Noto Sans KR', sans-serif;
 			font-size: 14px;
			margin: 0 auto;
			padding-bottom: 10px;										/* 하유리: 버튼-footer 사이 여백 추가(23.07.30.) */
		}

		/* 중앙정렬 */
		.content_table {
			width: 100%;
			/* display: flex; */												/* 하유리: 주석 처리(23.08.01.) */
			justify-content: center;
		}
		
		/* 하유리: 행 간격 띄우기(23.07.17.) */
		.content_table table {
			text-align: left;	/* th 왼쪽정렬 */
			border-collapse: separate;
			border-spacing: 10px 20px;
			margin-top: -21px;												/* 하유리: 테이블 위쪽 여백 줄이기(23.07.30.) */
			margin: 0 auto;													/* 하유리: 테이블 중앙 정렬(23.08.01.) */
		}
	
		/* 하유리: 글자-input박스 간 간격(23.07.17.) */
		.content_table th {
			font-weight: normal;
			flex: left;
			padding-right: 100px;
		}
		
		.content_table input, textarea, .review_preview {
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
		.review_imgName {
			border: none;	/* 테두리 없애기 */
		}
		
		/* 버튼 */

		/* 버튼 <div> */
		.btn_wrap {
			display: flex;														/* 하유리: 버튼 테이블 아래쪽에 배치(23.08.01.) */
    		justify-content: space-between;							/* 하유리: 버튼 테이블 아래쪽에 배치(23.08.01.) */
    		margin: 0 139px;												/* 하유리: 버튼 좌우 여백 지정(23.08.01.) */
		}

		/* 좌측 버튼 2개<div> */
		.content_btn1 {
			float: left;															/* 하유리: 버튼 왼쪽 정렬 */
			/* margin-left: 10px; */										/* 하유리: 주석 처리(23.08.01.) */
		}
		
		/* 우측 버튼 3개<div> */
		.content_btn2 {
			float: right;														/* 하유리: 버튼 우측 정렬 */
			/* margin-right: 10px; */									/* 하유리: 주석 처리(23.08.01.) */
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
			outline: none;													/* 하유리: 버튼 클릭 시 생기는 테두리 없애기(23..07.31.) */
		}

/* 		.line {
			display: flex;
			align-items: center;
			margin-bottom: 10px;
			flex-direction: row;
		} */

		.img img, .line .line-userId {
			display: inline-block;											/* 하유리: 지금 댓글 틀 맞추려면 필수(23.08.02.) */
		}

		.img img {
			display: flex;
		}


		/* 입력댓글 전체<div> */
		.line {
			text-align: left;													/* 하유리: 왼쪽 정렬(23.08.01.) */
    		/* margin-bottom: 30px; */								/* 하유리: 하단 여백 추가(23.08.01.) */
    		margin-top: 30px;												/* 하유리: 상단 여백 추가(23.08.02.) */
		}

		/* 입력된 댓글_id */
		.line-userId {
			flex-grow: 1;
    		text-align: left;													/* 하유리: 좌측 정렬(23.08.01.) */
    		font-weight: 700;												/* 하유리: 폰트 굵기 지정(23.08.01.) */
    		vertical-align: 9.3px;											/* 하유리: 아이콘-id 세로 중앙정렬(23.08.02.) */
    		margin-left: 10px;												/* 하유리: 좌측 여백 지정(23.08.02.) */
    		color: #000;														/* 하유리: 폰트 색상 지정(23.08.02.) */
		}

		/* 입력된 댓글_내용 */
		.line-title {
			width: 800px;														/* 하유리: 댓글 너비 지정(23.08.01.) */
			/* font-weight: bold; */										/* 하유리: 주석 처리(23.08.01.) */
			/* margin-right: 10px; */									/* 하유리: 주석 처리(23.08.01.) */
			padding:7px 0;													/* 하유리: 상하 여백만 주도록 변경(23.08.01.) */
			/* background-color: #128853; */						/* 하유리: 배경색 주석 처리(23.08.01.) */
			color: #333;														/* 하유리: 폰트 색상 변경(23.08.01.) */
			margin-left: 37px;												/* 하유리: 좌측 여백 지정(23.08.02.) */
			margin-top: -10px;												/* 하유리: 아이디-댓글 내용 사이 여백 지정(23.08.02.) */
		}

		/* 입력된 댓글_날짜 부분 */
		.line-content {
			flex-grow: 1;
			color: #b8b8b8;													/* 하유리: 폰트 색상 지정(23.08.02.) */
    		font-weight: 500;												/* 하유리: 폰트 굵기 지정(23.08.02.) */
    		font-size: 13px;													/* 하유리: 폰트 크기 지정(23.08.02.) */
    		margin-left: 37px;												/* 하유리: 좌측 여백 지정(23.08.02.) */
    		letter-spacing: -0.3px;										/* 하유리: 자간 지정(23.08.02.) */
		}

		/* 댓글작성 폼 */
		#commentForm {
			float: left;
			margin-left: 139px;												/* 하유리: 좌측 여백 지정(23.08.01.) */
			margin-bottom: 100px;										/* 하유리: 하단 여백 지정(23.08.01.) */
		    border-top: 7px solid #eeeeee;							/* 하유리: 글쓰기 테이블 - 댓글 작성폼 사이의 구분선(23.08.01.) */
    		padding-top: 50px;											/* 하유리: 구분선 - 댓글 작성폼 사이의 여백(23.08.01.) */
    		width: 832px;														/* 하유리: 너비 지정(23.08.01.) */
		}

		/* 댓글작성폼 상단 '댓글' 텍스트' */
		#commentForm p {
			text-align: left;													/* 하유리: 좌측 정렬(23.08.01.) */
			font-size: 20px;													/* 하유리: 폰트 크기 지정(23.08.01.) */
    		font-weight: 700;												/* 하유리: 폰트 굵기 지정(23.08.01.) */
    		letter-spacing: -1px;											/* 하유리: 자간 지정(23.08.01.) */
		}

		/* 댓글 입력 부분 */
		.comment_input {
    		height: 61px;														/* 하유리: 높이(23.08.01.) */
    		border-radius: 10px;											/* 하유리: 테두리 가장자리 둥글게 지정(23.08.01.) */
    		display: flex;														/* 하유리: 요소 일정간격으로 배열(23.08.01.) */
   	 		justify-content: space-between;
   	 		align-items: center;											/* 하유리: 세로 중앙 배열(23.08.01.) */
   	 		margin-bottom: 10px;										/* 하유리: input 외부에 여백 지정(23.08.01.) */
    	}

		/* 댓글 적는 사람 아이콘 */
		#commentForm img {
			height: 28px;														/* 하유리: 크기 지정(23.08.01.) */
		}

		/* 댓글_id, 내용 입력 input */
		.comment_id, .comment_text, #commentBt {
			border: 1px solid #e3e3e3;									/* 하유리: 테두리 지정(23.08.01.) */
    		height: 35px;														/* 하유리: 높이 지정(23.08.01.) */
    		border-radius: 8px;											/* 하유리: 테두리 가장자리 둥글게 지정(23.08.01.) */
    		font-weight: 300;												/* 하유리: 폰트 크기 지정(23.08.01.) */
    		outline: none;													/* 하유리: 클릭 시 생기는 테두리 없애기(23.08.01.) */
		}

		/* 댓글_id 입력 input */
		.comment_id {
			width: 150px;														/* 하유리: 너비 지정(23.08.01.) */
			padding: 10px;													/* 하유리: input 내부 여백 지정(23.08.01.) */
		}

		/* 댓글_내용 입력 input */
		.comment_text {
			width: 530px;														/* 하유리: 너비 지정(23.08.01.) */
			padding: 10px;													/* 하유리: input 내부 여백 지정(23.08.01.) */
		}

		/* 댓글입력 버튼 */
		 #commentBt {
			width: 105px;														/* 하유리: 너비 지정(23.08.01.) */
			font-weight: 500;												/* 하유리: 폰트 굵기 지정(23.08.01.) */
		}

		/* 입력된 댓글 전체<div> */
		#commentList {
			border: 1px solid #e2e2e2;									/* 하유리: 테두리 지정(23.08.02.) */
    		border-radius: 15px;											/* 하유리: 모서리 둥글게 지정(23.08.02.) */
    		padding: 0 20px 30px 20px;								/* 하유리: 안쪽 여백 지정(23.08.02.) */
		}

	</style>
</head>

<body>
	<div class="container mt-3">
		<!-- 제목: 변경(23.07.21.)(23.07.30.) -->
		<!-- 하유리: 필요없는 부분 삭제(23.07.30.) -->
		<div class="review_sub">										<!-- 하유리: 클래스명 변경(23.07.30.) -->
			<p class="review_text1">REVIEW</p>				<!-- 하유리: 클래스명 변경(23.07.30.) -->
		</div>

		<!-- 게시판 -->
		<div class="content_table">
<%-- 			<form action="<c:url value='/review/update'/>" method="POST"
				enctype="multipart/form-data" role="form"> --%>
				<input name="re_articleNO" type="hidden"
					value="${review.re_articleNO }" disabled>
				<table>
					<%-- 답글형은 주문번호 숨기기 - 김동혁(23.08.01) --%>
					<c:if test="${review.re_fakeOrderNum != null}">
						<tr>
							<th>주문번호</th>
							<td>	<input class="content_input" name="re_fakeOrderNum" type="text" value="${review.re_fakeOrderNum}" disabled/></td>
						</tr>
					</c:if>
				
 					<tr>
						<th>작성자</th>
						<td><input class="content_input" name="userId" type="text"
							value="${review.userId }" disabled></td>
					</tr>

					<tr>
						<th>제목</th>
						<td><input class="content_input" name="review_title"
							type="text" value="${review.re_title }" disabled></td>
					</tr>

					<tr>
						<th>내용</th>
						<td><textarea class="content_text" name="review_content"
								cols="50" rows="10" disabled>${review.re_content }</textarea></td>
					</tr>

					<tr>
						<th>업로드 이미지</th>
						<td>
							<c:choose>
								<c:when test="${empty review.re_imageFileList}">
									<input class="content_input" name="orderList" type="text" disabled/>
								</c:when>
								<c:otherwise>
									<div class="content_input_file">
										<c:forEach items="${review.re_imageFileList}" var="re_imageFileList">
											<input class="review_imgName" name="review_image" type="text" value="${re_imageFileList.re_originalFileName}"  disabled/><br/>
											<img class="review_preview" src="${contextPath}/review/imgDown?re_storedFileName=${re_imageFileList.re_storedFileName}" style="width:200px;"/><br/>
										</c:forEach>
									</div>
								</c:otherwise>
							</c:choose>
						</td>					
					</tr>

					<tr>
						<th>조회수</th>
						<td><input class="content_input" name="review_viewCnt"
							value="${review.re_viewCnt }" disabled></td>
					</tr>

					<tr>
						<th>작성일</th>
						<td><input class="content_input" name="review_upload"
							value="${review.re_writeDate }" disabled></td>
					</tr>

				</table>

				<!-- 버튼 -->
				<div class="btn_wrap">									<!-- 하유리: 버튼 전체를 감싸는 <div> 추가(23.08.01.) -->
					<div class="content_btn1">
						<button type="button" class="contentBtn"
							onClick="location.href='${contextPath}/review/list'">목록</button>
						<button type="button" class="contentBtn"
							onClick="location.href='${contextPath}/review/insert'">글쓰기</button>
					</div>
					<div class="content_btn2">
						<button type="button" class="contentBtn"
							onClick="location.href='${contextPath}/review/reply?re_articleNO=${review.re_articleNO }'">답글</button>
						<!-- 하유리: 본인 게시글만 수정, 삭제할 수 있도록 처리(23.07.18.) -->
						<c:if test="${user.userId == review.userId }">
							<button type="button" class="contentBtn"
								onClick="location.href='${contextPath}/review/update?re_articleNO=${review.re_articleNO }'">수정</button>
							<button type="button" class="contentBtn"
								onClick="location.href='${contextPath}/review/delete?re_articleNO=${review.re_articleNO }'">삭제</button>
						</c:if>
					</div>
				</div>
<!-- 			</form> -->
		</div>
		<%-- <form id="commentForm">
					<input type="text" name="userId" id="userId" placeholder="로그인 후 이용 가능" value="${userVO.userId}" required>
					<input type="text" name="ac_content" id="ac_content" placeholder="댓글 내용" required>
					<button type="submit">댓글 작성</button>
				</form> --%>

		<!-- 댓글 작성 폼 -->
		<div class="comment_wrap">																								<!-- 하유리: <div> 추가(23.08.01.) -->
			<form id="commentForm" method="POST">
				<p>댓글<p>
				<div class="comment_input">																						<!-- 하유리: 댓글 입력 부분 <div> 추가(23.08.01.) -->
					<img src="${contextPath }/resources/image/review/007.png"/>									<!-- 하유리: 아이콘 추가(23.08.01.) -->
					<input class="comment_id" type="text" name="userId" id="userId"
						placeholder="로그인 후 이용 가능" value="${userVO.userId}" required readOnly>	<!-- 하유리: 클래스명, reaOnly 추가(23.08.01.) -->
					<input class="comment_text" type="text" name="ac_content" id="ac_content"
						placeholder="댓글 내용" required autocomplete="off">										<!-- 하유리: 클래스명, 자동완성 끄기 추가(23.08.01.) -->
					<button type="submit" id="commentBt">댓글 입력</button>									<!-- 하유리: 오타 및 텍스트 수정(23.08.01.) -->
				</div>
				<!-- 댓글 목록 테이블 -->
				<div id="commentList"></div>
			</form>
		</div>

	</div>

	<script type="text/javascript">

	$(document).ready(function () {

		 $.ajax({
	            url: '${contextPath}/review/getCommentList', // 실제 댓글을 추가하는 서버 URL로 대체해주세요
	            type: 'POST',
	            data: {},
	            dataType: 'json',
	            success: function (response) {
	             // 서버에서 정상적으로 데이터를 받아왔을 때 실행되는 부분
	                var commentList = $('#commentList');
	                commentList.empty(); // 기존 목록을 비웁니다.

	                for (var i = 0; i < response.length; i++) {
	                    var comment = response[i];
	                    var newComment = $('<div class="line">');																						/* 하유리 변수명 변경(23.08.02.) */
	                    newComment.append($('<img src="${contextPath }/resources/image/review/006.png"/>'));				/* 하유리: 이미지 추가(23.08.01.) */
	                    newComment.append($('<div class="line-userId">').text(comment.userId));	       				   				/* 하유리: 변수명+클래스명 변경, '아이디' 텍스트 삭제(23.08.02.) */
	                    newComment.append($('<div class="line-title">').text(comment.ac_content));										/* 하유리: x번째 댓글' 텍스트 삭제(23.08.02.) */
	                    var dateString = new Date(comment.ac_writeDate).toISOString().split('T')[0];
	                    newComment.append($('<div class="line-content">').text('등록일자: ' + dateString));							/* 하유리: 텍스트 수정(23.08.02.) */
	                    commentList.append(newComment);
	                }
	            },
	            error: function() {
	            	alert('비회원 상태입니다.\n로그인 창으로 넘어갑니다.');
	                location.href = '${contextPath}/user/loginForm.do';
	            }
	        });


	    });




	$('#commentForm').on('submit', function(event) {
	    event.preventDefault(); // 폼의 기본 동작인 제출을 막습니다.

        var ac_content = $('#ac_content').val(); // 댓글 내용을 가져옵니다.
        var userId = $('#userId').val();

        // 댓글 추가를 위한 AJAX 요청 보내기
        $.ajax({
            url: '${contextPath}/review/addComment', // 실제 댓글을 추가하는 서버 URL로 대체해주세요
            type: 'POST',
            data: {ac_content : ac_content, userId : userId},
            dataType: 'json',
            success: function (response) {
             // 서버에서 정상적으로 데이터를 받아왔을 때 실행되는 부분
                var commentList = $('#commentList');
                commentList.empty(); // 기존 목록을 비웁니다.

                for (var i = 0; i < response.length; i++) {
                    var comment = response[i];
                    var newComment = $('<div class="line">');
                    newComment.append($('<img src="${contextPath }/resources/image/review/006.png"/>'));					/* 하유리: 이미지 추가(23.08.01.) */
                    newComment.append($('<div class="line-userId">').text(comment.userId));											/* 하유리: '아이디' 텍스트 삭제(23.08.01.)' */
                    newComment.append($('<div class="line-title">').text(comment.ac_content));											/* 하유리: x번째 댓글' 텍스트 삭제(23.08.02.) */
                    var dateString = new Date(comment.ac_writeDate).toISOString().split('T')[0];
                    newComment.append($('<div class="line-content">').text('등록일자: ' + dateString));								/* 하유리: 텍스트 수정(23.08.02.) */
                    commentList.append(newComment);
                }

            },
            error: function() {
            	alert('비회원 상태입니다.\n로그인 창으로 넘어갑니다.');
                location.href = '${contextPath}/user/loginForm.do';
            }
        });
    });

	$(document).on('click', '.line', function() {
		var parentCommentId = $(this).data('comment-id');
		console.log('test!! ' + parentCommentId);

		// 클릭한 댓글에 대한 자식 댓글 입력 폼이 이미 존재하는지 확인
		var commentForm = $('#commentForm-' + parentCommentId);
		var isCommentFormVisible = commentForm.is(":visible");

		// 댓글 폼이 보이지 않을 경우에만 폼을 추가
		if (!isCommentFormVisible) {
			// 기존에 열려있는 다른 댓글 폼들을 모두 숨김 처리
			$('.commentForm').hide();

			// 클릭한 댓글의 위치에 자식 댓글 입력 폼 추가
			var formHTML = `
            <form id="commentForm-${parentCommentId}" class="commentForm" method="POST">
                <input type="hidden" name="parentCommentId" value="${parentCommentId}">
                <div class="comment_input">
                    <img src="${contextPath}/resources/image/review/007.png"/>
                    <input class="comment_id" type="text" name="userId" id="userId"
                        placeholder="로그인 후 이용 가능" value="${userVO.userId}" required readOnly>
                    <input class="comment_text" type="text" name="ac_content" id="ac_content"
                        placeholder="댓글 내용" required autocomplete="off">
                    <button type="submit" id="commentBt">댓글 입력</button>
                </div>
            </form>
        `;
			$(this).append(formHTML);
		} else {
			// 이미 자식 댓글 입력 폼이 열려있다면 해당 폼을 숨깁니다.
			commentForm.hide();
		}
	});

</script>
</body>
</html>