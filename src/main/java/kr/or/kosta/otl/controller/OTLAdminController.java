package kr.or.kosta.otl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OTLAdminController {

	@RequestMapping(value = "/")
	public String index() {
		return "login"; // WEB-INF/views/index.jsp
	}
}
