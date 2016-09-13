package kr.or.kosta.otl.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.kosta.otl.service.MemberService;
import kr.or.kosta.otl.vo.Member;

@Controller
public class MemberController {

	@Autowired
	MemberService mService;
	
	//회원가입 페이지가기
	@RequestMapping(value="/member/goSignup.do")
	public String goSignup(){
		
		return "signup";
	}
	//로그인페이지가기
	@RequestMapping(value="/member/goLogin.do")
	public String goLogin(){
		System.out.println("로그인페이지다");
		return "login";
	}
	
	//인덱스페이지가기
	@RequestMapping(value="/member/goIndex.do")
	public String goIndex(){
		
		return "../../index";
	}
	
	//메뉴페이지가기(에프터로그인)
		@RequestMapping(value="/member/goMenu.do")
		public String goMenu(){
			
			return "afterLogin";
		}
	
	
	//
	/**
	 * 로그인
	 * @param id
	 * @param pw
	 * @return
	 */
	@RequestMapping(value="/member/login.do", method=RequestMethod.POST)
	public ModelAndView login(@RequestParam(value="id")String id, @RequestParam(value="pw")String pw, HttpServletRequest request){
		ModelAndView mav = new ModelAndView("loginResult");
		
		System.out.println("로그인"+id+pw);
		Member m = mService.login(id);
		String loginRsMsg = null;
		System.out.println(m);
		if(m != null && m.getPw().equals(pw)){
			//정보가 맞으면
			mav.addObject("info", m);
			loginRsMsg = "y";
			HttpSession session = request.getSession();
			session.setAttribute("id", m);
			//관리자 권한 체크
			if(m.getAuth() == 1){
				session.setAttribute("admin", true);
			}else{
				session.setAttribute("admin", false);
			}		
			//30분
			session.setMaxInactiveInterval(180000000);
		}else if(m == null || !(m.getPw().equals(pw))){
			//정보가 틀리면
			loginRsMsg = "n";	
		}
		mav.addObject("check", loginRsMsg);
		
		return mav;
	}
	
	@RequestMapping(value="/member/memlist.do")
	public ModelAndView memlist(){
		ModelAndView mav = new ModelAndView("memberList");
		ArrayList<Member> list = (ArrayList<Member>) mService.getAllMem();
		mav.addObject("memList", list);
		
		return mav;
	}
	@RequestMapping(value="/member/delMem.do")
	public String delMem(@RequestParam(value="memseq")int memseq){
		mService.delMem(memseq);
		
		return "redirect:/member/memlist.do";
	}
	
	/**
	 * 로그아웃
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/member/logout.do")
	public ModelAndView logout(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("loginResult");
			HttpSession session = request.getSession();
			mav.addObject("check", "로그아웃되었습니다.");
			session.invalidate();
		return mav;
	}
	
	
	@RequestMapping(value="/member/needLogin.do")
	public ModelAndView needLogin(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("loginResult");
			HttpSession session = request.getSession();
			mav.addObject("check", "로그인이 필요합니다.");
			session.invalidate();
		return mav;
	}
	
	/**
	 * 회원가입
	 * @param m
	 * @return
	 */
	@RequestMapping(value="/member/signup.do", method=RequestMethod.POST)
	public String signup(Member m){
		//ModelAndView mav = new ModelAndView("login");
		System.out.println("컴인"+m);
		//seq랑 권한은 수정
		int memberCnt = mService.getCnt();
		m.setMem_seq(memberCnt+1);
		m.setAuth(0);
		System.out.println(m.getMem_seq());
		mService.signup(m);
		return "signupResult";
	}
	/**
	 * 아이디 체크
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/member/idchk.do")
	public ModelAndView idchk(@RequestParam(value="id")String id){
		ModelAndView mav = new ModelAndView("idchkResult");
		System.out.println("안들어오냐 ㅡㅡ");
		System.out.println(id);
		Member m = null;
		m = mService.idchk(id);
		System.out.println(m);
		String chk ="n";
		//아이디가 있으면
		if(m != null && m.getId().equals(id)){
			chk="n";
		}else if(m== null){
			chk ="y";
		}
		mav.addObject("chkResult", chk);
		return mav;
	}
	
}
