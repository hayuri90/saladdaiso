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
    <link href="resources/css/header.css" rel="stylesheet" type="text/css">
    <link href="resources/css/footer.css" rel="stylesheet" type="text/css">
    <link href="resources/css/common/policy.css" rel="stylesheet" type="text/css">
</head>

<body>	
	<div>	
	<div class="terms_sub">
		<p class="terms_text">개인정보처리방침</p>
		<select>
	        <option value="current">[현행] 2023.07.01. 시행안</option>
    	</select>
	</div>
		
	<div class="terms_wrap">
		<div class="terms_margin">
			<div class="terms_detail">
				<p>(주)샐러드다이소 고객님의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호"에 관한 법률을 준수하고 있습니다.</p>
				<p>회사는 개인정보처리방침을 통하여 고객님께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.</p>
			</div>
			<div class="terms_detail">
				<h3>1. 수집하는 개인정보 항목 및 수집방법</h3>
				<ol>
					<li>가. 수집하는 개인정보의 항목</li>
						<ol class="detail_ol">
							<li>(1) 회사는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.</li>
							<li class="detail_ol_li">- 회원가입시 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 자택 전화번호 , 휴대전화번호 , 이메일 , 14세미만 가입자의 경우 법정대리인의 정보</li>
							<li class="detail_ol_li">- 서비스 신청시 : 주소, 결제 정보</li>
							<li>(2) 서비스 이용 과정이나 사업 처리 과정에서 서비스이용기록, 접속로그, 쿠키, 접속 IP, 결제 기록, 불량이용 기록이 생성되어 수집될 수 있습니다.</li>
						</ol>
				</ol>
				<br>
				<p>나. 수집방법</p>
				<ol class="detail_ol">
					<li>- 홈페이지, 서면양식, 게시판, 이메일, 이벤트 응모, 배송요청, 전화, 팩스, 생성 정보 수집 툴을 통한 수집</li>
				</ol>
			</div>
			<div class="terms_detail">
				<h3>2. 개인정보의 수집 및 이용목적</h3>
				<ol>
					<li>회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.</li>
					<li>(1) 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산</li>
					<li class="detail_ol_li">- 콘텐츠 제공 , 구매 및 요금 결제 , 물품배송 또는 청구지 등 발송 , 금융거래 본인 인증 및 금융 서비스</li>
					<li>(2) 회원 관리</li>
					<li class="detail_ol_li">- 회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 가입 의사 확인 , 연령확인 , 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 불만처리 등</li>
					<li class="detail_ol_li">- 민원처리 , 고지사항 전달</li>
					<li>(3) 마케팅 및 광고에 활용</li>
					<li class="detail_ol_li">- 이벤트 등 광고성 정보 전달 , 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계</li>
				</ol>
			</div>
			<div class="terms_detail">
				<h3>3. 개인정보의 보유 및 이용기간</h3>
				<p>원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.</p>
				<p>가. 회사 내부방침에 의한 정보보유 사유</p>
				<ol class="detail_ol">
					<li>- 회원이 탈퇴한 경우에도 불량회원의 부정한 이용의 재발을 방지, 분쟁해결 및 수사기관의 요청에 따른 협조를 위하여, 이용계약 해지일로부터 oo년간 회원의 정보를 보유할 수 있습니다.</li>
				</ol>
				<br/>
				<p>나. 관련 법령에 의한 정보 보유 사유</p>
					<ol class="detail_ol">
						<li>- 전자상거래등에서의 소비자 보호에 관한 법률 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 아래와 같이 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.</li>
						<li>(1) 계약 또는 청약철회 등에 관한 기록</li>
						<li class="detail_ol_li">- 보존이유 : 전자상거래등에서의 소비자 보호에 관한 법률</li>
						<li class="detail_ol_li">- 보존기간 : 5년</li>
						<li>(2) 대금 결제 및 재화 등의 공급에 관한 기록</li>
						<li class="detail_ol_li">- 보존이유: 전자상거래등에서의 소비자 보호에 관한 법률</li>
						<li class="detail_ol_li">- 보존기간 : 5년</li>
						<li>(3) 소비자 불만 또는 분쟁처리에 관한 기록</li>
						<li class="detail_ol_li">- 보존이유 : 전자상거래등에서의 소비자 보호에 관한 법률</li>
						<li class="detail_ol_li">- 보존기간 : 3년</li>
						<li>(4) 로그 기록</li>
						<li class="detail_ol_li">- 보존이유: 통신비밀보호법</li>
						<li class="detail_ol_li">- 보존기간 : 3개월</li>
					</ol>
			</div>
			<div class="terms_detail">
				<h3>4. 개인정보의 파기절차 및 방법</h3>
				<p>회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.</p>
				<ol>
					<li>(1) 파기절차</li>
						<ol class="detail_ol">
							<li>- 회원님이 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기됩니다.</li>
							<li>- 별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지 않습니다.</li>
						</ol>
					<li>(2) 파기방법</li>
						<ol class="detail_ol">
							<li>- 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.</li>
						</ol>
				</ol>
			</div>
			<div class="terms_detail">
				<h3>5. 개인정보 제공</h3>
				<p>회사는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.</p>
				<ol>
					<li>① 이용자는 '몰'이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.</li>
					<li>② '몰'은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.</li>
						<ol class="detail_ol">
							<li>(1) 이용자들이 사전에 동의한 경우</li>
							<li>(2) 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우</li>
						</ol>
				</ol>
			</div>
			<div class="terms_detail">
				<h3>6. 수집한 개인정보의 위탁</h3>
				<p>회사는 서비스 이행을 위해 아래와 같이 외부 전문업체에 위탁하여 운영하고 있습니다.</p>
				<ol>
					<li>(1) 위탁 대상자 : [택배사 이름]</li>
					<li>(2) 위탁업무 내용 : [택배사 위탁 내용]</li>
					<br/>
					<li>(1) 위탁 대상자 : [PG사 이름]</li>
					<li>(2) 위탁업무 내용 : [PG사 위탁 내용]</li>
					<br/>
					<li>(1) 위탁 대상자 : 공급업체 목록보기</li>
					<li>(2) 위탁업무 내용 : [위탁업무 내용]</li>
				</ol>
			</div>
			<div class="terms_detail">
				<h3>7. 이용자 및 법정대리인의 권리와 그 행사방법</h3>
				<ol>
					<li>(1) 이용자는 언제든지 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며 가입해지를 요청할 수도 있습니다.</li>
					<li>(2) 이용자들의 개인정보 조회,수정을 위해서는 "개인정보변경"(또는 "회원정보수정" 등)을 가입해지(동의철회)를 위해서는 "회원탈퇴"를 클릭하여 본인 확인 절차를 거치신 후 직접 열람, 정정 또는 탈퇴가 가능합니다.</li>
					<li>(3) 혹은 개인정보보호책임자에게 서면, 전화 또는 이메일로 연락하시면 지체없이 조치하겠습니다.</li>
					<li>(4) 귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체없이 통지하여 정정이 이루어지도록 하겠습니다.</li>
					<li>(5) 회사는 이용자의 요청에 의해 해지 또는 삭제된 개인정보는 "회사가 수집하는 개인정보의 보유 및 이용기간"에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.</li>
				</ol>
			</div>
			<div class="terms_detail">
				<h3>8. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항</h3>
				<p>회사는 귀하의 정보를 수시로 저장하고 찾아내는 "쿠키(cookie)" 등을 운용합니다. 쿠키란 웹사이트를 운영하는데 이용되는 서버가 귀하의 브라우저에 보내는 아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드디스크에 저장됩니다.</p>
				<p>회사은(는) 다음과 같은 목적을 위해 쿠키를 사용합니다.</p>
				<ol>
					<li>(1) 쿠키 등 사용 목적</li>
						<ol class="detail_ol">
							<li>- 회원과 비회원의 접속 빈도나 방문 시간 등을 분석, 이용자의 취향과 관심분야를 파악 및 자취 추적, 각종 이벤트 참여 정도 및 방문 회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서비스 제공</li>
							<li>- 귀하는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서, 귀하는 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다.</li>
						</ol>
					<br/>
					<li>(2) 쿠키 설정 거부 방법</li>
						<ol class="detail_ol">
							<li>- 쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다.</li>
							<li>- 설정방법 예(인터넷 익스플로어의 경우) : 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보</li>
							<li>- 단, 귀하께서 쿠키 설치를 거부하였을 경우 서비스 제공에 어려움이 있을 수 있습니다.</li>
						</ol>
				</ol>
			</div>
			<div class="terms_detail">
				<h3>9. 개인정보에 관한 민원서비스</h3>
				<p>회사는 고객의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서 및 개인정보보호책임자를 지정하고 있습니다.</p>
				<ol>
					<li>(1) 개인정보보호담당자</li>
						<ol class="detail_ol">
							<li>성명 : OOO</li>
							<li>소속 : OOO</li>
							<li>전화번호 : OO-OOO-OOOO</li>
							<li>이메일 :</li>
						</ol>
					<li>(2) 개인정보보호책임자</li>
						<ol class="detail_ol">
							<li>성명 : OOO</li>
							<li>소속 : OOO</li>
							<li>전화번호 : OO-OOO-OOOO</li>
							<li>이메일 :</li>
						</ol>
				</ol>
			</div>
			<div class="terms_detail">
				<ol>
					<li>- 귀하께서는 회사의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보보호책임자 혹은 담당부서로 신고하실 수 있습니다.</li>
					<li>- 회사는 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.</li>
					<li>- 기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.</li>
						<ol class="detail_ol">
							<li>∙ 개인정보침해신고센터 (privacy.kisa.or.kr / 국번 없이 118)</li>
							<li>∙ 개인정보분쟁조정위원회 (kopico.go.kr / 1833-6972)</li>
							<li>∙ 대검찰청 사이버수사과 (spo.go.kr / 지역번호+1301)</li>
							<li>∙ 경찰청 사이버안전국 (cyberbureau.police.go.kr / 국번없이 182)</li>
						</ol>
				</ol>
			</div>
			
		</div>
	</div>

</body>
</html>