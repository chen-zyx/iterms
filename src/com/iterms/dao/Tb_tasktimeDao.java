package com.iterms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.iterms.been.Tb_task;
import com.iterms.been.Tb_tasktime;

public interface Tb_tasktimeDao {
	
	public Tb_tasktime getById(@Param("id")Integer id);

	int update(Tb_tasktime tb_tasktime);

//	int insert(Tb_tasktime tb_tasktime);

	public List<Tb_tasktime> getPage(Tb_tasktime tb_tasktime);

	public int getAllCount(Tb_tasktime tb_tasktime);
	
	public List<Tb_tasktime> getAll();

	int delete(Tb_tasktime tb_tasktime);

	int inserttask1(Tb_tasktime tb_tasktime);
	int inserttask2(Tb_tasktime tb_tasktime);
	int inserttask3(Tb_tasktime tb_tasktime);
	int inserttask4(Tb_tasktime tb_tasktime);
}
