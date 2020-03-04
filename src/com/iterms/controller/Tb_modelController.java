package com.iterms.controller;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.iterms.been.Tb_hmark;
import com.iterms.been.Tb_model;
import com.iterms.been.Tb_node;
import com.iterms.service.Tb_hmarkService;
import com.iterms.service.Tb_modelService;
import com.iterms.service.Tb_nodeService;
import com.iterms.been.Tb_iterms;
import com.iterms.service.Tb_itermsService;
import com.iterms.been.Tb_users;
import com.iterms.been.Tb_zweit;
import com.iterms.service.Tb_usersService;
import com.iterms.service.Tb_zweitService;
import com.iterms.utils.GetIp;
import com.iterms.utils.downloadwiththreadpool;

import java.io.File;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
@Controller
@RequestMapping(value = "/tb_model")
public class Tb_modelController {
	@Autowired
	Tb_modelService tb_modelService;
	@Autowired
	Tb_itermsService tb_itermsService;
	@Autowired
	Tb_usersService tb_usersService;
	@Autowired
	Tb_nodeService tb_nodeService;
	@Autowired
	Tb_zweitService tb_zweitService;
	@Autowired
	Tb_hmarkService tb_hmarkService;
	@RequestMapping(value = "/tb_users_init", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_init(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		Tb_model ad=new Tb_model();
		session.setAttribute("tb_model",ad);
		//获取首页数据
		gettb_usersPage(session,ad,"1");
		request.getRequestDispatcher("/views/tb_users/mtb_model.jsp").forward(request, response);
	}
	@RequestMapping(value = "/tb_users_ck", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_ck(Tb_model tb_model,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		session.setAttribute("tb_model",tb_model);
		//获取首页数据
		gettb_usersPage(session,tb_model,"1");
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_model.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_apage", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_apage(String pnum,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		//获取查询条件
		Tb_model tb_model=(Tb_model)session.getAttribute("tb_model");
		gettb_usersPage(session,tb_model,pnum);
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_model.jsp").forward(request, response);
	}
	@RequestMapping(value = "/tb_users_add", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_add(Tb_model tb_model,MultipartFile gmfile,HttpSession session,HttpServletRequest request){
		Object myinfo=session.getAttribute("myinfo");
		if(myinfo==null){
			return "请重新登录";
		}else{
			Tb_users user=(Tb_users)myinfo;
			//时间格式
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String res = sdf.format(new Date());
			// upfiles文件夹位置
			String rootPath = request.getSession().getServletContext().getRealPath("upfiles");
			// 原始名称
			String fname = gmfile.getOriginalFilename();
			//文件类型
			String ftype=fname.substring(fname.lastIndexOf("."));
			res+=ftype;
			// 新文件
			File newFile = new File(rootPath + File.separator  + res);
			// 判断目标文件所在目录是否存在
			if( !newFile.getParentFile().exists()) {
				// 如果目标文件所在的目录不存在，则创建父目录
				newFile.getParentFile().mkdirs();
			}
			// 将内存中的数据写入磁盘
			try {
				gmfile.transferTo(newFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			tb_model.setMfile(res);
			tb_model.setTb_users_id(user.getId());
			tb_model.setCtime(sdf2.format(new Date()));
			if(tb_modelService.insertTb_model(tb_model)>0){
				//上传成功，添加上传记录
				Tb_hmark hmark=new Tb_hmark();
				hmark.setTb_model_id(tb_model.getId());
				hmark.setTb_users_id(user.getId());
				hmark.setHflag("上传");
				hmark.setHtime(sdf2.format(new Date()));
				hmark.setIpaddr(GetIp.getIpAddress(request));
				tb_hmarkService.insertTb_hmark(hmark);
				//上传成功，用户上传次数+1
				user=tb_usersService.getById(user.getId()+"");
				user.setUpnums(user.getUpnums()+1);
				tb_usersService.updateTb_users(user);
				session.setAttribute("myinfo", user);
				return "上传成功";
			}else{
				return "上传失败";
			}
		}
	}
	@RequestMapping(value = "/tb_users_upd", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_upd(Tb_model tb_model,MultipartFile gmfile,HttpServletRequest request){
			if(gmfile.isEmpty()){
				Tb_model ob=tb_modelService.getById(tb_model.getId()+"");
				tb_model.setMfile(ob.getMfile());
			}else{
				//时间格式
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
				String res = sdf.format(new Date());
				// upfiles文件夹位置
				String rootPath = request.getSession().getServletContext().getRealPath("upfiles");
				// 原始名称
				String fname = gmfile.getOriginalFilename();
				//文件类型
				String ftype=fname.substring(fname.lastIndexOf("."));
				res+=ftype;
				// 新文件
				File newFile = new File(rootPath + File.separator  + res);
				// 判断目标文件所在目录是否存在
				if( !newFile.getParentFile().exists()) {
					// 如果目标文件所在的目录不存在，则创建父目录
					newFile.getParentFile().mkdirs();
				}
				// 将内存中的数据写入磁盘
				try {
					gmfile.transferTo(newFile);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				tb_model.setMfile(res);
			}
			if(tb_modelService.updateTb_model(tb_model)>0){
				return "修改成功";
			}else{
				return "修改失败";
			}
	}
	@RequestMapping(value = "/del", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String del(String ids){
		if(ids.endsWith(",")){
			ids=ids.substring(0, ids.lastIndexOf(","));
		}
		if(tb_modelService.deleteTb_model(ids)>0){
			return "{\"msg\":\"删除成功\"}";
		}else{
			return "{\"msg\":\"删除失败\"}";
		}
	}
	@RequestMapping(value = "/getdata", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getdata(String id){
		Tb_model ad=tb_modelService.getById(id);
		JSONObject json=new JSONObject();
		json.put("ob", ad);
		return json.toString();
	}
	@RequestMapping(value = "/dfile", method = RequestMethod.GET,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public void dfile(String id,HttpServletRequest request,HttpSession session,
            HttpServletResponse response) throws ServletException, IOException{//文件下载
		Object myinfo=session.getAttribute("myinfo");
		if(myinfo==null){
			request.setAttribute("msg", "请重新登录");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
			return;
		}else{
			Tb_users user=(Tb_users)myinfo;
			//获取文件存放文件夹路径
			String rootPath = request.getSession().getServletContext().getRealPath("upfiles");
			//获取文件数据库信息
			Tb_model ad=tb_modelService.getById(id);
			//获取文件完整路径
			String path=rootPath+File.separator+ad.getMfile();
			System.out.println(path);
			//如果文件不存在，则跳转到失败页面
			if(!new File(path).exists()){
				request.setAttribute("msg", "文件获取失败");
				request.getRequestDispatcher("/error.jsp").forward(request, response);
				return;
			}
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			//下载成功，添加下载记录
			Tb_hmark hmark=new Tb_hmark();
			hmark.setTb_model_id(Integer.parseInt(id));
			hmark.setTb_users_id(user.getId());
			hmark.setHflag("下载");
			hmark.setHtime(sdf2.format(new Date()));
			hmark.setIpaddr(GetIp.getIpAddress(request));
			tb_hmarkService.insertTb_hmark(hmark);
			//下载成功，用户下载次数+1
			user=tb_usersService.getById(user.getId()+"");
			user.setDnums(user.getDnums()+1);
			tb_usersService.updateTb_users(user);
			session.setAttribute("myinfo", user);
			String ftype=path.substring(path.lastIndexOf("."));
			//获取输入流  
			InputStream bis = new BufferedInputStream(new FileInputStream(new File(path)));
			//转码，免得文件名中文乱码  
			String filename = URLEncoder.encode(ad.getMname(),"UTF-8");  
			//设置文件下载头  
			response.addHeader("Content-Disposition", "attachment;filename=" + filename+ftype);    
			//1.设置文件ContentType类型，这样设置，会自动判断下载文件类型    
			response.setContentType("multipart/form-data");   
			BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());  
			int len = 0; 
			byte[] buff = new byte[256];
			while ((len=bis.read(buff))>0) {
				out.write(buff,0,len);
			}
			/*while((len = bis.read()) != -1){  
				out.write(len);  
				out.flush();  
			}  */
			out.close();  
			
		}
	}
	@RequestMapping(value = "/openfile", method = RequestMethod.GET,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public void openfile(String id,HttpServletRequest request,HttpSession session,
            HttpServletResponse response) throws ServletException, IOException{
		Object myinfo=session.getAttribute("myinfo");
		if(myinfo==null){
			request.setAttribute("msg", "请重新登录");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
			return;
		}else{
			//获取文件存放文件夹路径
			String rootPath = request.getSession().getServletContext().getRealPath("upfiles");
			//获取文件数据库信息
			Tb_model ad=tb_modelService.getById(id);
			//获取文件完整路径
			String path=rootPath+File.separator+ad.getMfile();
			//System.out.println(path);
			//如果文件不存在，则跳转到失败页面
			if(!new File(path).exists()){
				request.setAttribute("msg", "文件获取失败");
				request.getRequestDispatcher("/error.jsp").forward(request, response);
				return;
			}
			String toolsPath = "C:/Program Files (x86)/BETA_CAE_Systems/ansa_v19.1.0/ansa64.bat";
			try { 
			     Process p = Runtime.getRuntime().exec(toolsPath+" "+path); 
			} catch (IOException e) { 
			     e.printStackTrace(); 
			} 
		}
	}
	/**
	 * @param request
	 * @param 条件
	 * @param pnum 要显示的页码
	 */
	public void gettb_usersPage(HttpSession session,Tb_model tb_model,String pnum){
		//每页显示的条数
		int scount=10;
		//总条数
		int allcount=tb_modelService.getAllCount(tb_model);
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
		tb_model.setSindex(sindex);
		tb_model.setScount(scount);
		List<Tb_model> alist=tb_modelService.getPage(tb_model);
		session.setAttribute("alist", alist);
		List<Tb_iterms> tb_itermslist=tb_itermsService.getAll();
		session.setAttribute("tb_itermslist", tb_itermslist);
		List<Tb_users> tb_userslist=tb_usersService.getAll();
		session.setAttribute("tb_userslist", tb_userslist);
		List<Tb_node> tb_nodelist=tb_nodeService.getAll();
		session.setAttribute("tb_nodelist", tb_nodelist);
		List<Tb_zweit> tb_zweitlist=tb_zweitService.getAll();
		session.setAttribute("tb_zweitlist", tb_zweitlist);
		session.setAttribute("allnums", allcount);
		session.setAttribute("pagenums", apnum);
		session.setAttribute("pagenum", pnums);
	}	
}
