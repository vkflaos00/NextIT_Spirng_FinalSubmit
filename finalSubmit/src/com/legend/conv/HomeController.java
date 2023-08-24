package com.legend.conv;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.product.service.ProductService;
import com.legend.conv.product.vo.ChartCategoryVO;
import com.legend.conv.product.vo.ProductChartVO;
import com.legend.conv.product.vo.ProductVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private final ProductService productService;

    @Autowired
    public HomeController(ProductService productService) {
        this.productService = productService;
    }
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		List<ProductChartVO> chartData = productService.getChartData();
		model.addAttribute("chartData", chartData);
		
		List<ChartCategoryVO> categoryData = productService.getCategoryData();
		model.addAttribute("categoryData", categoryData);
		
		try {
			List<ProductVO> productList = productService.getZzimProductList();
			logger.info("ZzimProductList" + productList.toString());
			model.addAttribute("productList", productList);
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
			model.addAttribute("e", e);
		}
				
		return "/home";
	}
	
	 // /chartData 엔드포인트 추가
    @RequestMapping("/chartData")
    @ResponseBody
    public List<ProductChartVO> chartData() {
    	List<ProductChartVO> chartData = productService.getChartData();
    	logger.info(chartData.toString());
        return chartData;
    }
    // /categoryData 엔드포인트 추가
    @RequestMapping("/categoryData")
    @ResponseBody
    public List<ChartCategoryVO> catergoryData() {
    	List<ChartCategoryVO> categoryData = productService.getCategoryData();
    	logger.info(categoryData.toString());
    	return categoryData;
    }
}
