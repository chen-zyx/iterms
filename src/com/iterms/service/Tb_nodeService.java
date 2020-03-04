package com.iterms.service;
import java.util.List;
import com.iterms.been.Tb_node;
public interface Tb_nodeService {
	//根据id获取对象
	public  Tb_node getById(String id); 
	//根据添加进行唯一性验证
	//public  Tb_node getByitermId(String iterm_id); 
	public boolean addcknodename(String nodename, String tb_iterms_id);
	//修改进行唯一性验证
	public boolean updcknodename(String nodename,String tb_iterms_id,String id);
	//添加
	public int insertTb_node(Tb_node tb_node);
	//修改
	public int updateTb_node(Tb_node tb_node);
	//删除
	public int deleteTb_node(String ids);
	//分页获取信息链表
	public List<Tb_node> getPage(Tb_node tb_node);
	//获取总条数
	public int getAllCount(Tb_node tb_node);
	//获取所有数据
	public List<Tb_node> getAll();
	
	public List<Tb_node> getbyflag();
}