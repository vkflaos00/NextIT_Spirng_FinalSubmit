package com.legend.conv.member.web;

import java.util.List;

import javax.inject.Inject;
import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.legend.conv.attach.vo.AttachVO;
import com.legend.conv.common.util.ConvFileUpload;
import com.legend.conv.common.vaild.Regist;
import com.legend.conv.exception.BizDuplicateKeyException;
import com.legend.conv.exception.BizMailAuthException;
import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.member.service.MailSendService;
import com.legend.conv.member.service.MemberService;
import com.legend.conv.member.vo.MailAuthVO;
import com.legend.conv.member.vo.MemberVO;

@Controller
public class MemberController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	MemberService memberService;

	@Autowired
	private ConvFileUpload ConvFileUpload;

	// 로그인 화면 응답 메소드
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model) {
		String fromUrl = request.getHeader("Referer");

		model.addAttribute("fromUrl", fromUrl);

		return "login/login";
	}

	// 회원가입 화면 응답 메소드
	@RequestMapping("/regist")
	public String regist(@ModelAttribute("member") MemberVO member) {
		return "login/regist";
	}

	// 회원가입 처리 메소드
	@RequestMapping("/registDo")
	public String registDo(@Validated(value = Regist.class) @ModelAttribute("member") MemberVO member,
			BindingResult error, HttpServletRequest request,
			@RequestParam(required = false) MultipartFile[] profilePhoto) throws Exception {

		if (error.hasErrors()) {
			return "login/regist";
		}
		System.out.println("profile" + profilePhoto);

		boolean fileuploadFlag = true;
		if (profilePhoto != null) {
			try {
				List<AttachVO> attachList = ConvFileUpload.fileUpload(profilePhoto, "PROFILEPHOTO", "profilePhoto");
				System.out.println("파일업로드");
				if (attachList.size() > 0) {
					member.setAttachList(attachList);
				}
			} catch (Exception e) {
				e.printStackTrace();
				fileuploadFlag = false;
			}
		}
		try {
			if(member.getId() !=null && ! member.getId().equals("")) {
				memberService.registerMember(member);
			}else {
				throw new Exception();
			}
		}catch(BizDuplicateKeyException bde) {
			bde.printStackTrace();
			
		}
		System.out.println("MemberController Member.toString() :" + member.toString());

		try {
			memberService.registerMember(member);

		} catch (BizDuplicateKeyException e) {
			System.out.println("e" + e);
		} catch (BizNotEffectedException e) {
			System.out.println("e" + e);
		} catch (BizMailAuthException e) {
			System.out.println("e" + e);
		}

		return "redirect:/";
	}

	// 로그인 처리 메소드
	@RequestMapping("/loginDo")
	public String loginDo(MemberVO member, Model model, HttpSession session, boolean rememberId,
			HttpServletResponse response, String fromUrl, HttpServletRequest request) {
		System.out.println("login.member" + member);
		try {
			boolean loginCheck = memberService.loginCheck(member, request, response);
			if (loginCheck) {
				// 로그인 성공시 메인페이지로 이동하면서 메시지 모델에 담아서 전달
				MemberVO login = memberService.getMember(member);
				session.setAttribute("login", login);
				
				Cookie cookies = new Cookie("id", login.getId());
				cookies.setMaxAge(1);
				response.addCookie(cookies);
				
				if (rememberId == true) {

					Cookie cookie = new Cookie("rememberId", login.getId());

					response.addCookie(cookie);

				} else {
					Cookie cookie = new Cookie("rememberId", "확인");
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
				return "redirect:/" ;
			} else {

				model.addAttribute("errMsg", "오타여 뭐여 누구여");

				return "login/login";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/login/error";
		}
	}

	// 로그아웃 처리 메소드
	@RequestMapping("/logoutDo")
	public String logoutDo(HttpSession session, HttpServletRequest request) {
		session.invalidate();

		return "redirect:/";
	}

	// 마이 페이지 화면 응답 메소드
	@RequestMapping("/myPage")
	public String myPage(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("login");

		try {
			member = memberService.getMember(member.getId());
			member.setPw("");
			model.addAttribute("member", member);
		} catch (Exception e) {
			model.addAttribute("e", e);
			e.printStackTrace();
		}
		System.out.println("member" + member.getId());
		return "login/myPage";
	}

	// 아이디 중복 체크 확인 메소드

	@RequestMapping("/login/idCheck")
	@ResponseBody
	public boolean IdCheck(@RequestParam("id") String id) {
		logger.info("MemberController IdCheck id:" + id);

		boolean result = memberService.idCheck(id);

		return result;
	}
	// 메일 중복 체크 확인 메소드

	@RequestMapping("/regist/mailCheck")
	@ResponseBody
	public boolean mailCheck(@RequestParam("mail") String mail) {
		logger.info("MemberController MailCheck mail:" + mail);

		boolean result = memberService.mailCheck(mail);

		return result;
	}
	@Inject
	private MailSendService mailSendService;

	// 회원가입 이메일 체크 메소드
	@RequestMapping("/regist/mailAuth")
	@ResponseBody
	public boolean mailAuth(@RequestParam(required = false) String mail) {
		logger.info("mail : " + mail);

		// 이메일 주소가 비어있으면 처리
		if (!StringUtils.hasText(mail)) {
			// 예: 클라이언트 측에서 경고 메시지를 띄우거나 다른 처리를 하도록 유도
			return false;
		}

		String authKey = mailSendService.sendAuthMail(mail);

		boolean result = false;

		if (!authKey.equals("false")) {
			memberService.registerMailAuth(mail, authKey);
			result = true;
		}

		return result;
	}

	@RequestMapping("/regist/mailWindow")
	public String mailWindow() {
		return "/login/mailWindow";
	}

	@RequestMapping("/regist/authKeyCompare")
	@ResponseBody
	public boolean authKeyCompare(MailAuthVO mailAuthVO) {
		logger.info("mailAuthVO.toString() : " + mailAuthVO.toString());

		boolean result = memberService.authKeyCompare(mailAuthVO);

		return result;
	}

	// 회원정보 수정 폼을 보여주는 메소드
	@RequestMapping("/edit")
	public String edit(HttpSession session, Model model) {
		MemberVO member = (MemberVO) session.getAttribute("login");
		model.addAttribute("member", member);
		return "/login/edit";
	}

	// 회원수정 처리 메소드
	@RequestMapping("/memberEditDo")
	public String memberEditDo(MemberVO member, HttpSession session) {
		System.out.println(member);

		memberService.editMember(member);

		session.setAttribute("login", member);

		return "redirect:/myPage";
	}

	// 회원삭제 처리 메소드
	@RequestMapping("/memberDelDo")
	public String memberDelDo(HttpSession session) {
		MemberVO login = (MemberVO) session.getAttribute("login");

		memberService.delMember(login);

		session.invalidate();

		return "redirect:/";
	}

	// 비밀번호 재설정 페이지로 이동
	@RequestMapping("/forgotPassword")
	public String forgotPasswordPage() {
		return "login/forgotPassword"; // 비밀번호 재설정 페이지의 이름
	}

	// 비밀번호 재설정 처리
	@RequestMapping("/forgotPasswordDo")
	@ResponseBody
	public String forgotPassword(@RequestParam("tel") String tel, HttpSession session) {
		try {
			// 이미 가입된 전화번호가 없으면 false 반환
			if (!memberService.isRegisteredTel(tel)) {
				return "false";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "false";
		}

		String code = memberService.sendRandomMessage(tel);
		session.setAttribute("rand", code);

		return "true";
	}

	// 비밀번호 재설정 페이지에서 인증 코드와 새로운 비밀번호 입력 후 처리
	@PostMapping("resetPassword")
	@ResponseBody
	public String resetPassword(@RequestParam("tel") String tel, @RequestParam("code") String inputCode,
			@RequestParam("newPassword") String newPassword, HttpSession session) {
		String rand = (String) session.getAttribute("rand");

		if (rand.equals(inputCode)) {
			session.removeAttribute("rand");

			try {
				memberService.resetPassword(tel, newPassword);
				return "success";
			} catch (Exception e) {
				e.printStackTrace();
				return "error";
			}
		}

		return "incorrect_code";
	}
	@RequestMapping("/home")
	public String home(HttpSession session, HttpServletResponse response, Model model) {
	    logger.info("LoginController home");

	    // 로그인 정보를 가져와서 세션에서 제거합니다.
	    MemberVO loginMember = (MemberVO) session.getAttribute("login");
	    session.removeAttribute("login");

	    // 가져온 로그인 정보를 다시 세션에 "memberVO" 이름으로 저장합니다.
	    if (loginMember != null) {
	        session.setAttribute("memberVO", loginMember); 
	    }

	    // 모델에 "memberVO" 정보를 추가하여 홈 페이지로 전달합니다.
	    model.addAttribute("memberVO", loginMember);

	    return "/home/home";
	}





	
	
	
	
}

