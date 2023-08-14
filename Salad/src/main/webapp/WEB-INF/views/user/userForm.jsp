<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
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
	
	<!-- css 적용 -->
	<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
	<link href="../resources/css/header.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/footer.css" rel="stylesheet" type="text/css" >
	<link href="../resources/css/userForm/userForm.css" rel="stylesheet" type="text/css" >	<!-- 하유리: css 적용(23.07.25.) -->

</head>

<body>
	<div class="total">															<!-- 하유리: div 추가(23.07.25.) -->
		<div class="join_sub">													<!-- 하유리: div 추가(23.07.25.) -->
			<p class="text_center">회원가입</p>						<!-- 하유리: style 태그 적용하기 위해 <p>태그로 수정, 텍스트 수정(23.07.25.) -->
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
				<form action="${contextPath}/user/addUser.do" method="post"  class="user-form">
									<!-- 하유리: <div id="login_table"> 삭제 -->
					<table>	<!-- 하유리: align="center" 삭제(23.07.25.) -->
						<tbody>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">아이디<span class="essential">*</span>	<!-- 하유리: <span> 추가, align속성 삭제(23.07.25.) -->
								</td>	
								<td align="left">
									<input class="join_input" style="width: 65%;" type="text" name="_user_id"  id="_user_id"   minlength="2" maxlength="10" required placeholder="ID(2-10자)" />								<!-- 하유리: class, </td> 추가(23.07.25.) -->
									<!-- ID 중복검사 기능 구현(23.07.18) -->
									<input type="hidden" name="userId"  id="userId" />
									<input type="button"  style="width: 33%;" id="btnOverlapped" class="btn btn-outline-success" value="중복체크" onClick="fn_overlapped()" />			<!--  하유리: <td> 추가(23.07.25.) -->
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">비밀번호<span class="essential">*</span>																<!-- 하유리: align속성, class, </p><span> 추가(23.07.25.) -->
								</td>
								<td><input class="join_input" name="userPwd" id="userPwd" type="password" minlength="4" maxlength="12" required placeholder="비밀번호(4-12자)"/></td>	<!-- 하유리: align속성, size 삭제(23.07.25.) -->
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">이름<span class="essential">*</span>																	<!-- 하유리: align속성 삭제(23.07.25.) -->
								</td>
								<td><input class="join_input" name="userName" type="text" minlength="2" maxlength="10" required placeholder="이름(2-10자)" /></td>				<!-- 하유리: align속성, size 삭제(23.07.25.) -->
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">성별<span class="essential">*</span>																	<!-- 하유리: <span> 태그 추가, align속성 삭제(23.07.25.) -->
								</td>
								<td class="userGender" align="left">
									<input type="radio" name="userGender" value="여" class="userGender" /><span class="genderTxt">여성</span>										<!-- 하유리: class, <span> 태그 추가, align속성 삭제(23.07.25.) -->
									<input type="radio" name="userGender" value="남" class="userGender" style="margin-left:40px"/><span class="genderTxt">남성</span>	<!-- class 추가, <span> 삭제 후 radio버튼에 style 지정 -->
								</td>
							</tr>
							<tr class="dot_line">
								<td class="fixed_join"><p class="join_label" id="label_email">이메일<span class="essential">*</span></td>	<!-- 하유리: align속성, <br>(e-mail) 삭제(23.07.25.) -->
								<td>
									<input class="join_input " type="email" name="userEmail" id="userEmail" placeholder="E-mail 입력" style="margin-bottom: 10px;"/>			<!-- 하유리: align속성, size 삭제(23.07.25.) -->
									<br>	<!-- 23.07.23 서승희 이메일 수신여부 수정 -->
									<input class="email_chk" type="checkbox" name="emailsts_yn" id="emailsts_y"   value="Y"  onclick="checkBoxValue();" checked/> <span class="email_chk_text" >쇼핑몰에서 발송하는 e-mail을 수신합니다.</span><!-- 23.07.20 email 수신동의 수정 -->  
                                  	<input class="email_chk" type="hidden" name="emailsts_yn" id="emailsts_n"  onclick="checkBoxValue();" /><span class="email_chk_text" ></span>
								</td> 
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label">생년월일<span class="essential">*</span>							<!-- 하유리: align속성 삭제, <span>추가(23.07.25.) -->
								</td>
								<td><input class="join_input" name="userBirth" type="text"  maxlength="8" required placeholder="생년월일 입력 8자리(숫자만 입력)" /></td>	<!-- 하유리: align속성, size, <br>(e-mail) 삭제(23.07.25.) -->
							</tr>
							<tr class="dot_line">
								<td class="fixed_join">
									<p class="join_label" id="label_phone">연락처<span class="essential">*</span>	<!-- 하유리: align속성 삭제, <span>추가(23.07.25.) -->
								</td>
								<td> 
								<!-- 23.07.27 문자 api 인증 서승희 수정 -->
								<input class="join_input" type="text" style="width: 65%;" name="userPhone" id="userPhone" maxlength="12" required value="${user.userPhone }"
									placeholder="전화번호 입력(숫자만 입력)"  autocomplete="off"/><!-- 하유리: align속성, size삭제, <style> 추가(23.07.25.) -->
								<input class="btn_pass" id="phoneChk" type="button" style="width: 33%; margin-bottom: 10px; " value="인증번호발송"  /> <!-- phoneChk 클릭시 함수 발동 -->
                                 <!-- 23.07.27 문자 api 인증 서승희 수정 -->
                                 <input class="join_input" type="text" style="width: 65%; margin-bottom: 10px;" name="phone" id="phone2" maxlength="4" required placeholder="인증번호 4자리 입력"
                                 autocomplete="off"/><!-- 하유리: align속성, size삭제, <style> 추가(23.07.25.) -->
                                 <input class="btn_pass" id="phoneChk2" type="button" style="width: 33%; margin-bottom: 10px;" value="인증번호확인"  /> <!--  phoneChk 클릭시 함수 발동 -->
								<br>
								<!-- 23.07.23 서승희 연락처 수신여부 수정 --> 
								<input class="sms_chk"  type="checkbox" name="smssts_yn" id="smssts_y"  value="Y" onclick="checkBoxValue1();" checked/><span class="sms_chk_text" >쇼핑몰에서 발송하는 SMS 소식을 수신합니다.</span><!-- 23.07.20 sms 수신동의 수정 --> 
                                 <input class="sms_chk" type="hidden" name="smssts_yn" id="smssts_n" onclick="checkBoxValue1();" /><span class="sms_chk_text" ></span>
								
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
										<!-- 기본 주소:  --><input class="join_input" type="text" id="userAddress1" name="userAddress1" size="30" placeholder="기본주소 입력" /><br><br>
									  	<!-- 상세 주소:  --><input class="join_input" type="text" id="userAddress2"  name="userAddress2" size="30" placeholder="상세주소 입력" /><br><br>
								   </p>
								</td>
							</tr>
						</tbody>
					</table>	
					
					<!-- 하유리: <br>태그 삭제(23.07.25.) -->
					<div class="clear">
						<input type="submit"  value="회원가입">
						<input  type="reset"  value="다시입력">	
						<%-- <input type="button" onclick="location.href='${contextPath}/main.do'" value="메인이동" /> --%>	<!-- 하유리: value 수정(23.07.25.) -->
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
		      	// 우편번호와 주소 정보를 해당 필드에 넣는다.
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
		
		//23.07.23 서승희 이메일 수신여부 추가
	    function checkBoxValue(){
	       var checkbox =document.getElementById("emailsts_y");
	       var hiddenInput  =document.getElementById("emailsts_n");
	       
	       if (checkbox.checked) {
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
	       
	     /* 인증문자 */
	     //23.07.27 서승희 핸드폰 문자인증 추가
	     $(function(){
		//var code2 = "";  //인증 코드를 저장하기 위해 code2 선언
		//휴대폰 번호 인증 
		$("#phoneChk").click(function(){  //지정된 ID가 있는 요소를 올바르게 대상으로 지정하기 위해 코드에 "#" 기호가 있어야 함
  		 alert('인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.');
    	 var phone=$("#userPhone").val();
    	
    	$.ajax({
        	type:"post", // post 형식으로 발송
        	url:"${contextPath}/sendSMS1.do", // controller 위치
        	data: {userPhone:phone}, // 전송할 데이터값
        	cache : false,  //false인 경우 동기식으로 처리한다.
        	success:function(data){
            	if(data === "error"){  //실패시 
            	    alert("휴대폰 번호가 올바르지 않습니다.")
          	  }else{  //성공시        
             	   alert("인증번호가 전송 되었습니다.")
             	   code2 = data; // 성공하면 데이터저장
            }
        }
    });
 }); 
 
	//휴대폰 인증번호 대조
 	 $("#phoneChk2").click(function(){
     	 if($("#phone2").val() === code2){ // 위에서 저장한값을 비교함
          	 alert('인증성공')
     	 }else{
        	  alert('인증실패')
      	}
  });
});	       
</script>

</body>
</html>