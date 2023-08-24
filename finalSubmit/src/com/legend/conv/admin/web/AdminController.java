package com.legend.conv.admin.web;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.legend.conv.exception.BizNotFoundException;
import com.legend.conv.member.service.MemberService;
import com.legend.conv.member.vo.AgeChartVO;
import com.legend.conv.member.vo.MemberSearchVO;
import com.legend.conv.member.vo.MemberVO;
import com.legend.conv.member.vo.RegionChartVO;
import com.legend.conv.product.vo.ProductChartVO;
import com.legend.conv.voc.service.VocService;
import com.legend.conv.voc.vo.VocSearchVO;
import com.legend.conv.voc.vo.VocVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private VocService vocService;
	
	@RequestMapping("/adminPage")
	public String adminPage(@ModelAttribute("searchVO") MemberSearchVO searchVO, Model model, @ModelAttribute("vocSearchVO") VocSearchVO vocSearchVO) {
		logger.info("adminController searchVO : " + searchVO);
		logger.info("adminController vocSearchVO : " + vocSearchVO);
		try {
			List<MemberVO> memberList = memberService.getMemberList(searchVO);
			logger.info("adminController memberList :" + memberList.toString());
			model.addAttribute("memberList", memberList);
			
			List<VocVO> vocList = vocService.getVocList(vocSearchVO);
			logger.info("adminController vocList :" + vocList);
			model.addAttribute("vocList", vocList);
		} catch (BizNotFoundException bnf) {
			bnf.printStackTrace();
			model.addAttribute("bnf", bnf);
		}
		
		return "/admin/adminPage";
	}
	
	@RequestMapping("/adminMember")
	public String adminMember(@ModelAttribute("searchVO") MemberSearchVO searchVO, Model model) {
		
		try {
			List<MemberVO> memberList = memberService.getMemberList(searchVO);
			logger.info("adminController memberList :" + memberList.toString());
			model.addAttribute("memberList", memberList);
		} catch (BizNotFoundException e) {
			e.printStackTrace();
			model.addAttribute("e", e);
		}
		return "/admin/part/adminMem";
	}
	
	@RequestMapping("/adminVOC")
	public String adminVOC(VocSearchVO vocSearchVO, Model model) {
		
		try {
			List<VocVO> vocList = vocService.getVocList(vocSearchVO);
			logger.info("adminController vocList :" + vocList);
			model.addAttribute("vocList", vocList);
		} catch (BizNotFoundException e) {
			e.printStackTrace();
			model.addAttribute("e", e);
		}
		return "/admin/part/adminVOC";
	}
	
	// regionChartData 엔드포인트 추가
    @RequestMapping("/regionChartData")
    @ResponseBody
    public List<RegionChartVO> regionChartData() {
    	List<RegionChartVO> regionChartData = memberService.regionChartData();
        return regionChartData;
    }
     //ageChartData 엔드포인트 추가
    @RequestMapping("/ageChartData")
    @ResponseBody
    public List<AgeChartVO> ageChartData() {
    	List<AgeChartVO> ageChartData = memberService.ageChartData();
    	return ageChartData;
    }
	
    @PostMapping("/deleteSelectedUsers")
    public ResponseEntity<String> deleteSelectedUsers (@RequestBody Map<String, Object> requestData) throws Exception {
        List<String> userIDs = (List<String>) requestData.get("userIDs");
        String deletionReason = (String) requestData.get("deletionReason");
        logger.info("userIDs:" + userIDs);
        logger.info("deletionReason :" + deletionReason);
        // 사용자 삭제 및 사유 저장 로직 수행
        if (userIDs != null && userIDs.size() >= 1) {
            memberService.deleteUsersWithReason(userIDs, deletionReason);
        } else {
            throw new Exception();
        }
        return ResponseEntity.ok("Users deleted successfully");
    }

}
