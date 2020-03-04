package com.iterms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.iterms.been.ExcelData;
import com.iterms.been.Tb_node;

public interface Tb_exceldataDao {

	// 添加
	public void insert(ExcelData excelData);

	// 获取全部项目名
	public List<ExcelData> getProjects();

	// 通过项目名获取数据
	public List<ExcelData> getByProject(@Param("project") String project);

	public List<ExcelData> getPage(ExcelData ExcelData);
	public int getAllCount(ExcelData exceldata);

}
