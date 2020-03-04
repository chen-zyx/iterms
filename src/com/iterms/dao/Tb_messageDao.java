package com.iterms.dao;

import java.util.List;


import org.apache.ibatis.annotations.Param;

import com.iterms.been.Tb_message;
import com.iterms.utils.PageModel;

public interface Tb_messageDao {

	//添加
	public Integer insert(Tb_message tb_message); 
	
	//修改
	public Integer update(Tb_message tb_message);
	
	//通过不同条件获取本用户信息
	public List<Tb_message> getMessages(@Param("tb_message")Tb_message tb_message,@Param("pm")PageModel<Tb_message> pm);
	
	//获取信息条数
	public Integer getCount(Tb_message tb_message);
	
	//通过信息id获取信息
	public Tb_message findById(Integer id);
}
