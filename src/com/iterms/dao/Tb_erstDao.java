package com.iterms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.iterms.been.Tb_erst;

public interface Tb_erstDao {
	
	//根据id获取对象
		public Tb_erst getById(@Param("id")Integer id);
		//添加
		//int insert(Tb_erst tb_erst);
		//修改
		//int update(Tb_erst tb_erst);
		//删除
		//int delete(Tb_erst tb_erst);
		/**
		 * @param 根据条件获取结果
		 * @return
		 */
		public List<Tb_erst> getPage(Tb_erst tb_erst);
		//获取总条数
		public int getAllCount(Tb_erst tb_erst);
		//获取全部信息
		public List<Tb_erst> getAll();
}
