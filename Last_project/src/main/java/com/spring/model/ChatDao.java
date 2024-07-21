package com.spring.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component(value = "chat")
public class ChatDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public ChatDao() {
		System.out.println("ChatDao 생성자");
	}

	public List<ChatBean> getAllChat(int lec_num) {
		
		List<ChatBean> clist = sqlSessionTemplate.selectList("chat.model.Chat.getAllChat", lec_num);
		
		System.out.println("getAllChat 사이즈 : " + clist.size());
		
		return clist;
	}

	public List<ChatBean> getChatByMy(int mem_num) {
		
		List<ChatBean> mylist = sqlSessionTemplate.selectList("chat.model.Chat.getChatByMy", mem_num);
		
		System.out.println("getChatByMy 사이즈 : " + mylist.size());
		
		return mylist;
	}

	public int insertChat(ChatBean cb) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.insert("chat.model.Chat.insertChat", cb);
		
		System.out.println("insertChat cnt : " + cnt);
		
		return cnt;
	}

	public int deleteChat(int chat_num) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.delete("chat.model.Chat.deleteChat", chat_num);
		
		System.out.println("deleteChat cnt : " + cnt);
		
		return cnt;
	}

	public String getChatNameByChatNum(String chat_num) {
		
		String chat_name = sqlSessionTemplate.selectOne("chat.model.Chat.getChatNameByChatNum", chat_num);
		
		System.out.println("getChatNameByChatNum name : " + chat_name);
		
		return chat_name;
	}
	
	
}
