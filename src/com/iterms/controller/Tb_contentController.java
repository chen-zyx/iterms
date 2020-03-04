package com.iterms.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.iterms.been.Tb_content;
import com.iterms.service.Tb_contentService;
import com.iterms.utils.GetIp;

@Controller
@RequestMapping(value = "/tb_content")
public class Tb_contentController {
	
	@Autowired
	Tb_contentService tb_contentService;

	@RequestMapping(value = "/tb_users_init", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_init(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		Tb_content ad=new Tb_content();
		session.setAttribute("tb_content",ad);
		//获取首页数据
		gettb_usersPage(session,ad,"1");
		request.getRequestDispatcher("/views/tb_users/mtb_content.jsp").forward(request, response);
	}
	@RequestMapping(value = "/tb_users_ck", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_ck(Tb_content tb_content,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		session.setAttribute("tb_content",tb_content);
		//获取首页数据
		gettb_usersPage(session,tb_content,"1");
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_content.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_apage", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_apage(String pnum,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		//获取查询条件
		Tb_content tb_content=(Tb_content)session.getAttribute("tb_content");
		gettb_usersPage(session,tb_content,pnum);
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_content.jsp").forward(request, response);
	}
	@RequestMapping(value = "/tb_users_add", method = RequestMethod.POST,produces = "text/html;charset=utf-8",consumes = "multipart/form-data")
	@ResponseBody
	public String tb_users_add(Tb_content tb_content,MultipartFile gcfile,HttpSession session,HttpServletRequest request){
		Object myinfo=session.getAttribute("myinfo");
		if(myinfo==null){
			return "请重新登录";
		}else{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
			String res = sdf.format(new Date());
			// upfiles文件夹位置
			String rootPath = request.getSession().getServletContext().getRealPath("upfiles");
			// 原始名称
			String fname = gcfile.getOriginalFilename();
			//文件类型
			String ftype=fname.substring(fname.lastIndexOf("."));
			res+=ftype;
			// 新文件
			File newFile = new File(rootPath + File.separator +res  );
			// 判断目标文件所在目录是否存在
			if( !newFile.getParentFile().exists()) {
				// 如果目标文件所在的目录不存在，则创建父目录
				newFile.getParentFile().mkdirs();
			}
			// 将内存中的数据写入磁盘
			try {
				gcfile.transferTo(newFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			tb_content.setcfile(res);
			
			if(tb_contentService.insertTb_content(tb_content)>0){
				return "上传成功";
			}else{
				return "上传失败";
			}
		}
	}
	
	@RequestMapping(value = "/del", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String del(String ids){
		if(ids.endsWith(",")){
			ids=ids.substring(0, ids.lastIndexOf(","));
		}
		if(tb_contentService.deleteTb_content(ids)>0){
			return "{\"msg\":\"删除成功\"}";
		}else{
			return "{\"msg\":\"删除失败\"}";
		}
	}
	@RequestMapping(value = "/getdata", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getdata(String id){
		Tb_content ad=tb_contentService.getById(id);
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
			//获取文件存放文件夹路径
			String rootPath = request.getSession().getServletContext().getRealPath("upfiles");
			//获取文件数据库信息
			Tb_content ad=tb_contentService.getById(id);
			//获取文件完整路径
			String path=rootPath+File.separator+ad.getcfile();
			System.out.println(path);
			//如果文件不存在，则跳转到失败页面
			if(!new File(path).exists()){
				request.setAttribute("msg", "文件获取失败");
				request.getRequestDispatcher("/error.jsp").forward(request, response);
				return;
			}
			String ftype=path.substring(path.lastIndexOf("."));
			//获取输入流  
			InputStream bis = new BufferedInputStream(new FileInputStream(new File(path)));
			//转码，免得文件名中文乱码  
			String filename = URLEncoder.encode(ad.getcname(),"UTF-8");  
			//设置文件下载头  
			response.addHeader("Content-Disposition", "attachment;filename=" + filename+ftype);    
			//1.设置文件ContentType类型，这样设置，会自动判断下载文件类型    
			response.setContentType("multipart/form-data");   
			BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());  
			int len = 0;  
			while((len = bis.read()) != -1){  
				out.write(len);  
				out.flush();  
			}  
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
			Tb_content ad=tb_contentService.getById(id);
			//获取文件完整路径
			String path=rootPath+File.separator+ad.getcfile();
			//System.out.println(path);
			//如果文件不存在，则跳转到失败页面
			if(!new File(path).exists()){
				request.setAttribute("msg", "文件获取失败");
				request.getRequestDispatcher("/error.jsp").forward(request, response);
				return;
			}
			String toolsPath = "C:/Program Files/Internet Explorer/iexplore.exe";
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
	public void gettb_usersPage(HttpSession session,Tb_content tb_content,String pnum){
		//每页显示的条数
		int scount=10;
		//总条数
		int allcount=tb_contentService.getAllCount(tb_content);
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
		tb_content.setSindex(sindex);
		tb_content.setScount(scount);
		List<Tb_content> alist=tb_contentService.getPage(tb_content);
		session.setAttribute("alist", alist);
		session.setAttribute("allnums", allcount);
		session.setAttribute("pagenums", apnum);
		session.setAttribute("pagenum", pnums);
	}	
}
