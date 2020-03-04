package com.iterms.dao;
import java.util.List;
import com.iterms.been.Tb_model;
import org.apache.ibatis.annotations.Param;
public interface Tb_modelDao {
	//根据id获取对象
	public Tb_model getById(@Param("id")Integer id);
	//添加
	int insert(Tb_model tb_model);
	//修改
	int update(Tb_model tb_model);
	//删除
	int delete(Tb_model tb_model);
	/**
	 * @param 根据条件获取结果
	 * @return
	 */
	public List<Tb_model> getPage(Tb_model tb_model);
	//获取总条数
	public int getAllCount(Tb_model tb_model);
	//获取全部信息
	public List<Tb_model> getAll();
}
