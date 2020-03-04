package com.iterms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.iterms.been.Tb_content;

public interface Tb_contentDao {
	
	//根据id获取对象
		public Tb_content getById(@Param("id")Integer id);
		//添加
		int insert(Tb_content tb_content);
		
		//删除
		int delete(Tb_content tb_content);
		/**
		 * @param 根据条件获取结果
		 * @return
		 */
		public List<Tb_content> getPage(Tb_content tb_content);
		//获取总条数
		public int getAllCount(Tb_content tb_content);
		//获取全部信息
		public List<Tb_content> getAll();

}
