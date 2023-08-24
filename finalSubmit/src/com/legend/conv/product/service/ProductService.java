package com.legend.conv.product.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.legend.conv.common.vo.UserZzimVO;
import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.product.dao.IProductDAO;
import com.legend.conv.product.vo.ChartCategoryVO;
import com.legend.conv.product.vo.ProductChartVO;
import com.legend.conv.product.vo.ProductSearchVO;
import com.legend.conv.product.vo.ProductVO;

@Service
public class ProductService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private final IProductDAO dao;
	
	@Autowired
	public ProductService(IProductDAO dao) {
		this.dao = dao;
	}
	
	// 게시판 보이기
	public List<ProductVO> getProductList (ProductSearchVO searchVO) throws BizNotEffectedException {
		
		int totalRowCount = dao.getTotalRowCount(searchVO);
		
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		
		List<ProductVO> productList = dao.getProductList(searchVO);
		
		if(productList == null) {
			throw new BizNotEffectedException();
		}
		
		return productList;
		
	}
	
	// 상세 화면
	public ProductVO getProduct(String itemNo) throws BizNotEffectedException {
		
		ProductVO product = dao.getProduct(itemNo);
		
		if(product == null) {
			throw new BizNotEffectedException();
		}
		
		return product;
	}
	
	// 유사 제품 보여주기
	public List<ProductVO> similarGetProduct(String itemName, String itemNo) {
		
		return dao.similarGetProduct(itemName,itemNo);
	}
	// 전체 제품 수량 구하기
	public List<ProductChartVO> getChartData() {
        return dao.getChartData();
    }
	// 전체 카테고리별 수량 구하기
	public List<ChartCategoryVO> getCategoryData() {
		return dao.getCategoryData();
	}
	
	// 찜 10위권 보이기
	public List<ProductVO> getZzimProductList () throws BizNotEffectedException {
		
		List<ProductVO> productList = dao.getZzimProductList();
		
		if(productList == null) {
			throw new BizNotEffectedException();
		}
		
		return productList;
		
	}
	// 찜하기
	public void plusZzim(String itemNo) {
		dao.plusZzim(itemNo);
	}
	
	// 유저의 찜목록 저장
	public void insertUserZzim(String itemNo, String userId) {
		dao.insertUserZzim(itemNo, userId);
	}
	
	// 찜목록 불러오기
	public UserZzimVO getZzim(String itemNo, String userId) {
		UserZzimVO zzim = dao.getZzim(itemNo, userId);
		return zzim;
	}
	
	// 찜하기 취소 할 시 유저찜에서 삭제
	public boolean cancelZzim(String itemNo, String userId) {
		int resCnt = dao.cancelZzim(itemNo, userId);
		
		if(resCnt == 1) {
			return true;
		}else {
			return false;
		}
	}
	// 찜하기 취소시 product 에서 likeflag 빼기
	public void minusZzim(String itemNo) {
		dao.minusZzim(itemNo);
	}
	// 채팅활성화된 목록 보이기
	public List<ProductVO> getProductChatList (ProductSearchVO searchVO) throws BizNotEffectedException {
		
		int totalRowCount = dao.getChatTotalRowCount(searchVO);
		logger.info("totalRowCount :" + totalRowCount);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		logger.info("searchVO:" + searchVO.toString());
		List<ProductVO> productChatList = dao.getProductChatList(searchVO);
		
		logger.info("productChatList:" + productChatList.toString());
		if(productChatList == null) {
			throw new BizNotEffectedException();
		}
		return productChatList;
		
	}
	
	public void chatOpen(String itemNo) throws BizNotEffectedException {
		int updatedRows = dao.chatOpen(itemNo);
		if(updatedRows == 0) {
			throw new BizNotEffectedException();
		}
	}
	
	public void chatClose(String itemNo) throws BizNotEffectedException {
		int updatedRows = dao.chatClose(itemNo);
		if(updatedRows == 0) {
			throw new BizNotEffectedException();
		}
	}
}
