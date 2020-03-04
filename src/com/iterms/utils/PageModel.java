package com.iterms.utils;

import java.util.List;

public class PageModel<E> {
	private Integer pageSize=5;  			//页面数据条数
	private Integer currentPage;		//当前页面
	private Integer startIndex;			//起始索引
	private Integer total;				//总记录数
	private Integer pageCount;			//总页数
	private List<E> resultList;			//数据集
	
	
	public Integer getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(Integer currentPage,Integer pageSize) {
		this.startIndex = (currentPage-1)*pageSize;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Integer getPageCount() {
		return pageCount;
	}
	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}
	public List<E> getResultList() {
		return resultList;
	}
	public void setResultList(List<E> resultList) {
		this.resultList = resultList;
	}
	@Override
	public String toString() {
		return "PageModel [pageSize=" + pageSize + ", currentPage=" + currentPage + ", startIndex=" + startIndex
				+ ", total=" + total + ", pageCount=" + pageCount + ", resultList=" + resultList + "]";
	}
	
	
}
