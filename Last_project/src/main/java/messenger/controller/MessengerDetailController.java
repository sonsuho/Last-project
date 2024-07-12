package messenger.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import messenger.model.MessengerBean;
import messenger.model.MessengerDao;

@Controller
public class MessengerDetailController {

	@Autowired
	MessengerDao messengerDao;
	
	@RequestMapping(value="/detail.messenger", produces = "application/json")
	public @ResponseBody MessengerBean detail(@RequestParam("msg_num") int msg_num) {
		System.out.println("여기루 오나여? 디테일?");
		System.out.println("msg_num: " + msg_num);
		MessengerBean mb = messengerDao.getMsgDetailByNum(msg_num);
		
		return mb;
	}
}
