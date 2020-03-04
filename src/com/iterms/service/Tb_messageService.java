package com.iterms.service;


import com.iterms.been.Tb_message;
import com.iterms.utils.PageModel;

public interface Tb_messageService {

	//添加
	public Integer insert(Tb_message tb_message); 
	
	//修改
	public Integer update(Tb_message tb_message);
		
	//通过信息id获取信息
	public Tb_message findById(Integer id);
	
	//获取信息条数
	public Integer getCount(Tb_message tb_message);
		
	//获取分页后的信息
	public PageModel<Tb_message>  getMessages(Tb_message tb_message,PageModel<Tb_message> pm);
}
