package messenger.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MessengerSelectedListController {
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping("selectedList.messenger")
	@ResponseBody
	public List<MemberBean> selectedList(@RequestBody int[] mem_num){
		System.out.println("memnum:" + mem_num);
		List<MemberBean> list = memberDao.getMemberByNum(mem_num);
	
		return list;
	}
	
}
