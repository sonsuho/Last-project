package admin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class ChangeAddrController {

private final String command = "changeAddr.admin";
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	@ResponseBody
	public String changeAddr(@RequestParam("addr") String addr, 
						   HttpSession session) {
		
		System.out.println("ChangeAddrController POST 요청");
		
		MemberBean mb = new MemberBean();
		mb.setMem_num(((MemberBean)session.getAttribute("loginInfo")).getMem_num());
		mb.setAddr(addr);
		int cnt = mdao.changeAddr(mb); 
		if(cnt != -1) {
			((MemberBean)session.getAttribute("loginInfo")).setAddr(addr);
			return addr;
		}else {
			return "NO";
		}
	}
	
}
