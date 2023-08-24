package com.legend.conv.voc.web;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.legend.conv.attach.service.AttachService;
import com.legend.conv.attach.vo.AttachVO;
import com.legend.conv.common.util.ConvFileUpload;
import com.legend.conv.common.vo.PagingVO;
import com.legend.conv.common.vo.SearchVO;
import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.exception.BizNotFoundException;
import com.legend.conv.member.vo.MemberVO;
import com.legend.conv.voc.service.VocService;
import com.legend.conv.voc.vo.VocPop;
import com.legend.conv.voc.vo.VocSearchVO;
import com.legend.conv.voc.vo.VocVO;

@Controller
public class VocController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	VocService service;

	@Autowired
	AttachService atchService;

	@Autowired
	private ConvFileUpload ConvFileUpload;

	@RequestMapping(value = "/voc")
	public String voc(HttpSession session, Model model) {
		model.addAttribute("memId", session.getAttribute("login"));
		return "/about/voc";
	}

	@RequestMapping(value = "/vocPop")
	public String vocpop(@ModelAttribute("vocPop") VocVO vocPop) 
	{
		return "/about/voc_popup";
	}

	@RequestMapping(value = "/registerVOC", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> registVOC(@RequestParam("file") MultipartFile[] profilePhoto,
			@RequestParam("content") String content, @RequestParam("title") String title,
			@RequestParam("mail") String mail, @RequestParam("category") String category,
			@ModelAttribute("vocPop") VocVO vocPop, HttpSession session) {

		vocPop.setVocTitle(title);
		vocPop.setVocContent(content);
		vocPop.setVocMail(mail);
		try {
			if (category.equalsIgnoreCase("1")) {
				vocPop.setVocCategory("결제 환불/취소");
			} else if (category.equalsIgnoreCase("2")) {
				vocPop.setVocCategory("상품 문의");
			} else if (category.equalsIgnoreCase("3")) {
				vocPop.setVocCategory("성복씨 문의");
			} else {
				vocPop.setVocCategory("계정 문의");
			}
			boolean fileuploadFlag = true;
			if (profilePhoto != null) {
				try {
					List<AttachVO> attachList = ConvFileUpload.fileUpload(profilePhoto, "VOC", "VOC");
					// System.out.println("파일업로드");
					vocPop.setVocAttach(attachList);
				} catch (Exception e) {
					e.printStackTrace();
					fileuploadFlag = false;
				}
			}
			service.registerVOC(vocPop);

			return new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			// 오류 발생 시
			System.err.print("VOC 컨트롤러 regiserVOC에서 오류발생");
			e.printStackTrace();
			return new ResponseEntity<>("error", HttpStatus.INTERNAL_SERVER_ERROR);

		}
	}

	@RequestMapping(value = "/selectVOC")
	@ResponseBody
	public Map<String, Object> selectVOC(HttpSession session, Model model, ObjectMapper objectMapper,
			@RequestParam(defaultValue = "1") int curPage, PagingVO pagingVO) {
		MemberVO member = (MemberVO) session.getAttribute("login");
		HashMap<String, Object> map = new HashMap<>();

		// Check if member is not logged in
		if (member == null) {
			map.put("error", "로그인이 필요합니다.");
			return map;
		}
		map = service.selectVOC(member.getMail());

		@SuppressWarnings("unchecked")
		ArrayList<VocVO> vocList = (ArrayList<VocVO>) map.get("vocList");
		if (vocList.isEmpty()) {
			map.put("keyword", "등록한 문의사항이 없습니다.");
			return map;
		} else {
			pagingVO = (PagingVO) map.get("pagingVO");
			pagingVO.setCurPage(curPage);
			pagingVO.pageSetting();

			// System.out.println("VocController selectVOC vocList.toStirng() : " +
			// vocList);
			// System.out.println("VocController selectVOC PagingVO.toStirng() : " +
			// pagingVO);
		}

		return map;
	}

	// 컨트롤러 측 코드
	@RequestMapping(value = "/vocViewPopup")
	@ResponseBody
	public ResponseEntity<Object> vocViewPopup(HttpSession session, @RequestParam("vocNo") String vocNo) {
		// 여기서 vocNo와 일치하는 문의글 데이터 조회 및 JSON 변환

		MemberVO member = (MemberVO) session.getAttribute("login");
		HashMap<String, Object> selectedVoc = service.selectVOC(member.getMail());

		@SuppressWarnings("unchecked")
		List<VocVO> vocList = (List<VocVO>) selectedVoc.get("vocList");
		for (VocVO vo : vocList) {
			if (vo.getVocNo().equals(vocNo)) {
				ObjectMapper objectMapper = new ObjectMapper();
				String jsonResponse;
				try {
					jsonResponse = objectMapper.writeValueAsString(vo);
				} catch (JsonProcessingException e) {
					return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
				}

				return new ResponseEntity<>(jsonResponse, HttpStatus.OK);
			}
		}

		// 일치하는 데이터를 찾지 못한 경우
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}

	@RequestMapping(value = "takePicture")
	@ResponseBody
	public HashMap<String, Integer> takePicture(@RequestParam String dataValue) {
		HashMap<String, Integer> map = new HashMap<>();
		try {
			AttachVO vo = service.takePicture(dataValue);
			System.out.println(vo.toString());
			int atchno = vo.getAtchNo();
			
			map.put("path", atchno);
			
			return map;
		} catch (NullPointerException e) {
			System.out.println("사진 안올림");
			map.put("err", 0);
			return map;
		}

	}

}