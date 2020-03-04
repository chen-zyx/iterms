package com.iterms.controller;
import java.io.IOException;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.iterms.dao.Tb_usersDao;
import com.iterms.been.Tb_users;
import com.iterms.service.Tb_usersService;
import com.iterms.utils.GetIp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
@Controller
@RequestMapping(value = "/login")
public class LoginController {
	@Resource(name = "tb_usersDao")
	Tb_usersDao tb_usersDao;
	@Autowired
	Tb_usersService tb_usersService;
	//用户登录
	@RequestMapping(value = "/login", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String login(String uname,String upassword,String utype){
		//获取request
		RequestAttributes ra = RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
		//根据用户类型，分别进行登录检测
		boolean bl=true;
	//	String ip=GetIp.getIpAddress(request);
		//String ipp="0:0:0:0:0:0:0:1";
	//	System.out.println(ip);
		//if (!ip.equals(ipp) ) {
		//	return "{\"msg\":\"找管理员要权限\"}";}
			//else {
		if("tb_users".equals(utype)){//用户信息登录
			bl=false;
			//根据账号和密码获取用户信息用户信息
			Tb_users ad=tb_usersService.login(uname, upassword);
			//如果登录信息正确，则把登录信息写入到session，并返回1
			if(ad!=null){
				if("否".equals(ad.getUflag())){
					return "{\"msg\":\"找管理员要权限\"}";
				}else{
					request.getSession(true).setAttribute("myinfo", ad);
					request.getSession(true).setAttribute("utype", utype);
					return "{\"msg\":\"1\"}";
				}
			}else{//如果登录信息不正确，给出提示
				return "{\"msg\":\"账号或密码错误\"}";
			}
		}
		if(bl){
			return "{\"msg\":\"系统错误\"}";
		}
		//}
		return null;
	}
	//修改登录密码
	@RequestMapping(value = "/updpwd", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updpwd(String opwd,String npwd,HttpServletRequest request,HttpSession session){
		Object utype=session.getAttribute("utype");
		Object myinfo=session.getAttribute("myinfo");
		if(utype==null||myinfo==null){
			return "{\"msg\":\"请重新登录\"}";
		}
		//根据用户类型，分别进行登录检测
		boolean bl=true;
		if("tb_users".equals(utype)){//如果登录用户为用户信息
			bl=false;
			Tb_users us=(Tb_users)myinfo;
			//获取用户信息用户信息
			Tb_users ad=tb_usersService.getById(us.getId()+"");
			//判断旧密码是否正确
			if(opwd.equals(ad.getUpwd())){
				ad.setUpwd(npwd);
				//修改密码
				if(tb_usersService.updateTb_users(ad)>0){
					session.setAttribute("myinfo", ad);
					return "{\"msg\":\"修改成功\"}";
				}else{
					return "{\"msg\":\"修改失败\"}";
				}
			}else{
				return "{\"msg\":\"旧密码输入有误\"}";
			}
		}
		if(bl){
			return "{\"msg\":\"系统错误\"}";
		}
		return null;
	}
	//退出登录
	@RequestMapping(value = "/logout", method = RequestMethod.GET,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public void logout(HttpServletRequest request,HttpServletResponse response){
		request.getSession().removeAttribute("myinfo");
		request.getSession().removeAttribute("utype");
		request.getSession().removeAttribute("alist");
		try {
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
