package com.iterms.controller;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.iterms.been.Tb_users;
import com.iterms.service.Tb_usersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONObject;
@Controller
@RequestMapping(value = "/tb_users")
public class Tb_usersController {
	@Autowired
	Tb_usersService tb_usersService;
	@RequestMapping(value = "/tb_users_init", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_init(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		Tb_users ad=new Tb_users();
		session.setAttribute("tb_users",ad);
		//获取首页数据
		gettb_usersPage(session,ad,"1");
		request.getRequestDispatcher("/views/tb_users/mtb_users.jsp").forward(request, response);
	}
	@RequestMapping(value = "/tb_users_ck", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_ck(Tb_users tb_users,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		session.setAttribute("tb_users",tb_users);
		//获取首页数据
		gettb_usersPage(session,tb_users,"1");
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_users.jsp").forward(request, response);
	}
	@RequestMapping(value = "/tb_users_apage", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_apage(String pnum,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		//获取查询条件
		Tb_users tb_users=(Tb_users)session.getAttribute("tb_users");
		gettb_usersPage(session,tb_users,pnum);
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_users.jsp").forward(request, response);
	}
	@RequestMapping(value = "/tb_users_add", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_add(Tb_users tb_users,HttpServletRequest request){
		if(tb_usersService.addckUno(tb_users.getUno())){
			return "{\"msg\":\"工号已存在\"}";
		}else{
			if(tb_usersService.insertTb_users(tb_users)>0){
				return "{\"msg\":\"添加成功\"}";
			}else{
				return "{\"msg\":\"添加失败\"}";
			}
		}
	}
	@RequestMapping(value = "/tb_users_upd", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_upd(Tb_users tb_users,HttpServletRequest request){
		if(tb_usersService.updckUno(tb_users.getUno(),tb_users.getId()+"")){
			return "{\"msg\":\"工号已存在\"}";
		}else{
			if(tb_usersService.updateTb_users(tb_users)>0){
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
		if(tb_usersService.deleteTb_users(ids)>0){
			return "{\"msg\":\"删除成功\"}";
		}else{
			return "{\"msg\":\"删除失败\"}";
		}
	}
	@RequestMapping(value = "/getdata", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getdata(String id){
		Tb_users ad=tb_usersService.getById(id);
		JSONObject json=new JSONObject();
		json.put("ob", ad);
		return json.toString();
	}
	/**
	 * @param request
	 * @param 条件
	 * @param pnum 要显示的页码
	 */
	public void gettb_usersPage(HttpSession session,Tb_users tb_users,String pnum){
		//每页显示的条数
		int scount=10;
		//总条数
		int allcount=tb_usersService.getAllCount(tb_users);
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
		tb_users.setSindex(sindex);
		tb_users.setScount(scount);
		List<Tb_users> alist=tb_usersService.getPage(tb_users);
		session.setAttribute("alist", alist);
		session.setAttribute("allnums", allcount);
		session.setAttribute("pagenums", apnum);
		session.setAttribute("pagenum", pnums);
	}
}
