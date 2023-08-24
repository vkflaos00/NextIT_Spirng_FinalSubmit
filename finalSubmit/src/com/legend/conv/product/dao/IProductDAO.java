package com.legend.conv.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.legend.conv.common.vo.UserZzimVO;
import com.legend.conv.product.vo.ChartCategoryVO;
import com.legend.conv.product.vo.ProductChartVO;
import com.legend.conv.product.vo.ProductSearchVO;
import com.legend.conv.product.vo.ProductVO;

@Mapper
public interface IProductDAO {
	
	// 제품 품목 보기
	public List<ProductVO> getProductList(ProductSearchVO searchVO);
	
	// total 제품수 구하기
	public int getTotalRowCount(ProductSearchVO searchVO);
	// total 채팅방수 구하기
	public int getChatTotalRowCount(ProductSearchVO searchVO);
	
	// View 제품 정보 보여주기
	public ProductVO getProduct(String itemNo);
	
	// 유사한 제품 보여주기
	public List<ProductVO> similarGetProduct(@Param("itemName")String itemName, @Param("itemNo")String itemNo);
	
	// 전체 제품 수량 구하기 ( 편의점별)
	public List<ProductChartVO> getChartData();
	
	// 차트용 카테고리별 수량 구하기
	public List<ChartCategoryVO> getCategoryData();
	
	// 찜하기 순위 10위 보이기
	public List<ProductVO> getZzimProductList();
	
	// 찜하기 클릭시 제품 likeFlag 올리기
	public int plusZzim(String itemNo);
	
	// 찜하기 클릭시 누가 클릭했는지 저장
	public int insertUserZzim(@Param("itemNo")String itemNo, @Param("userId")String userId); 
	
	// 찜유무 확인
	public UserZzimVO getZzim(@Param("itemNo")String itemNo, @Param("userId")String userId);
	
	// 찜하기 취소
	public int cancelZzim(@Param("itemNo")String itemNo, @Param("userId")String userId);
	
	// 찜하기 취소 할 시 제품 likeFlag 빼기
	public int minusZzim(String itemNo);
	
	// 제품 채팅 품목 보기
	public List<ProductVO> getProductChatList(ProductSearchVO searchVO);
	
	// 채팅방 오픈시 오픈유무 변경 
	public int chatOpen(String itemNo);
	
	// 채팅방 오픈시 오픈유무 변경 
	public int chatClose(String itemNo);
}
