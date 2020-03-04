package com.iterms.service;

import java.util.List;

import com.iterms.been.Tb_ips;

public interface Tb_ipsService {

	public Tb_ips getById(String id); 
	//添加
	public int insertTb_ips(Tb_ips tb_ips);
	//修改
	public int updateTb_ips(Tb_ips tb_ips);
	//删除
	public int deleteTb_ips(String ids);
	//分页获取信息链表
	public List<Tb_ips> getPage(Tb_ips tb_ips);
	//获取总条数
	public int getAllCount(Tb_ips tb_ips);
	//获取所有数据
	public List<Tb_ips> getAll();
	public boolean addckipsname(String getipstime, String tb_node_id);
	public boolean updckipstime(String getipstime, String string, String string2);
}
