package kr.or.kosta.otl.vo;



public class File {
private int fileNo;
private int board_seq;
private String fileName1;
private String fileName2;
private String filePath;
private String fileSize;


public int getFileNo() {
	return fileNo;
}
public void setFileNo(int fileNo) {
	this.fileNo = fileNo;
}
public int getBoard_seq() {
	return board_seq;
}
public void setBoard_seq(int board_seq) {
	this.board_seq = board_seq;
}
public String getFileName1() {
	return fileName1;
}
public void setFileName1(String fileName1) {
	this.fileName1 = fileName1;
}
public String getFileName2() {
	return fileName2;
}
public void setFileName2(String fileName2) {
	this.fileName2 = fileName2;
}
public String getFilePath() {
	return filePath;
}
public void setFilePath(String filePath) {
	this.filePath = filePath;
}
public String getFileSize() {
	return fileSize;
}
public void setFileSize(String fileSize) {
	this.fileSize = fileSize;
}
@Override
public String toString() {
	return "File [fileNo=" + fileNo + ", board_seq=" + board_seq + ", fileName1=" + fileName1 + ", fileName2="
			+ fileName2 + ", filePath=" + filePath + ", fileSzie=" + fileSize + "]";
}


}
