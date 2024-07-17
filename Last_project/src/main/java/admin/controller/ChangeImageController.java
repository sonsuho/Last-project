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
public class ChangeImageController {

private final String command = "changeImage.admin";
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	@ResponseBody
	public String changeImage(@RequestParam("image") String image, 
						   HttpSession session) {
		
		System.out.println("ChangeImageController POST 요청");
		
		MemberBean mb = new MemberBean();
		mb.setMem_num(((MemberBean)session.getAttribute("loginInfo")).getMem_num());

		//int cnt = mdao.changeImage(mb);
		return null;
	}
	
}
