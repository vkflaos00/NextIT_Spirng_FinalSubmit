package com.legend.conv.notice.vo;

public class PagingVO {
	
	private int curPage=1;
	private int rowSizePerPage=10;
	private int pageSize=5;
	private int totalRowCount;
	private int firstRow;
	private int lastRow;
	private int firstPage;
	private int lastPage;
	private int totalPageCount;

	public void pageSetting() {
		firstRow = totalRowCount - ( curPage -1 ) * rowSizePerPage ;
		lastRow = firstRow - (rowSizePerPage -1);
		if(lastRow < 0) {
			lastRow= 1 ;
		}
		totalPageCount=(totalRowCount-1)/rowSizePerPage +1;
		firstPage = (curPage-1)/pageSize*pageSize +1;
		lastPage = firstPage + pageSize -1;
		if(lastPage > totalPageCount) {
			lastPage = totalPageCount ; 
		}
	
	}
	
	public PagingVO() {}

	public PagingVO(int curPage, int rowSizePerPage, int pageSize, int totalRowCount, int firstRow, int lastRow,
			int firstPage, int lastPage, int totalPageCount) {
		this.curPage = curPage;
		this.rowSizePerPage = rowSizePerPage;
		this.pageSize = pageSize;
		this.totalRowCount = totalRowCount;
		this.firstRow = firstRow;
		this.lastRow = lastRow;
		this.firstPage = firstPage;
		this.lastPage = lastPage;
		this.totalPageCount = totalPageCount;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getRowSizePerPage() {
		return rowSizePerPage;
	}

	public void setRowSizePerPage(int rowSizePerPage) {
		this.rowSizePerPage = rowSizePerPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalRowCount() {
		return totalRowCount;
	}

	public void setTotalRowCount(int totalRowCount) {
		this.totalRowCount = totalRowCount;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}

	public int getLastRow() {
		return lastRow;
	}

	public void setLastRow(int lastRow) {
		this.lastRow = lastRow;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	@Override
	public String toString() {
		return "PagingVO [curPage=" + curPage + ", rowSizePerPage=" + rowSizePerPage + ", pageSize=" + pageSize
				+ ", totalRowCount=" + totalRowCount + ", firstRow=" + firstRow + ", lastRow=" + lastRow
				+ ", firstPage=" + firstPage + ", lastPage=" + lastPage + ", totalPageCount=" + totalPageCount + "]";
	}

	
	
}
