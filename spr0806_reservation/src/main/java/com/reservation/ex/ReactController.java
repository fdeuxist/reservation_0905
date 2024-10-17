package com.reservation.ex;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.executor.ReuseExecutor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.BusinessPlaceImagePathDto;
import com.reservation.dto.PlaceDetailDto;
import com.reservation.dto.SearchPlaceDto;
import com.reservation.dto.VendorAndImageListDto;
import com.reservation.dto.VendorDto;
import com.reservation.service.IBusinessPlaceImagePathService;
import com.reservation.service.IMapService;
import com.reservation.service.ISearchPlaceService;

// 만든이 김하겸
// React 연동 컨트롤러
@RestController
public class ReactController {

	@CrossOrigin(origins = "http://localhost:3000")
	@RequestMapping("/test")
	public String Test() {
		System.out.println("서버 접속 완료");
		return "connected...";
	}
	@CrossOrigin(origins = "http://localhost:3000")
	@GetMapping("/api/getPort")
	public int getServerPort(HttpServletRequest request) {
		int serverPort = request.getServerPort();
		System.out.println("서버단에서 포트번호는 "+ serverPort);
		return serverPort;
	}
	@CrossOrigin(origins = "http://localhost:3000")
	@RequestMapping("/clickSearch")
	public String search(@RequestParam("query") String query,RedirectAttributes rttr) {
        // 검색 로직을 통해 검색 결과를 얻음
		System.out.println("쿼리"+query);

        // 모델에 검색어와 결과를 추가
		rttr.addFlashAttribute("query",query);
        
        
        return "redirect:/my/search?query="+query;
	}
}
