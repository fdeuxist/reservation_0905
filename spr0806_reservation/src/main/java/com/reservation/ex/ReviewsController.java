package com.reservation.ex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.reservation.dto.ReviewsDto;
import com.reservation.service.IReviewsService;

/*
 @RestController를 사용하면 @ResponseBody가 기본적으로 적용되므로, 
 컨트롤러 클래스에서 @RestController를 선언하면 
 해당 클래스의 메서드에 별도로 @ResponseBody를 붙일 필요가 없습니다.
그러나 @Controller를 사용하고 메서드 단위에서 JSON 응답을 반환하고자 한다면, 
그 메서드에 @ResponseBody를 붙여야 합니다.
 */

@Controller
public class ReviewsController {

	@Autowired
	private IReviewsService iRServies;

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	

	@RequestMapping(value = "/reviews/test", method = RequestMethod.GET)
	@ResponseBody
    public ResponseEntity<String> test() throws Exception {
		logger.info("ReviewsController - /reviews/test   ");
		ResponseEntity<String> entity=null;
		
		entity = new ResponseEntity<String>("TEST", HttpStatus.OK);
		
		return entity;
    }
	
	@RequestMapping(value = "/reviews/selectFiveLatestReviews", method = RequestMethod.GET)
	@ResponseBody
    public ResponseEntity<Map<String, Object>> selectFiveLatestReviews(
			@RequestParam("vendor_email") String vendor_email, 
			@RequestParam("business_regi_num") String business_regi_num) throws Exception{
		
		logger.info("ReviewsController - /reviews/selectFiveLatestReviews   vendor_email : {} , business_regi_num : {} " + vendor_email + business_regi_num);
		Map<String, Object> response = new HashMap<>();
		ArrayList<ReviewsDto> dto = null;
		dto = iRServies.selectFiveLatestReviews(vendor_email, business_regi_num);
		response.put("dto", dto);
        logger.info("ReviewsController - /reviews/selectFiveLatestReviews    dto : {} " , dto);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
	
	@RequestMapping(value = "/reviews/selectOne", method = RequestMethod.GET)
	@ResponseBody
    public ResponseEntity<Map<String, Object>>  selectOne(@RequestParam String reservation_number) throws Exception {
		logger.info("ReviewsController - /reviews/selectOne   ");
		Map<String, Object> response = new HashMap<>();
		ReviewsDto dto = null;
		dto = iRServies.selectOne(reservation_number);
		response.put("dto", dto);

        logger.info("ReviewsController - /reviews/selectOne    dto : {} " , dto);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
	
	@RequestMapping(value = "/reviews/insert", method = RequestMethod.POST)
	@ResponseBody
    public ResponseEntity<String> insert(@RequestBody ReviewsDto dto) throws Exception {
		logger.info("ReviewsController - /reviews/insert   dto : {} " , dto);
		ResponseEntity<String> entity=null;
		try {
			iRServies.insert(dto);
			entity=new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
    }
	
	@RequestMapping(value = "/reviews/update", method = RequestMethod.POST)
	@ResponseBody
    public ResponseEntity<String> update(@RequestBody ReviewsDto dto) throws Exception {
		logger.info("ReviewsController - /reviews/update   dto : {} " , dto);
		ResponseEntity<String> entity=null;
		try {
			iRServies.update(dto);
			entity=new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
    }
	
	//멤버시점) 주문번호 받아서 리턴이 null이면 댓글 작성 , dto면 수정창 보여주기
	@RequestMapping(value = "/reviews/isReviewExist", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> isReviewExist(String reservation_number) throws Exception{
		logger.info("ReviewsController - /reviews/isReviewExist    reservation_number : {} " , reservation_number);
        Map<String, Object> response = new HashMap<>();
        ReviewsDto dto = null;
        dto = iRServies.isReviewExist(reservation_number);
        response.put("dto", dto);
        /*
        if(dto != null) {
        	response.put("dto", dto);
        }else {
        	response.put("dto", null);
        }*/
        logger.info("ReviewsController - /reviews/isReviewExist    dto : {} " , dto);
        return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/reviews/vendorMustCommentList", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> vendorMustCommentList(
			@RequestParam("vendor_email") String vendor_email, 
			@RequestParam("business_regi_num") String business_regi_num) throws Exception{
		logger.info("ReviewsController - /reviews/vendorMustCommentList    " + 
			"vendor_email : {} , business_regi_num : {} " , vendor_email , business_regi_num);
        Map<String, Object> response = new HashMap<>();
        ArrayList<ReviewsDto> dtos = iRServies.vendorMustCommentList(vendor_email, business_regi_num);
        response.put("dtos", dtos);
        logger.info("ReviewsController - /reviews/vendorMustCommentList    dtos : {}" , dtos);
        return new ResponseEntity<>(response, HttpStatus.OK);
	}
	

	@RequestMapping(value = "/reviews/vendorUpdateComment", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> vendorUpdateComment(@RequestBody Map<String, Object> requestBody) throws Exception {
	    String vendor_content = (String) requestBody.get("vendor_content");
	    String reservation_number = (String) requestBody.get("reservation_number");
		logger.info("ReviewsController - /reviews/vendorUpdateComment    " + 
			"vendor_content : {} , reservation_number : {} " , vendor_content , reservation_number);
        Map<String, Object> response = new HashMap<>();
        iRServies.vendorUpdateComment(vendor_content, reservation_number);
        ReviewsDto dto = iRServies.selectOne(reservation_number);
        response.put("dto", dto);
        logger.info("ReviewsController - /reviews/vendorUpdateComment    dto : {}" , dto);
        return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	
	
	
	
	
	
}
