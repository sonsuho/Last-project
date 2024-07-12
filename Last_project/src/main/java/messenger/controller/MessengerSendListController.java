package messenger.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;

@Controller
public class MessengerSendListController {
	//보낸 메신저함 리스트
	
	private final String command = "/slist.messenger";
	private final String gotoPage = "messengerSendList";
	
	@Autowired
	MessengerDao messengerDao;
	
	// 
	@RequestMapping(command)
	public String slist(Model model, HttpSession session) {
		
		MemberBean info = (MemberBean) session.getAttribute("loginInfo");
		
		List<MessengerBean> slist = messengerDao.getMsgSendList(info.getMem_num());
		model.addAttribute("slist", slist);
		
		return gotoPage;
	}
	
}
