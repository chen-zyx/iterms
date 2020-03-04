package com.iterms.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.iterms.been.ExcelData;
import com.iterms.been.Tb_task;
import com.iterms.been.Tb_tasktime;
import com.iterms.service.Tb_tasktimeService;

@Controller
@RequestMapping(value = "/tb_tasktime")
public class Tb_tasktimeController {

	@Autowired
	Tb_tasktimeService tb_tasktimeService;

	@RequestMapping(value = "/tb_users_init", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_init(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 把查询信息放入session
		Tb_tasktime ad = new Tb_tasktime();
		session.setAttribute("tb_tasktime", ad);
		// 获取首页数据
		gettb_usersPage(session, ad, "1");
		request.getRequestDispatcher("/views/tb_users/mtb_tasktime.jsp").forward(request, response);
	}

	@RequestMapping(value = "/tb_users_ck", method = RequestMethod.POST)
	@ResponseBody
	public void tb_users_ck(Tb_tasktime tb_tasktime, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 把查询信息放入session
		session.setAttribute("tb_tasktime", tb_tasktime);
		// 获取首页数据
		gettb_usersPage(session, tb_tasktime, "1");
		// 跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_tasktime.jsp").forward(request, response);
	}

	@RequestMapping(value = "/tb_users_upd", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_users_upd(Tb_tasktime tb_tasktime, HttpServletRequest request) throws ParseException {
		/*
		 * tb_tasktime.setshour(); tb_tasktime.setrhour(); tb_tasktime.setsminus();
		 * tb_tasktime.setrminus();
		 */
		if (tb_tasktimeService.updateTb_tasktime(tb_tasktime) > 0) {
			Tb_tasktime ad = tb_tasktimeService.getById(tb_tasktime.getId());
			ad.settflag();
			ad.sethour();

			if (tb_tasktimeService.updateTb_tasktime(ad) > 0) {
				return "{\"msg\":\"修改成功\"}";
			} else {
				return "{\"msg\":\"修改失败1\"}";
			}
		} else {
			return "{\"msg\":\"修改失败2\"}";
		}

	}

	@RequestMapping(value = "/tb_tasktime_show", method = RequestMethod.GET)
	@ResponseBody
	public void tb_tasktime_show(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Object> mlist = new ArrayList<Object>();
		Tb_tasktime tb_tasktime = new Tb_tasktime();
		tb_tasktime.setTb_task_id(55);
		List<Tb_tasktime> alist = tb_tasktimeService.getPage(tb_tasktime);
		if (alist != null && alist.size() > 0) {
			for (int i = 0; i < alist.size(); i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("taskname", alist.get(i).gettaskname());
				map.put("tname", alist.get(i).gettname());
				map.put("rhour", alist.get(i).getrhour());
				mlist.add(map);
			}
		}
		String json = JSON.toJSONString(mlist);
		session.setAttribute("tasktime", json);
		request.getRequestDispatcher("/views/tb_users/mtb_tasktimecharts.jsp").forward(request, response);
	}

	@RequestMapping(value = "/tb_tasktime_showmore", method = RequestMethod.GET)
	@ResponseBody
	public void tb_tasktime_showmore(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Object> mlist = new ArrayList<Object>();
		Tb_tasktime tb_tasktime = new Tb_tasktime();
		List<Tb_tasktime> alist = tb_tasktimeService.getPage(null);
		List<Integer> numlist = new ArrayList<Integer>();
		for (Tb_tasktime tasktime : alist) {
			if (!numlist.contains(tasktime.getTb_task_id())) {
				numlist.add(tasktime.getTb_task_id());
			}
		}
		for (Integer num : numlist) {
			List<Object> mlist2 = new ArrayList<Object>();
			Map<String, Object> map1 = new HashMap<String, Object>();
			Integer sum = 0;
			tb_tasktime.setTb_task_id(num);
			List<Tb_tasktime> list = tb_tasktimeService.getPage(tb_tasktime);
			if (list != null && list.size() > 0) {
				for (int j = 0; j < list.size(); j++) {
					/*
					 * if (!mlist2.contains(list.get(j).gettaskname())) {
					 * mlist2.add(list.get(j).gettaskname()); }
					 */
					map1.put("taskname",list.get(j).gettaskname());
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("tname", list.get(j).gettname());
					map.put("rhour", list.get(j).getrhour());
					sum += list.get(j).getrhour();
					mlist2.add(map);
				}
				map1.put("totalhour", sum);
			}
			mlist2.add(map1);
			mlist.add(mlist2);
		}

		String json = JSON.toJSONString(mlist);
		session.setAttribute("tasktimemore", json);
		System.out.println("json数据-->" + json.toString());
		request.getRequestDispatcher("/views/tb_users/mtb_tasktimemore.jsp").forward(request, response);
	}
	@RequestMapping(value = "/tb_tasktime_tochart2")
	public String tb_tasktime_tochart2() {
		return "../views/tb_users/mtb_chart2";
	}
	
	//各项目柱形工时对比
		@RequestMapping(value = "/tb_tasktime_totasksbarhour", method = RequestMethod.GET)
		@ResponseBody
		public void tb_tasktime_totasksbarhour(HttpSession session, HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			
			request.getRequestDispatcher("/views/tb_users/mtb_tasksbarhour.jsp").forward(request, response);
		}
		//各任务饼形工时对比
		@RequestMapping(value = "/tb_tasktime_totaskspiehour", method = RequestMethod.GET)
		@ResponseBody
		public void tb_tasktime_totaskspiehour(HttpSession session, HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			
			request.getRequestDispatcher("/views/tb_users/mtb_taskspiehour.jsp").forward(request, response);
		}
		//前处理各人员工时
		@RequestMapping(value = "/tb_tasktime_topreprocesstaskhour", method = RequestMethod.GET)
		@ResponseBody
		public void tb_tasktime_topreprocesstaskhour(HttpSession session, HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			
			request.getRequestDispatcher("/views/tb_users/mtb_preprocesstaskhour.jsp").forward(request, response);
		}

	@RequestMapping(value = "/tb_users_apage", method = RequestMethod.GET)
	@ResponseBody
	public void tb_users_apage(String pnum, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 获取查询条件
		Tb_tasktime tb_tasktime = (Tb_tasktime) session.getAttribute("tb_tasktime");
		gettb_usersPage(session, tb_tasktime, pnum);
		// 跳转到信息管理界面
		request.getRequestDispatcher("/views/tb_users/mtb_tasktime.jsp").forward(request, response);
	}

	@RequestMapping(value = "/getdata", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getdata(Integer id) {
		Tb_tasktime ad = tb_tasktimeService.getById(id);
		JSONObject json = new JSONObject();
		json.put("ob", ad);
		return json.toString();
	}

	public void gettb_usersPage(HttpSession session, Tb_tasktime tb_tasktime, String pnum) {
		// 每页显示的条数
		int scount = 10;
		// 总条数
		int allcount = tb_tasktimeService.getAllCount(tb_tasktime);
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
		tb_tasktime.setSindex(sindex);
		tb_tasktime.setScount(scount);
		List<Tb_tasktime> alist = tb_tasktimeService.getPage(tb_tasktime);
		session.setAttribute("alist", alist);
		session.setAttribute("allnums", allcount);
		session.setAttribute("pagenums", apnum);
		session.setAttribute("pagenum", pnums);
	}

}
