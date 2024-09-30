package com.reservation.service;

import java.util.List;

//import com.human.dto.BoardDto;
import com.reservation.dto.ReplyDtos;
import com.reservation.vo.PageMaker;

//import org.zerock.domain.Criteria;
//import org.zerock.domain.SearchCriteria;

public interface ReplyServices {


	
	public void boardReplyWrite(ReplyDtos dto) throws Exception;
	public void reReplyWrite(ReplyDtos dto) throws Exception;
	
	public void boardReplyUpdate(ReplyDtos dto) throws Exception;
	
	public void boardReplyDelete(int rId) throws Exception;
	
	public List<ReplyDtos> replyList(PageMaker pm) throws Exception;
	public int replyCount() throws Exception;
	
	public ReplyDtos readParent(int rId) throws Exception;
	public void boardReplyStep(int rGroup, int rStep) throws Exception;



}
