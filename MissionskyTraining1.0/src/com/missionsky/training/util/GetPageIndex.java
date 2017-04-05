package com.missionsky.training.util;

import com.missionsky.training.domain.PageData;

public class GetPageIndex {
	
	public static PageData getData(int pageIndex,int pageSize)
	{
		PageData pd=new PageData();
		pd.setStart_index((pageIndex-1)*pageSize);
		pd.setEnd_index(pageSize);
		return pd;
	}

}
