package messenger.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import member.model.MemberDao;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;

@Controller
public class MessengerReplyFormController {
	
	@Autowired
	MessengerDao messengerDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value = "replyForm.messenger", produces = "application/json")
	public @ResponseBody MessengerBean replyform(@RequestParam("msg_num") int msg_num) {
		
		MessengerBean mb = messengerDao.getMsgReplyByNum(msg_num);
		MemberBean member = memberDao.getImageByMemNum(mb.getMem_num());
		mb.setImage(member.getImage());
		
		return mb;
	}


}
