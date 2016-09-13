package kr.or.kosta.otl.vo;

public class Member {
private int mem_seq;
private String id;
private String pw;
private String name;
private int auth;


public int getMem_seq() {
	return mem_seq;
}
public void setMem_seq(int mem_seq) {
	this.mem_seq = mem_seq;
}
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getPw() {
	return pw;
}
public void setPw(String pw) {
	this.pw = pw;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getAuth() {
	return auth;
}
public void setAuth(int auth) {
	this.auth = auth;
}
@Override
public String toString() {
	return "member [mem_seq=" + mem_seq + ", id=" + id + ", pw=" + pw + ", name=" + name + ", auth=" + auth + "]";
}



}
