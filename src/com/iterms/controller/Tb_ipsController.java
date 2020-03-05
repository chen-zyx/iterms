package com.iterms.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.iterms.been.Tb_ips;
import com.iterms.been.Tb_iterms;
import com.iterms.been.Tb_node;
import com.iterms.been.Tb_task;
import com.iterms.been.Tb_users;
import com.iterms.service.Tb_ipsService;
import com.iterms.service.Tb_itermsService;
import com.iterms.service.Tb_nodeService;
import com.iterms.service.Tb_taskService;
import com.iterms.service.Tb_usersService;
import com.iterms.utils.ImgBase64Util;
import com.mysql.cj.Session;

@Controller
@RequestMapping(value = "/tb_ips")
public class Tb_ipsController {

	static int k;
	static String[] urll = new String[37];
	@Autowired
	Tb_nodeService tb_nodeService;
	@Autowired
	Tb_itermsService tb_itermsService;
	@Autowired
	Tb_taskService tb_taskService;
	@Autowired
	Tb_usersService tb_usersService;
	@Autowired
	Tb_ipsService tb_ipsService;
	
	@RequestMapping(value = "/tb_users_init", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_init(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		Tb_ips ad=new Tb_ips();
		session.setAttribute("tb_ips",ad);
		//获取首页数据
		gettb_usersPage(session,ad,"1");
		request.getRequestDispatcher("/views/tb_users/mtb_ips.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_pro", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_pro(Integer pos,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		
		Tb_ips ad=new Tb_ips();
		session.setAttribute("tb_ips",ad);
		//获取首页数据
		gettb_usersPage(session,ad,"1");
		request.getRequestDispatcher("/views/tb_users/mtb_ips.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_ck", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_ck(Tb_ips tb_ips,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		session.setAttribute("tb_ips",tb_ips);
		//获取首页数据
		gettb_usersPage(session,tb_ips,"1");
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_ips.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_apage", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_apage(String pnum,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		//获取查询条件
		Tb_ips tb_ips=(Tb_ips)session.getAttribute("tb_ips");
		gettb_usersPage(session,tb_ips,pnum);
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_ips.jsp").forward(request, response);
	}
	public String upipsfile(MultipartFile gfile, String rootPath,String res) {
		String ress=res+k+"";
		k++;
		// 原始名称
		String fname = gfile.getOriginalFilename();
		//文件类型
		String ftype=fname.substring(fname.lastIndexOf("."));
		ress+=ftype;
		// 新文件
		File newFile = new File(rootPath + File.separator +ress  );
		// 判断目标文件所在目录是否存在
		if( !newFile.getParentFile().exists()) {
			// 如果目标文件所在的目录不存在，则创建父目录
			newFile.getParentFile().mkdirs();
		}
		// 将内存中的数据写入磁盘
		try {
			gfile.transferTo(newFile);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(ress);
		return ress;
	}
	
	public String upipsfile2(String fname, String tgpath,String rootPath,String res) throws IOException {
		String nullstring="";
		if (fname.equals("n")||fname.equals("")){
			return nullstring;
		}else {
		String ress=res+k+"";
		k++;
		InputStream  in = null;
		OutputStream out = null;
		String urlstr=tgpath+fname;
		File file =new File(urlstr);
		//文件类型
		String ftype=fname.substring(fname.lastIndexOf("."));
		ress+=ftype;
		// 新文件
		File newFile = new File(rootPath + File.separator +ress  );
		// 判断目标文件所在目录是否存在
		if( !newFile.getParentFile().exists()) {
			// 如果目标文件所在的目录不存在，则创建父目录
			newFile.getParentFile().mkdirs();
		}
		try {
			  in = new FileInputStream(file);
			 out = new FileOutputStream(newFile);
			byte[] buffer = new byte[1024];  
          while (true) {  
              int byteRead = in.read(buffer);  
              if (byteRead == -1)  
                  break;  
              out.write(buffer, 0, byteRead);  
          }  
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      catch (MalformedURLException ex) {  
          System.err.println( " is not a URL Java understands.");  
      } 
		finally {  
          if (in != null)  
              in.close();  
          if (out != null) {  
              out.close();  
          }  
      }  
    
		System.out.println(ress);
		return ress;
	}
	}
	
	@RequestMapping(value = "/tb_users_add", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_add(Tb_ips tb_ips,MultipartFile gexcel,HttpSession session,HttpServletRequest request) throws IOException{
		Object myinfo=session.getAttribute("myinfo");
		if(myinfo==null){
			return "请重新登录";
		}else{
			Tb_users user=(Tb_users)myinfo;
			k=0;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
			String ename = gexcel.getOriginalFilename();
			ename=ename.substring(0, ename.lastIndexOf('.'));
			ename=ename+".xlsx";
			String res = sdf.format(new Date());
			res=res+tb_ips.getproject()+tb_ips.getname()+tb_ips.gettask();
			String rootPathh = request.getSession().getServletContext().getRealPath("upfiles");
			String rootPath=rootPathh+"\\ips";
			//System.out.println(rootPathh);
			String zipname=upipsfile(gexcel,rootPath,res);
			//c
			String zippath=(rootPath+"//"+zipname).replaceAll("\\*", "/");
			File zipFile = new File(zippath);
			 String tgpath =  "D:/ipsdatabase/";
			 unZipFiles(zipFile, tgpath);
			 rootPath=rootPath+"\\"+zipname.substring(0, zipname.lastIndexOf('.'));
			 tb_ips.setexcel(upipsfile2(ename,outstring+"\\",rootPath,res));
			System.out.println(tb_ips.getexcel());
			String url=rootPath + File.separator +tb_ips.getexcel()  ;
			readExcel(url,2);
			
			tb_ips.setcadjpg(upipsfile2(urll[13],outstring+"\\",rootPath,res));
			tb_ips.setipsjpg(upipsfile2(urll[16],outstring+"\\",rootPath,res));
			tb_ips.setpmujpg(upipsfile2(urll[19],outstring+"\\",rootPath,res));
			tb_ips.setipsfile(upipsfile2(urll[15],outstring+"\\",rootPath,res));
			tb_ips.setojpg(upipsfile2(urll[24],outstring+"\\",rootPath,res));
			tb_ips.setdreijpg(upipsfile2(urll[25],outstring+"\\",rootPath,res));
			tb_ips.setsechsjpg(upipsfile2(urll[26],outstring+"\\",rootPath,res));
			tb_ips.setnuenjpg(upipsfile2(urll[27],outstring+"\\",rootPath,res));
			tb_ips.setfinaljpg(upipsfile2(urll[28],outstring+"\\",rootPath,res));
			tb_ips.setsimojpg(upipsfile2(urll[29],outstring+"\\",rootPath,res));
			String aekof=urll[34].substring(0,urll[34].lastIndexOf('.'));
			tb_ips.setaekofile(upipsfile2(urll[34],outstring+"\\",rootPath,aekof));
			tb_ips.setpmusitu(upipsfile2(urll[31],outstring+"\\",rootPath,res));
			
			tb_ips.setplatform(urll[0]);
			tb_ips.setengine(urll[3]);
			tb_ips.setgearbox(urll[4]);
			tb_ips.setinputsource(urll[5]);
			tb_ips.setriskpartid(urll[8]);
			tb_ips.settm(urll[9]);
			tb_ips.setanriskpartid(urll[10]);
			tb_ips.setantm(urll[11]);
			tb_ips.setpipe(urll[12]);
			tb_ips.setdmuins(urll[22]);
			tb_ips.setminins(urll[17]);
			tb_ips.setipssolu(urll[18]);
			tb_ips.setpmuins(urll[20]);
			//tb_ips.setpmusitu(urll[31]);
			tb_ips.setcarid(urll[23]);
			tb_ips.setsimoins(urll[30]);
			tb_ips.setsimminins(urll[32]);
			tb_ips.setaekoid(urll[33]);
			tb_ips.setaekocom(urll[35]);
			tb_ips.setaekositu(urll[36]);
			
			tb_ips.setTb_users_id(user.getId());
			
			
			outstring=null;
			if(tb_ipsService.insertTb_ips(tb_ips)>0){
				return "{\"msg\":\"添加成功\"}";
			}else{
				return "{\"msg\":\"添加失败\"}";
			}
			
		}
	}
	
	@RequestMapping(value = "/tb_users_upd", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_upd(Tb_ips tb_ips,HttpServletRequest request){
		if(tb_ipsService.updckipstime(tb_ips.getipstime(),tb_ips.getTb_task_id()+"",tb_ips.getId()+"")){
			return "{\"msg\":\"项目名称已存在\"}";
		}else{
			if(tb_ipsService.updateTb_ips(tb_ips)>0){
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
		if(tb_ipsService.deleteTb_ips(ids)>0){
			return "{\"msg\":\"删除成功\"}";
		}else{
			return "{\"msg\":\"删除失败\"}";
		}
	}
	
	@RequestMapping(value = "/getdata", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getdata(String id){
		Tb_ips ad=tb_ipsService.getById(id);
		JSONObject json=new JSONObject();
		json.put("ob", ad);
		return json.toString();
	}
	
	@RequestMapping(value = "/tb_users_show", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_show(Tb_ips tb_ips,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		tb_ips = tb_ipsService.getById(tb_ips.id+"");
		tb_ips.setPath(tb_ips.getexcel(), tb_ips.getproject(), tb_ips.getname());
		session.setAttribute("ips", tb_ips);
		//System.out.println(tb_ips.toString());
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_ipsshow.jsp").forward(request, response);
	}
	
	
	@RequestMapping(value = "/tb_ips_download", method = RequestMethod.GET)
	@ResponseBody
	public void tb_ips_download(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String filename = request.getParameter("filename");
		Tb_ips ips = (Tb_ips) session.getAttribute("ips");
		if(filename==null) {
			String cadjpg = ImgBase64Util.getImgStr(ips.getPath()+"/"+ips.cadjpg);
			String pmujpg = ImgBase64Util.getImgStr(ips.getPath()+"/"+ips.pmujpg);
			String ojpg = ImgBase64Util.getImgStr(ips.getPath()+"/"+ips.ojpg);
			session.setAttribute("cadjpg", cadjpg);
			session.setAttribute("pmujpg", pmujpg);
			session.setAttribute("ojpg", ojpg);
			System.out.println(ojpg);
			request.getRequestDispatcher("/views/tb_users/mtb_preview.jsp").forward(request, response);
			return;
		}
		System.out.println(filename);
		response.addHeader("content-Type", "application/octet-stream");
	    response.addHeader("Content-Disposition","attachment;filename=" + filename);
	    String path = request.getServletContext().getRealPath("upfiles/ips/"+ips.getPath()+"/"+filename);
	    InputStream io =new FileInputStream(path);
	    OutputStream os=response.getOutputStream();
	    byte[] b=new byte[1024];
	    int len=-1;
		while((len=io.read(b))!=-1) {
	    	os.write(b, 0, len);
	    }
	    os.close();
	    io.close();
	}
	
	@RequestMapping(value = "/tb_ips_topdfpreview")
	public String tb_ips_topdfpreview(HttpSession session) {
		return "../views/tb_users/mtb_pdfpreview";
	}

	
	public void gettb_usersPage(HttpSession session,Tb_ips ad,String pnum){
		//每页显示的条数
		int scount=10;
		//总条数
		int allcount=tb_ipsService.getAllCount(ad);
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
		ad.setSindex(sindex);
		ad.setScount(scount);
		List<Tb_ips> alist=tb_ipsService.getPage(ad);
		for (Tb_ips tb_ips : alist) {
			tb_ips.setPath(tb_ips.getexcel(), tb_ips.getproject(), tb_ips.getname());
		}
		session.setAttribute("alist", alist);
		List<Tb_iterms> tb_itermslist=tb_itermsService.getAll();
		session.setAttribute("tb_itermslist", tb_itermslist);
		List<Tb_node> tb_nodelist=tb_nodeService.getAll();
		session.setAttribute("tb_nodelist", tb_nodelist);
		List<Tb_task> tb_tasklist=tb_taskService.getAll();
		session.setAttribute("tb_tasklist", tb_tasklist);
		session.setAttribute("allnums", allcount);
		session.setAttribute("pagenums", apnum);
		session.setAttribute("pagenum", pnums);
	}	
	
	
	public static void readExcel(String fileName, int colnum) {
		Workbook workbook = null;
		Row row = null;
		workbook = getWorkbook(fileName);
		Sheet sheet = workbook.getSheetAt(0);
		for (int i = 0; i < 37; i++) {
			row = sheet.getRow(i);
			urll[i]=new String();
			if (row != null) {
					Cell cell = row.getCell(colnum);
					String str = String.valueOf(getValueFromCell(cell));
				urll[i]=str;
				System.out.println(urll[i]);
			}
		}
	}
	
	
	private static Workbook getWorkbook(String fileName) {
		Workbook workbook = null;
		String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
		InputStream in = null;
		try {
			in = new FileInputStream(fileName);
			if ("xls".equals(suffix)) {
				workbook = new HSSFWorkbook(in);
			} else if ("xlsx".equals(suffix)) {
				workbook = new XSSFWorkbook(in);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return workbook;
	}

	private static Object getValueFromCell(Cell cell) {
		Object value = null;
		if (null == cell) {
			return "";
		}
		// 判断cell类型
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_NUMERIC: {
			value = String.valueOf(cell.getNumericCellValue());
			break;
		}
		case Cell.CELL_TYPE_FORMULA: {
			// 判断cell是否为日期格式
			if (DateUtil.isCellDateFormatted(cell)) {
				// 转换为日期格式YYYY-mm-dd
				value = cell.getDateCellValue();
			} else {
				// 数字
				value = String.valueOf(cell.getNumericCellValue());
			}
			break;
		}
		case Cell.CELL_TYPE_STRING: {
			value = cell.getRichStringCellValue().getString();
			break;
		}
		default:
			value = "";
		}
		return value;
	}
	static String outstring;
	 public void unZipFiles(String zipPath,String descDir)throws IOException
	  {
	     unZipFiles(new File(zipPath), descDir);
	  }
	  /**
	   * 解压文件到指定目录
	   */
	  @SuppressWarnings("rawtypes")
	  public void unZipFiles(File zipFile,String descDir)throws IOException
	  {
	    File pathFile = new File(descDir);
	    //String outstring=null;
	    if(!pathFile.exists())
	    {
	      pathFile.mkdirs();
	    }
	    //解决zip文件中有中文目录或者中文文件
	    ZipFile zip = new ZipFile(zipFile, Charset.forName("GBK"));
	    for(Enumeration entries = zip.entries(); entries.hasMoreElements();)
	    {
	      ZipEntry entry = (ZipEntry)entries.nextElement();
	      String zipEntryName = entry.getName();
	      InputStream in = zip.getInputStream(entry);
	      //System.out.println((descDir+zipEntryName).replaceAll("\\*", "/"));
	      String outPath = (descDir+zipEntryName).replaceAll("\\*", "/");
	      //判断路径是否存在,不存在则创建文件路径
	       outstring=outPath.substring(0, outPath.lastIndexOf('/'));
	      //System.out.println(outPath.substring(0, outPath.lastIndexOf('/')));
	      File file = new File(outPath.substring(0, outPath.lastIndexOf('/')));
	      if(!file.exists())
	      {
	        file.mkdirs();
	      }
	      //判断文件全路径是否为文件夹,如果是上面已经上传,不需要解压
	      if(new File(outPath).isDirectory())
	      {
	        continue;
	      }
	      //输出文件路径信息
	      System.out.println(outPath);
	      OutputStream out = new FileOutputStream(outPath);
	      byte[] buf1 = new byte[2048];
	      int len;
	      while((len=in.read(buf1))>0)
	      {
	        out.write(buf1,0,len);
	      }
	      in.close();
	      out.close();
	     
	    }
	    System.out.println("******************解压完毕********************");
	    zip.close();
	  }
	  
}
