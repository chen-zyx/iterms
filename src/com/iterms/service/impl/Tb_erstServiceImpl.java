package com.iterms.service.impl;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iterms.been.Tb_erst;
import com.iterms.dao.Tb_erstDao;
import com.iterms.service.Tb_erstService;

@Service
public class Tb_erstServiceImpl implements Tb_erstService {

	@Autowired
	private Tb_erstDao tb_erstDao;
	@Override
	public Tb_erst getById(String id) {
		// TODO Auto-generated method stub
		return tb_erstDao.getById(Integer.parseInt(id));
	}

	@Override
	public boolean addckerstname(String erstname) {
		Tb_erst ad=new Tb_erst();
		ad.seterstname(erstname);
		 List<Tb_erst> adlist=tb_erstDao.getPage(ad);
		Iterator<Tb_erst> ait=adlist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(erstname.equals(ad.geterstname())){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public boolean updckerstname(String erstname, String id) {
		Tb_erst ad=new Tb_erst();
		ad.seterstname(erstname);
		//根据条件获取信息链表
		List<Tb_erst> alist=tb_erstDao.getPage(ad);
		//遍历，找到条件相同，id不同的对象，返回true，否则返回false
		Iterator<Tb_erst> ait=alist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(erstname.equals(ad.geterstname())&&!id.equals(String.valueOf(ad.getId()))){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public List<Tb_erst> getPage(Tb_erst tb_erst) {
		// TODO Auto-generated method stub
		return tb_erstDao.getPage(tb_erst);
	}

	@Override
	public int getAllCount(Tb_erst tb_erst) {
		// TODO Auto-generated method stub
		return tb_erstDao.getAllCount(tb_erst);
	}

	@Override
	public List<Tb_erst> getAll() {
		// TODO Auto-generated method stub
		return tb_erstDao.getPage(new Tb_erst());
	}

}
