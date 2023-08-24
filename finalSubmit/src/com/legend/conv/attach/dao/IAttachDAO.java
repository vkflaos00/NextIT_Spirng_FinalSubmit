package com.legend.conv.attach.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.legend.conv.attach.vo.AttachVO;

@Mapper
public interface IAttachDAO {
	
	void insertAttach(AttachVO attach);
	
	List<AttachVO> getAttachList(@Param("atchParentNo")String boNo
			, @Param("atchCategory")String string);

	AttachVO getAttach(int atchNo);

	Integer getAttachNo(Map<String, Object> map);

	void deleteAttaches(Map<String, Object> map);

}