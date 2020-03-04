package com.iterms.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iterms.been.Tb_message;
import com.iterms.been.Tb_users;
import com.iterms.service.Tb_messageService;
import com.iterms.utils.PageModel;

@Controller
@RequestMapping(value = "tb_message")
public class Tb_messageController {

	@Autowired
	private Tb_messageService tb_messageService;

	// 跳轉到信息頁面
	@RequestMapping(value = "/tb_message_show", method = RequestMethod.GET)
	@ResponseBody
	public void tb_message_show( HttpSession session,HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Tb_users tb_users = (Tb_users) session.getAttribute("myinfo");
		session.setAttribute("user", tb_users);
		Tb_message tb_message = new Tb_message();
		tb_message.setReceiver(tb_users.getUemail());
		tb_message.setStatus("未查看");
		tb_message.setSendstatus("可查");
		Integer count = tb_messageService.getCount(tb_message);
		session.setAttribute("count", count);
		request.getRequestDispatcher("/views/tb_users/mtb_message.jsp").forward(request, response);
	}

	// 显示未读信息
	@RequestMapping(value = "/tb_message_unread", method = RequestMethod.GET)
	@ResponseBody
	public void tb_message_unread(PageModel<Tb_message> pm, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		if (pm.getCurrentPage() == null) {
			pm.setCurrentPage(1);
		}
		Tb_users tb_users = (Tb_users) session.getAttribute("myinfo");
		Tb_message tb_message = new Tb_message();
		tb_message.setReceiver(tb_users.getUemail());
		tb_message.setStatus("未查看");
		PageModel<Tb_message> messages = tb_messageService.getMessages(tb_message, pm);
		session.setAttribute("messages", messages);
		session.setAttribute("user", tb_users);
		request.getRequestDispatcher("/views/tb_users/mtb_unreadmessage.jsp").forward(request, response);
	}

	// 显示已读信息
	@RequestMapping(value = "/tb_message_read", method = RequestMethod.GET)
	@ResponseBody
	public void tb_message_read(PageModel<Tb_message> pm, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		if (pm.getCurrentPage() == null) {
			pm.setCurrentPage(1);
		}
		Tb_users tb_users = (Tb_users) session.getAttribute("user");
		Tb_message tb_message = new Tb_message();
		tb_message.setReceiver(tb_users.getUemail());
		tb_message.setStatus("已查看");
		PageModel<Tb_message> messages = tb_messageService.getMessages(tb_message, pm);
		session.setAttribute("messages", messages);
		request.getRequestDispatcher("/views/tb_users/mtb_readmessage.jsp").forward(request, response);
	}
	
	// 显示已發送信息
		@RequestMapping(value = "/tb_message_send", method = RequestMethod.GET)
		@ResponseBody
		public void tb_message_send(PageModel<Tb_message> pm, HttpSession session, HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {
			if (pm.getCurrentPage() == null) {
				pm.setCurrentPage(1);
			}
			Tb_users tb_users = (Tb_users) session.getAttribute("user");
			Tb_message tb_message = new Tb_message();
			tb_message.setSender(tb_users.getUemail());
			tb_message.setSendstatus("可查");
			PageModel<Tb_message> messages = tb_messageService.getMessages(tb_message, pm);
			session.setAttribute("sendmessages", messages);
			request.getRequestDispatcher("/views/tb_users/mtb_sendmessage.jsp").forward(request, response);
		}

	// 查看郵件 如果郵件是未查看，先改爲已查看
	@RequestMapping(value = "/tb_openMessage", method = RequestMethod.GET)
	@ResponseBody
	public void tb_openMessage(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String flag = request.getParameter("flag");
			Integer id = Integer.parseInt(request.getParameter("id"));
			Tb_message message = tb_messageService.findById(id);
			if (message.getStatus().equals("未查看")) {
				message.setStatus("已查看");
				tb_messageService.update(message);
			}
			session.setAttribute("flag", flag);
			session.setAttribute("message", message);
			session.setAttribute("receivetime", DateFormat.getDateInstance(DateFormat.FULL)
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(message.getCreatetime())));
		} catch (ParseException e) { // TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("/views/tb_users/mtb_openmessage.jsp").forward(request, response);
	}

	@RequestMapping(value = "/getCount", method = RequestMethod.GET)
	@ResponseBody
	public Integer getCount(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Tb_users tb_users = (Tb_users) request.getSession().getAttribute("myinfo");
		Tb_message tb_message = new Tb_message();
		tb_message.setReceiver(tb_users.getUemail());
		tb_message.setStatus("未查看");
		tb_message.setSendstatus("可查");
		Integer count = tb_messageService.getCount(tb_message);
		return count;
	}

	@RequestMapping(value = "/tb_message_add", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String tb_message_add(Tb_message tb_message, HttpServletRequest request) {
		tb_message.setCreatetime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		if (tb_messageService.insert(tb_message) > 0) {
			return "{\"msg\":\"发送成功\"}";
		} else {
			return "{\"msg\":\"发送失败\"}";
		}
	}

	@RequestMapping(value = "/del", method = RequestMethod.POST)
	@ResponseBody
	public String del(Tb_message tb_message) {
		/*
		 * int id = Integer.parseInt(request.getParameter("id")); String status =
		 * request.getParameter("status"); Tb_message tb_message = new Tb_message();
		 * tb_message.setId(id); tb_message.setStatus(status);
		 */
		if (tb_messageService.update(tb_message) > 0) {
			return "{\"msg\":\"删除成功\"}";
		} else {
			return "{\"msg\":\"删除失败\"}";
		}
	}
}
