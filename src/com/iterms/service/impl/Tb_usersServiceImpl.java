package com.iterms.service.impl;
import java.util.Iterator;
import java.util.List;
import com.iterms.dao.Tb_usersDao;
import com.iterms.been.Tb_users;
import com.iterms.service.Tb_usersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class Tb_usersServiceImpl implements Tb_usersService {
	@Autowired
	private Tb_usersDao tb_usersDao;
	@Override
	public Tb_users getById(String id) {
		// TODO Auto-generated method stub
		return tb_usersDao.getById(Integer.parseInt(id));
	}
	@Override
	public boolean addckUno(String uno) {
		// TODO Auto-generated method stub
		Tb_users ad=new Tb_users();
		ad.setUno(uno);
		 List<Tb_users> adlist=tb_usersDao.getPage(ad);
		Iterator<Tb_users> ait=adlist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(uno.equals(ad.getUno())){
				bl=true;
			}
		}
		return bl;
	}
	@Override
	public boolean updckUno(String uno, String id) {
		// TODO Auto-generated method stub
		Tb_users ad=new Tb_users();
		ad.setUno(uno);
		//根据条件获取信息链表
		List<Tb_users> alist=tb_usersDao.getPage(ad);
		//遍历，找到条件相同，id不同的对象，返回true，否则返回false
		Iterator<Tb_users> ait=alist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(uno.equals(ad.getUno())&&!id.equals(String.valueOf(ad.getId()))){
				bl=true;
			}
		}
		return bl;
	}
	@Override
	public Tb_users login(String uno, String upwd) {
		// TODO Auto-generated method stub
		Tb_users ad=new Tb_users();
		ad.setUno(uno);
		ad.setUpwd(upwd);
		List<Tb_users> alist=tb_usersDao.getPage(ad);
		Iterator<Tb_users> it=alist.iterator();
		Tb_users ads=null;
		while(it.hasNext()){
			ad=it.next();
			if(ad.getUno().equals(uno)&&ad.getUpwd().equals(upwd)){
				ads=ad;
			}
		}
		return ads;
	}
	@Override
	public int insertTb_users(Tb_users tb_users) {
		// TODO Auto-generated method stub
		return tb_usersDao.insert(tb_users);
	}
	@Override
	public int updateTb_users(Tb_users tb_users) {
		// TODO Auto-generated method stub
		return tb_usersDao.update(tb_users);
	}
	@Override
	public int deleteTb_users(String ids) {
		// TODO Auto-generated method stub
		int num=0;
		String[] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			Tb_users ad=tb_usersDao.getById(Integer.parseInt(id[i]));
			num=num+tb_usersDao.delete(ad);
		}
		return num;
	}
	@Override
	public List<Tb_users> getPage(Tb_users tb_users){
		// TODO Auto-generated method stub
		return tb_usersDao.getPage(tb_users);
	}
	@Override
	public int getAllCount(Tb_users tb_users) {
		return tb_usersDao.getAllCount(tb_users);
	}
	@Override
	public List<Tb_users> getAll() {
		// TODO Auto-generated method stub
		return tb_usersDao.getPage(new Tb_users());
	}
}
