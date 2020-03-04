package com.iterms.service;

import java.util.List;

import com.iterms.been.Tb_erst;



public interface Tb_erstService {

	//根据id获取对象
		public Tb_erst getById(String id); 
		//根据添加进行唯一性验证
		public boolean addckerstname(String erstname);
		//修改进行唯一性验证
		public boolean updckerstname(String erstname,String id);
		//添加
	//	public int insertTb_erst(Tb_erst Tb_erst);
		//修改
	//	public int updateTb_erst(Tb_erst Tb_erst);
		//删除
	//	public int deleteTb_erst(String ids);
		//分页获取信息链表
		public List<Tb_erst> getPage(Tb_erst tb_erst);
		//获取总条数
		public int getAllCount(Tb_erst tb_erst);
		//获取所有数据
		public List<Tb_erst> getAll();
}
