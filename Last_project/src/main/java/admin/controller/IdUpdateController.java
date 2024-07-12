package admin.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class IdUpdateController {

	private final String command = "idUpdate.admin";
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(command)
	public String idUpdate(@RequestBody Map<String, Object> data) {
		System.out.println("Received Data: " + data);
		MemberBean mb = new MemberBean();
		//adao.idUpdate(data);
		return "수정완료";
	}
	
}
