package com.iterms.service.impl;
import java.util.Iterator;
import java.util.List;
import com.iterms.dao.Tb_itermsDao;
import com.iterms.been.Tb_iterms;
import com.iterms.service.Tb_itermsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class Tb_itermsServiceImpl implements Tb_itermsService {
	@Autowired
	private Tb_itermsDao tb_itermsDao;
	@Override
	public Tb_iterms getById(String id) {
		// TODO Auto-generated method stub
		return tb_itermsDao.getById(Integer.parseInt(id));
	}
	@Override
	public boolean addckItname(String itname) {
		// TODO Auto-generated method stub
		Tb_iterms ad=new Tb_iterms();
		ad.setItname(itname);
		 List<Tb_iterms> adlist=tb_itermsDao.getPage(ad);
		Iterator<Tb_iterms> ait=adlist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(itname.equals(ad.getItname())){
				bl=true;
			}
		}
		return bl;
	}
	@Override
	public boolean updckItname(String itname, String id) {
		// TODO Auto-generated method stub
		Tb_iterms ad=new Tb_iterms();
		ad.setItname(itname);
		//根据条件获取信息链表
		List<Tb_iterms> alist=tb_itermsDao.getPage(ad);
		//遍历，找到条件相同，id不同的对象，返回true，否则返回false
		Iterator<Tb_iterms> ait=alist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(itname.equals(ad.getItname())&&!id.equals(String.valueOf(ad.getId()))){
				bl=true;
			}
		}
		return bl;
	}
	@Override
	public int insertTb_iterms(Tb_iterms tb_iterms) {
		// TODO Auto-generated method stub
		return tb_itermsDao.insert(tb_iterms);
	}
	@Override
	public int updateTb_iterms(Tb_iterms tb_iterms) {
		// TODO Auto-generated method stub
		return tb_itermsDao.update(tb_iterms);
	}
	@Override
	public int deleteTb_iterms(String ids) {
		// TODO Auto-generated method stub
		int num=0;
		String[] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			Tb_iterms ad=tb_itermsDao.getById(Integer.parseInt(id[i]));
			num=num+tb_itermsDao.delete(ad);
		}
		return num;
	}
	@Override
	public List<Tb_iterms> getPage(Tb_iterms tb_iterms){
		// TODO Auto-generated method stub
		return tb_itermsDao.getPage(tb_iterms);
	}
	@Override
	public int getAllCount(Tb_iterms tb_iterms) {
		return tb_itermsDao.getAllCount(tb_iterms);
	}
	@Override
	public List<Tb_iterms> getAll() {
		// TODO Auto-generated method stub
		return tb_itermsDao.getPage(new Tb_iterms());
	}
}
