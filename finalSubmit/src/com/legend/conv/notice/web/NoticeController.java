package com.legend.conv.notice.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.UriComponentsBuilder;

import com.legend.conv.attach.vo.AttachVO;
import com.legend.conv.common.util.ConvFileUpload;
import com.legend.conv.member.vo.MemberVO;
import com.legend.conv.notice.service.NoticeService;
import com.legend.conv.notice.vo.NoticeVO;
import com.legend.conv.notice.vo.SearchVO;

@Controller
public class NoticeController {

	@Autowired
	private ConvFileUpload convFileUpload;

	@Autowired
	NoticeService noticeService;

	// 공지사항 화면 응답 메소드
	@RequestMapping("/noticeView")
	public String noticeView(Model model, SearchVO searchVO) {
		try {
			List<NoticeVO> noticeList = noticeService.getNoticeList(searchVO);
			model.addAttribute("noticeList", noticeList);

		} catch (Exception e) {
			model.addAttribute("e", e);
			e.printStackTrace();
		}

		return "/notice/noticeView";
	}

	// 공지 글쓰기 화면 응답 메소드
	@RequestMapping("/noticeWriteView")
	public String noticeWriteView() {
		return "/notice/noticeWriteView";
	}

	// 글 작성 메소드
	@PostMapping("/noticeWriteDo")
	public String noticeWriteDo(Model model, MultipartHttpServletRequest mRequest, NoticeVO notice) {

		System.out.println("noticeVO :" + notice);
		List<MultipartFile> fileList = mRequest.getFiles("boFiles");

		System.out.println("FileList :" + fileList);
		MultipartFile[] boFiles = new MultipartFile[fileList.size()];
		for (int i = 0; i < fileList.size(); i++) {
			boFiles[i] = fileList.get(i);
		}

		boolean fileuploadFlag = true;
		if (boFiles != null) {
			try {
				List<AttachVO> attachList = convFileUpload.fileUpload(boFiles, "NOTICE", "notice");
				if (attachList.size() > 0) {
					notice.setAttachList(attachList);
				}
			} catch (Exception e) {
				e.printStackTrace();
				fileuploadFlag = false;
			}
		}

		try {
			if (notice.getNoticeTitle() != null && !notice.getNoticeTitle().equals("")) {
				noticeService.writeNotice(notice);
			} else {
				throw new Exception();
			}
			if (fileuploadFlag) {
				return "redirect:/noticeView";
			}
		} catch (Exception de) {
			de.printStackTrace();
		}
		return "redirect:/noticeView";
	}

	// 상세페이지 응답
	@RequestMapping("/noticeDetailView")
	public String noticeDetailView(int noticeNo, Model model) {

		System.out.println("noticeDetailView noticeNo :" + noticeNo);

		 noticeService.noticeCount(noticeNo);
		try {
			NoticeVO notice = noticeService.getNotice(noticeNo);
			model.addAttribute("notice", notice);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/notice/noticeDetailView";
	}

	// 글 수정 화면 응답
	@PostMapping("/noticeEditView")
	public String noticeEditView(@RequestParam int noticeNo, Model model) {

		try {
			NoticeVO notice = noticeService.getNotice(noticeNo);
			model.addAttribute("notice", notice);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "notice/noticeEditView";
	}

	// 수정 처리
	@PostMapping("/noticeEditDo")
	public String noticeEditDo(@ModelAttribute("notice") NoticeVO notice, Model model,
			MultipartHttpServletRequest mRequest, HttpServletRequest request,
			@RequestParam(required = false) MultipartFile[] boFiles) throws Exception {

		boolean fileuploadFlag = true;
		if (boFiles != null) {
			try {
				List<AttachVO> attachList = convFileUpload.fileUpload(boFiles, "NOTICE", "notice");
				if (attachList.size() > 0) {
					notice.setAttachList(attachList);
				}
			} catch (Exception e) {
				e.printStackTrace();
				fileuploadFlag = false;
			}
		}

		try {
			if (notice.getNoticeTitle() != null && !notice.getNoticeTitle().equals("")) {
				System.out.println("Edit notice : " + notice);
				noticeService.editNotice(notice);
			} else {
				throw new Exception();
			}
			if (fileuploadFlag) {
				String noticeNo = request.getParameter("noticeNo");
				String st = request.getParameter("searchType");
				String sc = request.getParameter("searchCategory");
				String sw = request.getParameter("searchWord");
				String cp = request.getParameter("curPage");
				String rpp = request.getParameter("rowSizePerPage");

				UriComponentsBuilder builder = UriComponentsBuilder.fromPath("/noticeDetailView")
						.queryParam("noticeNo", noticeNo).queryParam("searchType", st).queryParam("searchCategory", sc)
						.queryParam("searchWord", sw).queryParam("curPage", cp).queryParam("rowSizePerPage", rpp);

				String redirectUrl = builder.toUriString();

				return "redirect:" + redirectUrl;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 게시글 삭제
	@PostMapping("/noticeDelDo")
	public String noticeDelDo(int noticeNo) {
		noticeService.delNotice(noticeNo);

		return "redirect:/noticeView";
	}

	@RequestMapping(value = "/hit")
	@ResponseBody
	public String hitNotice(@RequestParam("noticeNo") int noticeNo, HttpSession session, NoticeVO notice,
			HttpServletRequest request, Model model) {

		noticeNo = notice.getNoticeNo();
		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = login.getId();
		System.out.println("loginId임 : " + id);

		noticeService.hitCheck(id, noticeNo);

		noticeService.hitNotice(noticeNo);
		String st = request.getParameter("searchType");
		String sw = request.getParameter("searchWord");
		String cp = request.getParameter("curPage");
		String rpp = request.getParameter("rowSizePerPage");

		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("/noticeDetailView")
				.queryParam("noticeNo", noticeNo).queryParam("searchType", st).queryParam("searchWord", sw)
				.queryParam("curPage", cp).queryParam("rowSizePerPage", rpp);

		String redirectUrl = builder.toUriString();

		return "redirect:" + redirectUrl;

	}

	@RequestMapping(value = "/hitCancel")
	@ResponseBody
	public String hitCancelNotice(@RequestParam("noticeNo") int noticeNo, HttpSession session, NoticeVO notice,
			HttpServletRequest request, Model model) {
		System.out.println("hitCancelNotice");

		noticeNo = notice.getNoticeNo();
		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = login.getId();
		System.out.println("loginId임 : " + id);

		noticeService.hitCheck(id, noticeNo);

		noticeService.hitCancelNotice(noticeNo);
		String st = request.getParameter("searchType");
		String sw = request.getParameter("searchWord");
		String cp = request.getParameter("curPage");
		String rpp = request.getParameter("rowSizePerPage");

		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("/noticeDetailView")
				.queryParam("noticeNo", noticeNo).queryParam("searchType", st).queryParam("searchWord", sw)
				.queryParam("curPage", cp).queryParam("rowSizePerPage", rpp);

		String redirectUrl = builder.toUriString();

		return "redirect:" + redirectUrl;
	}

	@RequestMapping(value = "/hitEdit")
	@ResponseBody
	public Boolean hitEdit(@RequestParam("noticeNo") int noticeNo, HttpSession session, NoticeVO notice,
			HttpServletRequest request, Model model) {

		noticeNo = notice.getNoticeNo();
		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = login.getId();
		System.out.println("loginId임 : " + id);

		Boolean hitYn = noticeService.hitEdit(id, noticeNo);

		return hitYn;
	}

	@RequestMapping(value = "/hitCheck")
	@ResponseBody
	public Boolean hitCheck(@RequestParam("noticeNo") int noticeNo, HttpSession session, NoticeVO notice,
			HttpServletRequest request, Model model) {

		noticeNo = notice.getNoticeNo();
		MemberVO login = (MemberVO) session.getAttribute("login");
		
		if(login == null) {
			return false;
		}
		
		String id = login.getId();
		System.out.println("loginId임 : " + id);
		Boolean hitYn = noticeService.hitCheck(id, noticeNo);

		return hitYn;
		
	}
}
