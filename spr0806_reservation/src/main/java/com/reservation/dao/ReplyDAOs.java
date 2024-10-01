package com.reservation.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.ReplyDtos;
import com.reservation.vo.PageMaker;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReplyDAOs {

	//public List<ReplyDtos> replyList(ReplyDtos vo) throws Exception;
	public List<ReplyDtos> replyList(@Param("pm") PageMaker pm) throws Exception;
	public void boardReplyWrite(ReplyDtos dto) throws Exception;
	public void reReplyWrite(ReplyDtos dto) throws Exception;
	public void boardReplyUpdate(ReplyDtos dto) throws Exception;
	public void boardReplyDelete(int rId) throws Exception;
	//public List<ReplyDtos> replyList(@Param("bId") int bId, @Param("pm") PageMaker pm) throws Exception;
	public int replyCount() throws Exception;
	public ReplyDtos readParent(int rId) throws Exception;
	public void boardReplyStep(@Param("rGroup") int rGroup, @Param("rStep") int rStep) throws Exception;
}
