package kr.or.kosta.otl.mapper;



import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import kr.or.kosta.otl.vo.*;

@MapperScan
public interface BoardMapper {

	//쓰기
	public void write(@Param("board")Board board);
	//수정
	public void update(@Param("b")Board board);
	//삭제
	public void delete(@Param("no")int no);
	//전체 보기
	public List<Board> getAll();
	//시퀀스 가져오기
	public int getSeq();
	//글번호로 글정보 가져오기
	public Board getBySeq(@Param("no")int no);
	//댓글의 rep_seq 알아내기
	public int getRepSeq(@Param("b")Board b);
	//댓글들의 순서를 정할 수 있는 메서드
	public void updateRepSeq(@Param("b")Board b);
	//pno에 맞는 데이터를 다가지고온다!
	public List<Board> getByPno(@Param("p_no")int p_no);
	//p_no에 맞는 reply_seq를 반환
	public Board getByRepSeq(@Param("board")Board board);
	//답글의 범위내에서 가장 큰 rep_seq를 구하기 위함
	public int getSameDeptNextReq(@Param("board")Board b);
	//pno에서 가장 큰거 가져오기
	public int getRepSeq2(@Param("p_no")int p_no);
	public int getCnt();
	public List<Board> getPageBoard(@Param("pageInfo")PageInfo pageInfo);
	public void addCnt(@Param("board_seq")int board_seq);
	public void updateFileCnt(@Param("board")Board board);
	//조건검색 페이징
	public List<Board> getByCondition(@Param("condition")String condition,@Param("contents") String contents,@Param("pageInfo") PageInfo pageInfo);

	public List<Board> getByWriter(@Param("map")HashMap<String, Object> map);
	public List<Board> getByTitle(@Param("map")HashMap<String, Object> map);
	public List<Board> getByContents(@Param("map")HashMap<String, Object> map);
	public List<Board> getByFilename(@Param("map")HashMap<String, Object> map);
	public int getByWriterBoardCnt(@Param("contents")String contents);
	public int getByTitleBoardCnt(@Param("contents")String contents);
	public int getByContentsBoardCnt(@Param("contents")String contents);
	public int getByFilenameBoardCnt(@Param("contents")String contents);
}
