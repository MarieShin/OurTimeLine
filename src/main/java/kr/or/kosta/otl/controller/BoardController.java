package kr.or.kosta.otl.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.kosta.otl.service.BoardService;
import kr.or.kosta.otl.service.FileService;
import kr.or.kosta.otl.service.MemberService;
import kr.or.kosta.otl.vo.Board;
import kr.or.kosta.otl.vo.Member;
import kr.or.kosta.otl.vo.PageInfo;
@Controller
public class BoardController {

	@Autowired
	BoardService bService;
	
	@Autowired
	FileService fService;
	
	@Autowired
	MemberService mService;

	public BoardController() {
		
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping(value="/board/goWriteBoard.do")
	public String goWriteBoard(HttpServletRequest request){
		HttpSession session = request.getSession();
		String retVal="";
		if(session.getAttribute("id") == null){
			retVal="redirect:/member/goIndex.do";
		}else{
			retVal="writeBoard";
		}
		
		return retVal;
	}
	
	
	@RequestMapping(value="/board/fileUpload.do", method=RequestMethod.POST)
	public void fileTest(@RequestParam MultipartFile file, HttpServletRequest request,
			@RequestParam(value="boardSeq") int boardSeq ){
		System.out.println("ddddd"+boardSeq);
		try {
			//@RequestParam(value="board_seq", defaultValue="0")int boardSeq ,
			//System.out.println("보드오나???:"+boardSeq);
			System.out.println("파일테스트가 먼저냐");
			//HttpSession session = request.getSession();
		//	int BoardSeq = (Integer) session.getAttribute("createBoardSeq");
		//	System.out.println("파일테스트가"+BoardSeq);
			
				Board b = bService.getBySeq(boardSeq);
				kr.or.kosta.otl.vo.File voFile = new kr.or.kosta.otl.vo.File();
				
				voFile.setBoard_seq(boardSeq);
				int fileNo = fService.getFileSeq();
				voFile.setFileNo(fileNo+1);
				
				
				String fileOrgName = file.getOriginalFilename();
				System.out.println(fileOrgName);
				voFile.setFileName1(fileOrgName);
				//확장자 
				
				String extend = fileOrgName.substring(fileOrgName.lastIndexOf("."));
				//extend += ;
				System.out.println("확장자"+extend);
				//TODO
				//String randomFileName = RandomStringUtils.random(24);
				//System.out.println(randomFileName);				
				
				//중복업는파일이름정하기
				java.util.Date todayNow = new java.util.Date();
				SimpleDateFormat sdf;
				sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				//b.setWriter(m.getId());
				
				String fileName = sdf.format(todayNow)+voFile.getBoard_seq()+voFile.getFileNo()+extend;

				voFile.setFileName2(fileName);
				//voFile.setBoard_seq(b.getBoard_seq());
				
				System.out.println("파일사이즈는 : "+file.getSize());
				long fSize =  file.getSize();
				String fileSize = "";
				System.out.println("파일사이즈1:"+fSize);
				if(fSize < 1024){
					fileSize = Math.round(fSize)+"B";
				}else if(fSize < 1048576){
					fileSize = Math.round(fSize/1024)+"KB";
				}else if(fSize < 1073741824){
					fileSize = Math.round(fSize/1048576)+"MB";
				}else{
					fileSize = Math.round(fSize/1073741824)+"GB";
				}
				System.out.println("파일사이즈2:"+fileSize);
						
				voFile.setFileSize(fileSize);
				
				String path="C:\\Users\\imoxion\\workspace\\SB\\src\\main\\webapp\\file\\"+fileName;
				
				File attachFile = new File(path);
				file.transferTo(attachFile);
				voFile.setFilePath("C:\\Users\\imoxion\\workspace\\SB\\src\\main\\webapp\\file\\"+fileName);
				bService.updateFileCnt(b.getFileCnt()+1, b.getBoard_seq());
				fService.insertFile(voFile);
			
			
			
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	
	}
	

	@RequestMapping(value="/board/delFile.do", method=RequestMethod.POST)
	public void delFile(@RequestParam(value="deleteFile")List<String> deleteFileName,
			@RequestParam(value="boardseq")int boardseq ) throws Exception {
		
		System.out.println("글삭제페이지들어왔따여");
		Board  b = bService.getBySeq(boardseq);
		
		String path= "C:\\Users\\imoxion\\workspace\\SB\\src\\main\\webapp\\file\\";
		for(int i = 0; i< deleteFileName.size()-1; i++){
			  fService.deleteFile(deleteFileName.get(i));
			  File file = new File(path+deleteFileName.get(i));
			  if(file.exists() == true){
				file.delete();
			  }
			  
		  }
		//파일 카운트 변경
		bService.updateFileCnt(b.getFileCnt()-(deleteFileName.size()-1), b.getBoard_seq());
		  
	}
	
	/**
	 * 게시판 전체보기
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/board/getAll.do")
	public ModelAndView getAll(HttpServletRequest request, @RequestParam(value="page", defaultValue="1")int page){
		ModelAndView mav = new ModelAndView("boardMain");
		HttpSession session = request.getSession();
		session.removeAttribute("condition");
		session.removeAttribute("contents");
		//ArrayList<Board> list = (ArrayList<Board>) bService.getAll();
		//페이지 정보 
		PageInfo pageInfo = new PageInfo();
		
		if(page == 0){
			page = 1000000;
		}
		//한페이지에 게시글 몇개 보여줄거니?
		pageInfo.setPageRecordSize(10);
		pageInfo.setStartRow((page-1)*pageInfo.getPageRecordSize());
		
		//전체 갯수 검색
		int totalBoardCnt = bService.getCnt();
		//필요한 갯수만큼 가져오기
		ArrayList<Board> list=(ArrayList<Board>) bService.getPageBoard(pageInfo);
				
		mav.addObject("bList", list);
		mav.addObject("bListSize", list.size());
		//mav.addObject("boardAllCnt", boardAllCnt);
		mav.addObject("pageSize", pageInfo.getPageRecordSize());
		//몇 페이지 씩 나타낼 것인지
		int showPage = 5;
		//전체 페이지가 몇개인지
		int totalPageCnt = (int) Math.ceil((double)totalBoardCnt/pageInfo.getPageRecordSize());
				//(boardAllCnt/pageInfo.getPageRecordSize())+(boardAllCnt%pageInfo.getPageRecordSize() == 0? 0:1);
		//현재 페이지 그룹이 몇인지
		int currentBlock = (int) Math.ceil((double)page/showPage);
		//페이지그룹의 수 
		int pageGroupCnt = (int)Math.ceil((double)totalPageCnt/showPage);
		//시작페이지
		int startPage = (currentBlock-1)*showPage +1;
		//끝페이지
		int endPage = startPage+showPage-1;
		if(endPage > totalPageCnt){
			endPage = totalPageCnt;
		}
	
		mav.addObject("showPage",showPage);
		mav.addObject("startPage",startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("currentBlock", currentBlock);
		mav.addObject("pageGroupCnt", pageGroupCnt);
		mav.addObject("totalPageCnt",totalPageCnt);
		session.setAttribute("currentPage", page);
		return mav;
	}
	
	@RequestMapping(value="/board/getByCondition.do")
	public ModelAndView getByCondition(HttpServletRequest request,ServletResponse response, 
			@RequestParam(value="page", defaultValue="1")int page,
			@RequestParam(value="condition", defaultValue="all")String condition,
			@RequestParam(value="contents", defaultValue="all")String contents) throws Exception{
		if(page == 0){
			page = 1000000;
		}

		System.out.println("폼데이터 들어왔다");
		System.out.println(condition+contents+page);
		ModelAndView mav = new ModelAndView("boardMain");
		HttpSession session = request.getSession();

		
		//ArrayList<Board> list = (ArrayList<Board>) bService.getAll();
		//페이지 정보 
		PageInfo pageInfo = new PageInfo();
		//한페이지에 게시글 몇개 보여줄거니?
		pageInfo.setPageRecordSize(10);
		pageInfo.setStartRow((page-1)*pageInfo.getPageRecordSize());
		

		System.out.println(pageInfo);
		//조건 검색 가져오기
		ArrayList<Board> list=(ArrayList<Board>)bService.getByCondition(condition, contents, pageInfo);
		System.out.println("조건 검색 결과 :"+list.size());
		//조건 갯수 검색
		int totalBoardCnt = bService.getByConditionCnt(condition, contents);
		mav.addObject("bList", list);
		mav.addObject("bListSize", list.size());
		//mav.addObject("boardAllCnt", boardAllCnt);
		mav.addObject("pageSize", pageInfo.getPageRecordSize());
		//몇 페이지 씩 나타낼 것인지
		int showPage = 5;
		//전체 페이지가 몇개인지
		int totalPageCnt = (int) Math.ceil((double)totalBoardCnt/pageInfo.getPageRecordSize());
				//(boardAllCnt/pageInfo.getPageRecordSize())+(boardAllCnt%pageInfo.getPageRecordSize() == 0? 0:1);
		if(page > totalPageCnt){
			page = 1000000;
		}
		//현재 페이지 그룹이 몇인지		
		int currentBlock = (int) Math.ceil((double)page/showPage);
		//페이지그룹의 수 
		int pageGroupCnt = (int)Math.ceil((double)totalPageCnt/showPage);
		//시작페이지
		int startPage = (currentBlock-1)*showPage +1;
		//끝페이지
		int endPage = startPage+showPage-1;
		if(endPage > totalPageCnt){
			endPage = totalPageCnt;
		}
			//int pageGroupCnt = (allPageCnt/pageGroupSize)+(allPageCnt%pageGroupSize == 0? 0:1);
		
		mav.addObject("showPage",showPage);
		mav.addObject("startPage",startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("currentBlock", currentBlock);
		mav.addObject("pageGroupCnt", pageGroupCnt);
		mav.addObject("totalPageCnt",totalPageCnt);
		mav.addObject("contents",contents);
		mav.addObject("condition",condition);
		session.setAttribute("currentPage", page);
		session.setAttribute("condition", condition);
		session.setAttribute("contents", contents);
		
		System.out.println(startPage);
		System.out.println(endPage);
		return mav;
	}
	/**
	 * 글쓰기
	 * @param b
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/board/writeBoard.do", method=RequestMethod.POST)
	public ModelAndView writeBoard(Board b,HttpServletRequest request){
		System.out.println("라이트보드가먼저냐");
		System.out.println(b);
		ModelAndView mav = new ModelAndView();
		//System.out.println("파일ㄹㄹㄹㄹㄹㄹ::"+file.length);
		//ModelAndView mav = new ModelAndView("board");
		HttpSession session = request.getSession();
		//TEST용 세션에 info가 없음 원래 id임
		Member m =(Member) session.getAttribute("id"); 
		//b의 pno의 여부에 따라 댓글인지 아닌지를 판단합시다.
		
		
		if(m == null){
			System.out.println("로그인해야 하는 상황");
			mav.setViewName("../../index");
		}else{
			//로그인 된 상황
			//글번호 지정하기
			int seq = bService.getSeq();
			b.setBoard_seq(seq+1);
			java.util.Date todayNow = new java.util.Date();
			SimpleDateFormat sdf;
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			//b.setWriter(m.getId());
			b.setWriter(m.getId());
			b.setReg_date(sdf.format(todayNow));
			System.out.println("메인글쓰기");
			//pno는 부모번호가 아니고 ref로 해석합시다.
			b.setP_no(seq+1);
			//부모글일때는 reply_seq가 자동으로 0으로 입력됨
			b.setWritername(m.getName());
			bService.insert(b);

			if(m.getId().equals(b.getWriter())){
				System.out.println("다르니?");
				session.setAttribute("createBoardSeq", b.getBoard_seq());
			}
			
			//파일이 있으면;
			/*if(file.length > 0){
				try {
					for(int i = 0; i< file.length; i++){
						vo.File voFile = new vo.File();
						int fileNo = fService.getFileSeq();
						voFile.setFileNo(fileNo+1);
						String fileOrgName = file[i].getOriginalFilename();
						voFile.setFileName1(fileOrgName);
						//TODO
						String randomFileName = RandomStringUtils.random(24);
						
						System.out.println(randomFileName);
						String fileName = fileOrgName;
						voFile.setFileName2(fileName);
						voFile.setBoard_seq(b.getBoard_seq());
						
						System.out.println("파일사이즈는 : "+file[i].getSize());
						int fileSize = Math.round(file[i].getSize()/1024);
						voFile.setFileSize(fileSize);
						
						String path="C:\\Users\\imoxion\\workspace\\SB\\src\\main\\webapp\\file\\"+fileName;
						
						File attachFile = new File(path);
						file[i].transferTo(attachFile);
						voFile.setFilePath("C:\\Users\\imoxion\\workspace\\SB\\src\\main\\webapp\\file\\"+fileName);
						bService.updateFileCnt(b.getFileCnt()+1, b.getBoard_seq());
						fService.insertFile(voFile);
					}
					
					
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
			}*/
			
			mav.addObject("board_seq",b.getBoard_seq());
			mav.setViewName("writeBoardResult");
		//	mav.setViewName("redirect:/board/getAll.do");
		}
		return mav;
		
	}
	
	@RequestMapping(value="/board/writeRepBoard.do", method=RequestMethod.POST)
	public ModelAndView writeRepBoard(Board b,@RequestParam(value="no")int parentBno,HttpServletRequest request){
		System.out.println("Rep보드 들어왔니??");
		System.out.println("부모글번호:"+parentBno);
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		Member m =(Member) session.getAttribute("id"); 
		if(m == null){
			System.out.println("로그인해야 하는 상황");
			mav.setViewName("../../index");
			
		}else{
			//로그인 된 상황
			//글번호 지정하기
			int seq = bService.getSeq();
			b.setBoard_seq(seq+1);
			java.util.Date todayNow = new java.util.Date();
			SimpleDateFormat sdf;
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			b.setWriter(m.getId());
			b.setReg_date(sdf.format(todayNow));
			//답글
			System.out.println("답글쓰기");

			//부모글의 dept보다 1이 크도록!!
			//reply_seq p_no별 답글 순서!
			//중간 끼워넣기 뒤의 글들 reply_seq 증가 쿼리
			/*update s_board set reply_seq = reply_seq+1
			  where p_no=#{p_no} and reply_seq >= #{reply_seq}*/
			//부모글의 rep_seq를 알아내고 거기에 +1을 한다!
			Board parentB = bService.getBySeq(parentBno);
			//parentB.getReply_seq();
			//같은 dept에서 가장 큰 seq를 가지고옴
			//int rep_seq = bService.getRepSeq(b.getP_no(), b.getDept());
			//rep_seq를 할당할 번호가 있으면 그번호중 가장큰 번호를 검색			
			//삽입하려는 rep_seq의 위치에 답글이 존재하는데, 이 답글의 dept가 부모의 dept와 같다면
			//Board findBoard = bService.getByRepSeq(b.getP_no(), parentB.getReply_seq()+1);
			//부모 글의 seq에 +1
			//부모 글 다음의 seq 즉 댓글이 있다면,
			Board nextBoard = bService.getByRepSeq(parentB.getP_no(), parentB.getReply_seq()+1);
			if( nextBoard != null &&parentB.getDept() < nextBoard.getDept()){
				System.out.println("부모글의 댓글이 있을때");
				//전 dept의 범위 안에서 가장큰 rep를 구한다!
				//1.부모의 dept. 즉, 자신의dept-1번의 rep_seq를 구한다.
				int parentBRepSeq = parentB.getReply_seq();
				//2.부모와 같은 dept의 다음 rep_seq를 구한다.(범위)
				int range = bService.getSameDeptNextReq(parentB.getP_no(),parentB.getDept(),parentBRepSeq);
				int repseq = 0;
				//범위를 구했는데 0이면 부모와 같은 레벨의 다음글이 없는 상황
				if(range == 0){
					System.out.println("범위가 없어서 dept에서 가장 rep가 큰걸 구할때");
					//이럴땐 같은 레벨의 가장 큰 글을 구하기
					//pno에서 가장 마지막 글일 때
					repseq=bService.getRepSeq2(parentB.getP_no());
					b.setReply_seq(repseq+1);
				}else{
					//부모와 같은레벨의 다음글(범위)이 존재할때
					System.out.println("범위를 구했을때");
					b.setReply_seq(range);
				}				
			}else{
				System.out.println("부모글의 댓글이 없을때");
				b.setReply_seq(parentB.getReply_seq()+1);
			}
			bService.updateRepSeq(b.getP_no(), b.getReply_seq());
			System.out.println("댓글:"+b);
			b.setWritername(m.getName());
			bService.insert(b);
			mav.addObject("board_seq",b.getBoard_seq());
			mav.setViewName("writeBoardResult");
		}
		return mav;
	}
	
/*	public String removeTag(String contents) throws Exception{
		//return contents.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
		System.out.println("태그변해라");
		contents.replaceAll("<","aa");
		contents.replaceAll(">","bb");
		System.out.println(contents);
		return contents;
	}*/
	
	/**
	 * 글상세
	 * @param no
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/board/boardDetail.do")
	public ModelAndView detailBoard(@RequestParam(value="boardNo")int no) throws Exception{
		ModelAndView mav = new ModelAndView("boardDetail");
		System.out.println(no+"를 가지고옴");
		//TODO 번호로 가져오기
		Board b = bService.getBySeq(no);
		//b.setContents(removeTag(b.getContents()));
		b.setContents(b.getContents().replaceAll("\n", "<br>"));
		System.out.println(b);
		
		if(b.getFileCnt() > 0){
			ArrayList<kr.or.kosta.otl.vo.File> fileList = (ArrayList<kr.or.kosta.otl.vo.File>) fService.getFileByBoardSeq(b.getBoard_seq());
			mav.addObject("fileList", fileList);
			mav.addObject("fileListSize", fileList.size());
			System.out.println(fileList);
		}
		
		bService.addCnt(b.getBoard_seq());
		
		mav.addObject("boardDetail",b);
		return mav;
	}
	
	@RequestMapping(value="/board/down.do")
	public ModelAndView download(@RequestParam(value="board_seq")int board_seq,
			@RequestParam(value="fileseq")int fileseq ) throws Exception {
		System.out.println("파일다운들어옴");
		ModelAndView mav = new ModelAndView("downView");
		kr.or.kosta.otl.vo.File vofile = fService.getFile(board_seq,fileseq);
		File downFile = new File(vofile.getFilePath());
		mav.addObject("downloadFile",downFile);
		mav.addObject("oriFileName",vofile.getFileName1());
		return mav;
	}	
	
	
	@RequestMapping(value="/board/boardDel.do")
	public String deleteBoard(@RequestParam(value="no")int no,HttpServletRequest request){
		HttpSession session = request.getSession();
		System.out.println("들어왔냐삭제");
		bService.del(no);
		if(session.getAttribute("condition") != null){
			return "redirect:/board/getByCondition.do?page="
		+session.getAttribute("currentPage")+"&condition="+session.getAttribute("condition")
		+"&contents="+session.getAttribute("contents");
		}else{
			return "redirect:/board/getAll.do?page="+session.getAttribute("currentPage");	
		}
		
	}
	

	@RequestMapping(value="/board/boardEdit.do")
	public ModelAndView editBoard(@RequestParam(value="no")int no){
		System.out.println("들어왔냐수정");
		ModelAndView mav = new ModelAndView("boardEdit");
		Board b = bService.getBySeq(no);
		if(b.getFileCnt() > 0){
			ArrayList<kr.or.kosta.otl.vo.File> fileList = (ArrayList<kr.or.kosta.otl.vo.File>) fService.getFileByBoardSeq(b.getBoard_seq());
			mav.addObject("fileList", fileList);
			mav.addObject("fileListSize", fileList.size());
			System.out.println(fileList);
		}
		mav.addObject("detail", b);
		return mav;
	}
	
	@RequestMapping(value="/board/doBoardEdit.do")
	public String doEditBoard(Board b){
		System.out.println("수정합시다");
		System.out.println(b);
		Board oB = bService.getBySeq(b.getBoard_seq());
		oB.setContents(b.getContents());
		oB.setTitle(b.getTitle());
		bService.edit(oB);
		System.out.println("수정했다앙");
		return "redirect:/board/boardDetail.do?boardNo="+oB.getBoard_seq();
	}
	@RequestMapping(value="/board/replyBoard.do")
	public ModelAndView replyBoard(@RequestParam(value="no")int no,@RequestParam(value="dept")int dept,
			@RequestParam(value="pno")int p_no){
		System.out.println("댓글답시다");
		ModelAndView mav = new ModelAndView("writeRepBoard");
		Board pBoard = bService.getBySeq(no);
		mav.addObject("parentBoard", pBoard);
		mav.addObject("p_no", p_no);
		//dept는 부모글의 dept
		
		int repDept=dept+1;
		mav.addObject("repDept", repDept);
		//부모글의 번호 보내서 정보사용할거임
		mav.addObject("no",no);
		return mav;
	
	}
	
}