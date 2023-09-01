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
	<!-- 부트스트랩 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- CSS -->
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
	<div class="loginForm">
		<div class="login_wrap">
			<a href="${contextPath}/main.do">
				<img src="${contextPath}/resources/image/user/logo.png"/>
			</a>
			<div id="login_table">
			 	<!-- 로그인 클릭 시 /user/login.do로 요청  -->
				<form action="${contextPath}/user/login.do" method="post" class="login-form">
					<table class="login_input">
						<tr>
							<td><input type="text" class="userId" name="userId" size="20" placeholder="아이디" autocomplete="off"/></td>
						</tr>
						<tr>
							<td><input type="password" name="userPwd" size="20" placeholder="비밀번호" autocomplete="off"/></td>
						</tr>
					</table>
					<div class="btnCen">
						<input type="submit" class="btnLogin" value="로그인" /><br>
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