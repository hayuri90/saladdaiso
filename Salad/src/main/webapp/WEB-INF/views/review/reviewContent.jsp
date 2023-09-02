<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
		<div class="content_table">
			<input type="hidden" name="re_articleNO" value="${review.re_articleNO }" disabled />
			<table>
				<!-- 김동혁: 답글형은 주문번호 숨기기(23.08.01) -->
				<c:if test="${review.re_fakeOrderNum != null}">
					<tr>
						<th>주문번호</th>
						<td><input type="text" class="content_input" name="re_fakeOrderNum" value="${review.re_fakeOrderNum}" disabled/></td>
					</tr>
				</c:if>
				<tr>
					<th>작성자</th>
					<td><input type="text" class="content_input" name="userId" value="${review.userId }" disabled /></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" class="content_input" name="review_title" value="${review.re_title }" disabled /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea class="content_text" name="review_content" cols="50" rows="10" disabled>${review.re_content }</textarea></td>
				</tr>
				<tr>
					<th>업로드 이미지</th>
					<td>
						<c:choose>
							<c:when test="${empty review.re_imageFileList}">
								<input type="text" class="content_input" name="orderList" disabled/>
							</c:when>
							<c:otherwise>
								<div class="content_input_file">
									<c:forEach items="${review.re_imageFileList}" var="re_imageFileList">
										<input type="text" class="review_imgName" name="review_image" value="${re_imageFileList.re_originalFileName}" disabled/><br/>
										<img class="review_preview" src="${contextPath}/review/imgDown?re_storedFileName=${re_imageFileList.re_storedFileName}" style="width:200px;"/><br/>
									</c:forEach>
								</div>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td><input class="content_input" name="review_viewCnt" value="${review.re_viewCnt }" disabled></td>
				</tr>
	
				<tr>
					<th>작성일</th>
					<td><input class="content_input" name="review_upload" value="${review.re_writeDate }" disabled></td>
				</tr>
			</table>
	
			<!-- 버튼 -->
			<div class="btn_wrap">	
				<div class="content_btn1">
					<button type="button" class="contentBtn" onClick="location.href='${contextPath}/review/list'">목록</button>
				</div>
				<div class="content_btn2">
					<!-- 김동혁: 답글 버튼 admin만 사용 가능 -->
					<c:if test="${user.userId == 'admin'}">
						<button type="button" class="contentBtn"
								onClick="location.href='${contextPath}/review/reply?re_articleNO=${review.re_articleNO }'">답글</button>
					</c:if>
					<!-- 하유리: 본인 게시글만 수정, 삭제할 수 있도록 처리(23.07.18.) -->
					<c:if test="${user.userId == review.userId }">
						<button type="button" class="contentBtn"
								onClick="location.href='${contextPath}/review/update?re_articleNO=${review.re_articleNO }'">수정</button>
						<button type="button" class="contentBtn"
								onClick="location.href='${contextPath}/review/delete?re_articleNO=${review.re_articleNO }'">삭제</button>
					</c:if>
				</div>
			</div>
		</div>
	
		<!-- 댓글 작성 폼 -->
		<div class="comment_wrap">
			<div id="commentForm2">
				<form id="commentForm" method="POST">
					<p>댓글<p>
					<div class="comment_input">
						<img src="${contextPath }/resources/image/review/007.png"/>
						<input class="comment_id" type="text" name="userId" id="userId"
							   placeholder="로그인 후 이용 가능" value="${userVO.userId}" required readOnly>
						<input class="comment_text" type="text" name="ac_content" id="ac_content"
							   placeholder="댓글 내용" required autocomplete="off">
						<button type="submit" id="commentBt">댓글 입력</button>
					</div>
				<!-- 댓글 목록 테이블 -->
				</form>
				<div id="commentList">
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function () {
			$.ajax({
				url: '${contextPath}/review/getCommentList', //실제 댓글을 추가하는 서버 URL로 대체해주세요
				type: 'POST',
				data: {},
				dataType: 'json',
				success: function (response) {
					//서버에서 정상적으로 데이터를 받아왔을 때 실행되는 부분
					var commentList = $('#commentList');
					commentList.empty(); //기존 목록을 비웁니다.
	
					for (var i = 0; i < response.length; i++) {
						var comment = response[i];
						var newComment = $('<div class="line">');                                                                  					/* 하유리 변수명 변경(23.08.02.) */
						var levelSum = 0;
	
						if (comment.ac_parentNO !== 0) {
							for(var j = 1; j < comment.level; j++) {
								levelSum += 40;
								console.log('레벨 : '+ comment.level);
							}
							newComment = $('<div class="line">').css('padding-left', levelSum + 'px');
							//newComment.addClass('line-child');
						}
						newComment.append($('<img src="${contextPath }/resources/image/review/006.png"/>'));	
						newComment.append($('<div class="line-userId">').text(comment.userId));             	
						newComment.append($('<div class="line-title">').text(comment.ac_content));           	
						var dateString = new Date(comment.ac_writeDate).toISOString().split('T')[0];
						newComment.append($('<div class="line-content">').text('등록일자: ' + dateString));      	
						newComment.append($('<button class="line-comment" name="reply" onclick="showCommentForm('+i+')">・ 대댓글</button>'));	
						
						/* 하유리: 자꾸 <form>태그가 바로 닫혀서, 위의 코드를 1줄로 작성(23.08.02.) */
						var ac_commentNoValue = comment.ac_commentNO;
						newComment.append($('<form id="comment_reply_Form_' + i + '" method="POST" style="display:none;"><input type="text" id="reply-NO_' + i + '" value="' + ac_commentNoValue + '" hidden><input type="text" class="comment_text2" id="reply-input_' + i + '" placeholder="대댓글을 입력해주세요" autocomplete="off"><button type="submit" id="commentBt2_' + i + '" class="reply-btn">대댓글 입력</button></form>'));
						console.log('넘버 내용: ' + ac_commentNoValue);
						commentList.append(newComment);
					}
				},
				error: function() {
					alert('비회원 상태입니다.\n로그인 창으로 넘어갑니다.');
					location.href = '${contextPath}/user/loginForm.do';
				}
			});
		});
		
		/* 하유리: '대댓글' 버튼 클릭 시, 대댓글 작성폼 보이기/숨기기(23.08.02.) */
		function showCommentForm(i) {
			if($('#comment_reply_Form_' + i + '').css('display')=='block') {
				$('#comment_reply_Form_' + i + '').css('display','none');
			} else {
				$('#comment_reply_Form_' + i + '').css('display','block');			
			}
		}
	
		//인덱스를 이용하여 적절한 폼 요소를 선택하기 위해 click 이벤트를 수정합니다.
		$(document).on('click', '[id^="commentBt2_"]', function(event) {
		    event.preventDefault();
		    var commentIndex = $(this).attr('id').split('_')[1]; //버튼의 id에서 댓글 인덱스를 추출합니다.
		    var ac_parentNO = $('#reply-NO_' + commentIndex).val(); //부모넘버
		    var ac_content = $('#reply-input_' + commentIndex).val(); //대댓글 내용
		    console.log('댓글 번호: ' + ac_parentNO);
		    console.log('대댓글 내용: ' + ac_content);
		    //댓글 데이터를 사용하여 원하는 동작을 수행합니다.
	
		 	//댓글 추가를 위한 AJAX 요청 보내기
	        $.ajax({
	            url: '${contextPath}/review/addReply', //실제 댓글을 추가하는 서버 URL로 대체해주세요
	            type: 'POST',
	            data: {ac_parentNO : ac_parentNO, ac_content : ac_content},
	            dataType: 'json',
	            success: function (response) {
	             //서버에서 정상적으로 데이터를 받아왔을 때 실행되는 부분
	                var commentList = $('#commentList');
	                commentList.empty(); //기존 목록을 비웁니다.
	
	                for (var i = 0; i < response.length; i++) {
	                    var comment = response[i];
	                    var newComment = $('<div class="line">');
						var levelSum = 0;
	
						if (comment.ac_parentNO !== 0) {
							for(var j = 1; j < comment.level; j++) {
								levelSum += 40;
								console.log('레벨 : '+ comment.level);
							}
							newComment = $('<div class="line">').css('padding-left', levelSum + 'px');
							//newComment.addClass('line-child');
						}
	                    newComment.append($('<img src="${contextPath }/resources/image/review/006.png"/>'));	
	                    newComment.append($('<div class="line-userId">').text(comment.userId));					
	                    newComment.append($('<div class="line-title">').text(comment.ac_content));				
	                    var dateString = new Date(comment.ac_writeDate).toISOString().split('T')[0];
	                   newComment.append($('<div class="line-content">').text('등록일자: ' + dateString));			
	                    newComment.append($('<button class="line-comment" name="reply"  onclick="showCommentForm('+i+')">・ 대댓글</button>'));	
	                    
						/* 하유리: 자꾸 <form>태그가 바로 닫혀서, 위의 코드를 1줄로 작성(23.08.02.) */
						var ac_commentNoValue = comment.ac_commentNO;
						newComment.append($('<form id="comment_reply_Form_' + i + '" method="POST" style="display:none;"><input type="text" id="reply-NO_' + i + '" value="' + ac_commentNoValue + '" hidden><input type="text" class="comment_text2" id="reply-input_' + i + '" placeholder="대댓글을 입력해주세요" autocomplete="off"><button type="submit" id="commentBt2_' + i + '" class="reply-btn">대댓글 입력</button></form>'));
						console.log('넘버 내용: ' + ac_commentNoValue);
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
			event.preventDefault(); //폼의 기본 동작인 제출을 막습니다.
	
			var ac_content = $('#ac_content').val(); //댓글 내용을 가져옵니다.
			var userId = $('#userId').val();
	
	        console.log('클릭!');
	
			//댓글 추가를 위한 AJAX 요청 보내기
			$.ajax({
				url: '${contextPath}/review/addComment', //실제 댓글을 추가하는 서버 URL로 대체해주세요
				type: 'POST',
				data: {ac_content : ac_content, userId : userId},
				dataType: 'json',
				success: function (response) {
					//서버에서 정상적으로 데이터를 받아왔을 때 실행되는 부분
					var commentList = $('#commentList');
					commentList.empty(); //기존 목록을 비웁니다.
	
					for (var i = 0; i < response.length; i++) {
						var comment = response[i];
						var newComment = $('<div class="line">');
						var levelSum = 0;
	
						if (comment.ac_parentNO !== 0) {
							for(var j = 1; j < comment.level; j++) {
	                            console.log('levelSum : ' + levelSum);
								levelSum += 40;
								console.log('레벨 : '+ comment.level);
							}
							newComment = $('<div class="line">').css('padding-left', levelSum + 'px');
							//newComment.addClass('line-child');
						}
						newComment.append($('<img src="${contextPath }/resources/image/review/006.png"/>'));
						newComment.append($('<div class="line-userId">').text(comment.userId)); 
						newComment.append($('<div class="line-title">').text(comment.ac_content)); 
						var dateString = new Date(comment.ac_writeDate).toISOString().split('T')[0];
						newComment.append($('<div class="line-content">').text('등록일자: ' + dateString));
	
						newComment.append($('<button class="line-comment" name="reply"  onclick="showCommentForm('+i+')">・ 대댓글</button>'));
						
						/* 하유리: 자꾸 <form>태그가 바로 닫혀서, 코드를 1줄로 작성(23.08.02.) */
						var ac_commentNoValue = comment.ac_commentNO;
						newComment.append($('<form id="comment_reply_Form_' + i + '" method="POST" style="display:none;"><input type="text" id="reply-NO_' + i + '" value="' + ac_commentNoValue + '" hidden><input type="text" class="comment_text2" id="reply-input_' + i + '" placeholder="대댓글을 입력해주세요" autocomplete="off"><button type="submit" id="commentBt2_' + i + '" class="reply-btn">대댓글 입력</button></form>'));
						console.log('넘버 내용: ' + ac_commentNoValue);
						commentList.append(newComment);
						
						$('#ac_content').val('');	/* 하유리: '댓글 입력' 버튼 클릭 후 입력이 완료되면 input에 작성한 내용 지우기(23.08.02.) */
					}
				},
				error: function() {
					alert('비회원 상태입니다.\n로그인 창으로 넘어갑니다.');
					location.href = '${contextPath}/user/loginForm.do';
				}
			});
		});	
	</script>
</body>
</html>