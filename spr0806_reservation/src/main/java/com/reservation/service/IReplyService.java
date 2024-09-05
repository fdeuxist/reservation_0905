package com.reservation.service;

import java.util.List;

import com.reservation.dto.ReplyDto;
import com.reservation.vo.PageMaker;

public interface IReplyService {
	public void boardReplyCreate(ReplyDto dto) throws Exception;
	public void reReplyCreate(ReplyDto dto)throws Exception;
	public void boardReplyStep(int rGroup, int rStep)throws Exception;
	
	public void boardReplyUpdate(ReplyDto dto) throws Exception;
	
	public void boardReplyDelete(int rId)throws Exception;
	
	public List<ReplyDto> replyList(int bId, PageMaker pm) throws Exception;
	public int replyCount (int bId) throws Exception;
	
	public ReplyDto readParent(int rId) throws Exception;
}
