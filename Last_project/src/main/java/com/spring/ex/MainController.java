package com.spring.ex;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.model.ChatBean;
import com.spring.model.ChatDao;
import member.model.MemberBean;

@Controller
public class MainController {
	
	final String command = "/main.chat";
	final String getPage = "main";
	
	@Autowired
	@Qualifier(value = "chat")
	ChatDao cdao;
	
	@RequestMapping(value = command)
	public ModelAndView main(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		MemberBean member = (MemberBean)session.getAttribute("loginInfo");
		String lec_num = member.getLec_num();
		
		List<ChatBean> clist = cdao.getAllChat(Integer.parseInt(lec_num));
		
		List<ChatBean> mylist = cdao.getChatByMy(member.getMem_num());

		mav.addObject("clist", clist);
		mav.addObject("mylist", mylist);
		
		mav.setViewName(getPage);
		
		return mav;
	}
}
