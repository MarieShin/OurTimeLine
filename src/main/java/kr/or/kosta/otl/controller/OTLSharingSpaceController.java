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
	 * ģ�� �� ���� �˻�
	 * ģ���϶��� ���� condition = 0
	 * �����϶��� ���� condition = 1
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/doSearch")
	public ModelAndView doSearch(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("searchResultPage");
		//�˻� ��� ��������~
		return mav;
	}
	
	/**
	 * ����Ʈ�� �� �� �ִ� ���� ���� �������� �̵�
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/goPostConditionPage")
	public ModelAndView goPostConditionPage(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("getPostSettingPage");
		//���� ��������
		return mav;
	}
	
	/**
	 * ����Ʈ ���� ���� ���� �Ϸ�
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/doPostConditionSetting")
	public String doPostConditionSetting(HttpServletRequest request){
		//���� ���� �Ϸ��ϱ�
		return "";
	}
	
	/**
	 * ���� �������� ����
	 * @return
	 */
	@RequestMapping(value="/goWritePost")
	public String goWritePost(){
		return "goWritePost.jsp";
	}
	
	/**
	 * ������ ������ ������ ������ list�� ���ϱ�
	 * ������ ������ ������ �׳� �� ��������
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getPost")
	public List<Article> doGetPost(HttpServletRequest request){
		List<Article> list = new ArrayList<Article>();
		
		
		return list;
		
	}
}
