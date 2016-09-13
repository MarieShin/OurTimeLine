package kr.or.kosta.otl.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import kr.or.kosta.otl.vo.Member;

@MapperScan
public interface MemberMapper {

	//로그인
	public Member login(@Param("id")String id);
	//회원가입
	public void join(@Param("m")Member m);
	//아이디중복체크
	public Member idchk(@Param("id")String id);
	//회원수
	public int getCnt();
	//전체회원가져오기
	public List<Member> getAllMem();
	//회원삭제
	public void delMem(@Param("memseq")int memseq);
}
