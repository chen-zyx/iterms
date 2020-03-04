package com.iterms.service.impl;
import java.util.Iterator;
import java.util.List;
import com.iterms.dao.Tb_modelDao;
import com.iterms.been.Tb_model;
import com.iterms.service.Tb_modelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class Tb_modelServiceImpl implements Tb_modelService {
	@Autowired
	private Tb_modelDao tb_modelDao;
	@Override
	public Tb_model getById(String id) {
		// TODO Auto-generated method stub
		return tb_modelDao.getById(Integer.parseInt(id));
	}
	@Override
	public int insertTb_model(Tb_model tb_model) {
		// TODO Auto-generated method stub
		return tb_modelDao.insert(tb_model);
	}
	@Override
	public int updateTb_model(Tb_model tb_model) {
		// TODO Auto-generated method stub
		return tb_modelDao.update(tb_model);
	}
	@Override
	public int deleteTb_model(String ids) {
		// TODO Auto-generated method stub
		int num=0;
		String[] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			Tb_model ad=tb_modelDao.getById(Integer.parseInt(id[i]));
			num=num+tb_modelDao.delete(ad);
		}
		return num;
	}
	@Override
	public List<Tb_model> getPage(Tb_model tb_model){
		// TODO Auto-generated method stub
		return tb_modelDao.getPage(tb_model);
	}
	@Override
	public int getAllCount(Tb_model tb_model) {
		return tb_modelDao.getAllCount(tb_model);
	}
	@Override
	public List<Tb_model> getAll() {
		// TODO Auto-generated method stub
		return tb_modelDao.getPage(new Tb_model());
	}
}
