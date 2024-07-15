package com.spring.model;

public class ChatBean {
	
	private int chat_num;							// 채팅방 번호
	private int lec_num;							// 수업 번호
	private String chat_name;						// 채팅방 이름
	private int mem_num;							// 채팅방 주인 회원 번호
	private String mem_name;							// 채팅방 주인 회원 이름
	
	public int getChat_num() {
		return chat_num;
	}
	public void setChat_num(int chat_num) {
		this.chat_num = chat_num;
	}
	
	public int getLec_num() {
		return lec_num;
	}
	public void setLec_num(int lec_num) {
		this.lec_num = lec_num;
	}
	
	public String getChat_name() {
		return chat_name;
	}
	public void setChat_name(String chat_name) {
		this.chat_name = chat_name;
	}
	
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
}
