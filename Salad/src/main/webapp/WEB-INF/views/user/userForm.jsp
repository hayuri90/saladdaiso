<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>	<!-- 하유리: Tiles가 제공하는 태그 라이브러리 추가(23.07.25.) -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!--  숫자, 날짜, 시간형식을 사용하기 위해 라이브러리 추가 -->
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html >
<html>
<head>
	<meta charset="utf-8">
	<!-- Daum에서 제공하는 주소 검색을 사용하기 위해 포함 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- CSS -->
	<link href="../resources/css/header.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/footer.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/userForm/userForm.css" rel="stylesheet" type="text/css" >
</head>

<body>
	<div class="total">
		<div class="join_sub">
			<p class="text_center">회원가입</p>
		</div>
		<div class="lineAndForm">
			<div class="top_line">		
				<span class="basic">정보입력</span>	
				<span class="essential">*</span>
				<span>필수입력사항</span>
			</div>
			<div class="userForm">
				<form action="${contextPath}/user/addUser.do" method="post"  class="user-form">
					<table>
						<tbody>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">아이디<span class="essential">*</span>
								</td>	
								<td align="left">
									<input type="text" class="join_input" id="_user_id" name="_user_id" 
										   style="width: 65%;" minlength="2" maxlength="10" required placeholder="ID(2-10자)" />
									<!-- ID 중복검사 기능 구현(23.07.18) -->
									<input type="hidden" id="userId" name="userId" />
									<input type="button" class="btn btn-outline-success" id="btnOverlapped" value="중복체크"
										   style="width: 33%;" onClick="fn_overlapped()" />
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">비밀번호<span class="essential">*</span>																
								</td>
								<td>
									<input type="password" class="join_input" id="userPwd" name="userPwd" 
										   minlength="4" maxlength="12" required placeholder="비밀번호(4-12자)"/></td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">이름<span class="essential">*</span>
								</td>
								<td><input type="text" class="join_input" name="userName" minlength="2" maxlength="10" required placeholder="이름(2-10자)" /></td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">성별<span class="essential">*</span>
								</td>
								<td class="userGender" align="left">
									<input type="radio" class="userGender" name="userGender" value="여" />
									<span class="genderTxt">여성</span>
									<input type="radio" class="userGender" name="userGender" value="남" style="margin-left:40px"/>
									<span class="genderTxt">남성</span>
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join"><p class="join_label" id="label_email">이메일<span class="essential">*</span></td>
								<td>
									<input type="email" class="join_input" id="userEmail" name="userEmail" placeholder="E-mail 입력"
										   style="margin-bottom: 10px;"/>
									<br>
									<input type="checkbox" class="email_chk" id="emailsts_y" name="emailsts_yn" value="Y" 
										   onclick="checkBoxValue();" checked/>
									<span class="email_chk_text" >쇼핑몰에서 발송하는 e-mail을 수신합니다.</span>
                                  	<input type="hidden" class="email_chk" id="emailsts_n" name="emailsts_yn" onclick="checkBoxValue();" />
                                  	<span class="email_chk_text" ></span>
								</td> 
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">생년월일<span class="essential">*</span>
								</td>
								<td>
									<input type="text" class="join_input" name="userBirth" required 
										   maxlength="8" placeholder="생년월일 입력 8자리(숫자만 입력)" /></td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label" id="label_phone">연락처<span class="essential">*</span>
								</td>
								<td> 
									<!-- 서승희: 문자 API 인증(23.07.27.) -->
									<input type="text" class="join_input" id="userPhone" name="userPhone" value="${user.userPhone }"
										   style="width: 65%;" maxlength="12" required placeholder="전화번호 입력(숫자만 입력)" autocomplete="off"/>
									<input type="button" class="btn_pass" id="phoneChk" value="인증번호발송" style="width: 33%; margin-bottom: 10px;" /> 
	                                
	                                <input type="text" class="join_input" id="phone2" name="phone" style="width: 65%; margin-bottom: 10px;" maxlength="4" 
	                                	   required placeholder="인증번호 4자리 입력" autocomplete="off"/>
	                                <input type="button" class="btn_pass" id="phoneChk2" value="인증번호확인" style="width: 33%; margin-bottom: 10px;" />
									<br>
									<input type="checkbox" class="sms_chk" id="smssts_y" name="smssts_yn" value="Y" onclick="checkBoxValue1();" checked/>
									<span class="sms_chk_text">쇼핑몰에서 발송하는 SMS 소식을 수신합니다.</span>
	                                <input type="hidden" class="sms_chk" id="smssts_n" name="smssts_yn" onclick="checkBoxValue1();" />
	                                <span class="sms_chk_text"></span>
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">주소<span class="essential">*</span>
								</td>
								<td>
									<p class="addressTxt"> 
									  	<input type="button" class="addBtn" value="주소 검색" onClick="location.href='javascript:execDaumPostcode()'"
									  		   style="width:100%;"/><br><br>
										<input type="text" class="join_input" id="userAddress1" name="userAddress1" size="30" placeholder="기본주소 입력" /><br><br>
									  	<input type="text" class="join_input" id="userAddress2" name="userAddress2" size="30" placeholder="상세주소 입력" /><br><br>
								   </p>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="clear">
						<input type="submit" value="회원가입">
						<input  type="reset" value="다시입력">	
					</div>
				</form>
			</div>
		</div>
	</div>
		
	<script>
		//주소검색(서승희 추가 23.07.19)
		function execDaumPostcode() {
			new daum.Postcode({
		    oncomplete: function(data) {
		    	//팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		      	//도로명 주소의 노출 규칙에 따라 주소를 조합한다.
		      	//내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		      	var fullRoadAddr = data.roadAddress;  //도로명 주소 변수
		      	var extraRoadAddr = ''; //도로명 조합형 주소 변수
		
		      	//법정동명이 있을 경우 추가한다.(법정리는 제외)
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
		      	//우편번호와 주소 정보를 해당 필드에 넣는다.
		      	document.getElementById('userAddress1').value = fullRoadAddr;
	    	}
		  }).open();
		}
		
		//ID 중복검사
		function fn_overlapped(){
			var _id=$("#_user_id").val();
		    if(_id==''){
		    	alert("ID를 입력하세요");
		   	 	return;
		    }
		    $.ajax({
		       type:"post",
		       async:false,  
		       url:"${contextPath}/user/overlapped.do",
		       dataType:"text",
		       data: {id:_id},
		       success:function (data,textStatus){
		          if(data=='false'){
		       	    alert("사용할 수 있는 ID입니다.");
		       	    $('#btnOverlapped').prop("disabled", true);
		       	    $('#_user_id').prop("disabled", true);
		       	    $('#userId').val(_id);
		          }else{
		        	  alert("사용할 수 없는 ID입니다.");
		          }
		       },
		       error:function(data,textStatus){
		          alert("에러가 발생했습니다.");ㅣ
		       },
		       complete:function(data,textStatus){
		          //alert("작업을완료 했습니다");
		       }
		    });  //end ajax	 
		 }	
		
		//서승희: 이메일 수신여부
	    function checkBoxValue(){
	       var checkbox =document.getElementById("emailsts_y");
	       var hiddenInput  =document.getElementById("emailsts_n");
	       
	       if (checkbox.checked){
	            hiddenInput.value = "true";
	 	   } else {
            	hiddenInput.value = "false";
		   }
	    }
		    
        //23.07.23 서승희 연락처 수신여부 추가
        function checkBoxValue1(){
			var checkbox =document.getElementById("smssts_y");
          	var hiddenInput  =document.getElementById("smssts_n");
          
          	if (checkbox.checked) {
               	hiddenInput.value = "true";
            } else {
               	hiddenInput.value = "false";
            }
        } 
	       
		/* 문자인증 API */
	    $(function(){
		//var code2 = "";  //인증 코드를 저장하기 위해 code2 선언
			$("#phoneChk").click(function(){
				alert('인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.');
	    	 	var phone=$("#userPhone").val();
    	
		    	$.ajax({
		        	type:"post", //post 형식으로 발송
		        	url:"${contextPath}/sendSMS1.do", //controller 위치
		        	data: {userPhone:phone}, //전송할 데이터값
		        	cache : false,  //false인 경우 동기식으로 처리한다.
		        	success:function(data){
		        		if(data === "error"){  //실패시 
		        			alert("휴대폰 번호가 올바르지 않습니다.")
		          	  	} else {  //성공시        
		             	   	alert("인증번호가 전송 되었습니다.")
		             	   	code2 = data; //성공하면 데이터저장
		            	}
		        	}
	    		});
	 		}); 
 
			//휴대폰 인증번호 대조
	 	 	$("#phoneChk2").click(function(){
	     	 	if($("#phone2").val() === code2){ //위에서 저장한값을 비교함
	          	 	alert('인증성공')
	     	 	} else {
	        	  	alert('인증실패')
	      		}
	  		});
		});	       
	</script>

</body>
</html>