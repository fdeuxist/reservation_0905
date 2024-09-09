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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.reservation.dto.BusinessPlaceImagePathDto;
import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.ServiceItemsDto;
import com.reservation.dto.VendorReservationDto;
import com.reservation.service.IBusinessPlaceImagePathService;
import com.reservation.service.IBusinessPlaceInfoService;
import com.reservation.service.IServiceItemsService;
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
	private IBusinessPlaceInfoService bpService;
	
	@Autowired
	private IBusinessPlaceImagePathService bpiService;
	@Autowired
	private IServiceItemsService sIService;

	@Autowired
	private ServletContext servletContext;

	private static final Logger logger = LoggerFactory.getLogger(VendorController.class);

	@RequestMapping(value = "/vendor/dailyschedule", method = RequestMethod.GET)
	public String DailySchedule(@RequestParam("date") String date, HttpSession session, Model model) {
		System.out.println("VendorController - /vendor/dailyschedule(get) selectedDate:" + date);

//		String email = (String)session.getAttribute("loginEmail");
//		String business_regi_num = (String)session.getAttribute("loginBusiness_regi_num");
//		String open_date = (String)session.getAttribute("open_date");
		model.addAttribute("selectedDate", date);
		// System.out.println(date);
		return "/vendor/dailyschedule";
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
	public String ServiceItemInsertDB(ServiceItemsDto dto, HttpSession session) throws Exception {

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

		return "redirect:/vendor/serviceiteminsert";
	}

	@RequestMapping(value = "/vendor/shopinfo", method = RequestMethod.GET)
	public String shopinfo(HttpSession session, Model model) throws Exception {
		System.out.println("VendorController - /vendor/shopinfo(post)");
		String email = (String) session.getAttribute("loginEmail");
		String business_regi_num = (String) session.getAttribute("loginBusiness_regi_num");
		System.out.println(email + "  ddddddddd   " + business_regi_num);
		BusinessPlaceInfoDto dto = bpService.selectOneBusinessPlaceInfo(email, business_regi_num);
		System.out.println("aaaaaa   " + dto);
		model.addAttribute("businessPlaceInfo", dto);
		return "/vendor/shopinfo";
	}

	@RequestMapping(value = "/vendor/shopinfo", method = RequestMethod.POST)
	public String shopinfoDB(BusinessPlaceInfoDto dto, HttpSession session,
	        @RequestParam("multiFile") List<MultipartFile> multiFileList,
	        @RequestParam("mainImage") MultipartFile mainImage) throws Exception {
	    System.out.println("VendorController - /vendor/shopinfo(post)");
	    String email = (String) session.getAttribute("loginEmail");
	    String business_regi_num = (String) session.getAttribute("loginBusiness_regi_num");
	    dto.setEmail(email);
	    dto.setBusiness_regi_num(business_regi_num);
	    List<Map<String, String>> fileList = new ArrayList<>();
	    String uploadDir = servletContext.getRealPath("/resources/imgs");
	    System.out.println(uploadDir);
	    
	    // Ensure directory exists
	    File directory = new File(uploadDir);
	    if (!directory.exists()) {
	        directory.mkdirs(); // Create directory if it does not exist
	    }

	    String mainOriginImg = mainImage.getOriginalFilename();
	    String originFileExtension = mainOriginImg.substring(mainOriginImg.lastIndexOf("."));
	    UUID originUUID = UUID.randomUUID();
	    String uniqueOriginName = originUUID.toString().split("-")[0];
	    String newOriginName = uniqueOriginName + originFileExtension;

	    for (int i = 0; i < multiFileList.size(); i++) {
	        String originFile = multiFileList.get(i).getOriginalFilename();
	        String fileExtension = originFile.substring(originFile.lastIndexOf("."));
	        UUID uuid = UUID.randomUUID();
	        String uniqueName = uuid.toString().split("-")[0];
	        String newFileName = uniqueName + fileExtension;
	        Map<String, String> map = new HashMap<>();
	        map.put("originFile", originFile);
	        map.put("newFileName", newFileName);
	        fileList.add(map);
	    }

	    try {
	        for (int i = 0; i < multiFileList.size(); i++) {
	            File uploadFile = new File(uploadDir + File.separator + fileList.get(i).get("newFileName"));
	            System.out.println("Uploading file to: " + uploadFile.getAbsolutePath());
	            multiFileList.get(i).transferTo(uploadFile);
	            String imgPath = "/resources/imgs/" + fileList.get(i).get("newFileName");
	            BusinessPlaceImagePathDto imgDto = new BusinessPlaceImagePathDto(email, business_regi_num, imgPath, "N");
	            bpiService.insertMyBusinessPlaceImagePath(imgDto);
	        }

	        File uploadMain = new File(uploadDir + File.separator + newOriginName);
	        System.out.println("Main image path: " + uploadMain.getAbsolutePath());
	        mainImage.transferTo(uploadMain); // Ensure the main image is also saved
	        String mainImgPath = "/resources/imgs/" + newOriginName;
	        BusinessPlaceImagePathDto mainDto = new BusinessPlaceImagePathDto(email, business_regi_num, mainImgPath, "Y");
	        bpiService.insertMyBusinessPlaceImagePath(mainDto);
	        System.out.println("Setting main image with email: " + mainDto.getEmail() +
	                           ", business_regi_num: " + mainDto.getBusiness_regi_num() +
	                           ", place_img_path: " + mainDto.getPlace_img_path());
	        bpiService.setMainImage(mainDto.getEmail(), mainDto.getBusiness_regi_num(), mainDto.getPlace_img_path());

	        System.out.println("이미지 업로드 성공");
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

	    System.out.println(dto);
	    bpService.updateMyBusinessPlaceInfo(dto);
	    return "redirect:/vendor/shopinfo";
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

}
