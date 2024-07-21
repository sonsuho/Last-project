package messenger.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;

@Controller
public class MessengerDeleteSendController {
	
	@Autowired
	MessengerDao messengerDao;
	
	@RequestMapping("deleteSend.messenger")
	public String delete(@RequestParam("delcheck") int[] delcheckArr, HttpSession session) {
		System.out.println("@@@@@@ delete send 컨트롤러  : ");
		MessengerBean mb = new MessengerBean();
		System.out.println("mb.getDel_chk()1 : " + mb.getDel_chk());
		
		for (int msg_num : delcheckArr) {
			System.out.println("sendList msg_num: " + msg_num);
			
			mb = messengerDao.getMsgByNum(msg_num);
			
			// 보낸 편지함에서 보낸 사람 num = login 세션 num 과 같을 때 , 보낸 사람 번호 + 메세지 번호 + del_chk -2로 업데이트  
			if (mb.getMem_num() == ((MemberBean)session.getAttribute("loginInfo")).getMem_num()) {
				System.out.println("del 업데이트2");
				mb.setMem_num( ((MemberBean)session.getAttribute("loginInfo")).getMem_num());
				mb.setDel_chk( mb.getDel_chk() -2 );
				System.out.println("mb.getDel_chk()3 : " + mb.getDel_chk());
			}
			
			// del_chk가 0이거나 0일 때 삭제
			if(mb.getDel_chk() == 0) {
				System.out.println("del_chk 0일 때 delete ");
				System.out.println("mb.getDel_chk()3 : " + mb.getDel_chk());
				messengerDao.deleteMsg(msg_num);
			} else {
				System.out.println("del_chk 0이 아닐 때 update");
				System.out.println("mb.getDel_chk()4 update : " + mb.getDel_chk());
				messengerDao.updateForDelMsg(mb);
			}
			
			
        }
		
		return "redirect:/slist.messenger";
	}
	
	
}
