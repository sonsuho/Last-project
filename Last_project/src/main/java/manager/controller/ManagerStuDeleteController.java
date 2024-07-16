package manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberDao;

@Controller
public class ManagerStuDeleteController {

	private final String command = "stuDelete.manager";
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestParam("mem_num") int mem_num) {
		
		String result;
		
		int cnt = mdao.idDelete(mem_num);
		if(cnt==-1)
			result = "삭제 실패";
		else
			result = "삭제 성공";
		
		return result;
	}
	
}
