package com.iterms.service.impl;
import java.util.Iterator;
import java.util.List;
import com.iterms.dao.Tb_nodeDao;
import com.iterms.been.Tb_node;
import com.iterms.service.Tb_nodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class Tb_nodeServiceImpl implements Tb_nodeService {

	@Autowired
	private Tb_nodeDao tb_nodeDao;
	
	@Override
	public Tb_node getById(String id) {
		// TODO Auto-generated method stub
		return tb_nodeDao.getById(Integer.parseInt(id));
	}

	@Override
	public boolean addcknodename(String noname, String project) {
		// TODO Auto-generated method stub
		Tb_node ad=new Tb_node();
		ad.setname(noname);
		 List<Tb_node> adlist=tb_nodeDao.getPage(ad);
		Iterator<Tb_node> ait=adlist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(noname.equals(ad.getname())&&project.contentEquals(ad.getProject())){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public boolean updcknodename(String noname, String project,String id) {
		// TODO Auto-generated method stub
		Tb_node ad=new Tb_node();
		ad.setname(noname);
		//根据条件获取信息链表
		List<Tb_node> alist=tb_nodeDao.getPage(ad);
		//遍历，找到条件相同，id不同的对象，返回true，否则返回false
		Iterator<Tb_node> ait=alist.iterator();
		boolean bl=false;
		while(ait.hasNext()){
			 ad=ait.next();
			if(noname.equals(ad.getname())&&project.contentEquals(ad.getProject())&&!id.equals(String.valueOf(ad.getId()))){
				bl=true;
			}
		}
		return bl;
	}

	@Override
	public int insertTb_node(Tb_node tb_node) {
		// TODO Auto-generated method stub
		return tb_nodeDao.insert(tb_node);
	}

	@Override
	public int updateTb_node(Tb_node tb_node) {
		// TODO Auto-generated method stub
		return tb_nodeDao.update(tb_node);
	}

	@Override
	public int deleteTb_node(String ids) {
		// TODO Auto-generated method stub
		int num=0;
		String[] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			Tb_node ad=tb_nodeDao.getById(Integer.parseInt(id[i]));
			num=num+tb_nodeDao.delete(ad);
		}
		return num;
	}

	@Override
	public List<Tb_node> getPage(Tb_node tb_node) {
		// TODO Auto-generated method stub
		return tb_nodeDao.getPage(tb_node);
	}

	@Override
	public int getAllCount(Tb_node tb_node) {
		// TODO Auto-generated method stub
		return tb_nodeDao.getAllCount(tb_node);
	}

	@Override
	public List<Tb_node> getAll() {
		// TODO Auto-generated method stub
		return tb_nodeDao.getPage(new Tb_node());
	}

	@Override
	public List<Tb_node> getbyflag() {
		// TODO Auto-generated method stub
		return tb_nodeDao.getByflag();
	}

	/*@Override
	public Tb_node getByitermId(String iterm_id) {
		// TODO Auto-generated method stub
		return tb_nodeDao.getByitermId(Integer.parseInt(iterm_id));
	}*/

}
