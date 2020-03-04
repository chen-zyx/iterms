package com.iterms.service.impl;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iterms.been.Tb_content;
import com.iterms.been.Tb_iterms;
import com.iterms.dao.Tb_contentDao;
import com.iterms.service.Tb_contentService;

@Service
public class Tb_contentServiceImpl implements Tb_contentService {
	@Autowired
	private Tb_contentDao tb_contentDao;

	@Override
	public Tb_content getById(String id) {
		// TODO Auto-generated method stub
		return tb_contentDao.getById(Integer.parseInt(id));
	}

	@Override
	public boolean addckcname(String cname) {
		Tb_content ad=new Tb_content();
		ad.setcname(cname);
		 List<Tb_content> adlist=tb_contentDao.getPage(ad);
		Iterator<Tb_content> ait=adlist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(cname.equals(ad.getcname())){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public boolean updckcname(String cname, String id) {
		Tb_content ad=new Tb_content();
		ad.setcname(cname);
		//根据条件获取信息链表
		List<Tb_content> alist=tb_contentDao.getPage(ad);
		//遍历，找到条件相同，id不同的对象，返回true，否则返回false
		Iterator<Tb_content> ait=alist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(cname.equals(ad.getcname())&&!id.equals(String.valueOf(ad.getId()))){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public int insertTb_content(Tb_content tb_content) {
		// TODO Auto-generated method stub
		return tb_contentDao.insert(tb_content);
	}

	

	@Override
	public int deleteTb_content(String ids) {
		int num=0;
		String[] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			Tb_content ad=tb_contentDao.getById(Integer.parseInt(id[i]));
			num=num+tb_contentDao.delete(ad);
		}
		return num;
	}

	@Override
	public List<Tb_content> getPage(Tb_content tb_content) {
		// TODO Auto-generated method stub
		return tb_contentDao.getPage(tb_content);
	}

	@Override
	public int getAllCount(Tb_content tb_content) {
		return tb_contentDao.getAllCount(tb_content);
	}

	@Override
	public List<Tb_content> getAll() {
		
		return tb_contentDao.getPage(new Tb_content());
	}

}
