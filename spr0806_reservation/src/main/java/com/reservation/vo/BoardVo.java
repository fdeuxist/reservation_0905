package com.reservation.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class BoardVo {
	private int page = 1;  //현재 페이지
	private int perPageNum = 10; //페이지당 데이터 개수
	private String searchType; //검색할 칼럼
	private String keyword; //검색할 내용
	
	private int totalCount; // 전체 DATA 갯수
	private int totalStartPage=1; //첫 page
	private int totalEndPage; //끝 page
	private int startPage; //pagemaker에서 시작페이지 번호
	private int endPage; //pagemaker에서 마지막페이지 번호
	private boolean prev; //이전 페이지 번호 목록 이동
	private boolean next; //pageMaker 에서 사용자에게 제공하는 한화면에서 보여줄 페이지개수
	
	private int displayPageNum =10;
	private String bGroupKind;
	private String categoryType;
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
		endPage= (int)(//ceil 올림 floor 내림 round 반올림
				Math.ceil(page/(double)displayPageNum)*displayPageNum);
		startPage=endPage-displayPageNum+1;
		if(totalEndPage< endPage) {
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
		if(endPage==totalEndPage) {
			next=false;
		}else {
			next=true;
		}
	}
//	private boolean prev;//이전 페이지 번호 목록 이동
//	private boolean next;//다음 페이지 번호 목록 이동
	
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
	
	public String getbGroupKind() {
		return bGroupKind;
	}
	public void setbGroupKind(String bGroupKind) {
		this.bGroupKind = bGroupKind;
	}
	public String getCategoryType() {
		return categoryType;
	}
	public void setCategoryType(String categoryType) {
		this.categoryType = categoryType;
	}
	@Override
	public String toString() {
		return "BoardVo [page=" + page + ", perPageNum=" + perPageNum + ", searchType=" + searchType + ", keyword="
				+ keyword + ", totalCount=" + totalCount + ", totalStartPage=" + totalStartPage + ", totalEndPage="
				+ totalEndPage + ", startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next="
				+ next + ", displayPageNum=" + displayPageNum + ", bGroupKind=" + bGroupKind + ", categoryType="
				+ categoryType + "]";
	}
	
	public String makeSearch() {
		UriComponents u=UriComponentsBuilder.newInstance()
				.queryParam("bGroupKind", bGroupKind)
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum)
				.queryParam("searchType", searchType)
				.queryParam("keyword", keyword)
				.build();
		return u.toUriString();		
	}
	
	public String makeSearch(int page) {
		UriComponents u = UriComponentsBuilder.newInstance()
			.queryParam("bGroupKind",bGroupKind)
			.queryParam("page",page)
			.queryParam("perPageNum",perPageNum)
			.queryParam("searchType",searchType)
			.queryParam("keyword",keyword)
			.build();
			return u.toUriString();
	}
	public String makePage(int page) {
		UriComponents u = UriComponentsBuilder.newInstance()
				.queryParam("bGroupKind", bGroupKind)
				.queryParam("page",page)
				.queryParam("perPageNum", perPageNum)
				.build();
		return u.toUriString();
	}
}
