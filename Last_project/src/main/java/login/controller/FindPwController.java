package login.controller;

import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import member.model.MemberDao;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import utility.Sha256;

@Controller
@ComponentScan(basePackages = {"login","member"})
public class FindPwController {

	private final String command = "findPw.in";
	private final String getPage = "findPwForm";
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String findPw() {
		return getPage;
	}
	
	@RequestMapping(value="findPw.in", method=RequestMethod.POST)
	@ResponseBody
	public String findPw(@RequestParam("userId") String id,
				 					  @RequestParam("userPhone") String phone) throws Exception {
		
		MemberBean mb = new MemberBean();
		mb.setId(id);
		mb.setPhone(phone);
		
		int mem_num = mdao.findPw(mb);
		if(mem_num == -1) {
			System.out.println("일치하는 회원정보가 없습니다");
			return "NO";
		}
		
		mb.setMem_num(mem_num);
		String code = sendSms(mb);
		System.out.println("findPw POST code : " + code);
	    return code + "," + mem_num;
	}
	
	@RequestMapping(value="sendSms.in", method=RequestMethod.POST)
	@ResponseBody
	public String sendSms(@RequestParam("userPhone") String phone, HttpSession session) throws Exception {
		
		MemberBean mb = new MemberBean();
		mb.setMem_num(((MemberBean)session.getAttribute("loginInfo")).getMem_num());
		mb.setPhone(phone);
		String code = sendSms(mb);
		System.out.println("findPw POST code : " + code);
		
		return code;
	}
	
	public String sendSms(MemberBean mb) throws Exception {

		System.out.println("SMS 본인인증 시작");
		
		// 6자리 랜덤 숫자 생성
		Random rand = new Random();
		String numStr = "";
		for(int i=0; i<6; i++) {
			String ran = Integer.toString(rand.nextInt(10)); 
			numStr += ran;
		}
		
		
		String api_key = "NCSF9UNVAWPDZPCR";
	    String api_secret = "FT1K1DIIZKUDYBKAXKUTUMSHW2ZUWVUP";
	    Message coolsms = new Message(api_key, api_secret);

	  
	    HashMap<String, String> set = new HashMap<String, String>();
	    set.put("to", "01084249684"); // 수신번호
	    set.put("from", "01084249684"); // 발신번호
	    set.put("text", "sist 인증번호 ["+numStr+"]"); // 문자내용
	    set.put("type", "sms"); // 문자 타입

	    System.out.println("인증 정보 설정 완료 [" + numStr + "]");
	    System.out.println(set);
	    try {
	        JSONObject result = coolsms.send(set); // 보내기&전송결과받기
	        System.out.println("인증 정보 전송 완료 [" + numStr + "]");
	        System.out.println(result.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
        

	    System.out.println("돌아가기");
	    
	    return numStr;
	}
	
	@RequestMapping("changePw.in")
	public String changePw(MemberBean mb) {
		System.out.println("변경하는 pw : " + mb.getPw());
		System.out.println("변경하는 mem_num : " + mb.getMem_num());
		
		System.out.println("해시전 PW : " + mb.getPw());
		String encryPassword = Sha256.encrypt(mb.getPw());
		mb.setPw(encryPassword);
        System.out.println("해시후 PW : " + mb.getPw());
		int cnt = mdao.changePw(mb);
		if(cnt==-1) {
			System.out.println("비밀번호 변경 실패");
		} else {
			System.out.println("비밀번호 변경 성공");
		}
		
		return "redirect:/login.in";
	}
}
