package com.iterms.service;

import java.util.List;

import com.iterms.been.Tb_task;

public interface Tb_taskService {
		//根据id获取对象
		public  Tb_task getById(String id); 
		//根据添加进行唯一性验证
		public  Tb_task getBynodeId(String node_id); 
		public boolean addcktaskname(String taskname, String tb_node_id);
		//修改进行唯一性验证
		public boolean updcktaskname(String taskname,String tb_node_id,String id);
		//添加
		public int insertTb_task(Tb_task tb_task);
		
		public int updateTb_tasktable(Tb_task tb_task,int i);
		//修改
		public int updateTb_task(Tb_task tb_task);
		//删除
		public int deleteTb_task(String ids);
		//分页获取信息链表
		public List<Tb_task> getPage(Tb_task tb_task);
		//获取总条数
		public int getAllCount(Tb_task tb_task);
		//获取所有数据
		public List<Tb_task> getAll();
}
