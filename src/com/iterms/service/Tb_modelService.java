package com.iterms.service;
import java.util.List;
import com.iterms.been.Tb_model;
public interface Tb_modelService {
	//根据id获取对象
	public Tb_model getById(String id); 
	//添加
	public int insertTb_model(Tb_model tb_model);
	//修改
	public int updateTb_model(Tb_model tb_model);
	//删除
	public int deleteTb_model(String ids);
	//分页获取信息链表
	public List<Tb_model> getPage(Tb_model tb_model);
	//获取总条数
	public int getAllCount(Tb_model tb_model);
	//获取所有数据
	public List<Tb_model> getAll();
}
