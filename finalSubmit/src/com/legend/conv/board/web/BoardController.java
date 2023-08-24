package com.legend.conv.board.web;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.legend.conv.board.service.BoardService;
import com.legend.conv.board.vo.BoardVO;
import com.legend.conv.board.vo.Category;
import com.legend.conv.board.vo.HitVO;
import com.legend.conv.common.util.ConvFileUpload;
import com.legend.conv.common.vo.SearchVO;
import com.legend.conv.member.vo.MemberVO;
import com.legend.conv.notice.vo.NoticeVO;

@Controller
public class BoardController {

	@Autowired
	private ConvFileUpload convFileUpload;

	@Autowired
	public BoardService boardService;

	// 자유 게시판 응답 메소드
	@RequestMapping("/boardList")
	public String boardList(Model model, SearchVO searchVO, BoardVO boardVO) {

		try {
			List<BoardVO> boardList = boardService.getBoardList(searchVO);
			model.addAttribute("boardList", boardList);
			// 인기글 리스트 가져오기
			List<BoardVO> likeBoard = boardService.likeBoardList(boardVO);
			model.addAttribute("likeBoard", likeBoard);

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			model.addAttribute("errorMsg", e.getMessage());
			return "error";
		}

		return "board/boardList";
	}

	// 글 작성 화면 응답 메소드
	@RequestMapping("/boardWrite")
	public String boardWrite(HttpSession session, HttpServletRequest request, Model model) {

		// 현재 세션에 login 키값으로 저장된게 없으면(로그인 안한 상태면)
		// 로그인 화면으로 보내주기
		MemberVO login = (MemberVO) session.getAttribute("login");
		//System.out.println("login" + login);

		if (login == null) {
			String fromUrl = request.getHeader("Referer");
			model.addAttribute("fromUrl", fromUrl);

			return "login/login";
		}
		return "board/boardWrite";
	}

	// 글 작성 처리 메소드
	@PostMapping("/boardWriteDo")
	public String boardWriteDo(@ModelAttribute("board") BoardVO board, HttpSession session,
			MultipartHttpServletRequest mRequest) {

		System.out.println("board : " + board);

		String boCateValue = board.getBoCate().name(); // 카테고리 값을 문자열로 변환
		if (boCateValue != null) {
			boCateValue = boCateValue.toUpperCase(); // 대문자로 변환
			board.setBoCate(Category.valueOf(boCateValue));
		}

		// DB에 전송 (INSERT)
		// boardWrite 으로부터 boTitle, boContent만 가져옴

		// boAuthor(memId)도 챙겨와야함
		// 1. boardWrite.jsp 에 input 태그 (hidden) 이용
		// 2. Controller 메소드에서 세션 객체를 통해 꺼내 쓰기
		MemberVO login = (MemberVO) session.getAttribute("login");
		board.setId(login.getId());
		
		List<MultipartFile> fileList = mRequest.getFiles("boFiles");

		System.out.println("FileList :" + fileList);
		MultipartFile[] boFiles = new MultipartFile[fileList.size()];
		for (int i = 0; i < fileList.size(); i++) {
			boFiles[i] = fileList.get(i);
		}

		boolean fileuploadFlag = true;
		if (boFiles != null) {
			try {
				List<AttachVO> attachList = convFileUpload.fileUpload(boFiles, "BOARD", "board");
				if (attachList.size() > 0) {
					board.setAttachList(attachList);
				}
			} catch (Exception e) {
				e.printStackTrace();
				fileuploadFlag = false;
			}
		}

		try {
			if (board.getBoTitle() != null && !board.getBoTitle().equals("")) {
				boardService.writeBoard(board);
			} else {
				throw new Exception();
			}
			if (fileuploadFlag) {
				return "redirect:/boardList";
			}
		} catch (Exception de) {
			de.printStackTrace();
		}
		return "redirect:/boardList";
	}

	@RequestMapping("/boardView")
	public String boardView(@RequestParam String boNo, Model model,
			HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchVO") SearchVO searchVO) {
		
		Cookie oldCookie = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null)
			for (Cookie cookie : cookies)
				if (cookie.getName().equals("boardView"))
					oldCookie = cookie;
		
		
		if (oldCookie != null) {
			
			if (!oldCookie.getValue().contains("[" + boNo.toString() + "]")) {
				
				boardService.hitCnt(boNo);
				oldCookie.setValue(oldCookie.getValue() + "_[" + boNo + "]");
				oldCookie.setPath("/");
				oldCookie.setMaxAge(60 * 60 * 24);
				response.addCookie(oldCookie);
			}
		} else {
			boardService.hitCnt(boNo);
			Cookie newCookie = new Cookie("boardView", "[" + boNo + "]");
			newCookie.setPath("/");
			newCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newCookie);
		}

		// DB로부터 boNo에 해당하는 게시글 데이터 가져와서
		// boardView.jsp 파일에 전달(model)
		// 조회수 증가
		try {
			BoardVO board = boardService.getBoard(boNo);
			// 조회된 첨부파일 목록을 board 객체에 설정
			model.addAttribute("board", board);
			// board 객체가 null인지 확인하여 예외 처리
			if (board == null) {
				throw new Exception("해당 게시글을 찾을 수 없습니다.");
			}
			

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			model.addAttribute("errorMsg", e.getMessage());

			return "error";
		}
		return "board/boardView";
	}

	// 글 수정
	@PostMapping("/boardModDo")
	public String boardModDo(@ModelAttribute("board") BoardVO board, HttpServletRequest request, Model model,
			MultipartHttpServletRequest mRequest, @RequestParam(required = false) MultipartFile[] boFiles)
			throws Exception {

		boolean fileuploadFlag = true;
		if (boFiles != null) {
			try {
				List<AttachVO> attachList = convFileUpload.fileUpload(boFiles, "BOARD", "board");
				if (attachList.size() > 0) {
					board.setAttachList(attachList);
				}
			} catch (Exception e) {
				e.printStackTrace();
				fileuploadFlag = false;
			}
		}

		try {
			if (board.getBoNo() != null && !board.getBoNo().equals("")) {
				// 게시글 수정(UPDATE)
				boardService.modBoard(board);
				
				System.out.println("board :" + board);
			} else {
				throw new IllegalArgumentException("게시글 번호가 없습니다.");
			}
			if (fileuploadFlag) {
				return "redirect:/boardView?boNo=" + board.getBoNo();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("예외 발생: " + e.getClass().getName() + " - " + e.getMessage());
			// 예외 발생 시에는 에러 페이지로 이동하거나 오류 메시지를 출력하는 등의 처리를 추가할 수 있습니다.
			model.addAttribute("errorMessage", "게시글 수정 중 오류가 발생했습니다.");
			return "error";
		}
		return "redirect:/boardView?boNo=" + board.getBoNo();
	}

	// 게시글 수정 화면 응답
	@PostMapping("/boardModify")
	public String boardModify(Model model, String boNo) {

		try {
			BoardVO board = boardService.getBoard(boNo);
			model.addAttribute("board", board);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "board/boardModify";
	}

	// 게시글 삭제
	@PostMapping("/boardDel")
	public String boardDel(@ModelAttribute BoardVO board) {

		try {
			if (board.getBoNo() != null) {
				// 게시글 삭제(DELETE)
				boardService.delBoard(board);
			} else {
				throw new Exception();
			}
			return "redirect:/boardList";
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return "redirect:/boardList";
	}

	// 추천수
	@RequestMapping(value = "/board/hit")
	@ResponseBody
	public String hitBoard(String boNo, HttpSession session, BoardVO board,
			HttpServletRequest request, Model model) {

		boNo = board.getBoNo();
		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = login.getId();
		//System.out.println("loginId임 : " + id);

		boardService.hitCheck(id, boNo);

		boardService.hitBoard(boNo);

		return "redirect:/boardView?boNo=" + board.getBoNo();

	}

	@RequestMapping(value = "/board/hitCancel")
	@ResponseBody
	public String hitCancelBoard(String boNo, HttpSession session, BoardVO board,
			HttpServletRequest request, Model model) {
		//System.out.println("hitCancelBoard");

		boNo = board.getBoNo();
		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = login.getId();
		//System.out.println("loginId임 : " + id);

		boardService.hitCheck(id, boNo);

		boardService.hitCancelBoard(boNo);

		return "redirect:/boardView?boNo=" + board.getBoNo();
	}

	@RequestMapping(value = "/board/hitEdit")
	@ResponseBody
	public Boolean hitEdit(String boNo, HttpSession session, BoardVO board,
			HttpServletRequest request, Model model) {

		boNo = board.getBoNo();
		MemberVO login = (MemberVO) session.getAttribute("login");
		String id = login.getId();
		//System.out.println("loginId임 : " + id);

		Boolean hitYn = boardService.hitEdit(id, boNo);

		return hitYn;
	}

	@RequestMapping(value = "/board/hitCheck")
	@ResponseBody
	public Boolean hitCheck(String boNo, HttpSession session, BoardVO board,
			HttpServletRequest request, Model model) {

		boNo = board.getBoNo();
		MemberVO login = (MemberVO) session.getAttribute("login");

		if (login == null) {
			return false;
		}

		String id = login.getId();
		//System.out.println("loginId임 : " + id);
		Boolean hitYn = boardService.hitCheck(id, boNo);

		return hitYn;

	}
}
