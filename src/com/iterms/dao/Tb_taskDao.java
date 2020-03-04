package com.iterms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.iterms.been.Tb_task;

public interface Tb_taskDao {

	public Tb_task getById(@Param("id")Integer id);
	public Tb_task getBynodeId(@Param("tb_node_id")Integer node_id);
	int insert(Tb_task tb_task);
	//修改
	int update(Tb_task tb_task);
	//删除
	int delete(Tb_task tb_task);
	/**
	 * @param 根据条件获取结果
	 * @return
	 */
	public List<Tb_task> getPage(Tb_task tb_task);
	//获取总条数
	public int getAllCount(Tb_task tb_task);
	//获取全部信息
	public List<Tb_task> getAll();
	
	
	int updateips(Tb_task tb_task);
	int updateaku(Tb_task tb_task);
	int updatebau(Tb_task tb_task);
	int updatelas(Tb_task tb_task);
	int updateboden(Tb_task tb_task);
	int updatewas(Tb_task tb_task);
	int updatekla(Tb_task tb_task);
	int updatekaro(Tb_task tb_task);
	
	
}
