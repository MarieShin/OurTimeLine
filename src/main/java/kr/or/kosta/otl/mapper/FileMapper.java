package kr.or.kosta.otl.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import kr.or.kosta.otl.vo.File;


@MapperScan
public interface FileMapper {

	int getFileSeq();

	void insertFile(@Param("voFile")File voFile);

	List<File> getFileByBoardSeq(@Param("board_seq")int board_seq);

	File getFile(@Param("f")kr.or.kosta.otl.vo.File f);

	void delFile(@Param("filename2")String filename2);

}
