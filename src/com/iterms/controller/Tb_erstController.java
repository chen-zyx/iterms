package com.iterms.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.iterms.been.Tb_erst;
import com.iterms.service.Tb_erstService;

@Controller
@RequestMapping(value = "/tb_erst")
public class Tb_erstController {

	@Autowired
	Tb_erstService tb_erstService;
	@RequestMapping(value = "/tb_users_init", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_init(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		Tb_erst ad=new Tb_erst();
		session.setAttribute("tb_erst",ad);
		//获取首页数据
		gettb_usersPage(session,ad,"1");
		request.getRequestDispatcher("/views/tb_users/mtb_erst.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_ck", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_ck(Tb_erst tb_erst,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		session.setAttribute("tb_erst",tb_erst);
		//获取首页数据
		gettb_usersPage(session,tb_erst,"1");
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_erst.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_pro", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_pro(Tb_erst tb_erst,Integer nodei,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		session.setAttribute("tb_erst",tb_erst);
		session.setAttribute("nodei",nodei);
		System.out.println(nodei+"");
		//获取首页数据
		gettb_usersPage(session,tb_erst,"1");
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_erst.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_apage", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_apage(String pnum,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		//获取查询条件
		Tb_erst tb_erst=(Tb_erst)session.getAttribute("tb_erst");
		gettb_usersPage(session,tb_erst,pnum);
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_erst.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/getdata", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getdata(String id){
		Tb_erst ad=tb_erstService.getById(id);
		JSONObject json=new JSONObject();
		json.put("ob", ad);
		return json.toString();
	}
	
	public void gettb_usersPage(HttpSession session,Tb_erst tb_erst,String pnum){
		//每页显示的条数
		int scount=10;
		//总条数
		int allcount=tb_erstService.getAllCount(tb_erst);
		int apnum=allcount/scount;
		if(allcount%scount>0){
			apnum++;
		}
		//要显示的页码
		int pnums=Integer.parseInt(pnum);
		if(pnums>apnum){
			pnums=apnum;
		}
		if(pnums<1){
			pnums=1;
		}
		//开始条数
		int sindex=(pnums-1)*10;
		tb_erst.setSindex(sindex);
		tb_erst.setScount(scount);
		List<Tb_erst> alist=tb_erstService.getPage(tb_erst);
		session.setAttribute("alist", alist);
		session.setAttribute("allnums", allcount);
		session.setAttribute("pagenums", apnum);
		session.setAttribute("pagenum", pnums);
	}
	
}
