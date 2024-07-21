package com.spring.ex;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.model.ChatBean;
import com.spring.model.ChatDao;

import member.model.MemberBean;

@Controller
public class DeleteChatController {
	
	final String command = "/delete.chat";
	final String getPage = "redirect:/main.chat";
	
	@Autowired
	ChatDao cdao;
	
	@RequestMapping(command)
	public String deleteChat(@RequestParam(value = "chat_num") int chat_num, HttpSession session, HttpServletResponse response) {
		
		response.setContentType("text/html;charset=utf-8");
		
		System.out.println("삭제할 번호 : " + chat_num);
		
		MemberBean member = (MemberBean)session.getAttribute("loginInfo");
		
		int mem_num = member.getMem_num();
		
		List<ChatBean> clist = cdao.getChatByMy(mem_num);
		
		Boolean check = false;
		
		for(ChatBean chat : clist) {
			if(chat.getChat_num() == chat_num) {
				check = true;
				break;
			}
		}
		
		if(check) {			
			cdao.deleteChat(chat_num);
		}else {
			
			try {
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
                out.println("alert('삭제하려는 채팅방의 방장이 아닙니다!!!');");
                out.println("location.href='main.chat';"); // 이동할 페이지 설정
                out.println("</script>");
                
                out.flush();
                out.close();
                
                return null;
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return getPage;
	}
	
}
