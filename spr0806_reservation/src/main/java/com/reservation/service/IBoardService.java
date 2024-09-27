package com.reservation.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.reservation.vo.BoardVo;
import com.reservation.dto.BoardDto;

public interface IBoardService {
	public List<BoardDto> listAll() throws Exception;
	public List<String> listMenu() throws Exception;
	public void create(BoardDto dto) throws Exception;
	public BoardDto read(Integer bId) throws Exception;
	public void update(BoardDto dto) throws Exception;	
	public void delete(Integer bId) throws Exception;
	public void bHitUpdate(int bId) throws Exception;
	public void bLike(int bId) throws Exception;
	public void bDislike(int bId) throws Exception;
	public List<BoardDto> listMenu(@Param("bGroupKind")String bGroupKind);
	public List<String> menuKind();
	
	public void updateReply(BoardDto dto) throws Exception;
	public void reply(BoardDto dto) throws Exception;

	public List<BoardDto> listSearchCriteria(BoardVo vo) throws Exception;
	public void replyUpdate(BoardDto dto)throws Exception;
	public int listSearchCount(BoardVo vo)throws Exception;
	
	
	public List<BoardDto> selectPerson(String bName) throws Exception;

}
