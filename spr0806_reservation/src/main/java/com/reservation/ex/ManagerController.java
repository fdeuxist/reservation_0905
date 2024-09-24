package com.reservation.ex;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.AuthoritiesDto;
import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.UserDto;
import com.reservation.service.IAuthoritiesService;
import com.reservation.service.IBusinessPlaceInfoService;
import com.reservation.service.IUserReservationService;
import com.reservation.service.IUserService;

@Controller
public class ManagerController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private IAuthoritiesService aService;

	@Autowired
	private IUserService uService;

	@Autowired
	private IBusinessPlaceInfoService bPIService;

	// 대시보드 기능 추가 만든이:오규원 추가일자:0906
	@Autowired
	private IUserReservationService userRService;

	//@RequestMapping(value = "/manager/manager", method = RequestMethod.GET)
	@RequestMapping(value = "/manager/mypage", method = RequestMethod.GET)
	public String manager(HttpSession session, Model model) throws Exception {
		System.out.println("ManagerController - /manager/manager");

		String email = (String) session.getAttribute("loginEmail");
		if (session.getAttribute("loginName") == null) {
			session.setAttribute("loginName", uService.selectEmail(email).getName());
		}

		//return "/manager/manager";
		return "/manager/mypage";
	}

	@RequestMapping(value = "/manager/manageUsers", method = RequestMethod.GET)
	public String manageUsers(HttpSession session, Model model) throws Exception {
		System.out.println("ManagerController - /manager/manageUsers");

		String email = (String) session.getAttribute("loginEmail");
		if (session.getAttribute("loginName") == null) {
			session.setAttribute("loginName", uService.selectEmail(email).getName());
		}
		ArrayList<AuthoritiesDto> roleDtos = aService.selectAll();
		ArrayList<UserDto> dtos = uService.selectAll();
		model.addAttribute("userList", dtos);
		model.addAttribute("role", roleDtos);
		return "/manager/manageUsers";
	}

	@RequestMapping(value = "/manager/selectUser", method = RequestMethod.GET)
	public String selectUser(HttpSession session, @RequestParam("userEmail") String userEmail, Model model)
			throws Exception {
		System.out.println("ManagerController - /manager/selectUser");

		String email = (String) session.getAttribute("loginEmail");
		if (session.getAttribute("loginName") == null) {
			session.setAttribute("loginName", uService.selectEmail(email).getName());
		}
		System.out.println("선택한 유저의 이메일" + userEmail);
		UserDto dto = uService.selectEmail(userEmail);
		AuthoritiesDto authDto = aService.selectEmail(userEmail);
		model.addAttribute("role", authDto);
		model.addAttribute("user", dto);

		return "/manager/selectUser";
	}

	

	@RequestMapping(value = "/manager/delete", method = RequestMethod.POST)
	public String delete(HttpSession session, Model model, @RequestParam("email") String uEmail,
			RedirectAttributes rttr) throws Exception {
		System.out.println("ManagerController - /manager/manageUsers");

		String email = (String) session.getAttribute("loginEmail");
		if (session.getAttribute("loginName") == null) {
			session.setAttribute("loginName", uService.selectEmail(email).getName());
		}
		uService.delete(uEmail);
		rttr.addFlashAttribute("msg", uEmail + "회원의 정보를 삭제완료했습니다.");
		return "redirect:/manager/manageUsers";
	}

	@RequestMapping(value = "/manager/edit", method = RequestMethod.GET)
	public String edit(HttpSession session, UserDto dto, Model model) throws Exception {
		System.out.println("ManagerController - /manager/selectUser");

		String email = (String) session.getAttribute("loginEmail");
		if (session.getAttribute("loginName") == null) {
			session.setAttribute("loginName", uService.selectEmail(email).getName());
		}
		UserDto updateDto = new UserDto();
		updateDto.setEmail(dto.getEmail());
		updateDto.setName(dto.getName());
		updateDto.setPhone(dto.getPhone());

		uService.mUpdate(updateDto);
		System.out.println(dto.getName());
		return "redirect:/manager/manageUsers";
	}
	
	@GetMapping("/getContent")
	@ResponseBody
	public void selectContent(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("ManagerController - /manager/selectContent");

		String email = (String) session.getAttribute("loginEmail");
		if (session.getAttribute("loginName") == null) {
			session.setAttribute("loginName", uService.selectEmail(email).getName());
		}
		String action = request.getParameter("action");
		String userEmail = request.getParameter("userEmail");
		System.out.println(userEmail);
		UserDto userDto = uService.selectEmail(userEmail);
		String content = "";
		switch (action) {
		case "editProfile":
			content = "<div id='editProfileContent'>" + "<h3>유저 정보 수정</h3>"
					+ "<form id='editProfileForm' action='/ex/manager/edit'>" + "<div class='form-group'>"
					+ "<label for='name'>사용자 이름:</label>" + "<input type='text' id='name' name='name' value='"
					+ userDto.getName() + "' required>" + "</div>" + "<div class='form-group'>"
					+ "<label for='email'>이메일:</label>" + "<input type='text' id='email' name='email' value='"
					+ userDto.getEmail() + "' readonly>" + "</div>" + "<div class='form-group'>"
					+ "<label for='phone'>전화번호:</label>" + "<input type='text' id='phone' name='phone' value='"
					+ userDto.getPhone() + "' required>" + "</div>" + "<button type='submit'>정보 수정</button>" + "</form>"
					+ "</div>";

			break;

		case "deleteUser":
			content = "<div id='deleteUserContent'>" + "<h3>유저 탈퇴</h3>"
					+ "<p>이 작업을 수행하면 유저의 모든 데이터가 삭제됩니다. 계속 진행하시겠습니까?</p>"
					+ "<form id='deleteUserForm' action='/ex/manager/delete' method='post'>"
					+ "<input type='hidden' name='email' value='" + userDto.getEmail() + "'>"
					+ "<button type='submit'>유저 탈퇴</button>" + "</form>"
					+ "<button id='cancelDelete' onclick='document.getElementById(\"deleteUserContent\").style.display=\"none\";'>취소</button>"
					+ "</div>";
			break;

		case "userPosts":
			// 유저의 글 목록을 가져오는 방법을 추가로 구현해야 합니다.
			// 아래는 예시 데이터입니다.
			content = "<div id='userPostsContent'>" + "<h3>유저가 쓴 글 목록</h3>"
					+ "<table><thead><tr><th>제목</th><th>작성일</th><th>상태</th></tr></thead>"
					+ "<tbody><tr><td>첫 번째 글 제목</td><td>2024-09-01</td><td>게시됨</td></tr>"
					+ "<tr><td>두 번째 글 제목</td><td>2024-08-15</td><td>게시됨</td></tr></tbody></table></div>";
			break;

		case "userInquiries":
			// 유저의 문의 사항을 가져오는 방법을 추가로 구현해야 합니다.
			// 아래는 예시 데이터입니다.
			content = "<div id='userInquiriesContent'>" + "<h3>문의 사항</h3>"
					+ "<table><thead><tr><th>제목</th><th>내용</th><th>상태</th><th>날짜</th></tr></thead>"
					+ "<tbody><tr><td>첫 번째 문의 제목</td><td>문의 내용 요약...</td><td>처리 완료</td><td>2024-09-01</td></tr>"
					+ "<tr><td>두 번째 문의 제목</td><td>문의 내용 요약...</td><td>대기 중</td><td>2024-08-20</td></tr></tbody></table></div>";
			break;

		default:
			content = "<p>잘못된 요청입니다.</p>";
			break;
		}

		// 응답을 작성합니다.
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(content);
	}

	// 대시보드 기능 추가 만든이:오규원 추가일자:0906
	@RequestMapping(value = "/manager/dashBoard", method = RequestMethod.GET)
	public String dashboard(Model model) throws Exception {
		List<Map<String, Object>> dtos = userRService.sumServicePrice();
		model.addAttribute("dtos", dtos);
		List<Map<String, Object>> times = userRService.countTimeshhmm();
		model.addAttribute("times", times);
		List<Map<String, Object>> serviceNames = userRService.countServiceName();
		model.addAttribute("serviceNames", serviceNames);

		System.out.println("dashBoard...." + dtos);
		System.out.println("dashBoard...." + times);
		System.out.println("dashBoard...." + serviceNames);
		return "/manager/dashBoard";
	}

}
