package messenger.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;

@Controller
public class MessengerDetailController {

	@Autowired
	MessengerDao messengerDao;
	
	
	
	@RequestMapping(value="/detail.messenger", produces = "application/json")
	public @ResponseBody MessengerBean detail(@RequestParam("msg_num") int msg_num, HttpSession session) {
		System.out.println("여기루 오나여? 디테일?");
		System.out.println("msg_num: " + msg_num);
		
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		
		MessengerBean mb = messengerDao.getMsgDetailByNum(msg_num, loginInfo);
		
		String msgUpload = mb.getMsg_upload();
        if (msgUpload != null) {
            String[] uploadList = msgUpload.split("/");
            mb.setUploadList(uploadList);
        } else {
            // 메시지의 첨부파일 정보가 없는 경우에 대한 처리
            mb.setUploadList(new String[0]); // 빈 배열로 초기화 또는 null로 설정
        }
		
		return mb;
	}
}
