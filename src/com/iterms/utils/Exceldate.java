package com.iterms.utils;



public class Exceldate {
		public String datename;
	    public String datemark;
	    public Object date;
	    private Integer id;
		public Integer getId(){
			return id;
		}
		public void setId(Integer id){
			this.id=id;
		}
	    public String getDatename() {
	        return datename;
	    }
	    public void setDatename(String datename) {
	        this.datename = datename;
	    }
	    public String getDatemark() {
	        return datemark;
	    }
	    public void setDatemark(String datemark) {
	        this.datemark = datemark;
	    }
	    public Object getDate() {
	    	return date;
	    }
	    public void setDate(Object date) {
	    	this.date=date;
	    }
	    /*public Exceldate(String datename, String datemark,Date date) {
	        super();
	        this.datename = datename;
	        this.datemark = datemark;
	        this.date=date;
	    }*/
	    
}
