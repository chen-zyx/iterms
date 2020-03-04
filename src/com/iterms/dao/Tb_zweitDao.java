package com.iterms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.iterms.been.Tb_zweit;

public interface Tb_zweitDao {
	public Tb_zweit getById(@Param("id")Integer id);
	public List<Tb_zweit> getPage(Tb_zweit tb_zweit);
	public int getAllCount(Tb_zweit tb_zweit);
	public List<Tb_zweit> getAll();

}
