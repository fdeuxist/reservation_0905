package com.reservation.ex;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.reservation.dto.ReplyDto;
import com.reservation.vo.PageMaker;
import com.reservation.service.IReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	@Autowired
	private IReplyService rs;
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@RequestMapping(value = "/{bId}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> list(@PathVariable("bId") int bId, @PathVariable("page") int page) {
		ResponseEntity<Map<String, Object>> entity = null;
		try {
			PageMaker pm = new PageMaker();
			pm.setPage(page);

			Map<String, Object> map = new HashMap<String, Object>();
			List<ReplyDto> list = rs.replyList(bId, pm);

			map.put("list", list);

			int replyCount = rs.replyCount(bId);
			pm.setTotalCount(replyCount);
			map.put("pageMaker", pm);

			logger.info("pageMaker", pm);
			System.out.println("--list pm" + pm);

			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyDto dto) {
		ResponseEntity<String> entity = null;
		try {
			rs.boardReplyCreate(dto);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/{rId}", method = RequestMethod.POST)
	public ResponseEntity<String> reRegister(@PathVariable("rId") int rId, @RequestBody ReplyDto dto) {
		ResponseEntity<String> entity = null;
		try {
			ReplyDto parent = rs.readParent(rId);
			int parentRGroup = parent.getrGroup();
			int parentRStep = parent.getrStep();
			int parentRIndent = parent.getrIndent();
			System.out.println(
					"parentRGroup" + parentRGroup + ", parentRStep" + parentRStep + ", ParentRIndent" + parentRIndent);
			rs.boardReplyStep(parentRGroup, parentRStep);

			dto.setrIndent(parentRIndent + 1);
			dto.setrStep(parentRStep + 1);

			rs.reReplyCreate(dto);
			logger.info("re-reply");
			System.out.println("ReplyDto" + dto);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/{rId}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("rId") int rId) {
		ResponseEntity<String> entity = null;
		try {
			logger.info("delete reply");
			System.out.println("--rId" + rId);
			rs.boardReplyDelete(rId);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/{rId}", method = RequestMethod.PATCH)
	public ResponseEntity<String> update(@PathVariable("rId") int rId, @RequestBody ReplyDto dto) {
		ResponseEntity<String> entity = null;
		try {
			logger.info("update reply");
			System.out.println("--update" + rId + ", ReplyDto" + dto);
			dto.setrId(rId);
			rs.boardReplyUpdate(dto);

			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
