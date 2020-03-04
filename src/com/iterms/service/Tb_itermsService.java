package com.iterms.service;
import java.util.List;
import com.iterms.been.Tb_iterms;
public interface Tb_itermsService {
	//根据id获取对象
	public Tb_iterms getById(String id); 
	//根据添加进行唯一性验证
	public boolean addckItname(String itname);
	//修改进行唯一性验证
	public boolean updckItname(String itname,String id);
	//添加
	public int insertTb_iterms(Tb_iterms tb_iterms);
	//修改
	public int updateTb_iterms(Tb_iterms tb_iterms);
	//删除
	public int deleteTb_iterms(String ids);
	//分页获取信息链表
	public List<Tb_iterms> getPage(Tb_iterms tb_iterms);
	//获取总条数
	public int getAllCount(Tb_iterms tb_iterms);
	//获取所有数据
	public List<Tb_iterms> getAll();
}
