package com.reservation.ex;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.BusinessPlaceImagePathDto;
import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.ServiceItemsDto;

import com.reservation.dto.UserReservationDto;
import com.reservation.dto.VendorReservationDto;
import com.reservation.service.IBusinessPlaceImagePathService;
import com.reservation.service.IBusinessPlaceInfoService;
import com.reservation.service.IServiceItemsService;
import com.reservation.service.IUserReservationService;
import com.reservation.service.IUserService;
import com.reservation.service.IVendorReservationService;
import com.reservation.service.IVendorService;

@Controller
public class ImgUploadController {

	@Autowired
	private IVendorService vService;

	@Autowired
	private IUserService uService;

	@Autowired
	private IVendorReservationService vRService;

	@Autowired
	private IUserReservationService uRService;

	@Autowired
	private IBusinessPlaceInfoService bpService;

	@Autowired
	private IBusinessPlaceImagePathService bpiService;
	@Autowired
	private IServiceItemsService sIService;

	@Autowired
	private ServletContext servletContext;

	private static final Logger logger = LoggerFactory.getLogger(ImgUploadController.class);

	@PostMapping("/uploadImages")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> uploadImages(HttpSession session,
	        @RequestParam("images") List<MultipartFile> multiFileList) throws Exception {
	    // 이미지 파일을 DB에 저장하는 로직
	    System.out.println("드래그 앤 드롭 컨트롤러 진입....");
	    String email = (String) session.getAttribute("loginEmail");
	    String business_regi_num = (String) session.getAttribute("loginBusiness_regi_num");

	    if (multiFileList.isEmpty()) {
	        System.out.println("멀티 파일 리스트가 비어 있습니다. 업로드를 건너뜁니다.");
	    } else {
	        try {
	            for (MultipartFile file : multiFileList) {
	                String originFile = file.getOriginalFilename();

	                // originFile이 비어있을 경우 건너뛰기
	                if (originFile == null || originFile.isEmpty()) {
	                    System.out.println("원본 파일 이름이 비어 있습니다. 해당 파일을 건너뜁니다.");
	                    continue; // 현재 반복을 건너뜁니다.
	                }

	                System.out.println("신창섭의 절실함은 " + originFile);

	                // 파일 확장자 추출
	                String fileExtension = "";
	                int lastDotIndexFile = originFile.lastIndexOf(".");
	                if (lastDotIndexFile != -1) {
	                    fileExtension = originFile.substring(lastDotIndexFile);
	                } else {
	                    fileExtension = ".jpg"; // 확장자가 없는 경우 기본값
	                }

	                // UUID를 기반으로 파일명 생성
	                UUID uuid = UUID.randomUUID();
	                String uniqueFileName = uuid.toString().split("-")[0] + fileExtension;
	                System.out.println("Generated unique file name: " + uniqueFileName);

	                // 파일을 이진 데이터로 변환
	                byte[] imageData = file.getBytes();

	                // DTO 생성 (UUID 기반 파일명과 이진 데이터 저장)
	                BusinessPlaceImagePathDto imgDto = new BusinessPlaceImagePathDto(email, business_regi_num, uniqueFileName, "N", imageData);

	                // DB에 파일명 및 이진 데이터 저장
	                bpiService.insertMyBusinessPlaceImagePath(imgDto);
	            }
	        } catch (IllegalStateException e) {
	            System.out.println("업로드 실패");
	            e.printStackTrace();
	        } catch (IOException e) {
	            System.out.println("File upload failed due to IO exception");
	            e.printStackTrace();
	        }
	    }

	    Map<String, Object> response = new HashMap<>();
	    response.put("success", true);
	    return ResponseEntity.ok(response);
	}

	@PostMapping("/setMainImage")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> setMainImage(@RequestParam String imagePath, HttpSession session)
			throws Exception {
		// 메인 이미지로 설정하는 비즈니스 로직
		// 데이터베이스에서 기존 메인 이미지를 해제하고, 새 메인 이미지를 설정
		 boolean success = false;
		String email = (String) session.getAttribute("loginEmail");
		String business_regi_num = (String) session.getAttribute("loginBusiness_regi_num");
        BusinessPlaceImagePathDto dto = bpiService.selectImage(imagePath);
        byte[] imgData = dto.getFile_data();
		BusinessPlaceImagePathDto mainDto = new BusinessPlaceImagePathDto(email, business_regi_num, imagePath, "Y",imgData);
		if (mainDto.getPlace_img_path().contains("noimage")) {
            System.out.println("기본 이미지임으로 업로드 및 저장 취소 ...");
             success = false;
        } else {
        	bpiService.updateIsMainYToN(email, business_regi_num);
            success = bpiService.setMainImage(mainDto.getEmail(), mainDto.getBusiness_regi_num(), mainDto.getPlace_img_path());
            System.out.println("메인이미지값은 " + mainDto.getPlace_img_path());
        }
		
		Map<String, Object> response = new HashMap<>();
		response.put("success", success);
		return ResponseEntity.ok(response);
	}

}

