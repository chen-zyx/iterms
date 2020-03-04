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

import com.iterms.service.Tb_taskService;
import com.iterms.service.Tb_tasktimeService;
import com.alibaba.fastjson.JSONObject;
import com.iterms.been.Tb_iterms;
import com.iterms.been.Tb_node;
import com.iterms.been.Tb_task;
import com.iterms.been.Tb_tasktime;
import com.iterms.service.Tb_itermsService;
import com.iterms.service.Tb_nodeService;

@Controller
@RequestMapping(value = "/tb_task")
public class Tb_taskController {
	
	@Autowired
	Tb_nodeService tb_nodeService;
	@Autowired
	Tb_taskService tb_taskService;
	@Autowired
	Tb_tasktimeService tb_tasktimeService;

	@Autowired
	Tb_itermsService tb_itermsService;

	@RequestMapping(value = "/tb_users_init", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_init(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session

		Tb_task ad=new Tb_task();
		session.setAttribute("tb_task",ad);
		//获取首页数据
		gettb_usersPage(session,ad,"1");
		request.getRequestDispatcher("/views/tb_users/mtb_task.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_ck", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_ck(Tb_task tb_task,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		session.setAttribute("tb_task",tb_task);
		//获取首页数据
		gettb_usersPage(session,tb_task,"1");
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_task.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_pro", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_pro(Integer nodei, Tb_task tb_task,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		session.setAttribute("tb_task",tb_task);
		session.setAttribute("nodei",nodei);
		System.out.println(nodei+"");
		//获取首页数据
		gettb_usersPage(session,tb_task,"1");
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_task.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_apage", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_apage(String pnum,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		//获取查询条件
		Tb_task tb_task=(Tb_task)session.getAttribute("tb_task");
		gettb_usersPage(session,tb_task,pnum);
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_task.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_add", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_add(Tb_task tb_task,HttpServletRequest request, Tb_tasktime tb_tasktime){
		String s=null;
		if(tb_taskService.addcktaskname(tb_task.gettaskname(),tb_task.getTb_node_id()+"")){
			s= "{\"msg\":\"仿真任务已存在\"}";
		}else{
			char ss=tb_task.gettaskflag();
			switch(ss) {
			case '0':
				if(tb_taskService.insertTb_task(tb_task)>0) {
					tb_task.setaku(tb_task.getId());
					tb_task.setakusitu(tb_task.getsitu());
					tb_task.setsimuflag(true);
					if(tb_taskService.updateTb_tasktable(tb_task,0)>0) {
							s= "{\"msg\":\"添加成功\"}";
						}else{
							s= "{\"msg\":\"添加失败\"}";
				}}else{
					s= "{\"msg\":\"添加失败\"}";
				}
				break;
			case '1':
				if(tb_taskService.insertTb_task(tb_task)>0) {
					tb_task.setbau(tb_task.getId());
					tb_task.setbausitu(tb_task.getsitu());
					tb_task.setsimuflag(true);
					if(tb_taskService.updateTb_tasktable(tb_task,1)>0) {
							s= "{\"msg\":\"添加成功\"}";
						}else{
							s= "{\"msg\":\"添加失败\"}";
				}}else{
					s= "{\"msg\":\"添加失败\"}";
				}
				break;
			case '2':
				if(tb_taskService.insertTb_task(tb_task)>0) {
					tb_task.setlas(tb_task.getId());
					tb_task.setlassitu(tb_task.getsitu());
					tb_task.setsimuflag(true);
					if(tb_taskService.updateTb_tasktable(tb_task,2)>0) {
							s= "{\"msg\":\"添加成功\"}";
						}else{
							s= "{\"msg\":\"添加失败\"}";
				}}else{
					s= "{\"msg\":\"添加失败\"}";
				}
				break;
			case '3':
				if(tb_taskService.insertTb_task(tb_task)>0) {
					tb_task.setboden(tb_task.getId());
					tb_task.setbodensitu(tb_task.getsitu());
					tb_task.setsimuflag(true);
					if(tb_taskService.updateTb_tasktable(tb_task,3)>0) {
							s= "{\"msg\":\"添加成功\"}";
						}else{
							s= "{\"msg\":\"添加失败\"}";
				}}else{
					s= "{\"msg\":\"添加失败\"}";
				}
				break;
			case '4':
				if(tb_taskService.insertTb_task(tb_task)>0) {
					tb_task.setwas(tb_task.getId());
					tb_task.setwassitu(tb_task.getsitu());
					tb_task.setsimuflag(true);
					if(tb_taskService.updateTb_tasktable(tb_task,4)>0) {
							s= "{\"msg\":\"添加成功\"}";
						}else{
							s= "{\"msg\":\"添加失败\"}";
				}}else{
					s= "{\"msg\":\"添加失败\"}";
				}
				break;
			case '5':
				if(tb_taskService.insertTb_task(tb_task)>0) {
					tb_task.setkaro(tb_task.getId());
					tb_task.setkarositu(tb_task.getsitu());
					tb_task.setsimuflag(true);
					if(tb_taskService.updateTb_tasktable(tb_task,5)>0) {
							s= "{\"msg\":\"添加成功\"}";
						}else{
							s= "{\"msg\":\"添加失败\"}";
				}}else{
					s= "{\"msg\":\"添加失败\"}";
				}
				break;
			case '6':
				if(tb_taskService.insertTb_task(tb_task)>0) {
					tb_task.setkla(tb_task.getId());
					tb_task.setklasitu(tb_task.getsitu());
					tb_task.setsimuflag(true);
					if(tb_taskService.updateTb_tasktable(tb_task,6)>0) {
							s= "{\"msg\":\"添加成功\"}";
						}else{
							s= "{\"msg\":\"添加失败\"}";
				}}else{
					s= "{\"msg\":\"添加失败\"}";
				}
				break;
			case '7':
				if(tb_taskService.insertTb_task(tb_task)>0) {
					tb_task.setips(tb_task.getId());
					tb_task.setipssitu(tb_task.getsitu());
					tb_task.setsimuflag(true);
					if(tb_taskService.updateTb_tasktable(tb_task,7)>0) {
							s= "{\"msg\":\"添加成功\"}";
						}else{
							s= "{\"msg\":\"添加失败\"}";
				}}else{
					s= "{\"msg\":\"添加失败\"}";
				}
				break;
		}
			//tb_task.settb_task_id(tb_task.getId());
			tb_tasktime.setTb_task_id(tb_task.getId());
			tb_tasktime.setTb_node_id(tb_task.getTb_node_id());
			tb_tasktime.setcalcuv1("calcuv1");
			tb_tasktime.setcalcuv2("calcuv2");
			tb_tasktime.setpreprocess("preprocess");
			tb_tasktime.setreport("report");
			if(tb_tasktimeService.insertTb_tasktime(tb_tasktime)>0) {
				s= "{\"msg\":\"添加成功\"}";
			}else{
				s= "{\"msg\":\"添加失败2\"}";
	}}
		return s;
	}
	
	@RequestMapping(value = "/tb_users_upd", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_upd(Tb_task tb_task,HttpServletRequest request){
		if(tb_taskService.updcktaskname(tb_task.gettaskname(),tb_task.getTb_node_id()+"",tb_task.getId()+"")){
			return "{\"msg\":\"项目名称已存在\"}";
		}else{
			if(tb_taskService.updateTb_task(tb_task)>0){
				return "{\"msg\":\"修改成功\"}";
			}else{
				return "{\"msg\":\"修改失败\"}";
			}
		}
	}
	
	@RequestMapping(value = "/del", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String del(String ids){
		if(ids.endsWith(",")){
			ids=ids.substring(0, ids.lastIndexOf(","));
		}
		if(tb_taskService.deleteTb_task(ids)>0){
			return "{\"msg\":\"删除成功\"}";
		}else{
			return "{\"msg\":\"删除失败\"}";
		}
	}
	
	@RequestMapping(value = "/getdata", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getdata(String id){
		Tb_task ad=tb_taskService.getById(id);
		//System.out.println(ad.getsitu());
		JSONObject json=new JSONObject();
		json.put("ob", ad);
		return json.toString();
	}
	
	
	public void gettb_usersPage(HttpSession session,Tb_task tb_task,String pnum){
		//每页显示的条数
		int scount=10;
		//总条数
		int allcount=tb_taskService.getAllCount(tb_task);
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
		tb_task.setSindex(sindex);
		tb_task.setScount(scount);
		List<Tb_task> alist=tb_taskService.getPage(tb_task);
		session.setAttribute("alist", alist);
		List<Tb_node> tb_nodelist=tb_nodeService.getAll();
		session.setAttribute("tb_nodelist", tb_nodelist);
		List<Tb_iterms> tb_itermslist=tb_itermsService.getAll();
		session.setAttribute("tb_itermslist", tb_itermslist);
		session.setAttribute("allnums", allcount);
		session.setAttribute("pagenums", apnum);
		session.setAttribute("pagenum", pnums);
	}	
}
