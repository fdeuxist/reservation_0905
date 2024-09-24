package com.reservation.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class BoardDto {
	
	/*
	 게시판 테이블
	drop table board;
	
	CREATE TABLE board (
	bGroupKind VARCHAR2(255),
	bId NUMBER PRIMARY KEY,
	bName VARCHAR2(255) NOT NULL,
	bTitle VARCHAR2(255) NOT NULL,
	bContent VARCHAR2(4000) NOT NULL,
	bEtc VARCHAR2(4000) NULL,
	bWriteTime DATE DEFAULT sysdate,
	bUpdateTime DATE DEFAULT null,
	bHit NUMBER DEFAULT 0,
	bGroup NUMBER ,
	bStep NUMBER DEFAULT 0,
	bIndent NUMBER DEFAULT 0,
	bDelete VARCHAR2(1) DEFAULT 'Y',
	bLike NUMBER DEFAULT 0,
	bDislike NUMBER DEFAULT 0
	);
	create sequence bId;
	
	select * from board;
	*/
	private String bGroupKind;
	private int bId;
	private String bName;
	private String bTitle;
	private String bContent;
	private String bEtc;
	@DateTimeFormat(pattern="yyyy-MM-dd'T' HH:mm")
	private Date bWriteTime;
	@DateTimeFormat(pattern="yyyy-MM-dd'T' HH:mm")
	private Date bUpdateTime;
	private int bHit;
	private int bGroup;
	private int bStep;
	private int bIndent;
	private String bDelete;
	private int bLike;
	private int bDislike;
	public String getbGroupKind() {
		return bGroupKind;
	}
	public void setbGroupKind(String bGroupKind) {
		this.bGroupKind = bGroupKind;
	}
	public int getbId() {
		return bId;
	}
	public void setbId(int bId) {
		this.bId = bId;
	}
	public String getbName() {
		return bName;
	}
	public void setbName(String bName) {
		this.bName = bName;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public String getbEtc() {
		return bEtc;
	}
	public void setbEtc(String bEtc) {
		this.bEtc = bEtc;
	}
	public Date getbWriteTime() {
		return bWriteTime;
	}
	public void setbWriteTime(Date bWriteTime) {
		this.bWriteTime = bWriteTime;
	}
	public Date getbUpdateTime() {
		return bUpdateTime;
	}
	public void setbUpdateTime(Date bUpdateTime) {
		this.bUpdateTime = bUpdateTime;
	}
	public int getbHit() {
		return bHit;
	}
	public void setbHit(int bHit) {
		this.bHit = bHit;
	}
	public int getbGroup() {
		return bGroup;
	}
	public void setbGroup(int bGroup) {
		this.bGroup = bGroup;
	}
	public int getbStep() {
		return bStep;
	}
	public void setbStep(int bStep) {
		this.bStep = bStep;
	}
	public int getbIndent() {
		return bIndent;
	}
	public void setbIndent(int bIndent) {
		this.bIndent = bIndent;
	}
	public String getbDelete() {
		return bDelete;
	}
	public void setbDelete(String bDelete) {
		this.bDelete = bDelete;
	}
	public int getbLike() {
		return bLike;
	}
	public void setbLike(int bLike) {
		this.bLike = bLike;
	}
	public int getbDislike() {
		return bDislike;
	}
	public void setbDislike(int bDislike) {
		this.bDislike = bDislike;
	}
	@Override
	public String toString() {
		return "BoardDto [bGroupKind=" + bGroupKind + ", bId=" + bId + ", bName=" + bName + ", bTitle=" + bTitle
				+ ", bContent=" + bContent + ", bEtc=" + bEtc + ", bWriteTime=" + bWriteTime + ", bUpdateTime="
				+ bUpdateTime + ", bHit=" + bHit + ", bGroup=" + bGroup + ", bStep=" + bStep + ", bIndent=" + bIndent
				+ ", bDelete=" + bDelete + ", bLike=" + bLike + ", bDislike=" + bDislike + "]";
	}
	

	
}