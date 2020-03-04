package com.iterms.service;

import java.util.List;

import com.iterms.been.Tb_task;
import com.iterms.been.Tb_tasktime;

public interface Tb_tasktimeService {

	public Tb_tasktime getById(Integer id); 
	//添加
//	public int insertTb_tasktime(Tb_tasktime tb_tasktime);
	//修改
	public int updateTb_tasktime(Tb_tasktime tb_tasktime);
	//删除
	public int deleteTb_tasktime(String ids);
	//分页获取信息链表
	public List<Tb_tasktime> getPage(Tb_tasktime tb_tasktime);
	//获取总条数
	public int getAllCount(Tb_tasktime tb_tasktime);
	//获取所有数据
	public List<Tb_tasktime> getAll();
	public int insertTb_tasktime(Tb_tasktime tb_tasktime);
}
