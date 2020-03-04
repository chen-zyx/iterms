package com.iterms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iterms.been.Tb_message;
import com.iterms.dao.Tb_messageDao;
import com.iterms.service.Tb_messageService;
import com.iterms.utils.PageModel;
@Service
public class Tb_messageServiceImpl implements Tb_messageService {
	@Autowired
	private Tb_messageDao tb_messageDao;
	
	@Override
	public Integer insert(Tb_message tb_message) {
		// TODO Auto-generated method stub
		return tb_messageDao.insert(tb_message);
	}

	@Override
	public Integer update(Tb_message tb_message) {
		// TODO Auto-generated method stub
		return tb_messageDao.update(tb_message);
	}

	@Override
	public Integer getCount(Tb_message tb_message) {
		// TODO Auto-generated method stub
		return tb_messageDao.getCount(tb_message);
	}

	@Override
	public PageModel<Tb_message> getMessages(Tb_message tb_message,PageModel<Tb_message> pm) {
		// TODO Auto-generated method stub
		pm.setStartIndex(pm.getCurrentPage(), pm.getPageSize());
		List<Tb_message> messages = tb_messageDao.getMessages(tb_message, pm);
		pm.setResultList(messages);
		pm.setTotal(tb_messageDao.getCount(tb_message));
		Integer pageCount=pm.getTotal()/pm.getPageSize();
		if(pm.getTotal()%pm.getPageSize()>0) {
			pageCount++;
		}
		pm.setPageCount(pageCount);
		return pm;
	}

	@Override
	public Tb_message findById(Integer id) {
		// TODO Auto-generated method stub
		return tb_messageDao.findById(id);
	}

}
