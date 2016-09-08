package kr.or.kosta.otl.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OTLSharingSpace {
	
	/**
	 * 模备 棺 力格 八祸
	 * 模备老锭绰 炼扒 condition = 0
	 * 力格老锭绰 炼扒 condition = 1
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
