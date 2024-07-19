package messenger.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import member.model.MemberDao;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;

@Controller
public class MessengerTopMenuController {

	@Autowired
	MessengerDao messengerDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value = "/topMenu.messenger", method = RequestMethod.GET,  produces = "application/json")
	public @ResponseBody List<MessengerBean> topmenu(HttpSession session) {
		System.out.println("topMenu msg controller");
		MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
		
		int mem_num = loginInfo.getMem_num();
		List<MessengerBean> reclist = messengerDao.getRecentlyMsg(mem_num);
		session.setAttribute("reclist", reclist);
		for(MessengerBean mb :  reclist) {
			System.out.println(mb.getMsg_num());
			System.out.println(mb.getSend_name());
			System.out.println(mb.getSend_time());
		}
		
		return reclist;
		
	}
	
}
