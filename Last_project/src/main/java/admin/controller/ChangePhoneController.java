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
public class ChangePhoneController {

private final String command = "changePhone.admin";
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	@ResponseBody
	public String changePhone(@RequestParam("userPhone") String phone, 
						   HttpSession session) {
		
		System.out.println("ChangePhoneController POST 요청");
		
		MemberBean mb = new MemberBean();
		mb.setMem_num(((MemberBean)session.getAttribute("loginInfo")).getMem_num());

		// 문자열 길이가 11이면 010-xxxx-xxxx 형태로 변환
		if (phone.length() == 11) {
		    String formattedPhone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7);
		    System.out.println(formattedPhone);
		    mb.setPhone(formattedPhone);
		    int cnt = mdao.changePhone(mb);
		    System.out.println("cnt : " + cnt);
		    if(cnt != -1) {
		    	((MemberBean)session.getAttribute("loginInfo")).setPhone(formattedPhone);
		    	return formattedPhone;
		    }else {
		    	return "NO";
		    }
		} else {
		    System.out.println("Invalid phone number format");
		    return "NO";
		}
		
	}
	
}
