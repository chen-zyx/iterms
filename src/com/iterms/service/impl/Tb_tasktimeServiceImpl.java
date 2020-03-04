package com.iterms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iterms.been.Tb_ips;
import com.iterms.been.Tb_task;
import com.iterms.been.Tb_tasktime;
import com.iterms.dao.Tb_tasktimeDao;
import com.iterms.service.Tb_tasktimeService;

@Service
public class Tb_tasktimeServiceImpl implements Tb_tasktimeService {

	@Autowired
	private Tb_tasktimeDao tb_tasktimeDao;
	
	@Override
	public Tb_tasktime getById(Integer id) {
		// TODO Auto-generated method stub
		return tb_tasktimeDao.getById(id);
		}

	/*@Override
	public int insertTb_tasktime(Tb_tasktime tb_tasktime) {
		// TODO Auto-generated method stub
		return tb_tasktimeDao.insert(tb_tasktime)	;
		}*/

	@Override
	public int updateTb_tasktime(Tb_tasktime tb_tasktime) {
		// TODO Auto-generated method stub
		return tb_tasktimeDao.update(tb_tasktime);
	}

	@Override
	public int deleteTb_tasktime(String ids) {
		int num=0;
		String[] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			Tb_tasktime ad=tb_tasktimeDao.getById(Integer.parseInt(id[i]));
			num=num+tb_tasktimeDao.delete(ad);
		}
		return num;
	}

	@Override
	public List<Tb_tasktime> getPage(Tb_tasktime tb_tasktime) {
		// TODO Auto-generated method stub
		return tb_tasktimeDao.getPage(tb_tasktime);
	}

	@Override
	public int getAllCount(Tb_tasktime tb_tasktime) {
		// TODO Auto-generated method stub
		return tb_tasktimeDao.getAllCount(tb_tasktime);
	}

	@Override
	public List<Tb_tasktime> getAll() {
		// TODO Auto-generated method stub
		return tb_tasktimeDao.getAll();
	}

	@Override
	public int insertTb_tasktime(Tb_tasktime tb_tasktime) {
		// TODO Auto-generated method stub
		int s1=tb_tasktimeDao.inserttask1(tb_tasktime);
		int s2=tb_tasktimeDao.inserttask2(tb_tasktime);
		int s3=tb_tasktimeDao.inserttask3(tb_tasktime);
		int s4=tb_tasktimeDao.inserttask4(tb_tasktime);
		return s1*s2*s3*s4;
	}
}
