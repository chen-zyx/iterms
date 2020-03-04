package com.iterms.been;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Tb_tasktime {

	private Integer id;
	public Integer getId(){
		return id;
	}
	public void setId(Integer id){
		this.id=id;
	}
	
	private String name;
	public String getname(){
		return name;
	}
	public void setname(String name){
		this.name=name;
	}
	
	private String project;
	public String getproject(){
		return project;
	}
	public void setproject(String project){
		this.project=project;
	}
	
	private String taskname;
	public String gettaskname(){
		return taskname;
	}
	public void settaskname(String taskname){
		this.taskname=taskname;
	}
	
	private String preprocess;
	public String getpreprocess(){
		return preprocess;
	}
	public void setpreprocess(String preprocess){
		this.preprocess=preprocess;
	}
	
	private String calcuv1;
	public String getcalcuv1(){
		return calcuv1;
	}
	public void setcalcuv1(String calcuv1){
		this.calcuv1=calcuv1;
	}
	
	private String calcuv2;
	public String getcalcuv2(){
		return calcuv2;
	}
	public void setcalcuv2(String calcuv2){
		this.calcuv2=calcuv2;
	}
	
	private String report;
	public String getreport(){
		return report;
	}
	public void setreport(String report){
		this.report=report;
	}
	
	private String tname;
	public String gettname(){
		return tname;
	}
	public void settname(String tname){
		this.tname=tname;
	}
	
	private Integer pnumber;
	public Integer getpnumber(){
		return pnumber;
	}
	public void setpnumber(Integer pnumber){
		this.pnumber=pnumber;
	}
	
	public String sstime;
	public String getsstime() {
		return sstime;
	}
	public void setsstime(String sstime) {
		this.sstime=sstime;
	}
	
	public String srtime;
	public String getsrtime() {
		return srtime;
	}
	public void setsrtime(String srtime) {
		this.srtime=srtime;
	}
	public String ostime;
	public String getostime() {
		return ostime;
	}
	public void setostime(String ostime) {
		this.ostime=ostime;
	}
	
	public String ortime;
	public String getortime() {
		return ortime;
	}
	public void setortime(String ortime) {
		this.ortime=ortime;
	}
	
	private Integer tb_task_id;
	public Integer getTb_task_id(){
		return tb_task_id;
	}
	public void setTb_task_id(Integer tb_task_id){
		this.tb_task_id=tb_task_id;
	}
	
	private Integer tb_node_id;
	public Integer getTb_node_id(){
		return tb_node_id;
	}
	public void setTb_node_id(Integer tb_node_id){
		this.tb_node_id=tb_node_id;
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
	
	private int tflag;
	public int gettflag() {
		return tflag;
	}
	public void settflag() {
		int a,b,c,d;
		if (sstime=="") {
			a=1;
		}else {
			a=2;
		}
		if (srtime=="") {
			b=1;
		}else {
			b=2;
		}
		if (ostime=="") {
			c=1;
		}else {
			c=2;
		}
		if (ortime=="") {
			d=1;
		}else {
			d=2;
		}
		tflag=a*1000+b*100+c*10+d;
	}
	
	private Integer shour;
	public Integer getshour(){
		return shour;
	}
	public void sethour() throws ParseException{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d1=sdf.parse(sstime);
		String currentDate =  sdf.format( new Date() );
		Date d0=sdf.parse(currentDate);
		Date d2=sdf.parse(srtime);
		Date d3=sdf.parse(ostime);
		Date d4=sdf.parse(ortime);

		switch(tflag) {
		case 1111:
			break;
		case 2111:
			shour=daysBetween(d1,d0)*pnumber;
			sminus=daysBetween(d1,d0);
			break;
		case 1211:
			shour=daysBetween(d2,d0)*pnumber;
			rhour=daysBetween(d2,d0)*pnumber;
			sminus=0;
			break;
		case 1121:
			shour=daysBetween(d0,d3)*pnumber;
			rhour=0;
			break;
		case 1112:
			
			break;
		case 2211:
			shour=daysBetween(d1,d0)*pnumber;
			rhour=daysBetween(d2,d0)*pnumber;
			sminus=daysBetween(d1,d2);
			break;
		case 2121:
			shour=daysBetween(d1,d3)*pnumber;
			rhour=0;
			sminus=daysBetween(d1,d0);
			break;
		case 2112:
			shour=daysBetween(d1,d4)*pnumber;
			rhour=daysBetween(d2,d0)*pnumber;
			rminus=0;
			break;
		case 1221:
			shour=daysBetween(d2,d3)*pnumber;
			rhour=daysBetween(d2,d0)*pnumber;
			sminus=0;
			break;
		case 1212:
			shour=daysBetween(d2,d4)*pnumber;
			rhour=daysBetween(d2,d4)*pnumber;
			sminus=0;
			rminus=0;
			break;
		case 1122:
			
			rminus=daysBetween(d3,d4);
			break;
		case 2221:
			shour=daysBetween(d2,d3)*pnumber;
			rhour=daysBetween(d2,d0)*pnumber;
			sminus=daysBetween(d1,d2);
			break;
		case 2212:
			shour=daysBetween(d1,d4)*pnumber;
			rhour=daysBetween(d2,d4)*pnumber;
			sminus=daysBetween(d1,d2);
			rminus=0;
			break;
		case 2122:
			shour=daysBetween(d1,d3)*pnumber;
			rhour=daysBetween(d1,d4)*pnumber;
			sminus=0;
			rminus=daysBetween(d3,d4);
			break;
		case 1222:
			shour=daysBetween(d2,d3)*pnumber;
			rhour=daysBetween(d2,d4)*pnumber;
			rminus=daysBetween(d3,d4);
			break;
		case 2222:
			shour=daysBetween(d1,d3)*pnumber;
			rhour=daysBetween(d2,d4)*pnumber;
			sminus=daysBetween(d1,d2);
			rminus=daysBetween(d3,d4);
			break;
		}

	}
	private Integer rhour;
	public Integer getrhour(){
		return rhour;
	}
	
	private Integer sminus;
	public Integer getsminus(){
		return sminus;
	}
	
	private Integer rminus;
	public Integer getrminus(){
		return rminus;
	}
	
	
	/**

	* 计算两个日期之间相差的天数

	* @param smdate 较小的时间

	* @param bdate 较大的时间

	* @return 相差天数

	* @throws ParseException

	*/

	public static int daysBetween(Date smdate,Date bdate) throws ParseException

	{

	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

	smdate=sdf.parse(sdf.format(smdate));

	bdate=sdf.parse(sdf.format(bdate));

	Calendar cal = Calendar.getInstance();

	cal.setTime(smdate);

	long time1 = cal.getTimeInMillis();

	cal.setTime(bdate);

	long time2 = cal.getTimeInMillis();

	long between_days=(time2-time1)/(1000*3600*24);

	return Integer.parseInt(String.valueOf(between_days));

	}

	/**

	*字符串的日期格式的计算

	*/

	public static int daysBetween(String smdate,String bdate) throws ParseException{

	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

	Calendar cal = Calendar.getInstance();

	cal.setTime(sdf.parse(smdate));

	long time1 = cal.getTimeInMillis();

	cal.setTime(sdf.parse(bdate));

	long time2 = cal.getTimeInMillis();

	long between_days=(time2-time1)/(1000*3600*24);

	return Integer.parseInt(String.valueOf(between_days));

	}
	@Override
	public String toString() {
		return "Tb_tasktime [id=" + id + ", name=" + name + ", project=" + project + ", taskname=" + taskname
				+ ", preprocess=" + preprocess + ", calcuv1=" + calcuv1 + ", calcuv2=" + calcuv2 + ", report=" + report
				+ ", tname=" + tname + ", pnumber=" + pnumber + ", sstime=" + sstime + ", srtime=" + srtime
				+ ", ostime=" + ostime + ", ortime=" + ortime + ", tb_task_id=" + tb_task_id + ", tb_node_id="
				+ tb_node_id + ", Sindex=" + Sindex + ", Scount=" + Scount + ", tflag=" + tflag + ", shour=" + shour
				+ ", rhour=" + rhour + ", sminus=" + sminus + ", rminus=" + rminus + "]";
	}

	
}
