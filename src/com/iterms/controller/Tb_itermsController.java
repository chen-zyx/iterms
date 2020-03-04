package com.iterms.controller;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.iterms.been.Tb_iterms;
import com.iterms.service.Tb_itermsService;
import com.iterms.been.Modell;

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
import com.alibaba.fastjson.JSONObject;
@Controller
@RequestMapping(value = "/tb_iterms")
public class Tb_itermsController {
	
	Modell[] modell=new Modell[66];
	
	@Autowired
	Tb_itermsService tb_itermsService;
	@RequestMapping(value = "/tb_users_init", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_init(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		Tb_iterms ad=new Tb_iterms();
		session.setAttribute("tb_iterms",ad);
		String fileName = "C:\\Users\\18194\\Desktop\\Projekt TerminUebersicht-2019年 第四季度更新 2019 11 29.xlsx";
        readExcel(fileName,4);
        List<Modell> elist=getList();
		session.setAttribute("elist", elist);
		//获取首页数据
		gettb_usersPage(session,ad,"1");
		request.getRequestDispatcher("/views/tb_users/mtb_iterms.jsp").forward(request, response);
	}
	
	public List<Modell>  getList(){
		List<Modell> list = new ArrayList<Modell>();
		for(int i=0;i<65;i++) {
			list.add(modell[i]);
		}
		return list;
		
	}
	
	@RequestMapping(value = "/tb_users_ck", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_ck(Tb_iterms tb_iterms,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//把查询信息放入session
		session.setAttribute("tb_iterms",tb_iterms);
		//获取首页数据
		gettb_usersPage(session,tb_iterms,"1");
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_iterms.jsp").forward(request, response);
	}
	@RequestMapping(value = "/tb_users_apage", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_apage(String pnum,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		//获取查询条件
		Tb_iterms tb_iterms=(Tb_iterms)session.getAttribute("tb_iterms");
		gettb_usersPage(session,tb_iterms,pnum);
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_iterms.jsp").forward(request, response);
	}
	@RequestMapping(value = "/tb_users_add", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_add(Tb_iterms tb_iterms,HttpServletRequest request){
		if(tb_itermsService.addckItname(tb_iterms.getItname())){
			return "{\"msg\":\"项目名称已存在\"}";
		}else{
			if(tb_itermsService.insertTb_iterms(tb_iterms)>0){
				return "{\"msg\":\"添加成功\"}";
			}else{
				return "{\"msg\":\"添加失败\"}";
			}
		}
	}
	@RequestMapping(value = "/tb_users_upd", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_upd(Tb_iterms tb_iterms,HttpServletRequest request){
		if(tb_itermsService.updckItname(tb_iterms.getItname(),tb_iterms.getId()+"")){
			return "{\"msg\":\"项目名称已存在\"}";
		}else{
			if(tb_itermsService.updateTb_iterms(tb_iterms)>0){
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
		if(tb_itermsService.deleteTb_iterms(ids)>0){
			return "{\"msg\":\"删除成功\"}";
		}else{
			return "{\"msg\":\"删除失败\"}";
		}
	}
	@RequestMapping(value = "/getdata", method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getdata(String id){
		Tb_iterms ad=tb_itermsService.getById(id);
		JSONObject json=new JSONObject();
		json.put("ob", ad);
		return json.toString();
	}
	
	/*@RequestMapping(value = "/jumpnode", method = RequestMethod.POST)
	@ResponseBody
	public void jumpnode(String iterm_id,HttpSession session,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		Tb_node ad=Tb_nodeService.getById(iterm_id);
		//把查询信息放入session
		session.setAttribute("tb_node",tb_node);
		//获取首页数据
		gettb_usersPage(session,tb_node,"1");
		//跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_node.jsp").forward(request, response);
	}*/
	/**
	 * @param request
	 * @param 条件
	 * @param pnum 要显示的页码
	 */
	public void gettb_usersPage(HttpSession session,Tb_iterms tb_iterms,String pnum){
		//每页显示的条数
		int scount=10;
		//总条数
		int allcount=tb_itermsService.getAllCount(tb_iterms);
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
		tb_iterms.setSindex(sindex);
		tb_iterms.setScount(scount);
		List<Tb_iterms> alist=tb_itermsService.getPage(tb_iterms);
		session.setAttribute("alist", alist);
		session.setAttribute("allnums", allcount);
		session.setAttribute("pagenums", apnum);
		session.setAttribute("pagenum", pnums);
	}
	public  void readExcel(String fileName,int colnum) {
        Workbook workbook = null;
  //    Modell[] modell=new Modell[66];
        Row row = null;
   //     int colnum=0;
        //获取Excel文档
        workbook = getWorkbook(fileName);
        //获取Excel文档的第一个sheet页
        Sheet sheet = workbook.getSheetAt(1);
        //获取文档中已保存数据的行数
     //   int rowNum = sheet.getPhysicalNumberOfRows();
        //获取第一行
        row = sheet.getRow(1);        
        //获取当前行已保存数据的最大列数
       //  colnum = row.getPhysicalNumberOfCells()+1;
        for (int i = 23; i < 89; i++) {
            row = sheet.getRow(i);
            modell[i-23]=new Modell();
            modell[i-23].setpos(i+1);
            //System.out.println(i);
            if (row != null)
            {
                for (int j = 0; j < colnum; j++) {
                    Cell cell = row.getCell(j);
                    String str=String.valueOf(getValueFromCell(cell));
                    switch (j){
                    case 0:{
                    	modell[i-23].setkla(str);
                    	break;
                    }
                    case 1:{
                    	modell[i-23].setname(str);
                    	break;
                    }
                    case 2:{
                    	modell[i-23].setprojekt(str);
                    	break;
                    }
                    case 3:{
                    	modell[i-23].setbezeichnung(str);
                    	break;
                    }
                    }
                 //   System.out.println(j);
                  //  System.out.println(getValueFromCell(cell));
                }
            }
        }//System.out.println(rowNum);
        //System.out.println(modell[65].getpos());
        //System.out.println(modell[65].getname());
    }
	 private static Workbook getWorkbook(String fileName) {//根据后缀获取Excel表格
	        Workbook workbook = null;
	        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
	        InputStream in = null;
	        try {
	            in = new FileInputStream(fileName);
	            if ("xls".equals(suffix))
	            {
	                workbook = new HSSFWorkbook(in);
	            }
	            else if ("xlsx".equals(suffix))
	            {
	                workbook = new XSSFWorkbook(in);
	            }
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        return workbook;
	    }
	    
	    private static Object getValueFromCell(Cell cell) {//获取单元格的值
	        Object value = null;
	        if (null == cell)
	        {
	            return "";
	        }
	        //判断cell类型
	        switch(cell.getCellType()){
	        case Cell.CELL_TYPE_NUMERIC:{
	            value = String.valueOf(cell.getNumericCellValue());
	            break;
	        }
	        case Cell.CELL_TYPE_FORMULA:{
	            //判断cell是否为日期格式
	            if(DateUtil.isCellDateFormatted(cell)){
	                //转换为日期格式YYYY-mm-dd
	                value = cell.getDateCellValue();
	            }else{
	                //数字
	                value = String.valueOf(cell.getNumericCellValue());
	            }
	            break;
	        }
	        case Cell.CELL_TYPE_STRING:{
	            value = cell.getRichStringCellValue().getString();
	            break;
	        }
	        default:
	            value = "";
	        }
	        return value;
	    }
	}


