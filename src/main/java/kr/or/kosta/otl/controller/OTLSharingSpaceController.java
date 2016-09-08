package kr.or.kosta.otl.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.kosta.otl.model.Article;

@Controller
public class OTLSharingSpaceController {
	
	/**
	 * 친구 및 제목 검색
	 * 친구일때는 조건 condition = 0
	 * 제목일때는 조건 condition = 1
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/doSearch")
	public ModelAndView doSearch(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("searchResultPage");
		//검색 목록 가져오기~
		return mav;
	}
	
	/**
	 * 포스트를 볼 수 있는 조건 설정 페이지로 이동
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/goPostConditionPage")
	public ModelAndView goPostConditionPage(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("getPostSettingPage");
		//조건 가져오기
		return mav;
	}
	
	/**
	 * 포스트 보는 조건 설정 완료
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/doPostConditionSetting")
	public String doPostConditionSetting(HttpServletRequest request){
		//조건 설정 완료하기
		return "";
	}
	
	/**
	 * 쓰기 페이지로 가기
	 * @return
	 */
	@RequestMapping(value="/goWritePost")
	public String goWritePost(){
		return "goWritePost.jsp";
	}
	
	/**
	 * 더보기 조건이 있으면 기존의 list에 더하기
	 * 더보기 조건이 없으면 그냥 다 가져오기
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getPost")
	public List<Article> doGetPost(HttpServletRequest request){
		List<Article> list = new ArrayList<Article>();
		
		
		return list;
		
	}
}
