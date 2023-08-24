package com.legend.conv.common.vo;

public class PagingVO2 {
	
	private int curPage2=1;            // 페이지 번호 ( 목록페이지 처음 요청때문에 초기값을 1으로 세팅 )              
	private int rowSizePerPage2=10;    // 한 페이지당 게시글 수  ( 기본 10 )                            
	private int pageSize2=5;           // 리스트 하단에 보여줄 페이지 링크 갯수  ( 보통 10 )                   
	private int totalRowCount2;        // 총 게시글 수                                            
	private int firstRow;             // 해당 페이지의 시작 글 번호                                    
	private int lastRow;              // 해당 페이지의 마지막 글 번호                                   
	private int firstPage2;            // 하단 페이지링크에서 시작  페이지 번호                              
	private int lastPage2;             // 하단 페이지링크에서 마지막 페이지 번호                              
	private int totalPageCount2;       // 하단 총 페이지링크 건수                                      

	
	public void pageSetting() {
	    firstRow = (curPage2 - 1) * rowSizePerPage2 + 1;
	    lastRow = curPage2 * rowSizePerPage2;
	    if (lastRow > totalRowCount2) {
	        lastRow = totalRowCount2;
	    }
	    totalPageCount2 = (totalRowCount2 - 1) / rowSizePerPage2 + 1;
	    firstPage2 = (curPage2 - 1) / pageSize2 * pageSize2 + 1;
	    lastPage2 = firstPage2 + pageSize2 - 1;
	    if (lastPage2 > totalPageCount2) {
	        lastPage2 = totalPageCount2;
	    }
	}

	
	public PagingVO2() {}

	public PagingVO2(int curPage2, int rowSizePerPage2, int pageSize2, int totalRowCount2, int firstRow, int lastRow,
			int firstPage2, int lastPage2, int totalPageCount2) {
		super();
		this.curPage2 = curPage2;
		this.rowSizePerPage2 = rowSizePerPage2;
		this.pageSize2 = pageSize2;
		this.totalRowCount2 = totalRowCount2;
		this.firstRow = firstRow;
		this.lastRow = lastRow;
		this.firstPage2 = firstPage2;
		this.lastPage2 = lastPage2;
		this.totalPageCount2 = totalPageCount2;
	}


	@Override
	public String toString() {
		return "PagingVO2 [curPage2=" + curPage2 + ", rowSizePerPage2=" + rowSizePerPage2 + ", pageSize2=" + pageSize2
				+ ", totalRowCount2=" + totalRowCount2 + ", firstRow=" + firstRow + ", lastRow=" + lastRow
				+ ", firstPage2=" + firstPage2 + ", lastPage2=" + lastPage2 + ", totalPageCount2=" + totalPageCount2
				+ "]";
	}


	public int getCurPage2() {
		return curPage2;
	}


	public void setCurPage2(int curPage2) {
		this.curPage2 = curPage2;
	}


	public int getRowSizePerPage2() {
		return rowSizePerPage2;
	}


	public void setRowSizePerPage2(int rowSizePerPage2) {
		this.rowSizePerPage2 = rowSizePerPage2;
	}


	public int getPageSize2() {
		return pageSize2;
	}


	public void setPageSize2(int pageSize2) {
		this.pageSize2 = pageSize2;
	}


	public int getTotalRowCount2() {
		return totalRowCount2;
	}


	public void setTotalRowCount2(int totalRowCount2) {
		this.totalRowCount2 = totalRowCount2;
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


	public int getFirstPage2() {
		return firstPage2;
	}


	public void setFirstPage2(int firstPage2) {
		this.firstPage2 = firstPage2;
	}


	public int getLastPage2() {
		return lastPage2;
	}


	public void setLastPage2(int lastPage2) {
		this.lastPage2 = lastPage2;
	}


	public int getTotalPageCount2() {
		return totalPageCount2;
	}


	public void setTotalPageCount2(int totalPageCount2) {
		this.totalPageCount2 = totalPageCount2;
	}
	
	
}
