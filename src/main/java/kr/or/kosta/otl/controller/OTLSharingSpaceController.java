package kr.or.kosta.otl.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OTLSharingSpace {
	
	/**
	 * ģ�� �� ���� �˻�
	 * ģ���϶��� ���� condition = 0
	 * �����϶��� ���� condition = 1
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/SS")
	public ModelAndView search(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("sharingSpace");
		
		return mav;
	}
	

}
