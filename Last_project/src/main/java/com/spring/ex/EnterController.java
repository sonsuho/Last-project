package com.spring.ex;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.model.ChatDao;

import member.model.MemberBean;

@Controller
public class EnterController {
    
    final String command = "/enter.chat";
    final String getPage = "home";
    
    @Autowired
	@Qualifier(value = "chat")
    ChatDao cdao;
    
    @RequestMapping(value = command)
    public String enter(HttpServletRequest request, HttpSession session) {
         
        String chat_num = request.getParameter("chat_num"); 						// 폼에서 전달된 room 파라미터 가져오기
        
        MemberBean member = (MemberBean)session.getAttribute("loginInfo");
        
        String chat_name = cdao.getChatNameByChatNum(chat_num);
        
        request.setAttribute("chat_num", chat_num);
        request.setAttribute("chat_name", chat_name);
        request.setAttribute("mem_name", member.getName());
        request.setAttribute("mem_num", member.getMem_num());
        
        System.out.println(chat_num);
        System.out.println(member.getName());
        
        return getPage;
    }
}

