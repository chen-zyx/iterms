package com.iterms.dao;
import java.util.List;
import com.iterms.been.Tb_node;
import org.apache.ibatis.annotations.Param;
public interface Tb_nodeDao {
	//根据id获取对象
	public Tb_node getById(@Param("id")Integer id);
	public Tb_node getByProject(@Param("project")String iterm_id);
	
	public List<Tb_node> getByflag();
	//添加
	int insert(Tb_node tb_node);
	//修改
	int update(Tb_node tb_node);
	//删除
	int delete(Tb_node tb_node);
	/**
	 * @param 根据条件获取结果
	 * @return
	 */
	public List<Tb_node> getPage(Tb_node tb_node);
	//获取总条数
	public int getAllCount(Tb_node tb_node);
	//获取全部信息
	public List<Tb_node> getAll();
}
