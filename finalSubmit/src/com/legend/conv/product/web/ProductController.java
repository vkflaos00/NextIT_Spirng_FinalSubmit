package com.legend.conv.product.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.legend.conv.common.vo.UserZzimVO;
import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.product.service.ProductService;
import com.legend.conv.product.vo.ProductSearchVO;
import com.legend.conv.product.vo.ProductVO;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@RequestMapping("/productView")
	public String ProductView(@ModelAttribute("searchVO") ProductSearchVO searchVO, Model model) {
		
		// 제품 품목 리스트 DB에서 불러오기 
		try {
			List<ProductVO> productList = productService.getProductList(searchVO);
			// 화면 단에 넘겨주기~~~~
			model.addAttribute("productList", productList);
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
			model.addAttribute("e", e);
		}
		
		
		return "/product/productView";
	}
	
	@RequestMapping("/productDetailView")
	public String ProductDetailView(ProductSearchVO searchVO,@RequestParam String itemNo, Model model) {
		
		try {
			ProductVO product = productService.getProduct(itemNo);
			model.addAttribute("product", product);
			
			List<ProductVO> similarList = productService.similarGetProduct(product.getItemName(),itemNo);
			model.addAttribute("similarList", similarList );
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
			model.addAttribute("e", e);
		}
		
		return "/product/productDetailView";
	}
	
	@RequestMapping("/plusZzim")
	@ResponseBody
	public boolean plusZzim(@RequestParam String itemNo, @RequestParam String userId) {
		
		try {
			productService.plusZzim(itemNo);
			productService.insertUserZzim(itemNo, userId);
			
			return true;
		} catch (Exception e){
			return false;
		}
	}
	
	
	@PostMapping(value="/getZzim")
	@ResponseBody
	public UserZzimVO getZzim(@RequestParam String itemNo, @RequestParam String userId) {
		System.out.println("itemNo:"+itemNo + "userId:" + userId);
		UserZzimVO getZzim = productService.getZzim(itemNo,userId);
		System.out.println(getZzim);
		return getZzim;
	}
	
	@RequestMapping("/cancelZzim")
	@ResponseBody
	public boolean cancelZzim(String itemNo,String userId) {
		
		try {
			productService.minusZzim(itemNo);
			boolean isCancelled = productService.cancelZzim(itemNo, userId);
			
			return isCancelled;
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
	}
	
	@RequestMapping("/productChat")
	public String ProductChat(@ModelAttribute("searchVO") ProductSearchVO searchVO, Model model) {
		
		// 제품 품목 리스트 DB에서 불러오기 
		try {
			List<ProductVO> productChatList = productService.getProductChatList(searchVO);
			// 화면 단에 넘겨주기~~~~
			model.addAttribute("productChatList", productChatList);
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
			model.addAttribute("e", e);
		}
		
		
		return "/product/productChat";
	}
}
