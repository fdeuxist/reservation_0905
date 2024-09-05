package com.reservation.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.ReplyDto;
import com.reservation.vo.PageMaker;

public interface ReplyDao {
	public void boardReplyCreate(ReplyDto dto)throws Exception;
	public void reReplyCreate(ReplyDto dto)throws Exception;
	public void boardReplyStep(@Param("rGroup")int rGroup,@Param("rStep")int rStep) throws Exception;
	public void boardReplyUpdate(ReplyDto dto)throws Exception;
	public void boardReplyDelete(int rId) throws Exception;
	public List<ReplyDto> replyList(@Param("bId") int bId,@Param("pm") PageMaker pm) throws Exception;
	public int replyCount(int bId) throws Exception;
	public ReplyDto readParent(int rId)throws Exception;
}
