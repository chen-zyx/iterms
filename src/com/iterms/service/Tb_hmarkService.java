package com.iterms.service;
import java.util.List;
import com.iterms.been.Tb_hmark;
public interface Tb_hmarkService {
	//根据id获取对象
	public Tb_hmark getById(String id); 
	//添加
	public int insertTb_hmark(Tb_hmark tb_hmark);
	//修改
	public int updateTb_hmark(Tb_hmark tb_hmark);
	//删除
	public int deleteTb_hmark(String ids);
	//分页获取信息链表
	public List<Tb_hmark> getPage(Tb_hmark tb_hmark);
	//获取总条数
	public int getAllCount(Tb_hmark tb_hmark);
	//获取所有数据
	public List<Tb_hmark> getAll();
}
