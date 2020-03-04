package com.iterms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.iterms.been.Tb_ips;

public interface Tb_ipsDao {

	public Tb_ips getById(@Param("id")Integer id);

	int update(Tb_ips tb_ips);

	int insert(Tb_ips tb_ips);

	public List<Tb_ips> getPage(Tb_ips tb_ips);

	public int getAllCount(Tb_ips tb_ips);
	
	public List<Tb_ips> getAll();

	int delete(Tb_ips tb_ips);

}
