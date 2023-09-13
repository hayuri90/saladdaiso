<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>	<!-- 하유리: Tiles가 제공하는 태그 라이브러리 추가(23.07.25.) -->
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html >
<html>
<head>
	<meta charset="utf-8">
	<!-- Daum에서 제공하는 주소 검색을 사용하기 위해 포함 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<!-- 부트스트랩 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- CSS -->
 	<link href="../resources/css/header.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/footer.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/mypage/myDetailInfo.css" rel="stylesheet" type="text/css" >
</head>

<body>
	<div class="total">
		<div class="join_sub">
			<p class="text_center">#회원 상세 정보</p>
		</div>
		<div class="lineAndForm">
			<div class="top_line">		
				<span class="basic">정보입력</span>	
				<span class="essential">*</span>
				<span class="essential_input">필수입력사항</span>
			</div>
			<div class="userForm">
				<form name="frm_mod_user" >
					<table>
						<tbody>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">아이디<span class="essential">*</span>
								</td>	
								<td align="left">
									<input class="join_input" type="text" name="userId" id="userId" minlength="2" maxlength="10" required  value="${user.userId }" disabled/>					<!-- 서승희: <style> 삭제(23.08.01.) -->					
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">비밀번호<span class="essential">*</span>	
								</td>
								<td>
									<input class="join_input" name="userPwd" id="userPwd" type="password" minlength="4" maxlength="12" required  value="${user.userPwd }" />
								</td>
								<td class="btn_modify">
									<button class="btn-cursor-pointer" type="button" onClick="fn_modify_user_info('userPwd')">
										<img src="${contextPath}/resources/image/mypage/modify.png" alt="userPwd" class="userPwd_img">
									</button>
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">비밀번호 확인<span class="essential">*</span>
								</td>	
								<!-- 서승희: 비밀번호 확인(23.07.27.) -->
								<!-- onkeyup="JS function" 입력이 되었을 때 -->
								<td>
									<input type="password" class="join_input" id="userPwdConfirm" name="userPwdConfirm" 
										   placeholder="비밀번호 확인" onkeyup="passConfirm()">
								</td>
								<td><span id ="confirmMsg"></span></td>
							</tr>
							
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">이름<span class="essential">*</span>
								</td>
								<td>
									<input type="text" class="join_input" name="userName" value="${user.userName }" minlength="2" maxlength="10" required />
								</td>			
								<td class="btn_modify">
									<button type="button" class="btn-cursor-pointer" onClick="fn_modify_user_info('userName')">
										<img src="${contextPath}/resources/image/mypage/modify.png" alt="userName" class="userName_img">
									</button>
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">성별<span class="essential">*</span>																	<!-- 하유리: <span> 태그 추가, align속성 삭제(23.07.25.) -->
								</td>
								<td class="userGender" align="left">
									<c:choose>
					  					<c:when test="${user.userGender=='남' }">
						 					<input type="radio" class="radio_woman" name="userGender" value="여" />여성
						 					<input type="radio" class="radio_man" name="userGender" value="남" style="margin-left:10px" checked />남성
										</c:when>
							 			<c:otherwise>
							 				<input type="radio" name="userGender" value="여" checked  />여성
												<span class="genderTxt"></span>
							 				<input type="radio" name="userGender" value="남" />남성
							 			</c:otherwise>
								 	</c:choose>
								</td>
								<td class="btn_modify">
									<button class="btn-cursor-pointer" type="button" onClick="fn_modify_user_info('userGender')">
										<img src="${contextPath}/resources/image/mypage/modify.png" alt="userGender">
									</button>
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label" id="label_email">이메일<span class="essential">*</span>
								</td>
								<td>
									<input type="email" class="join_input" id="userEmail" name="userEmail" value="${user.userEmail }" 
										   style="margin-bottom: 10px;"/>
									<c:choose> 
						    		<c:when test="${user.emailsts_yn=='true' || user.emailsts_yn=='Y,'}">
						      			<input type="checkbox" class="email_chk" id="emailsts_y" name="emailsts_yn" value="Y," checked />
						      			<span class="email_chk_text">쇼핑몰에서 발송하는 e-mail을 수신합니다.</span>
									</c:when>
									<c:otherwise>
							  			<input type="checkbox" class="email_chk" name="emailsts_yn" id="emailsts_n" value="N" />
							  			<span class="email_chk_text" >쇼핑몰에서 발송하는 e-mail을 수신합니다.</span>
									</c:otherwise>
						 			</c:choose>
								</td>
								<td  class="btn_modify">
									<button type="button" class="btn_modify_email btn-cursor-pointer" onClick="fn_modify_user_info('email')">
										<img src="${contextPath}/resources/image/mypage/modify.png" alt="email">
									</button>
								</td> 
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">생년월일<span class="essential">*</span>	
								</td>
								<td>
									<input type="text" class="join_input" name="userBirth" value="${user.userBirth }" maxlength="8" required />
								</td>
								<td class="btn_modify">
									<button type="button" class="btn-cursor-pointer" onClick="fn_modify_user_info('userBirth')">
										<img src="${contextPath}/resources/image/mypage/modify.png" alt="userBirth" class="userBirth_img">
									</button>
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label" id="label_phone">연락처<span class="essential">*</span>
								</td>
								<td>
									<input type="text" class="join_input" name="userPhone" value="${user.userPhone }" 
										   maxlength="12" required style="margin-bottom: 10px;"/>
									<c:choose>
										<c:when test="${user.smssts_yn=='true' || user.smssts_yn=='Y,'}">
									     	<input class="sms_chk" type="checkbox"  name="smssts_yn"  id="smssts_y"  value="Y,"  checked /><span class="sms_chk_text" >쇼핑몰에서 발송하는 SMS를 수신합니다.</span>
									   	</c:when>
									   	<c:otherwise>
										  	<input class="sms_chk" type="checkbox"  name="smssts_yn" id="smssts_n"  value="N" /><span class="sms_chk_text" >쇼핑몰에서 발송하는 SMS를 수신합니다.</span>		
										</c:otherwise>
									</c:choose>	
					 			</td>
								<td class="btn_modify">
									<button type="button" class="btn_modify_phone btn-cursor-pointer" onClick="fn_modify_user_info('phone')">
										<img src="${contextPath}/resources/image/mypage/modify.png" alt="phone">
									</button>
								</td>
							</tr>
								<tr class="dot_line">
									<td class="fixed_join">
										<p class="join_label">주소<span class="essential">*</span>
									</td>
									<td>
										<p class="addressTxt"> 
										  	<input type="button" class="addBtn" onClick="location.href='javascript:execDaumPostcode()'" 
										  		   value="주소 검색" style="width:100%; "/>
										  	<br><br>
										  	<!-- 주소 검색 API -->
											<input type="text" class="join_input" id="userAddress1" name="userAddress1" value="${user.userAddress1 }" 
												   placeholder="기본주소 입력" size="30" />
											<br><br>
										  	<input type="text" class="join_input" id="userAddress2" name="userAddress2" value="${user.userAddress2 }" 
										  		   placeholder="상세주소 입력" size="30" />
										  	<br><br>
									   	</p>
								  	</td>
									<td  class="btn_modify">
										<button type="button" class="btn_modify_address btn-cursor-pointer" onClick="fn_modify_user_info('address')">
											<img src="${contextPath}/resources/image/mypage/modify.png" alt="address" class="userAddress_img">
										</button>
									</td>
								</tr>
						</tbody>
					</table>	
		
					<div class="clear" align="center">
						<input type="hidden" name="command" value="modify_my_info" /> 
						<input type="reset" class="btn-cancel" name="btn_cancel_user" value="수정취소">
						<input type="button" class="btn-delete-user" value="회원탈퇴" onclick="removeMember();" />
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
	//주소검색
	function execDaumPostcode() {
	  new daum.Postcode({
	    oncomplete: function(data) {
	      //팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	      //도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	      //내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	      var fullRoadAddr = data.roadAddress;  //도로명 주소 변수
	      var extraRoadAddr = ''; //도로명 조합형 주소 변수
	
	      //법정동명이 있을 경우 추가한다. (법정리는 제외)
	      //법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	        extraRoadAddr += data.bname;
	      }
	      //건물명이 있고, 공동주택일 경우 추가한다.
	      if(data.buildingName !== '' && data.apartment === 'Y'){
	        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	      }
	      //도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	      if(extraRoadAddr !== ''){
	        extraRoadAddr = ' (' + extraRoadAddr + ')';
	      }
	      //도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	      if(fullRoadAddr !== ''){
	        fullRoadAddr += extraRoadAddr;
	      }
	      //주소 정보를 해당 필드에 넣는다.
	      document.getElementById('userAddress1').value = fullRoadAddr;
	    }
	  }).open();
	} 
	
	//수정하기 버튼 클릭 시
	//수정된 회원 정보의 속성과 수정 값을 컨트롤러로 전송합니다.
	//수정할 특정 속성을 나타내는 'attribute'를 매개변수로 받고 `value`로 변수를 초기화
	 function fn_modify_user_info(attribute){
		var value;
		var frm_mod_user=document.frm_mod_user;
		if(attribute=='userPwd'){
			value=frm_mod_user.userPwd.value;
		}else if(attribute=='userName'){
			value=frm_mod_user.userName.value;
		} else if(attribute=='userGender'){
			var userGender=frm_mod_user.userGender;
			for(var i=0;userGender.length;i++){
				if(userGender[i].checked){
					value=userGender[i].value;
					break;
				}
			}
		}else if(attribute=='email'){  //23.07.20 이메일 수신동의 수정
			var userEmail=frm_mod_user.userEmail;
			var emailsts_yn=frm_mod_user.emailsts_yn;
			
			value_userEmail=userEmail.value;
			value_emailsts_yn=emailsts_yn.checked;
			value=value_userEmail+","+value_emailsts_yn;
			//alert(value);
		}else if(attribute=='userBirth'){
			value=frm_mod_user.userBirth.value;
		}else if(attribute=='phone'){  //23.07.20 연락처 수신동의 수정
			var userPhone=frm_mod_user.userPhone;
			var smssts_yn=frm_mod_user.smssts_yn;
			
			value_userPhone=userPhone.value;
			value_smssts_yn=smssts_yn.checked;
			value=value_userPhone+","+value_smssts_yn;
		}else if(attribute=='address'){
			var userAddress1=frm_mod_user.userAddress1;
			var userAddress2=frm_mod_user.userAddress2;
			
			value_userAddress1=userAddress1.value;
			value_userAddress2=userAddress2.value;
			value=value_userAddress1+","+value_userAddress2;
		} 
		console.log(attribute);
		
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/mypage/modifyMyInfo.do",
			data : {
				attribute:attribute,
				value:value,
			},
			success : function(data, textStatus) {
				if(data.trim()=='mod_success'){
					alert("회원 정보를 수정했습니다.");
				}else if(data.trim()=='failed'){
					alert("다시 시도해 주세요.");	
				}
			},
			error : function(data, textStatus) {
				alert("다시 시도해 주세요."+data);
			},
			complete : function(data, textStatus) {
				
			}
		}); //end ajax
	}
	
	  //비밀번호 확인 
	  //23.07.27 서승희 비밀번호 확인 추가
		function passConfirm() {
		/* 비밀번호, 비밀번호 확인 입력창에 입력된 값을 비교해서 같다면 비밀번호 일치, 그렇지 않으면 불일치 라는 텍스트 출력.*/
		/* document : 현재 문서를 의미함. 작성되고 있는 문서를 뜻함. */
		/* getElementByID('아이디') : 아이디에 적힌 값을 가진 id의 value를 get을 해서 password 변수 넣기 */
		var password = document.getElementById('userPwd');					//비밀번호 
		var passwordConfirm = document.getElementById('userPwdConfirm');	//비밀번호 확인 값
		var confirmMsg = document.getElementById('confirmMsg');				//확인 메세지
		var correctColor = "#32cd32";	//맞았을 때 출력되는 색깔.
		var wrongColor ="#ff0000";		//틀렸을 때 출력되는 색깔
		
		if(password.value == passwordConfirm.value){//password 변수의 값과 passwordConfirm 변수의 값과 동일하다.
			confirmMsg.style.color = correctColor;/* span 태그의 ID(confirmMsg) 사용  */
			confirmMsg.innerHTML ="일치";/* innerHTML : HTML 내부에 추가적인 내용을 넣을 때 사용하는 것. */
		}else{
			confirmMsg.style.color= wrongColor;
			confirmMsg.innerHTML ="불일치";
			}
		}
	  
	  //서승희: 회원탈퇴하기 추가(23.07.31.)
	function removeMember() {
		if(window.confirm("정말 탈퇴 하시겠습니까?")){
		location.href="${contextPath}/mypage/removeUser.do";
		}
	}
	</script>
	
</body>
</html>