<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
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
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
     <!-- css 적용 -->
   <!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
 	<link href="../resources/css/header.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/footer.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/mypage/myDetailInfo.css" rel="stylesheet" type="text/css" >	<!-- 하유리: css 적용(23.07.25.) -->
	<style>
	/* #login_table{
	width:100%;
	 display: flex;
	 justify-content: center;
	}
	.user-form {
           display: inline-block;
           padding: 30px;
        } */
   /*  .fixed_join{
     	 justify-content: center;
         padding-top:12px;
         padding-right:15px;
         }  */

	</style>

</head>

<body>
	<div class="total">															<!-- 하유리: div 추가(23.07.25.) -->
		<div class="join_sub">													<!-- 하유리: div 추가(23.07.25.) -->
			<!-- 23.08.01 서승희 제목 수정 -->
			<p class="text_center">#회원 상세 정보</p>						<!-- 하유리: style 태그 적용하기 위해 <p>태그로 수정, 텍스트 수정(23.07.25.) -->
		</div>
		<div class="lineAndForm">											<!-- 하유리: div 추가(23.07.25.) -->
			<!-- 하유리: 구분선 및 텍스트 추가(23.07.25.) -->
			<div class="top_line">		
				<span class="basic">정보입력</span>	
				<span class="essential">*</span>
				<span>필수입력사항</span>
			</div>
			<!-- 하유리: div 추가(23.07.25.) -->
			<div class="userForm">
				<form name="frm_mod_user" >
									<!-- 하유리: <div id="login_table"> 삭제 -->
					<table>	<!-- 하유리: align="center" 삭제(23.07.25.) -->
						<tbody>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">아이디<span class="essential">*</span>	<!-- 하유리: <span> 추가, align속성 삭제(23.07.25.) -->
								</td>	
								<td align="left"><!-- 하유리: class, </td> 추가(23.07.25.) -->
									<input class="join_input" type="text" name="userId"  id="userId"   minlength="2" maxlength="10" required  value="${user.userId }" disabled/>					<!-- 서승희: <style> 삭제(23.08.01.) -->					
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">비밀번호<span class="essential">*</span>						<!-- 하유리: align속성, class, </p><span> 추가(23.07.25.) -->
								</td>
								<td><input class="join_input" name="userPwd" id="userPwd" type="password" minlength="4" maxlength="12" required  value="${user.userPwd }" /></td>	<!-- 하유리: align속성, size 삭제(23.07.25.) -->
								<td  class="btn_modify"><!-- 23.07.31 수정하기 아이콘으로 변경 서승희 -->
								<button class="btn-cursor-pointer" type="button" onClick="fn_modify_user_info('userPwd')">
								<img src="${contextPath}/resources/image/mypage/modify1.png" alt="userPwd" width="27px;" height="27px;">
								</button>
						<!-- 	<input id="btn_modify" name="input" type="button"  value="수정하기" onClick="fn_modify_user_info('userPwd')"/> -->
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">비밀번호 확인<span class="essential">*</span></td>				<!-- 하유리: align속성, class, </p><span> 추가(23.07.25.) -->
								<!-- 23.07.27 서승희 비밀번호 확인 추가 -->
								<!-- onkeyup="JS function" 입력이 되었을 때, -->
								<td><input class="join_input"  type="password" name="userPwdConfirm" id="userPwdConfirm" placeholder="비밀번호 확인" onkeyup="passConfirm()"></td>
								<td><span id ="confirmMsg"></span></td>
							</tr>
							
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">이름<span class="essential">*</span>																	<!-- 하유리: align속성 삭제(23.07.25.) -->
								</td>
								<td><input class="join_input" name="userName" type="text" minlength="2" maxlength="10" required  value="${user.userName }" /></td>				<!-- 하유리: align속성, size 삭제(23.07.25.) -->
								<td  class="btn_modify"><!-- 23.07.31 수정하기 아이콘으로 변경 서승희 -->
								<button class="btn-cursor-pointer" type="button" onClick="fn_modify_user_info('userName')">
								<img src="${contextPath}/resources/image/mypage/modify1.png" alt="userName" width="27px;" height="27px;">
								</button>
								<!-- <input type="button" value="수정하기" onClick="fn_modify_user_info('userName')"/> 
								<span style="display:none;"></span> 버튼의 텍스트가 표시되지 않도록 비어 있는 span 태그를 사용합니다.-->
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">성별<span class="essential">*</span>																	<!-- 하유리: <span> 태그 추가, align속성 삭제(23.07.25.) -->
								</td>
								<td class="userGender" align="left">
									<c:choose>
					  					<c:when test="${user.userGender=='남' }">
						 					<input type="radio" name="userGender" value="여" />여성
												<span class="genderTxt"></span>							
						 					<input type="radio" name="userGender" value="남"  checked style="margin-left:40px" />남성
										</c:when>
						 			<c:otherwise>
						 				 <input type="radio" name="userGender" value="여" checked  />여성
											<span class="genderTxt"></span>
						 				<input type="radio" name="userGender" value="남" />남성
						 			</c:otherwise>
								 </c:choose>
								</td>
								<td  class="btn_modify"><!-- 23.07.31 수정하기 아이콘으로 변경 서승희 -->
								<button class="btn-cursor-pointer" type="button" onClick="fn_modify_user_info('userGender')">
								<img src="${contextPath}/resources/image/mypage/modify1.png" alt="userGender" width="27px;" height="27px;">
								</button>
								<!-- <input type="button" value="수정하기" onClick="fn_modify_user_info('userGender')"/> -->
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join"><p class="join_label" id="label_email">이메일<span class="essential">*</span></td>	<!-- 하유리: align속성, <br>(e-mail) 삭제(23.07.25.) -->
								<td>
									<input class="join_input " type="email" name="userEmail" id="userEmail" value="${user.userEmail }" style="margin-bottom: 10px;"/>			<!-- 하유리: align속성, size 삭제(23.07.25.) -->
								 <!-- 23.07.23 서승희 이메일 수신여부 수정 -->
								<c:choose> 
					    		<c:when test="${user.emailsts_yn=='true' || user.emailsts_yn=='Y,'}">
					      			<input  class="email_chk"  type="checkbox" name="emailsts_yn"   id="emailsts_y"   value="Y,"  checked /><span class="email_chk_text" >쇼핑몰에서 발송하는 e-mail을 수신합니다.</span>	<!-- 23.07.20 email 수신동의 수정 -->
								</c:when>
								<c:otherwise>
						  			<input  class="email_chk"  type="checkbox" name="emailsts_yn"   id="emailsts_n"   value="N" /><span class="email_chk_text" >쇼핑몰에서 발송하는 e-mail을 수신합니다.</span>
								</c:otherwise>
					 			</c:choose>
								</td>
								<td  class="btn_modify"><!-- 23.07.31 수정하기 아이콘으로 변경 서승희 -->
								<button class="btn_modify_email btn-cursor-pointer" type="button" onClick="fn_modify_user_info('email')">
								<img src="${contextPath}/resources/image/mypage/modify1.png" alt="email" width="27px;" height="27px;">
								</button>
								<!-- <input type="button" value="수정하기" onClick="fn_modify_user_info('email')"/> -->
								</td> 
						</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">생년월일<span class="essential">*</span>							<!-- 하유리: align속성 삭제, <span>추가(23.07.25.) -->
								</td>
								<td><input class="join_input" name="userBirth" type="text"  maxlength="8" required  value="${user.userBirth }" /></td>	<!-- 하유리: align속성, size, <br>(e-mail) 삭제(23.07.25.) -->
								<td  class="btn_modify"><!-- 23.07.31 수정하기 아이콘으로 변경 서승희 -->
								<button class="btn-cursor-pointer" type="button" onClick="fn_modify_user_info('userBirth')">
								<img src="${contextPath}/resources/image/mypage/modify1.png" alt="userBirth" width="27px;" height="27px;">
								</button>
								<!-- <input type="button" value="수정하기" onClick="fn_modify_user_info('userBirth')"/> -->
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label" id="label_phone">연락처<span class="essential">*</span>	<!-- 하유리: align속성 삭제, <span>추가(23.07.25.) -->
								</td>
								<td> <input class="join_input" type="text" name="userPhone" maxlength="12" required  value="${user.userPhone }" style="margin-bottom: 10px;"/>	<!-- 하유리: align속성, size삭제, <style> 추가(23.07.25.) -->
									<!-- <select  name="userPhone" id="userPhone">
										<option>없음</option>
										<option selected value="010">010</option>
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
										<option value="0502">0502</option>
										<option value="0503">0503</option>
										<option value="0505">0505</option>
										<option value="0506">0506</option>
										<option value="0507">0507</option>
										<option value="0508">0508</option>
										<option value="070">070</option>
									</select>  -->
					<!-- 23.07.23 서승희 연락처 수신여부 수정 -->
					<c:choose> 
					   <c:when test="${user.smssts_yn=='true' || user.smssts_yn=='Y,'}">
					     <input class="sms_chk" type="checkbox"  name="smssts_yn"  id="smssts_y"  value="Y,"  checked /><span class="sms_chk_text" >쇼핑몰에서 발송하는 SMS를 수신합니다.</span> <!-- 23.07.20 sms 수신동의 수정 -->
					   </c:when>
					   <c:otherwise>
						  <input class="sms_chk" type="checkbox"  name="smssts_yn" id="smssts_n"  value="N" /><span class="sms_chk_text" >쇼핑몰에서 발송하는 SMS를 수신합니다.</span>		
							</c:otherwise>
					 	</c:choose>	
					 	</td>
						<td  class="btn_modify"><!-- 23.07.31 수정하기 아이콘으로 변경 서승희 -->
						<button class="btn_modify_phone btn-cursor-pointer" type="button" onClick="fn_modify_user_info('phone')">
						<img src="${contextPath}/resources/image/mypage/modify1.png" alt="phone" width="27px;" height="27px;">
						</button>
						<!-- <input type="button" value="수정하기" onClick="fn_modify_user_info('phone')"/> -->
						</td>
						</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">주소<span class="essential">*</span>	<!-- 하유리: align속성 삭제, <span>추가(23.07.25.) -->
								</td>
								<td>																								<!-- 하유리: align속성 삭제(23.07.25.) -->
									<p class="addressTxt"> 
									  	<input class="addBtn" type="button" onClick="location.href='javascript:execDaumPostcode()'"value="주소 검색" style="width:100%; "/><br><br>
									  	<!-- 서승희 주소검색 부분 추가 23.07.19 --><!-- 하유리: 기본주소: , 상세주소: 텍스트 삭제 + placeholder 수정 + 버튼 윗부분으로 이동(23.07.25.) -->
										<!-- 기본 주소:  --><input class="join_input" type="text" id="userAddress1" name="userAddress1" size="30" value="${user.userAddress1 }" placeholder="기본주소 입력" /><br><br>
									  	<!-- 상세 주소:  --><input class="join_input" type="text" id="userAddress2"  name="userAddress2" size="30" value="${user.userAddress2 }" placeholder="상세주소 입력" /><br><br>
								   </p>
								  </td>
								<td  class="btn_modify"><!-- 23.07.31 수정하기 아이콘으로 변경 서승희 -->
								<button class="btn_modify_address btn-cursor-pointer" type="button" onClick="fn_modify_user_info('address')">
								<img src="${contextPath}/resources/image/mypage/modify1.png" alt="address" width="27px;" height="27px;">
								</button>
								<!-- <input type="button" value="수정하기" onClick="fn_modify_user_info('address')"/> -->
								</td>
							</tr>
						</tbody>
					</table>	
		
					<div class="clear" align="center">
						<input type="hidden" name="command"  value="modify_my_info" /> 
						<!-- <input name="btn_cancel_member" type="button"  value="수정 취소"> -->
						<%-- <input name="btn_modify_user" type="button" onclick="fn_modify_user_info('modify_all')"  value="수정하기"> --%>
						<input class="btn-cancel" name="btn_cancel_user" type="reset"  value="수정취소">
						<%-- <input type="button" onclick="location.href='${contextPath}/mypage/removeUser.do?userId=${user.userId}'" value="회원탈퇴"/> --%>
						<!-- 23.07.31 서승희 회원탈퇴 수정 -->
						<input class="btn-delete-user" type="button" onclick="removeMember();" value="회원탈퇴"/>
						<!-- <br><br> -->					<!-- 하유리: <br> 주석처리(23.08.02.) -->
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
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var fullRoadAddr = data.roadAddress;  // 도로명 주소 변수
      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if(data.buildingName !== '' && data.apartment === 'Y'){
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if(extraRoadAddr !== ''){
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
      if(fullRoadAddr !== ''){
        fullRoadAddr += extraRoadAddr;
      }
      // 주소 정보를 해당 필드에 넣는다.
      document.getElementById('userAddress1').value = fullRoadAddr;
    }
  }).open();
} 

//수정하기 버튼 클릭 시
// 수정된 회원 정보의 속성과 수정 값을 컨트롤러로 전송합니다.
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
	var wrongColor ="#ff0000";	//틀렸을 때 출력되는 색깔
	
	if(password.value == passwordConfirm.value){//password 변수의 값과 passwordConfirm 변수의 값과 동일하다.
		confirmMsg.style.color = correctColor;/* span 태그의 ID(confirmMsg) 사용  */
		confirmMsg.innerHTML ="일치";/* innerHTML : HTML 내부에 추가적인 내용을 넣을 때 사용하는 것. */
	}else{
		confirmMsg.style.color= wrongColor;
		confirmMsg.innerHTML ="불일치";
		}
	}
  
  //회원탈퇴하기 
  //23.07.31 서승희 회원탈퇴 추가
function removeMember() {
	if(window.confirm("정말 탈퇴 하시겠습니까?")){
	location.href="${contextPath}/mypage/removeUser.do";
	}
}
</script>
	
</body>
</html>