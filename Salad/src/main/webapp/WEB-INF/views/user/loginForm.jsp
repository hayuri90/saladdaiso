<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
     <!-- css 적용 -->
    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
 	<link href="../resources/css/header.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/footer.css" rel="stylesheet" type="text/css" >
	<link href="${contextPath}/resources/css/userForm/loginForm.css" rel="stylesheet" type="text/css" >	<!-- 하유리: login -->
	
	<c:if test='${result==not empty message }'>
	<script>
		window.onload=function()
		{
			alert("아이디나  비밀번호가 틀립니다. 다시 로그인해주세요");
		}
	</script>
	</c:if>
</head>

<body>
	<div class="loginForm">			<!-- 하유리: <div> 추가(23.07.26.) -->
		<div class="login_wrap">		<!-- 하유리: <div> 추가(23.07.26.) -->
			<a href="${contextPath}/main.do">	<!-- 하유리: 로고 이미지 클릭 시 메인 이동 링크 추가(23.07.26.) -->
				<img src="${contextPath}/resources/image/user/logo.png"/>	<!-- 하유리: 로고 이미지 추가(23.07.26.) -->
			</a>
			<!-- <h1 align="center">회원 로그인 </h1> -->				<!-- 하유리: 해당 태그 주석처리(23.07.26.) -->
			<div id="login_table">
			 	<!-- 로그인 클릭 시 /user/login.do로 요청  -->
				<form action="${contextPath}/user/login.do" method="post" class="login-form">
					<!-- 하유리: table border="1", <tbody>, <tr> 속성, <td> 주석처리(23.07.26.) -->
					<table class="login_input">
						<!-- <tbody> -->
							<tr><!-- <tr class="dot_line"  align="center"> -->	
								<!-- <td class="fixed_join">아이디</td> -->	
								<td><input class="userId" name="userId" type="text" size="20" placeholder="아이디" autocomplete="off"/></td>
							</tr>
							<tr>
							<!-- <tr class="solid_line"  align="center"> -->
								<!-- <td class="fixed_join">비밀번호</td> -->
								<td><input name="userPwd" type="password" size="20" placeholder="비밀번호" autocomplete="off"/></td>
							</tr>
						<!-- </tbody> -->
					</table>
					<div class="btnCen">
						<input type="submit" value="로그인" class="btnLogin"/>
						<br> 
						<!-- <input type="reset" value="다시입력" class="btnCancel"/> -->		<!-- 하유리: 주석처리(23.07.26.) -->
						<input type="button" onclick="location.href='${contextPath}/user/userForm.do'" value="회원가입" />
					</div>
				</form>	
			</div>
			
			<!-- 하유리: footer 추가(23.07.26.) -->
			<div class="login_footer">
				<div class="serviceList">
					<a href="#">이용약관</a>
					<a href="#">개인정보</a>
					<a href="#">처리방침</a>
					<a href="#">운영정책</a>
					<a href="#">고객센터</a>
					<a href="#">공지사항</a>
				</div>
				<div class="copyright">
					Copyright © saladdaiso Corp. All rights reserved.
				</div>
			</div>
			<!-- footer-end -->
		</div>
	</div>
</body>
</html>