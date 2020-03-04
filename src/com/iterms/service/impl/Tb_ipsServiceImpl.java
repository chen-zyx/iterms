package com.iterms.service.impl;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iterms.been.Tb_ips;
import com.iterms.been.Tb_node;
import com.iterms.dao.Tb_ipsDao;
import com.iterms.service.Tb_ipsService;

@Service
public class Tb_ipsServiceImpl implements Tb_ipsService {

	@Autowired
	private Tb_ipsDao tb_ipsDao;
	@Override
	public Tb_ips getById(String id) {
		// TODO Auto-generated method stub
		return tb_ipsDao.getById(Integer.parseInt(id));
	}

	@Override
	public int insertTb_ips(Tb_ips tb_ips) {
		// TODO Auto-generated method stub
		return tb_ipsDao.insert(tb_ips);
	}

	@Override
	public int updateTb_ips(Tb_ips tb_ips) {
		// TODO Auto-generated method stub
		return tb_ipsDao.update(tb_ips);
	}

	@Override
	public int deleteTb_ips(String ids) {
		int num=0;
		String[] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			Tb_ips ad=tb_ipsDao.getById(Integer.parseInt(id[i]));
			num=num+tb_ipsDao.delete(ad);
		}
		return num;
	}

	@Override
	public List<Tb_ips> getPage(Tb_ips tb_ips) {
		// TODO Auto-generated method stub
		return tb_ipsDao.getPage(tb_ips);
	}

	@Override
	public int getAllCount(Tb_ips tb_ips) {
		// TODO Auto-generated method stub
		return tb_ipsDao.getAllCount(tb_ips);
	}

	@Override
	public List<Tb_ips> getAll() {
		// TODO Auto-generated method stub
		return tb_ipsDao.getPage(new Tb_ips());
	}

	@Override
	public boolean addckipsname(String getipstime,String tb_task_id) {
		Tb_ips ad=new Tb_ips();
		ad.setipstime(getipstime);
		 List<Tb_ips> adlist=tb_ipsDao.getPage(ad);
		Iterator<Tb_ips> ait=adlist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(getipstime.equals(ad.getipstime())&&tb_task_id.equals(String.valueOf(ad.getTb_task_id()))){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public boolean updckipstime(String getipstime, String tb_task_id, String id) {
		Tb_ips ad=new Tb_ips();
		ad.setipstime(getipstime);
		//根据条件获取信息链表
		List<Tb_ips> alist=tb_ipsDao.getPage(ad);
		//遍历，找到条件相同，id不同的对象，返回true，否则返回false
		Iterator<Tb_ips> ait=alist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(getipstime.equals(ad.getipstime())&&tb_task_id.equals(String.valueOf(ad.getTb_task_id()))&&!id.equals(String.valueOf(ad.getId()))){
				bl=true;
			}
		}
		return bl;
	}

}
