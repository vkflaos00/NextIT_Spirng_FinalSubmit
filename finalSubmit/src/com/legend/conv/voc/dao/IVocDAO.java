package com.legend.conv.voc.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.legend.conv.attach.vo.AttachVO;
import com.legend.conv.voc.vo.VocSearchVO;
import com.legend.conv.voc.vo.VocVO;
@Mapper
public interface IVocDAO {
	
	public int registerVOC(VocVO vo);
	
	int getTotalRowCount(String memMail);

	public ArrayList<VocVO> selectVOC(String memMail);
	
	// VOC 목록 불러오기
	public List<VocVO> getVocList(VocSearchVO vocSearchVO);
	
	// VOC 처리안된 목록 숫자 불러오기
	public int getTotalProcessCount(VocSearchVO vocSearchVO);

	public String getKey();

	public void commit();

	public AttachVO takePicture(String vocNo);
}
