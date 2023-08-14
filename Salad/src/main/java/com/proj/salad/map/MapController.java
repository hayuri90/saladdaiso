package com.proj.salad.map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MapController {
	
	//하유리: 이벤트 페이지 보이기(23.07.19.)
	@RequestMapping(value="/map", method=RequestMethod.GET)
	public String eventPage() {
		return "/map/mapPage";
	}
	
}
