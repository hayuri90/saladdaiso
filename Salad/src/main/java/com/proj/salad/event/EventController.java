package com.proj.salad.event;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class EventController {
	
	//하유리: 이벤트 페이지 보이기(23.07.19.)
	@RequestMapping(value="/event", method=RequestMethod.GET)
	public String eventPage() {
		return "/event/eventPage";
	}
	
}
