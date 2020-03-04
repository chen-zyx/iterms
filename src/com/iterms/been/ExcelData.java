package com.iterms.been;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class ExcelData {
	
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
		public void setjahr() {
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

	
}
