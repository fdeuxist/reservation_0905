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
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
public class VendorController {

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

	private static final Logger logger = LoggerFactory.getLogger(VendorController.class);

	//0913 
    @RequestMapping(value = "/vendor/myorders", method = RequestMethod.GET)
    public String vendorrMyorders(HttpSession session, Model model) throws Exception {
        System.out.println("VendorController - /vendor/myorders");
        String vendor_email = (String)session.getAttribute("loginEmail");
        String business_regi_num = (String)session.getAttribute("loginBusiness_regi_num");
//        String open_date = (String)session.getAttribute("open_date");
        String status="3";
        ArrayList<UserReservationDto> dtoList = uRService.selectAllVendorOrdersNotInStatus(vendor_email, business_regi_num, status);
        model.addAttribute("dtoList", dtoList);
        
        return "/vendor/myorders";
    }
    
    //0913 
    @RequestMapping(value = "/vendor/orderinfo", method = RequestMethod.GET)
    public String orderinfo(String reservationNumber, HttpSession session, Model model) throws Exception {
        logger.info("VendorController - /vendor/orderinfo");
        UserReservationDto myOrder = 
                 uRService.selectOneMyOrder(reservationNumber);
        model.addAttribute("myOrder", myOrder);
        return "/vendor/orderinfo";
    }
    
    
	
	
//0904	 /vendor/dailyschedule대신사용
	@RequestMapping(value = "/vendor/dailyscheduleupdate", method = RequestMethod.GET)
	public String vendorScheduleupdate(
			@RequestParam("date") String date,
	        Model model) {
		////////////
//        model.addAttribute("vendorEmail", email);
//        model.addAttribute("vendorBusiness_regi_num", business_regi_num);
		model.addAttribute("selectedDate", date);
		System.out.println("VendorController - /vendor/dailyscheduleupdate");
		return "/vendor/dailyscheduleupdate";
	}
	
	
	@RequestMapping(value = "/vendor/monthlyschedule", method = RequestMethod.GET)
	public String MonthlySchedule(HttpSession session, Model model) {
		System.out.println("VendorController - /vendor/schedulemodify(get)");

//		String email = (String)session.getAttribute("loginEmail");
//		String business_regi_num = (String)session.getAttribute("loginBusiness_regi_num");
//		String open_date = (String)session.getAttribute("open_date");

		return "/vendor/monthlyschedule";
	}

	@RequestMapping(value = "/vendor/serviceiteminsert", method = RequestMethod.GET)
	public String ServiceItemInsert(HttpSession session, Model model) {
		System.out.println("VendorController - /vendor/serviceiteminsert(get)");
		String email = (String) session.getAttribute("loginEmail");
		String businessRegiNum = (String) session.getAttribute("loginBusiness_regi_num");

		model.addAttribute("serviceItems", new ServiceItemsDto());
		if (email == null || businessRegiNum == null) {
			return "redirect:/login";
		}

		return "/vendor/serviceiteminsert";
	}

	@RequestMapping(value = "/vendor/serviceiteminsert", method = RequestMethod.POST)
	public String ServiceItemInsertDB(ServiceItemsDto dto, 
            HttpSession session, RedirectAttributes rttr) throws Exception {

		System.out.println("VendorController - /vendor/serviceiteminsert(post)");
		String email = (String) session.getAttribute("loginEmail");
		String businessRegiNum = (String) session.getAttribute("loginBusiness_regi_num");

		dto.setEmail(email);
		dto.setBusiness_regi_num(businessRegiNum);
		System.out.println(dto);
		// DTO에 데이터 설정
//        ServiceItemsDto dto = new ServiceItemsDto();
//        dto.setEmail(email);
//        dto.setBusiness_regi_num(businessRegiNum);
//        dto.setService_name(serviceName);
//        dto.setService_description(serviceDescription);
//        dto.setRequired_time(requiredTime);
//        dto.setService_price(servicePrice);
//        dto.setItem_status(itemStatus);

		sIService.insertMyItem(dto);
        rttr.addFlashAttribute("msg","success");
        
		return "redirect:/vendor/serviceiteminsert";
	}

	@RequestMapping(value = "/vendor/shopinfo", method = RequestMethod.GET)
    public String shopinfo(HttpSession session, Model model) throws Exception {
		System.out.println("VendorController - /vendor/shopinfo(get)");
		
		String email = (String) session.getAttribute("loginEmail");
        String business_regi_num = (String) session.getAttribute("loginBusiness_regi_num");
        System.out.println("session email : " + email + "  session regi_num:  " + business_regi_num);
        BusinessPlaceInfoDto dto = bpService.selectOneBusinessPlaceInfo(email, business_regi_num);
        System.out.println("BusinessPlaceInfoDto : " + dto);
        model.addAttribute("businessPlaceInfo", dto);
        return "/vendor/shopinfo";
    }

	@RequestMapping(value = "/vendor/shopinfo", method = RequestMethod.POST)
	public String shopinfoDB(BusinessPlaceInfoDto dto, HttpSession session,
	        @RequestParam("multiFile") List<MultipartFile> multiFileList,
	        @RequestParam("mainImage") MultipartFile mainImage) throws Exception {
	    System.out.println("VendorController - /vendor/shopinfo(post)");

	    // 업로드 디렉토리 경로
	    String uploadDir = servletContext.getRealPath("/resources/imgs");
	    File directory = new File(uploadDir);
	    if (!directory.exists()) {
	        directory.mkdirs(); // Create directory if it does not exist
	    }

	    // Vendor 정보 수정하기
	    String email = (String) session.getAttribute("loginEmail");
	    String business_regi_num = (String) session.getAttribute("loginBusiness_regi_num");
	    dto.setEmail(email);
	    dto.setBusiness_regi_num(business_regi_num);

	    List<Map<String, String>> fileList = new ArrayList<>();

	    // Main image processing
	    String mainOriginImg = mainImage.getOriginalFilename();
	    System.out.println("대표 이미지 파일명: " + mainOriginImg);

	    // 예외 처리: mainOriginImg가 비어있을 경우 업로드를 건너뜀
	    if (mainOriginImg == null || mainOriginImg.isEmpty()) {
	        System.out.println("대표 이미지가 비어 있습니다. 업로드를 건너뜁니다.");
	    } else {
	        String originFileExtension = "";
	        int lastDotIndex = mainOriginImg.lastIndexOf(".");
	        if (lastDotIndex != -1) {
	            originFileExtension = mainOriginImg.substring(lastDotIndex);
	        } else {
	            originFileExtension = ".jpg"; // Default extension if none found
	        }
	        
	        UUID originUUID = UUID.randomUUID();
	        String uniqueOriginName = originUUID.toString().split("-")[0];
	        String newOriginName = uniqueOriginName + originFileExtension;
	        if (mainOriginImg.contains("noimage")) {
	            newOriginName = "noimage";
	        }

	        // Upload main image
	        try {
	            File uploadMain = new File(uploadDir + File.separator + newOriginName);
	            System.out.println("Main image path: " + uploadMain.getAbsolutePath());
	            mainImage.transferTo(uploadMain); // Ensure the main image is also saved
	            String mainImgPath = "/resources/imgs/" + newOriginName;
	            BusinessPlaceImagePathDto mainDto = new BusinessPlaceImagePathDto(email, business_regi_num, mainImgPath, "Y");
	            if (mainDto.getPlace_img_path().contains("noimage")) {
	                System.out.println("기본 이미지임으로 업로드 및 저장 취소 ...");
	            } else {
	                bpiService.insertMyBusinessPlaceImagePath(mainDto);
	                bpiService.updateIsMainYToN(email, business_regi_num);
	                bpiService.setMainImage(mainDto.getEmail(), mainDto.getBusiness_regi_num(), mainDto.getPlace_img_path());
	                System.out.println("메인이미지값은 " + mainDto.getPlace_img_path());
	                System.out.println("이미지 업로드 성공");
	            }
	        } catch (IllegalStateException e) {
	            System.out.println("업로드 실패");
	            e.printStackTrace();
	        } catch (IOException e) {
	            System.out.println("File upload failed due to IO exception");
	            e.printStackTrace();
	        }
	    }

	    // Multi-files processing
	    if (multiFileList.isEmpty()) {
	        System.out.println("멀티 파일 리스트가 비어 있습니다. 업로드를 건너뜁니다.");
	    } else {
	        for (MultipartFile file : multiFileList) {
	            String originFile = file.getOriginalFilename();
	            
	            // originFile이 비어있을 경우 건너뛰기
	            if (originFile == null || originFile.isEmpty()) {
	                System.out.println("원본 파일 이름이 비어 있습니다. 해당 파일을 건너뜁니다.");
	                continue; // 현재 반복을 건너뜁니다.
	            }

	            System.out.println("신창섭의 절실함은 " + originFile);
	            String fileExtension = "";
	            int lastDotIndexFile = originFile.lastIndexOf(".");
	            if (lastDotIndexFile != -1) {
	                fileExtension = originFile.substring(lastDotIndexFile);
	            } else {
	                fileExtension = ".jpg"; // Default extension if none found
	            }

	            UUID uuid = UUID.randomUUID();
	            String uniqueName = uuid.toString().split("-")[0];
	            String newFileName = uniqueName + fileExtension;
	            Map<String, String> map = new HashMap<>();
	            map.put("originFile", originFile);
	            map.put("newFileName", newFileName);
	            fileList.add(map);
	        }

	        // Upload multi-files
	        try {
	            for (int i = 0; i < multiFileList.size(); i++) {
	                // originFile이 비어있는 경우를 다시 체크
	                if (fileList.get(i).get("originFile") == null || fileList.get(i).get("originFile").isEmpty()) {
	                    System.out.println("업로드할 파일이 비어있어 건너뜁니다.");
	                    continue;
	                }

	                File uploadFile = new File(uploadDir + File.separator + fileList.get(i).get("newFileName"));
	                System.out.println("Uploading file to: " + uploadFile.getAbsolutePath());
	                multiFileList.get(i).transferTo(uploadFile);
	                String imgPath = "/resources/imgs/" + fileList.get(i).get("newFileName");
	                BusinessPlaceImagePathDto imgDto = new BusinessPlaceImagePathDto(email, business_regi_num, imgPath, "N");
	                bpiService.insertMyBusinessPlaceImagePath(imgDto);
	            }
	        } catch (IllegalStateException e) {
	            System.out.println("업로드 실패");
	            for (int i = 0; i < multiFileList.size(); i++) {
	                new File(uploadDir + File.separator + fileList.get(i).get("newFileName")).delete();
	            }
	            e.printStackTrace();
	        } catch (IOException e) {
	            System.out.println("File upload failed due to IO exception");
	            e.printStackTrace();
	        }
	    }

	    System.out.println(dto);
	    bpService.updateMyBusinessPlaceInfo(dto);
	    return "redirect:/vendor/vendor";
	}

	

	// vendor 로그인을 하면 vendor 시작페이지로 가면서
	// 세션에 이름과 사업자번호를 등록해두게 된다
	@RequestMapping(value = "/vendor/vendor", method = RequestMethod.GET)
	public String vendor(HttpSession session, Model model) throws Exception {
		System.out.println("VendorController - /vendor/vendor");

		String email = (String) session.getAttribute("loginEmail");
		if (session.getAttribute("loginName") == null) {
			session.setAttribute("loginName", uService.selectEmail(email).getName());
			session.setAttribute("loginBusiness_regi_num", vService.selectEmail(email).getBusiness_regi_num());
		}

		return "/vendor/vendor";
	}

	@RequestMapping(value = "/vendor/scheduleinsert", method = RequestMethod.GET)
	public String vendorScheduleinsert(HttpSession session, Model model) throws Exception {
		System.out.println("VendorController - /vendor/scheduleinsert");

		return "/vendor/scheduleinsert";
	}

	// rest처리예정
	@RequestMapping(value = "/vendor/scheduleinsert", method = RequestMethod.POST)
	public String vendorScheduleinsertDB(@RequestParam("date") String date, @RequestParam("timeSlots") String timeSlots,
			HttpSession session, Model model) {
		System.out.println("VendorController - /vendor/scheduleinsert");

		VendorReservationDto dto = new VendorReservationDto((String) session.getAttribute("loginEmail"),
				(String) session.getAttribute("loginBusiness_regi_num"), date, timeSlots, "1" // 0이면 바로예약불가 1이면 바로예약가능
		);

		System.out.println(dto.getOpen_date());
		System.out.println("^ date   v times");
		System.out.println(dto.getTimes());

		try {
			vRService.insert(dto);
		} catch (DuplicateKeyException e) {
			e.printStackTrace();
			System.out.println("유니크 제약조건 위반  데이터 삽입 실패\n constraint vendor_reservation_unique\n"
					+ "        unique (email, business_regi_num, open_date)");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/vendor/scheduleinsert";
	}


	// 이미지 삭제 기능
    // rest처리예정

    // 이미지 리스트 출력
    @RequestMapping(value = "/vendor/imgList", method = RequestMethod.GET)
    public void imgList(HttpSession session, Model model) throws Exception {
        System.out.println("VendorController - /vendor/scheduleinsert");
        String email = (String) session.getAttribute("loginEmail");

        String business_regi_num = (String) session.getAttribute("loginBusiness_regi_num");
        System.out.println(business_regi_num);
        System.out.println(email);
        ArrayList<BusinessPlaceImagePathDto> imgList = bpiService.selectAllMyBusinessPlaceImgPaths(email,
                business_regi_num);
        System.out.println(imgList);
        model.addAttribute("imageList", imgList);

    }

    // 이미지 삭제 0919 김하겸
    @GetMapping("/deleteImage")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteImage(@RequestParam String imagePath) throws Exception {
        // 이미지 삭제 로직 구현
        boolean flag = bpiService.deleteImage(imagePath);// 이미지 삭제 메소드 호출
        Map<String, Object> response = new HashMap<>();
        response.put("success", flag);

        if (!flag) {
            response.put("message", "이미지 삭제에 실패했습니다.");
        }

        return ResponseEntity.ok(response); // JSON 형태로 반환

    }


}
