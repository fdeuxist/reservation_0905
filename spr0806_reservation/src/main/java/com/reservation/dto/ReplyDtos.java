package com.reservation.dto;

import java.time.LocalDateTime;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

public class ReplyDtos {
	private int rId;
	//private int bId;
	private String writer;
	private String content;
	
	private int rGroup;
	private int rStep;
	private int rIndent;
	
	
	public int getrId() {
		return rId;
	}



	public void setrId(int rId) {
		this.rId = rId;
	}



	/*
	 * public int getbId() { return bId; }
	 * 
	 * 
	 * 
	 * public void setbId(int bId) { this.bId = bId; }
	 */



	public String getWriter() {
		return writer;
	}



	public void setWriter(String writer) {
		this.writer = writer;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
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



	@Override
	public String toString() {
		return "ReplyDtos [rId=" + rId + ", writer=" + writer + ", content=" + content + ", rGroup=" + rGroup
				+ ", rStep=" + rStep + ", rIndent=" + rIndent + "]";
	}
}
