package kr.or.kosta.otl.service;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.kosta.otl.mapper.BoardMapper;
import kr.or.kosta.otl.vo.Board;
import kr.or.kosta.otl.vo.PageInfo;



/**
 * @author imoxion
 *
 */
@Service
public class BoardService {

	@Autowired
	private BoardMapper mapper;
	
	public BoardService() {
		// TODO Auto-generated constructor stub
	}
	//�쟾泥댁“�쉶
	public List<Board> getAll(){
		return mapper.getAll();
	}
	//湲��벐湲�
	public void insert(Board board) {
		mapper.write(board);
		
	}
	public int getSeq(){
		
		int retVal = 0;
		try{
			retVal=mapper.getSeq();	
		}catch (Exception e){
			retVal = 0;
		}
			return retVal;
		//}
		
	}
	public Board getBySeq(int no) {
		// TODO Auto-generated method stub
		return mapper.getBySeq(no);
	}
	public void del(int no) {
		// TODO Auto-generated method stub
		mapper.delete(no);
	}
	public void edit(Board b){
		mapper.update(b);
	}
	public int getRepSeq(int p_no, int dept) {
		Board b = new Board();
		b.setP_no(p_no);
		b.setDept(dept);
		int retVal = 0;
		try{
			retVal =mapper.getRepSeq(b);	
		}catch (Exception e){
			retVal = 0;
		}
		
			return retVal;
		
		
	}
	public void updateRepSeq(int p_no, int reply_seq) {
		Board b = new Board();
		b.setP_no(p_no);
		b.setReply_seq(reply_seq);
		
		mapper.updateRepSeq(b);
	}
	public List<Board> getByPno(int p_no) {
		// TODO Auto-generated method stub
		return mapper.getByPno(p_no);
	}
	public Board getByRepSeq(int p_no, int reply_seq) {
		// TODO Auto-generated method stub
		
		Board board = new Board();
		board.setP_no(p_no);
		board.setReply_seq(reply_seq);
		
		return mapper.getByRepSeq(board);
	}
	//�떟湲��쓽 踰붿쐞�궡�뿉�꽌 媛��옣 �겙 rep_seq瑜� 援ы븯湲� �쐞�븿
	public int getSameDeptNextReq(int p_no, int dept, int parentBRepSeq) {
		// TODO Auto-generated method stub
		Board board = new Board();
		board.setP_no(p_no);
		board.setDept(dept);
		board.setReply_seq(parentBRepSeq);
		int retVal = 0;
		try{
			retVal = mapper.getSameDeptNextReq(board);
		}catch (Exception e){
			retVal = 0;
		}
	
			return retVal;	
		
		
	}
	//p_no�뿉�꽌 媛��옣 �겙 repseq
	public int getRepSeq2(int p_no) {
		// TODO Auto-generated method stub
		int retVal = 0;
		try{
			retVal = mapper.getRepSeq2(p_no);
		}catch (Exception e){
			retVal = 0;
		}
	
			return retVal;	
		
	}
	public int getCnt() {
		// TODO Auto-generated method stub
	
			return  mapper.getCnt();
	}
	public List<Board> getPageBoard(PageInfo pageInfo) {
		// TODO Auto-generated method stub
		System.out.println("page parameter : " +pageInfo );
		return mapper.getPageBoard(pageInfo);
	}
	public void addCnt(int board_seq) {
		// TODO Auto-generated method stub
		mapper.addCnt(board_seq);
		
	}
	public void updateFileCnt(int fileCnt, int board_seq) {
		// TODO Auto-generated method stub
		Board board = new Board();
		board.setFileCnt(fileCnt);
		board.setBoard_seq(board_seq);
		mapper.updateFileCnt(board);
	}
	
	
	public List<Board> getByCondition(String condition, String contents, PageInfo pageInfo) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("contents", contents);
		map.put("pageInfo", pageInfo);
		if(condition.equals("all")){
			
			return getPageBoard(pageInfo);
		}else if(condition.equals("id")){
			
			return mapper.getByWriter(map);
		}else if(condition.equals("title")){
			
			return mapper.getByTitle(map);
		}else if(condition.equals("contents")){
			
			return mapper.getByContents(map);
		}else if(condition.equals("filename")){
			
			return mapper.getByFilename(map);
		}else{
			return null;
		}
			
	}
	public int getByConditionCnt(String condition, String contents) {
		// TODO Auto-generated method stub
		if(condition.equals("all")){
			
			return getCnt();
		}else if(condition.equals("id")){
			return mapper.getByWriterBoardCnt(contents);
		}else if(condition.equals("title")){
			
			return mapper.getByTitleBoardCnt(contents);
		}else if(condition.equals("contents")){
			
			return mapper.getByContentsBoardCnt(contents);
		}else if(condition.equals("filename")){
			
			return mapper.getByFilenameBoardCnt(contents);
		}else{
			return 0;
		}
		
	}
	
}
