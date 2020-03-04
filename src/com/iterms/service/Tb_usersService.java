package com.iterms.service;
import java.util.List;
import com.iterms.been.Tb_users;
public interface Tb_usersService {
	//根据id获取对象
	public Tb_users getById(String id); 
	//根据添加进行唯一性验证
	public boolean addckUno(String uno);
	//修改进行唯一性验证
	public boolean updckUno(String uno,String id);
	//登录获取对象信息
	public Tb_users login(String uname,String upassword);
	//添加
	public int insertTb_users(Tb_users tb_users);
	//修改
	public int updateTb_users(Tb_users tb_users);
	//删除
	public int deleteTb_users(String ids);
	//分页获取信息链表
	public List<Tb_users> getPage(Tb_users tb_users);
	//获取总条数
	public int getAllCount(Tb_users tb_users);
	//获取所有数据
	public List<Tb_users> getAll();
}
