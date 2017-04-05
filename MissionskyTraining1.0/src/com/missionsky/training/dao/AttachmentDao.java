package com.missionsky.training.dao;

import java.util.List;

import com.missionsky.training.domain.Attachment;
import com.missionsky.training.domain.AttachmentInfo;
import com.missionsky.training.domain.PageData;

public interface AttachmentDao {
	
	/*获取附件的总记录数*/
	public int getRowcount(); 
	/*分页查看附件信息列表*/
	public List<AttachmentInfo> getAttachmentByPage(PageData pd);
	/*上传附件*/
	public void addAttachment(Attachment ath);
	/*模糊查询获取附件的总记录数*/
	public int getRowcountByCondition(String QueryName); 
	/*模糊分页查询*/
	public List<AttachmentInfo> queryAttachmentByPage(PageData pd);
	/*删除附件*/
	public void deleteAttachment(int attachmentId);

}
