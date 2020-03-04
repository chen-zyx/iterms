package com.iterms.service.impl;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iterms.dao.Tb_taskDao;
import com.iterms.been.Tb_task;
import com.iterms.service.Tb_taskService;
@Service
public class Tb_taskServiceImpl implements Tb_taskService{

	@Autowired
	private Tb_taskDao tb_taskDao;
	
	@Override
	public Tb_task getById(String id) {
		return tb_taskDao.getById(Integer.parseInt(id));
	}

	@Override
	public Tb_task getBynodeId(String node_id) {
		return tb_taskDao.getBynodeId(Integer.parseInt(node_id));
	}

	@Override
	public boolean addcktaskname(String taskname, String tb_node_id) {
		Tb_task ad=new Tb_task();
		ad.settaskname(taskname);
		 List<Tb_task> adlist=tb_taskDao.getPage(ad);
		Iterator<Tb_task> ait=adlist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(taskname.equals(ad.gettaskname())&&tb_node_id.equals(String.valueOf(ad.getTb_node_id()))){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public boolean updcktaskname(String taskname, String tb_node_id, String id) {
		Tb_task ad=new Tb_task();
		ad.settaskname(taskname);
		//根据条件获取信息链表
		List<Tb_task> alist=tb_taskDao.getPage(ad);
		//遍历，找到条件相同，id不同的对象，返回true，否则返回false
		Iterator<Tb_task> ait=alist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(taskname.equals(ad.gettaskname())&&tb_node_id.equals(String.valueOf(ad.getTb_node_id()))&&!id.equals(String.valueOf(ad.getId()))){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public int insertTb_task(Tb_task tb_task) {
		return tb_taskDao.insert(tb_task);
	}

	@Override
	public int updateTb_task(Tb_task tb_task) {
		return tb_taskDao.update(tb_task);
	}

	@Override
	public int deleteTb_task(String ids) {
		int num=0;
		String[] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			Tb_task ad=tb_taskDao.getById(Integer.parseInt(id[i]));
			num=num+tb_taskDao.delete(ad);
		}
		return num;
	}

	@Override
	public List<Tb_task> getPage(Tb_task tb_task) {
		return tb_taskDao.getPage(tb_task);
	}

	@Override
	public int getAllCount(Tb_task tb_task) {
		return tb_taskDao.getAllCount(tb_task);
	}

	@Override
	public List<Tb_task> getAll() {
		return tb_taskDao.getPage(new Tb_task());
	}

	
	@Override
	public int updateTb_tasktable(Tb_task tb_task,int i) {
		// TODO Auto-generated method stub
		int ii=0;
		switch(i) {
		case 0:
			ii= tb_taskDao.updateaku(tb_task);
			break;
		case 1:
			ii= tb_taskDao.updatebau(tb_task);
			break;
		case 2:
			ii= tb_taskDao.updatelas(tb_task);
			break;
		case 3:
			ii= tb_taskDao.updateboden(tb_task);
			break;
		case 4:
			ii= tb_taskDao.updatewas(tb_task);
			break;
		case 5:
			ii= tb_taskDao.updatekaro(tb_task);
			break;
		case 6:
			ii= tb_taskDao.updatekla(tb_task);
			break;
		case 7:
			ii= tb_taskDao.updateips(tb_task);
			break;
		}
		return ii;
	}

	

}
