package com.proj.salad.user.service;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

//23.07.27 문자 api 인증 서승희 추가
@Service
//@RequiredArgsConstructor는 Lombok으로 스프링에서 DI(의존성 주입)의 방법 중에 생성자 주입을 임의의 코드없이 자동으로 설정
//초기화 되지않은 final 필드나, @NonNull 이 붙은 필드에 대해 생성자를 생성(@Autowired를 사용하지 않고 의존성 주입)
@RequiredArgsConstructor 
public class CertificationService {
	
	public static void certifiedPhoneNumber(String userPhone, String numStr) {
		
		String api_key="NCSFXMC4H65WGKRL";  //coolsms에서 받은 api key를 추가
		String api_secret="R154XDHX3SEUOB1QC8AC0ZWYKUGZNB0F";  //coolsms에서 받은 api secret를 추가
		Message coolsms = new Message(api_key, api_secret);

		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", userPhone);  //받는 연락처,수신번호(ajax로 view 화면에서 받아온 값으로 넘김)
		params.put("from", "01041153975");  //보내는 연락처,발신번호, jsp에서 전송한 발신번호를 받아 map에 저장
		params.put("type", "SMS");  // 문자타입
		params.put("text", "[SALAD DAISO] 인증번호 [" + numStr + "]를" + "입력해주세요.");  // 문자내용, jsp에서 전송한 문자내용을 받아 map에 저장
		params.put("app_version", "test app 1.2");  // application name and version
		
		try {
			JSONObject obj = (JSONObject)coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
	}
	
}
