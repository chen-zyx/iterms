package com.iterms.dao;
import java.util.List;
import com.iterms.been.Tb_users;
import org.apache.ibatis.annotations.Param;
public interface Tb_usersDao {
	//根据id获取对象
	public Tb_users getById(@Param("id")Integer id);
	//添加
	int insert(Tb_users tb_users);
	//修改
	int update(Tb_users tb_users);
	//删除
	int delete(Tb_users tb_users);
	/**
	 * @param 根据条件获取结果
	 * @return
	 */
	public List<Tb_users> getPage(Tb_users tb_users);
	//获取总条数
	public int getAllCount(Tb_users tb_users);
	//获取全部信息
	public List<Tb_users> getAll();
}
