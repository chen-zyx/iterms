package com.iterms.been;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class Tb_node {
	/*private Integer id;
	public Integer getId(){
		return id;
	}
	public void setId(Integer id){
		this.id=id;
	}
	
	private String nodename;
	public String getnodename(){
		return nodename;
	}
	public void setnodename(String nodename){
		this.nodename=nodename;
	}
	
	private String pep;
	public String getpep(){
		return pep;
	}
	public void setpep(String pep){
		this.pep=pep;
	}
	
	private Object nodedate;
	public Object getnodedate() {
		return nodedate;
	}
	public void setnodedate(Object nodedate) {
		this.nodedate=nodedate;
	}
	
	private String nodemark;
	public String getnodemark(){
		return nodemark;
	}
	public void setnodemark(String nodemark){
		this.nodemark=nodemark;
	}
	
	private String nodenowmark;
	public String getnodenowmark() {
		return nodenowmark;
	}
	public void setnodenowmark(String nodenowmark) {
		this.nodenowmark=nodenowmark;
	}
	
	private Integer tb_iterms_id;
	public Integer getTb_iterms_id(){
		return tb_iterms_id;
	}
	public void setTb_iterms_id(Integer tb_iterms_id){
		this.tb_iterms_id=tb_iterms_id;
	}
	
	/*private String tb_iterms_itname;
	public String getTb_iterms_itname(){
		return tb_iterms_itname;
	}
	public void setTb_iterms_itname(String tb_iterms_itname){
		this.tb_iterms_itname=tb_iterms_itname;
	}*/
	
	/*private Integer tb_users_id;
	public Integer getTb_users_id(){
		return tb_users_id;
	}
	public void setTb_users_id(Integer tb_users_id){
		this.tb_users_id=tb_users_id;
	}
	
	private String itname;
	public String getItname(){
		return itname;
	}
	public void setItname(String itname){
		this.itname=itname;
	}
	private String itmark;
	public String getItmark(){
		return itmark;
	}
	public void setItmark(String itmark){
		this.itmark=itmark;
	}
	
	private Integer Sindex;
	public Integer getSindex() {
		return Sindex;
	}
	public void setSindex(Integer sindex) {
		Sindex = sindex;
	}
	private Integer Scount;
	public Integer getScount() {
		return Scount;
	}
	public void setScount(Integer scount) {
		Scount = scount;
	}*/
	
	public Integer id;
	

	public Integer getId() {
	return id;
}
public void setId(Integer id) {
	this.id = id;
}

	public String name;
	public String getname() {
		return name;
	}
	public void setname(String name) {
		this.name=name;
	}
	public String project;
	
	
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}

	public String wochestr;
	public String getwochestr() {
		return wochestr;
	}
	public void setwochestr(String wochestr) {
		this.wochestr=wochestr;
	}
	public void printwochestr() {
		System.out.println(wochestr);
	}
	
	public int jahr;
	public int getjahr() {
		return jahr;
	}
	public void setjahr(int jahr) {
		this.jahr=jahr;
	}
	public void setjahr2() {
		String[] str=wochestr.split("W");
		String[] strr=str[1].split("\\/");
		String jahrstr="20"+strr[1];
		jahr=Integer.parseInt(jahrstr);
	}
	
	public int woche;
	public int getwoche() {
		return woche;
	}
	public void setwoche() {
		String[] str=wochestr.split("W");
		String[] strr=str[1].split("\\/");
		woche=Integer.parseInt(strr[0]);
	}
	
	public Date date;
	public Date getdate() {
		return date;
	}
	public void setdate() {
		Calendar c = new GregorianCalendar(); 
		 c.set(Calendar.YEAR, jahr); 
		 c.set (Calendar.MONTH, Calendar.JANUARY); 
		 c.set(Calendar.DATE, 1);
		 Calendar cal = (GregorianCalendar) c.clone(); 
		 cal.add(Calendar.DATE, (woche-1) * 7);
		 cal.set(Calendar.DAY_OF_WEEK,Calendar.MONDAY);	
		 date=cal.getTime (); 	 
	}
	//時間
	public String time;
	public String getTime() {
		return time;
	}
	public void setTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		this.time=sdf.format(date);
	}

	@Override
	public String toString() {
		return "ExcelData [id=" + id + ", name=" + name + ", project=" + project + ", wochestr=" + wochestr
				+ ", jahr=" + jahr + ", woche=" + woche + ", date=" + date + ", time=" + time + "]";
	}
	
	private Integer Sindex;
	public Integer getSindex() {
		return Sindex;
	}
	public void setSindex(Integer sindex) {
		Sindex = sindex;
	}
	private Integer Scount;
	public Integer getScount() {
		return Scount;
	}
	public void setScount(Integer scount) {
		Scount = scount;
	}

	static int k=0;
	private String[] situ=new String[8];
	public void setsitu(String sit) {
		 situ[k]=new String(); 
		 situ[k]=sit;
		 k++;
	}

	
	private String ipssitu;
	public String getipssitu(){
		return ipssitu;
	}
	public void setipssitu(String ipssitu){
		this.ipssitu=ipssitu;
	}
	
	private String akusitu;
	public String getakusitu(){
		return akusitu;
	}
	public void setakusitu(String akusitu){
		this.akusitu=akusitu;
	}
	
	private String bausitu;
	public String getbausitu(){
		return bausitu;
	}
	public void setbausitu(String bausitu){
		this.bausitu=bausitu;
	}
	
	private String lassitu;
	public String getlassitu(){
		return lassitu;
	}
	public void setlassitu(String lassitu){
		this.lassitu=lassitu;
	}
	
	private String bodensitu;
	public String getbodensitu(){
		return bodensitu;
	}
	public void setbodensitu(String bodensitu){
		this.bodensitu=bodensitu;
	}
	
	private String wassitu;
	public String getwassitu(){
		return wassitu;
	}
	public void setwassitu(String wassitu){
		this.wassitu=wassitu;
	}
	
	private String klasitu;
	public String getklasitu(){
		return klasitu;
	}
	public void setklasitu(String klasitu){
		this.klasitu=klasitu;
	}
	
	private String karositu;
	public String getkarositu(){
		return karositu;
	}
	public void setkarositu(String karositu){
		this.karositu=karositu;
	}
	
}
