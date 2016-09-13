package kr.or.kosta.otl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.kosta.otl.mapper.FileMapper;
import kr.or.kosta.otl.vo.File;


@Service
public class FileService {

	@Autowired
	private FileMapper mapper;
	
	public int getFileSeq() {
		// TODO Auto-generated method stub
		int retVal = 0;
		try{
			retVal = mapper.getFileSeq();	
		}catch (Exception e){
			retVal = 0;
		}
		return retVal;
	}

	public void insertFile(kr.or.kosta.otl.vo.File voFile) {
		// TODO Auto-generated method stub
		mapper.insertFile(voFile);
		
	}

	public List<File> getFileByBoardSeq(int board_seq) {
		// TODO Auto-generated method stub
		return mapper.getFileByBoardSeq(board_seq);
		
	}

	public kr.or.kosta.otl.vo.File getFile(int board_seq, int fileseq) {
		// TODO Auto-generated method stub
		
		kr.or.kosta.otl.vo.File f = new File();
		f.setBoard_seq(board_seq);
		f.setFileNo(fileseq);
		return mapper.getFile(f);
	}

	public void deleteFile(String filename2) {
		// TODO Auto-generated method stub
		mapper.delFile(filename2);
	}

}
