package com.iterms.service.impl;
import java.util.Iterator;
import java.util.List;
import com.iterms.dao.Tb_hmarkDao;
import com.iterms.been.Tb_hmark;
import com.iterms.service.Tb_hmarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class Tb_hmarkServiceImpl implements Tb_hmarkService {
	@Autowired
	private Tb_hmarkDao tb_hmarkDao;
	@Override
	public Tb_hmark getById(String id) {
		// TODO Auto-generated method stub
		return tb_hmarkDao.getById(Integer.parseInt(id));
	}
	@Override
	public int insertTb_hmark(Tb_hmark tb_hmark) {
		// TODO Auto-generated method stub
		return tb_hmarkDao.insert(tb_hmark);
	}
	@Override
	public int updateTb_hmark(Tb_hmark tb_hmark) {
		// TODO Auto-generated method stub
		return tb_hmarkDao.update(tb_hmark);
	}
	@Override
	public int deleteTb_hmark(String ids) {
		// TODO Auto-generated method stub
		int num=0;
		String[] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			Tb_hmark ad=tb_hmarkDao.getById(Integer.parseInt(id[i]));
			num=num+tb_hmarkDao.delete(ad);
		}
		return num;
	}
	@Override
	public List<Tb_hmark> getPage(Tb_hmark tb_hmark){
		// TODO Auto-generated method stub
		return tb_hmarkDao.getPage(tb_hmark);
	}
	@Override
	public int getAllCount(Tb_hmark tb_hmark) {
		return tb_hmarkDao.getAllCount(tb_hmark);
	}
	@Override
	public List<Tb_hmark> getAll() {
		// TODO Auto-generated method stub
		return tb_hmarkDao.getPage(new Tb_hmark());
	}
}
