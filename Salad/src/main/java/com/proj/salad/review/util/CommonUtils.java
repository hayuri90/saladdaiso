package com.proj.salad.review.util;

import java.util.UUID;

public class CommonUtils {
	//파일을 저장할 때, 파일이름이 중복되는 것을 방지하기 위해서 32글자의 랜덤한 문자열을 만들어서 반환해주는 메소드
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", ""); //"-" 제거
	}
	
}