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
import utility.Sha256;

@Controller
public class ChangePwController {

	private final String command = "changePw.admin";
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	@ResponseBody
	public String changePw(@RequestParam("pw") String pw, 
						   @RequestParam("pw1") String pw1, 
						   HttpSession session) {
		
		System.out.println("ChangePwController POST 요청");
		System.out.println("pw : " + pw);
		System.out.println("pw1 : " + pw1);
		
		MemberBean mb = (MemberBean)session.getAttribute("loginInfo");
		String encryPassword = Sha256.encrypt(pw);
		String changePw = Sha256.encrypt(pw1);
		
		if(encryPassword.equals(mb.getPw())) {
			System.out.println("change pw1 : " + mb.getPw());
			mb.setPw(changePw);
			System.out.println("change pw2 : " + mb.getPw());
			int cnt = mdao.changePw(mb);
			System.out.println("cnt : " + cnt);
			if(cnt!=-1) {
				System.out.println("YES");
				return "YES";
			} else {
				System.out.println("ERROR");
				return "ERROR";
			}
		} else {
			return "NO";
		}
		
	}
}
