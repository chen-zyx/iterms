package com.iterms.service.impl;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iterms.been.Tb_zweit;
import com.iterms.dao.Tb_zweitDao;
import com.iterms.service.Tb_zweitService;
@Service
public class Tb_zweitServiceImpl implements Tb_zweitService {

	@Autowired
	private Tb_zweitDao tb_zweitDao;
	
	@Override
	public Tb_zweit getById(String id) {
		return tb_zweitDao.getById(Integer.parseInt(id));
	}

	@Override
	public boolean addckzweitname(String zweitname) {
		Tb_zweit ad=new Tb_zweit();
		ad.setzweitname(zweitname);
		 List<Tb_zweit> adlist=tb_zweitDao.getPage(ad);
		Iterator<Tb_zweit> ait=adlist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(zweitname.equals(ad.getzweitname())){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public boolean updckzweitname(String zweitname, String id) {
		Tb_zweit ad=new Tb_zweit();
		ad.setzweitname(zweitname);
		//根据条件获取信息链表
		List<Tb_zweit> alist=tb_zweitDao.getPage(ad);
		//遍历，找到条件相同，id不同的对象，返回true，否则返回false
		Iterator<Tb_zweit> ait=alist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(zweitname.equals(ad.getzweitname())&&!id.equals(String.valueOf(ad.getId()))){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public List<Tb_zweit> getPage(Tb_zweit tb_zweit) {
		return tb_zweitDao.getPage(tb_zweit);
	}

	@Override
	public int getAllCount(Tb_zweit tb_zweit) {
		return tb_zweitDao.getAllCount(tb_zweit);
	}

	@Override
	public List<Tb_zweit> getAll() {
		return tb_zweitDao.getPage(new Tb_zweit());
	}

}
