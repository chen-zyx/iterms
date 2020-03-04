package com.iterms.dao;
import java.util.List;
import com.iterms.been.Tb_iterms;
import org.apache.ibatis.annotations.Param;
public interface Tb_itermsDao {
	//根据id获取对象
	public Tb_iterms getById(@Param("id")Integer id);
	//添加
	int insert(Tb_iterms tb_iterms);
	//修改
	int update(Tb_iterms tb_iterms);
	//删除
	int delete(Tb_iterms tb_iterms);
	/**
	 * @param 根据条件获取结果
	 * @return
	 */
	public List<Tb_iterms> getPage(Tb_iterms tb_iterms);
	//获取总条数
	public int getAllCount(Tb_iterms tb_iterms);
	//获取全部信息
	public List<Tb_iterms> getAll();
}
