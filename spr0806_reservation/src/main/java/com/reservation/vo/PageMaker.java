package com.reservation.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	private String bGroupKind;
	private int page=1;
	private int perPageNum=10;
	private String searchType;
	private String keyword;
	
	private int totalCount;
	private int totalStartPage=1;
	private int totalEndPage;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int displayPageNum = 10;

	public String getbGroupKind() {
		return bGroupKind;
	}

	public void setbGroupKind(String bGroupKind) {
		this.bGroupKind = bGroupKind;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	
	private void calcData() {
		totalStartPage=1;
		totalEndPage=(int)Math.ceil(totalCount/(double)perPageNum);
		endPage = (int) (//ceil 올림 floor내림  round 반올림
				Math.ceil(page/(double)displayPageNum)*displayPageNum); 
		startPage=endPage-displayPageNum+1;
		if(totalEndPage<endPage) {
			endPage=totalEndPage;
		}
		
		if(startPage<1) {
			startPage=1;
		}
		if(startPage==1) {
			prev=false;
		}else {
			prev=true;
		}
	}
	
	public int getTotalStartPage() {
		return totalStartPage;
	}

	public void setTotalStartPage(int totalStartPage) {
		this.totalStartPage = totalStartPage;
	}

	public int getTotalEndPage() {
		return totalEndPage;
	}

	public void setTotalEndPage(int totalEndPage) {
		this.totalEndPage = totalEndPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	@Override
	public String toString() {
		return "PageMaker [bGroupKind=" + bGroupKind + ", page=" + page + ", perPageNum=" + perPageNum + ", searchType="
				+ searchType + ", keyword=" + keyword + ", totalCount=" + totalCount + ", totalStartPage="
				+ totalStartPage + ", totalEndPage=" + totalEndPage + ", startPage=" + startPage + ", endPage="
				+ endPage + ", prev=" + prev + ", next=" + next + ", displayPageNum=" + displayPageNum + "]";
	}
	
	public String makeSearch() {
		UriComponents u =UriComponentsBuilder.newInstance()
				.queryParam("bGroupKind",bGroupKind)
				.queryParam("page",page)
				.queryParam("perPageNum",perPageNum)
				.queryParam("searchType",searchType)
				.queryParam("keyword",keyword)
				.build();
		return u.toUriString();
	}
	public String makepage(int page) {
		UriComponents u = UriComponentsBuilder.newInstance()
				.queryParam("bGroupKind",bGroupKind)
				.queryParam("page",page)
				.queryParam("perPageNum", perPageNum)
				.build();
		return u.toUriString();
	}
}
