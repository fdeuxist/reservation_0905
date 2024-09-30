package com.reservation.ex;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.BoardDto;
import com.reservation.dto.ReplyDtos;
import com.reservation.service.IBoardService;
import com.reservation.service.ReplyServices;
import com.reservation.vo.PageMaker;

@RestController
@RequestMapping("/replies")
public class ReplyControllers {
	private static final Logger logger = LoggerFactory.getLogger(ReplyControllers.class);

	/*
	 * @Autowired private BoardService boardService;
	 */

	@Autowired
	private ReplyServices replyService;

	//등록
	@RequestMapping(value = "new", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyDtos dto) {
		ResponseEntity<String> entity=null;
		try {
			System.out.println("ReplyDtos:"+dto);
			replyService.boardReplyWrite(dto);
			entity=new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//대댓글
	@RequestMapping(value = "/{rId}/replies", method = RequestMethod.POST)
	public ResponseEntity<String> reRegister(@PathVariable("rId") int rId, @RequestBody ReplyDtos dto) {
		ResponseEntity<String> entity=null;
		try {
			logger.info("Entering reRegister method with rId=" + rId + " and ReplyDtos=" + dto);
			ReplyDtos parent=replyService.readParent(rId);
			int parentRGroup=parent.getrGroup();
			int parentRStep=parent.getrStep();
			int parentRIndent=parent.getrIndent();
			System.out.println("parentRGroup" + parentRGroup + ", parentRStep" + parentRStep + "parentRIndent" + parentRIndent);
			replyService.boardReplyStep(parentRGroup, parentRStep);
			
			System.out.println(dto);
			
			dto.setrGroup(rId);
			dto.setrIndent(parentRIndent+1);
			dto.setrStep(parentRStep+1);
			
			System.out.println(dto);
			
			replyService.reReplyWrite(dto);
			logger.info("re-reply");
			System.out.println("ReplyDtos" + dto);
			entity=new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			logger.info("Error during reRegister", e);
			e.printStackTrace();
			entity=new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//댓글리스트
	@RequestMapping(value="/page/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> list(@PathVariable("page") int page) {
		ResponseEntity<Map<String, Object>> entity=null;
		try {
			PageMaker pm=new PageMaker();
			pm.setPage(page);
			
			Map<String, Object> map= new HashMap<String, Object>();
			List<ReplyDtos> list=replyService.replyList(pm);
			
			map.put("list", list);
			
			int replyCount=replyService.replyCount();
			pm.setTotalCount(replyCount);
			map.put("pageMaker", pm);
			
			logger.info("replyPage");
			System.out.println("--list pm " + pm);
			
			entity=new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//댓글삭제
	@RequestMapping(value="/{rId}/delete", method=RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("rId") int rId) {
		ResponseEntity<String> entity=null;
		try {
			logger.info("delete reply");
			System.out.println("--rId" + rId);
			replyService.boardReplyDelete(rId);
			entity=new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//댓글수저
	@RequestMapping(value="/{rId}/update", method= {RequestMethod.PUT, RequestMethod.PATCH}) //수정
	public ResponseEntity<String> update(@PathVariable("rId") int rId, @RequestBody ReplyDtos dto) {
		ResponseEntity<String> entity=null;
		try {
			logger.info("update reply");
			System.out.println("--update rId" + rId + ", ReplyDtos" + dto);
			dto.setrId(rId);
			replyService.boardReplyUpdate(dto);
			
			entity=new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	

	
	
	
	
	

}
