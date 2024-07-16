package com.spring.ex;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.model.ChatBean;
import com.spring.model.ChatDao;
import member.model.MemberBean;

@Controller
public class MakeChatController {
	
	final String command = "/make.chat";
	final String getPage = "makeForm";
	final String gotoPage = "redirect:/main.chat";
	
	@Autowired
	ChatDao cdao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String makeForm() {
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String make(@RequestParam(value = "chat_name") String chat_name, HttpSession session, HttpServletResponse response) {
		
		response.setContentType("text/html;charset=utf-8");
		
		if(chat_name == null || chat_name.equals("")) {
			
			try {
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
                out.println("alert('스터디 그룹명을 입력하세요!!!');");
                out.println("location.href='make.chat';"); // 이동할 페이지 설정
                out.println("</script>");
                
                out.flush();
                out.close();
				
                return null;
                
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		MemberBean member = (MemberBean)session.getAttribute("loginInfo");
		
		ChatBean cb = new ChatBean();
		
		cb.setChat_name(chat_name);
		cb.setLec_num(Integer.parseInt(member.getLec_num()));
		cb.setMem_num(member.getMem_num());
		cb.setMem_name(member.getName());
		
		cdao.insertChat(cb);
		
		return gotoPage;
	}
}
