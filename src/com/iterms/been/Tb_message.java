package com.iterms.been;

public class Tb_message {
	
	private Integer id;
	private String sender;     //发送人邮箱
	private String receiver;	//接收人id
	private String title;		//信息标题
	private String content;		//信息内容
	private String status;		//接收信息查看状态
	private String sendstatus;	//發送信息狀態
	private String createtime;	//信息发送时间
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getSendstatus() {
		return sendstatus;
	}
	public void setSendstatus(String sendstatus) {
		this.sendstatus = sendstatus;
	}
	@Override
	public String toString() {
		return "Tb_message [id=" + id + ", sender=" + sender + ", receiver=" + receiver + ", title=" + title
				+ ", content=" + content + ", status=" + status + ", sendstatus=" + sendstatus + ", createtime="
				+ createtime + "]";
	}
}
