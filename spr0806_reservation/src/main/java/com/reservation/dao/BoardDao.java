package com.reservation.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.reservation.vo.BoardVo;
import com.reservation.dto.BoardDto;

public interface BoardDao {
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
//	답글 게시판
	public void reply(BoardDto dto) throws Exception;
	public void replyUpdate(BoardDto dto) throws Exception;
//	게시물 페이지 나누기
	public List<BoardDto> listSearch(BoardVo vo)throws Exception;
	public int listSearchCount(BoardVo vo) throws Exception;
	public List<BoardDto> selectPerson(String bName) throws Exception;
	
	public void updateName(@Param("oldName") String oldName, @Param("newName") String newName) throws Exception;
}
