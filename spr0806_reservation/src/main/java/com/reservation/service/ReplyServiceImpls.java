package com.reservation.service;

import java.util.List;

import javax.inject.Inject;
import org.mybatis.spring.SqlSessionTemplate;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//import com.human.dto.BoardDto;
import com.reservation.dto.ReplyDtos;
import com.reservation.vo.PageMaker;
import com.reservation.dao.ReplyDAOs;

@Service
public class ReplyServiceImpls implements ReplyServices {
	@Autowired
    private SqlSession sqlSession;

    private ReplyDAOs getReplyDAO() {
        return sqlSession.getMapper(ReplyDAOs.class);
    }
    
	//댓글 작성
	@Override
	public void boardReplyWrite(ReplyDtos reply) throws Exception {
		getReplyDAO().boardReplyWrite(reply);
	}
	
	//대댓글 작성
		@Override
		public void reReplyWrite(ReplyDtos reply) throws Exception {
			getReplyDAO().reReplyWrite(reply);
		}
		
	@Override
	public void boardReplyUpdate(ReplyDtos reply) throws Exception{
			getReplyDAO().boardReplyUpdate(reply);
	}	
		
	//댓글 삭제
	@Override
	public void boardReplyDelete(int rId) throws Exception {
		getReplyDAO().boardReplyDelete(rId);
	}	
	
	//댓글리스트
	@Override
	public List<ReplyDtos> replyList(PageMaker pm) throws Exception {
		return getReplyDAO().replyList(pm);
	}
	
	//댓글카운트
	@Override
	public int replyCount() throws Exception {
		return getReplyDAO().replyCount();
	}
	
	@Override
	public ReplyDtos readParent(int rId) throws Exception {
		return getReplyDAO().readParent(rId);
	}

	@Override
	public void boardReplyStep(int rGroup, int rStep) throws Exception {
		getReplyDAO().boardReplyStep(rGroup, rStep);
	}
		
//	//댓글 조회
//	@Override
//	public List<ReplyDto> listAll(int bId) throws Exception {
//		return getReplyDAO().replyList(bId);
//	}
//	
//	
//
//	//댓글 수정
//	@Override
//	public void replymodify(ReplyDto vo) throws Exception {
//		getReplyDAO().replymodify(vo);
//	}
//
//	
//
//	
//
//	@Override
//	public void replyReply(ReplyDto vo) throws Exception {
//		getReplyDAO().replyReply(vo);
//		
//	}
//
//	@Override
//	public void replyregist(ReplyDto vo) throws Exception {
//		getReplyDAO().replywrite(vo);
//		
//	}
//
//	
//
//	@Override
//	public List<ReplyDto> replyList(ReplyDto vo) throws Exception {
//		return getReplyDAO().replyList(vo);
//	}

}
