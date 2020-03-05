package com.iterms.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.iterms.been.ExcelData;
import com.iterms.been.Modell;
import com.iterms.been.Tb_iterms;
import com.iterms.been.Tb_model;
import com.iterms.been.Tb_node;
import com.iterms.been.Tb_users;
import com.iterms.been.Tb_node;
import com.iterms.service.impl.Tb_itermsServiceImpl;
import com.iterms.utils.Exceldate;
import com.iterms.service.Tb_exceldataService;
import com.iterms.service.Tb_itermsService;
import com.iterms.service.Tb_nodeService;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.HttpRequestHandlerServlet;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

@Controller
@RequestMapping(value = "/tb_node")
public class Tb_nodeController {
	Modell[] modell = new Modell[66];
	ExcelData[] exceldata = new ExcelData[9];
	String fileName = "C:\\Users\\18194\\Desktop\\Projekt TerminUebersicht-2019年 第四季度更新 2019 11 29.xlsx";
	@Autowired
	Tb_nodeService tb_nodeService;
	@Autowired
	Tb_itermsService tb_itermsService;
	@Autowired
	Tb_exceldataService tb_exceldataService;

	@RequestMapping(value = "/tb_users_init", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_init(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 把查询信息放入session
		readExcel(fileName, 4);
		List<Modell> elist = getList();
		session.setAttribute("elist", elist);
		List<ExcelData> plist = tb_exceldataService.getProjects();
		session.setAttribute("plist", plist);
		/*
		 * List<ExcelData> nlist=getList2(); session.setAttribute("nlist", nlist);
		 */

		/*ExcelData ad = new ExcelData();
		session.setAttribute("exceldata", ad);*/
		// 获取首页数据
		
		
		Tb_node ad=new Tb_node();
		session.setAttribute("tb_node", ad);
		gettb_usersPage(session, ad, "1");
		// 获取首页数据
		request.getRequestDispatcher("/views/tb_users/mtb_node.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_init2", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_init2(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		// 把查询信息放入session
		readExcel(fileName, 4);
		List<Modell> elist = getList();
		session.setAttribute("elist", elist);
		List<ExcelData> plist = tb_exceldataService.getProjects();
		session.setAttribute("plist", plist);
		/*
		 * List<ExcelData> nlist=getList2(); session.setAttribute("nlist", nlist);
		 */

		/*ExcelData ad = new ExcelData();
		session.setAttribute("exceldata", ad);*/
		// 获取首页数据
		
		
		Tb_node ad=new Tb_node();
		session.setAttribute("tb_node", ad);
		gettb_usersPage(session, ad, "1");
		// 获取首页数据
		request.getRequestDispatcher("/views/tb_users/mtb_simu.jsp").forward(request, response);
	}

	@RequestMapping(value = "/tb_users_pro", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_pro(Integer pos, HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 把查询信息放入session

		readExcel2(fileName, 13, pos);
		List<ExcelData> nlist = getList2();
		session.setAttribute("nlist", nlist);

		Tb_node ad = new Tb_node();
		session.setAttribute("tb_node", ad);
		// 获取首页数据
		gettb_usersPage(session, ad, "1");
		request.getRequestDispatcher("/views/tb_users/mtb_node.jsp").forward(request, response);
	}

	@RequestMapping(value = "/tb_users_ck", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_ck(Tb_node tb_node, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println(tb_node.getname());
		System.out.println(tb_node.getjahr());
		System.out.println(tb_node.getProject());
		
		// 把查询信息放入session
		session.setAttribute("tb_node", tb_node);
		// 获取首页数据
		gettb_usersPage(session, tb_node, "1");
		// 跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_node.jsp").forward(request, response);
	}
	
	@RequestMapping(value = "/tb_users_ckk", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_ckk(ExcelData exceldata, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 把查询信息放入session
		session.setAttribute("tb_node", exceldata);
		// 获取首页数据
		gettb_usersPaage(session, exceldata, "1");
		// 跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_node.jsp").forward(request, response);
	}

	@RequestMapping(value = "/tb_users_apage", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_apage(String pnum, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 获取查询条件
		Tb_node tb_node = (Tb_node) session.getAttribute("tb_node");
		gettb_usersPage(session, tb_node, pnum);
		// 跳转到信息管理界面
		/*ExcelData exceldata = (ExcelData) session.getAttribute("exceldata");
		gettb_usersPaage(session, exceldata, pnum);*/
		request.getRequestDispatcher("/views/tb_users/mtb_node.jsp").forward(request, response);
	}

	@RequestMapping(value = "/tb_users_add", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_add(Tb_node tb_node, HttpServletRequest request) {
		System.out.println(tb_node.getname());
		if (tb_nodeService.addcknodename(tb_node.getname(), tb_node.getProject() + "")) {
			return "{\"msg\":\"项目节点已存在\"}";
		} else {
			tb_node.setjahr2();
			tb_node.setwoche();
			tb_node.setdate();
			tb_node.setTime();
			System.out.println(tb_node.getname());
			if (tb_nodeService.insertTb_node(tb_node) > 0) {
				return "{\"msg\":\"添加成功\"}";
			} else {
				return "{\"msg\":\"添加失败\"}";
			}
		}
	}

	@RequestMapping(value = "/tb_users_upd", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_upd(Tb_node tb_node, HttpServletRequest request) {
		if (tb_nodeService.updcknodename(tb_node.getname(), tb_node.getProject() + "", tb_node.getId() + "")) {
			return "{\"msg\":\"项目名称已存在\"}";
		} else {
			if (tb_nodeService.updateTb_node(tb_node) > 0) {
				return "{\"msg\":\"修改成功\"}";
			} else {
				return "{\"msg\":\"修改失败\"}";
			}
		}
	}

	@RequestMapping(value = "/del", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String del(String ids) {
		if (ids.endsWith(",")) {
			ids = ids.substring(0, ids.lastIndexOf(","));
		}
		if (tb_nodeService.deleteTb_node(ids) > 0) {
			return "{\"msg\":\"删除成功\"}";
		} else {
			return "{\"msg\":\"删除失败\"}";
		}
	}

	// 顯示excel數據圖
	@RequestMapping(value = "/tb_users_show", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_show(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Object> mlist = new ArrayList<Object>();
		List<ExcelData> list = tb_exceldataService.getProjects();
		readExcel(fileName, 4);
		List<Modell> elist = getList();
		if (list != null && list.size() > 0) {
			//System.out.println("读数据" + list.size());
			for (int i = 1; i < list.size(); i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("name", list.get(i).getProject());
				//System.out.println(list.get(i).getProject());
				List<ExcelData> list2 = tb_exceldataService.getByProject(list.get(i).getProject());
				getResults(list2, map);
				mlist.add(map);
			}
		} else {
			//System.out.println("写数据");
			for (int i = 25, j = 1; i < 89 && j < elist.size(); i++, j++) {
				readExcel2(fileName, 13, i);
				list = getList2();
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("name", elist.get(j).getprojekt());
				getResults(list, map);
				mlist.add(map);
			}
		}
		String jsonString = JSON.toJSONString(mlist);
		session.setAttribute("data", jsonString);
		request.getRequestDispatcher("/views/tb_users/mtb_chart.jsp").forward(request, response);
	}

	@RequestMapping(value = "/getdata", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getdata(String id) {
		Tb_node ad = tb_nodeService.getById(id);
		JSONObject json = new JSONObject();
		json.put("ob", ad);
		return json.toString();
	}

	public void gettb_usersPage(HttpSession session, Tb_node tb_node, String pnum) {
		// 每页显示的条数
		int scount = 10;
		// 总条数
		int allcount = tb_nodeService.getAllCount(tb_node);
		int apnum = allcount / scount;
		if (allcount % scount > 0) {
			apnum++;
		}
		// 要显示的页码
		int pnums = Integer.parseInt(pnum);
		if (pnums > apnum) {
			pnums = apnum;
		}
		if (pnums < 1) {
			pnums = 1;
		}
		// 开始条数
		int sindex = (pnums - 1) * 10;
		tb_node.setSindex(sindex);
		tb_node.setScount(scount);
		List<Tb_node> alist = tb_nodeService.getPage(tb_node);
		session.setAttribute("alist", alist);
		List<Tb_node> flist = tb_nodeService.getbyflag();
		session.setAttribute("flist", flist);
		List<Tb_iterms> tb_itermslist = tb_itermsService.getAll();
		session.setAttribute("tb_itermslist", tb_itermslist);
		session.setAttribute("allnums", allcount);
		session.setAttribute("pagenums", apnum);
		session.setAttribute("pagenum", pnums);
	}
	
	public void gettb_usersPaage(HttpSession session, ExcelData exceldata, String pnum) {
		// 每页显示的条数
		int scount = 10;
		// 总条数
		int allcount = tb_exceldataService.getAllCount(exceldata);
		int apnum = allcount / scount;
		if (allcount % scount > 0) {
			apnum++;
		}
		// 要显示的页码
		int pnums = Integer.parseInt(pnum);
		if (pnums > apnum) {
			pnums = apnum;
		}
		if (pnums < 1) {
			pnums = 1;
		}
		// 开始条数
		int sindex = (pnums - 1) * 10;
		exceldata.setSindex(sindex);
		exceldata.setScount(scount);
		List<ExcelData> list = tb_exceldataService.getAll();
		session.setAttribute("list", list);
		session.setAttribute("allnums", allcount);
		session.setAttribute("pagenums", apnum);
		session.setAttribute("pagenum", pnums);
	}

	public List<ExcelData> getList2() {
		List<ExcelData> list = new ArrayList<ExcelData>();
		// int kk=k-1;
		for (int i = 0; i < k; i++) {
			list.add(exceldata[i]);
		}
		return list;

	}

	public List<Modell> getList() {
		List<Modell> list = new ArrayList<Modell>();
		for (int i = 0; i < 65; i++) {
			list.add(modell[i]);
		}
		return list;

	}

	static int k;

	public void readExcel(String fileName, int colnum) {
		Workbook workbook = null;
		Row row = null;
		workbook = getWorkbook(fileName);
		Sheet sheet = workbook.getSheetAt(1);
		row = sheet.getRow(1);
		for (int i = 23; i < 89; i++) {
			row = sheet.getRow(i);
			modell[i - 23] = new Modell();
			modell[i - 23].setpos(i + 1);

			if (row != null) {
				for (int j = 0; j < colnum; j++) {
					Cell cell = row.getCell(j);
					String str = String.valueOf(getValueFromCell(cell));
					switch (j) {
					case 0: {
						modell[i - 23].setkla(str);
						break;
					}
					case 1: {
						modell[i - 23].setname(str);
						break;
					}
					case 2: {
						modell[i - 23].setprojekt(str);
						break;
					}
					case 3: {
						modell[i - 23].setbezeichnung(str);
						break;
					}
					}
				}
			}
		}
	}

	private void readExcel2(String fileName, int colnum, Integer pos) {
		Workbook workbook = null;
		Row row = null;
		k = 0;
		// System.out.println(pos+"");
		workbook = getWorkbook(fileName);
		Sheet sheet = workbook.getSheetAt(1);
		row = sheet.getRow(pos - 1);
		Row row2 = sheet.getRow(2);
		if (row != null) {
			for (int j = 4; j < colnum; j++) {
				Cell cell = row.getCell(j);
				String str = String.valueOf(getValueFromCell(cell));
				if (str != "") {
					// System.out.println(str);
					Cell cell2 = row2.getCell(j);
					String str2 = String.valueOf(getValueFromCell(cell2));
					exceldata[k] = new ExcelData();
					exceldata[k].setname(str2);
					exceldata[k].setProject(String.valueOf(getValueFromCell(row.getCell(2))));
					exceldata[k].setwochestr(str);
					exceldata[k].setjahr();
					exceldata[k].setwoche();
					exceldata[k].setdate();
					exceldata[k].setTime();
					// 将数据添加到数据库
					tb_exceldataService.insert(exceldata[k]);
					k++;
				}
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
	
	private Map<String, Object> getResults(List<ExcelData> list,Map<String, Object> map){
		Iterator<ExcelData> iterator = list.iterator();
		while (iterator.hasNext()) {
			ExcelData ed = iterator.next();
			if (ed.getname().equals("BF")) {
				map.put(ed.getname(), ed.getwochestr());
				map.put("bdate", ed.getTime());
			}
			if (ed.getname().equals("LF")) {
				map.put(ed.getname(), ed.getwochestr());
				map.put("ldate", ed.getTime());
			}
			if (ed.getname().equals("VFF")) {
				map.put(ed.getname(), ed.getwochestr());
				map.put("vdate", ed.getTime());
			}
			if (ed.getname().equals("PVS")) {
				map.put(ed.getname(), ed.getwochestr());
				map.put("pdate", ed.getTime());
			}
			if (ed.getname().equals("0S")) {
				map.put("OS", ed.getwochestr());
				map.put("odate", ed.getTime());
			}
			if (ed.getname().equals("SOP")) {
				map.put(ed.getname(), ed.getwochestr());
				map.put("sdate", ed.getTime());
			}
		}
		return map;
	}

}
