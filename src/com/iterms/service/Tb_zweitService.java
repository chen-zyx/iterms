package com.iterms.service;

import java.util.List;

import com.iterms.been.Tb_zweit;

public interface Tb_zweitService {

	public Tb_zweit getById(String id); 
	public boolean addckzweitname(String zweitname);
	public boolean updckzweitname(String zweitname,String id);
	public List<Tb_zweit> getPage(Tb_zweit tb_zweit);
	public int getAllCount(Tb_zweit tb_zweit);
	public List<Tb_zweit> getAll();
	
}
