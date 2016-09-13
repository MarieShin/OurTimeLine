package kr.or.kosta.otl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.kosta.otl.mapper.MemberMapper;
import kr.or.kosta.otl.vo.Member;


/**
 * �쉶�썝愿��젴 �꽌鍮꾩뒪
 * @author imoxion
 *
 */
@Service
public class MemberService {

	@Autowired
	private MemberMapper mapper;
	
	
	public Member login(String id){
		return mapper.login(id);
	}
	
	public void signup(Member m){
		mapper.join(m);
		
	}
	
	public Member idchk(String id){
		return mapper.idchk(id);
		
	}

	/**
	 * �쉶�썝 �닔 媛�吏�怨� �삤湲�
	 */
	public int getCnt() {
		
		return mapper.getCnt();

	}

	public List<Member> getAllMem() {
		// TODO Auto-generated method stub
		return mapper.getAllMem();
	}

	public void delMem(int memseq) {
		// TODO Auto-generated method stub
		mapper.delMem(memseq);
	}
	
}
