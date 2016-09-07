package kr.or.kosta.contact.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ContactAdminController {

	@RequestMapping(value = "/")
	public String index() {
		return "index"; // WEB-INF/views/index.jsp
	}

}
