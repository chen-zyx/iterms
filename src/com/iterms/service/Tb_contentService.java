package com.iterms.service;

import java.util.List;

import com.iterms.been.Tb_content;

public interface Tb_contentService {

	//根据id获取对象
		public Tb_content getById(String id); 
		//根据添加进行唯一性验证
		public boolean addckcname(String cname);
		//修改进行唯一性验证
		public boolean updckcname(String cname,String id);
		//添加
		public int insertTb_content(Tb_content tb_content);
		
		//删除
		public int deleteTb_content(String ids);
		//分页获取信息链表
		public List<Tb_content> getPage(Tb_content tb_content);
		//获取总条数
		public int getAllCount(Tb_content tb_content);
		//获取所有数据
		public List<Tb_content> getAll();
}
