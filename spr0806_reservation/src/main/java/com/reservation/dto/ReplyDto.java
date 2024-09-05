package com.reservation.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ReplyDto {
	
	/*댓글 SQL
	 * drop table reply;
	CREATE TABLE reply (
	rId NUMBER PRIMARY KEY,
	bId NUMBER NOT NULL,
	rContent VARCHAR2(1000) NOT NULL,
	rName VARCHAR2(100) NOT NULL,
	rWriteTime date DEFAULT sysdate,
	rUpdateTime date,
	rEtc VARCHAR2(1000),
	rGroup NUMBER NOT NULL,
	rStep NUMBER DEFAULT 0,
	rIndent NUMBER DEFAULT 0,
	rDelete CHAR(1) DEFAULT 'N'
	);

	select * from reply;

	drop sequence rid;
	CREATE SEQUENCE rId;
	*/
	private int rId;
	private int bId;
	private String rContent;
	private String rName;
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm:ss")
	private Date rWriteTime;
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm:ss")
	private Date rUpdateTime;
	private String rEtc;
	private int rGroup;
	private int rStep;
	private int rIndent;
	private String rDelete;
	public int getrId() {
		return rId;
	}
	public void setrId(int rId) {
		this.rId = rId;
	}
	public int getbId() {
		return bId;
	}
	public void setbId(int bId) {
		this.bId = bId;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public String getrName() {
		return rName;
	}
	public void setrName(String rName) {
		this.rName = rName;
	}
	public Date getrWriteTime() {
		return rWriteTime;
	}
	public void setrWriteTime(Date rWriteTime) {
		this.rWriteTime = rWriteTime;
	}
	public Date getrUpdateTime() {
		return rUpdateTime;
	}
	public void setrUpdateTime(Date rUpdateTime) {
		this.rUpdateTime = rUpdateTime;
	}
	public String getrEtc() {
		return rEtc;
	}
	public void setrEtc(String rEtc) {
		this.rEtc = rEtc;
	}
	public int getrGroup() {
		return rGroup;
	}
	public void setrGroup(int rGroup) {
		this.rGroup = rGroup;
	}
	public int getrStep() {
		return rStep;
	}
	public void setrStep(int rStep) {
		this.rStep = rStep;
	}
	public int getrIndent() {
		return rIndent;
	}
	public void setrIndent(int rIndent) {
		this.rIndent = rIndent;
	}
	public String getrDelete() {
		return rDelete;
	}
	public void setrDelete(String rDelete) {
		this.rDelete = rDelete;
	}
	
	@Override
	public String toString() {
		return "replyDto [rId=" + rId + ", bId=" + bId + ", rContent=" + rContent + ", rName=" + rName + ", rWriteTime="
				+ rWriteTime + ", rUpdateTime=" + rUpdateTime + ", rEtc=" + rEtc + ", rGroup=" + rGroup + ", rStep="
				+ rStep + ", rIndent=" + rIndent + ", rDelete=" + rDelete + "]";
	}
}
