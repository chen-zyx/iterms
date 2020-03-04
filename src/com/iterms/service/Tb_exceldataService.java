package com.iterms.service;

import java.util.List;

import com.iterms.been.ExcelData;
import com.iterms.been.Tb_node;

public interface Tb_exceldataService {
	// 添加
	public void insert(ExcelData excelData);

	// 获取全部项目名
	public List<ExcelData> getProjects();

	// 通过项目名获取数据
	public List<ExcelData> getByProject(String project);
	
	
	public List<ExcelData> getAll();

	public int getAllCount(ExcelData exceldata);
}
