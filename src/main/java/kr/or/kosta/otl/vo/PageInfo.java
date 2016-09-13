package kr.or.kosta.otl.vo;

public class PageInfo {
	
	private int pageRecordSize;
	private int startRow;
	
	
	public int getPageRecordSize() {
		return pageRecordSize;
	}
	public void setPageRecordSize(int pageSize) {
		this.pageRecordSize = pageSize;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	@Override
	public String toString() {
		return "PageInfo [pageRecordSize=" + pageRecordSize + ", startRow=" + startRow + "]";
	}
	
	

}
