package com.iterms.dao;
import java.util.List;
import com.iterms.been.Tb_hmark;
import org.apache.ibatis.annotations.Param;
public interface Tb_hmarkDao {
	//根据id获取对象
	public Tb_hmark getById(@Param("id")Integer id);
	//添加
	int insert(Tb_hmark tb_hmark);
	//修改
	int update(Tb_hmark tb_hmark);
	//删除
	int delete(Tb_hmark tb_hmark);
	/**
	 * @param 根据条件获取结果
	 * @return
	 */
	public List<Tb_hmark> getPage(Tb_hmark tb_hmark);
	//获取总条数
	public int getAllCount(Tb_hmark tb_hmark);
	//获取全部信息
	public List<Tb_hmark> getAll();
}
