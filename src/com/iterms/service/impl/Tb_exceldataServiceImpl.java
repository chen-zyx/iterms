

package com.iterms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iterms.been.ExcelData;
import com.iterms.been.Tb_node;
import com.iterms.dao.Tb_exceldataDao;
import com.iterms.service.Tb_exceldataService;

@Service
public class Tb_exceldataServiceImpl implements Tb_exceldataService {

	@Autowired
	private Tb_exceldataDao tb_exceldataDao;

	@Override
	public void insert(ExcelData excelData) {
		// TODO Auto-generated method stub
		tb_exceldataDao.insert(excelData);
	}

	@Override
	public List<ExcelData> getProjects() {
		// TODO Auto-generated method stub
		return tb_exceldataDao.getProjects();
	}

	@Override
	public List<ExcelData> getByProject(String project) {
		// TODO Auto-generated method stub
		return tb_exceldataDao.getByProject(project);
	}

	@Override
	public List<ExcelData> getAll() {
		// TODO Auto-generated method stub
		return tb_exceldataDao.getPage(new ExcelData());
	}

	@Override
	public int getAllCount(ExcelData exceldata) {
		// TODO Auto-generated method stub
		return tb_exceldataDao.getAllCount(exceldata);
	}


}