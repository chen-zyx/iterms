package com.iterms.been;

public class Modell {
	
	public int id;
	public int getId(){
		return id;
	}
	public void setId(int id){
		this.id=id;
	}
	
	public String name;
	public String getname() {
		return name;
	}
	public void setname(String name) {
		this.name=name;
	}
	
	public String projekt;
	public String getprojekt() {
		return projekt;
	}
	public void setprojekt(String projekt) {
		this.projekt=projekt;
	}
	
	public String kla;
	public String getkla() {
		return kla;
	}
	public void setkla(String kla) {
		this.kla=kla;
	}
	
	public String bezeichnung;
	public String getbezeichnung() {
		return bezeichnung;
	}
	public void setbezeichnung(String bezeichnung) {
		this.bezeichnung=bezeichnung;
	}
	
	public Integer pos;
	public Integer getpos() {
		return pos;
	}
	public void setpos(Integer pos) {
		this.pos=pos;
	}
	@Override
	public String toString() {
		return "Modell [id=" + id + ", name=" + name + ", projekt=" + projekt + ", kla=" + kla + ", bezeichnung="
				+ bezeichnung + ", pos=" + pos + "]";
	}
	
}
