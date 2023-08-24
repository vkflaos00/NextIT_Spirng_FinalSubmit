package com.legend.conv.gift.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.legend.conv.gift.vo.ItemVO;
import com.legend.conv.gift.vo.KakaoPayApprovalVO;
import com.legend.conv.gift.vo.KakaoPayReadyVO;

@Service
public class KakaoPayService {
 
	private static final Logger logger = LoggerFactory.getLogger(KakaoPayService.class);
	
    private static final String HOST = "https://kapi.kakao.com";
    
    private KakaoPayReadyVO kakaoPayReadyVO;
    private KakaoPayApprovalVO kakaoPayApprovalVO;
    
    public String kakaoPayReady(List<ItemVO> selectedItems) {
 
        RestTemplate restTemplate = new RestTemplate();	
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "88e34d129ddc0c11228fcd25690e7a4e");
        headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "1001");
        params.add("partner_user_id", "CONV");

        int totalQuantity = 0;
        int totalAmount = 0;
        String firstItemName = null;
        int totalItems = 0;
        
        for (int i = 0; i < selectedItems.size(); i++) {
            ItemVO item = selectedItems.get(i);
            totalItems ++;

            int quantity = item.getQuantity();
            totalQuantity += quantity;

            int totalItemAmount = item.getTotalAmount();
            totalAmount += totalItemAmount;

            int taxFreeAmount = (int) (totalItemAmount * 0.1);
            params.add("tax_free_amount", String.valueOf(taxFreeAmount));

            if (i == 0) {
                firstItemName = item.getItemName();
            }
        }

        if (selectedItems.size() > 1) {
            String combinedItemName = firstItemName + " 외 " + (totalItems - 1) + "건";
            params.add("item_name", combinedItemName);
        } else {
            params.add("item_name", firstItemName);
        }

        params.add("quantity", String.valueOf(totalQuantity));
        params.add("total_amount", String.valueOf(totalAmount));


        params.add("approval_url", "http://192.168.1.38:8080/gift/kakaoPaySuccess");
        params.add("cancel_url", "http://192.168.1.38:8080/gift/kakaoPayCancel");
        params.add("fail_url", "http://192.168.1.38:8080/gift/kakaoPaySuccessFail");
 
//        params.add("approval_url", "http://192.168.1.28:8080/conv/gift/kakaoPaySuccess");
//        params.add("cancel_url", "http://192.168.1.28:8080/conv/gift/kakaoPayCancel");
//        params.add("fail_url", "http://192.168.1.28:8080/conv/gift/kakaoPaySuccessFail");
        
         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        try {
        	 kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
            return kakaoPayReadyVO.getNext_redirect_pc_url();
 
        } catch (RestClientException e) {
             logger.error("RestClientException occurred during kakaoPayReady", e);
        } catch (URISyntaxException e) {
        	logger.error("URISyntaxException occurred during kakaoPayReady", e);
        }
        
        return "/pay";
        
    }
    
    public KakaoPayApprovalVO kakaoPayInfo(String pg_token) {
    	 
        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "88e34d129ddc0c11228fcd25690e7a4e");
        headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
 
        // 서버로 요청할 Body
        System.out.println("kakaoPayReadyVO"+ kakaoPayReadyVO);
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id", "1001");
        params.add("partner_user_id", "CONV");
        params.add("pg_token", pg_token);
       
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            	
           System.out.println("kakaoPayApprovalVO" + kakaoPayApprovalVO);
            return kakaoPayApprovalVO;
        
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    
}
 
