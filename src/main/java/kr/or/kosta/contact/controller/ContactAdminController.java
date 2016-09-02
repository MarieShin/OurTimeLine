package kr.or.kosta.contact.controller;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.kosta.contact.model.Contact;

@Controller
public class ContactAdminController {

	@RequestMapping("/hello")
	public @ResponseBody List<String> hello() {
		System.out.println("hello");

		List<String> list = new ArrayList<String>();
		list.add("kim");
		list.add("lee");
		list.add("park");

		return list;
	}

	@RequestMapping(value = "/result1")
	public @ResponseBody Map<String, String> result() {
		Map<String, String> map = new HashMap<String, String>();

		map.put("name", "kim");
		map.put("addr", "seoul");
		map.put("age", "20");

		return map;
	}

	@RequestMapping(value = "/search")
	public @ResponseBody Contact search() {
		Contact contact = new Contact();
		contact.setId(1);
		contact.setName("kim");
		contact.setEmail("kim@gg.com");
		contact.setAge(22);
		contact.setAddr("seoul");

		return contact;
	}

	@RequestMapping(value = "/")
	public String index() {
		return "index"; // WEB-INF/views/index.jsp
	}

	@RequestMapping(value = "/regist")
	public ModelAndView regist() {
		ModelAndView mav = new ModelAndView();

		mav.addObject("name", "하이루");
		mav.addObject("greet", "안녕하세요.");

		mav.setViewName("regist");

		return mav;
	}

	@RequestMapping(value = "/doCalc")
	public ModelAndView doCalc(HttpServletRequest request) {
		int numOne = Integer.parseInt(request.getParameter("numOne"));
		int numTwo = Integer.parseInt(request.getParameter("numTwo"));

		ModelAndView mav = new ModelAndView();
		mav.addObject("result", numOne + numTwo);
		mav.setViewName("result");

		return mav;

	}

	@RequestMapping(value = "/flight_fee")
	public String flightFee() {
		return "flight_fee";
	}

	@RequestMapping(value = "/result")
	public ModelAndView result(HttpServletRequest request) {

		int destination = 0;

		int adult = Integer.parseInt(request.getParameter("adult"));
		int young = Integer.parseInt(request.getParameter("young"));
		int children = Integer.parseInt(request.getParameter("children"));

		String radio = request.getParameter("radio");

		if ("la".equals(radio)) {
			destination = 932000;
		} else if ("bk".equals(radio)) {
			destination = 525000;
		} else if ("sd".equals(radio)) {
			destination = 1103350;
		}

		int result_fee = (int) (((adult + young) * destination + children * (destination * 0.20)) * 1.005);
		String result = NumberFormat.getCurrencyInstance().format(result_fee);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("result");

		return mav;

	}
}
