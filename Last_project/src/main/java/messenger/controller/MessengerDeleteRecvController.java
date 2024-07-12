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
public class MessengerDeleteRecvController {
	
	@Autowired
	MessengerDao messengerDao;
	
	@RequestMapping("deleteRecv.messenger")
	public String delete(@RequestParam("delcheck") int[] delcheckArr, HttpSession session) {
		System.out.println("@@@@@@ delete recv 컨트롤러  : ");
		MessengerBean mb = new MessengerBean();
		System.out.println("mb.getDel_chk()1 : " + mb.getDel_chk());
		
		for (int msg_num : delcheckArr) {
			System.out.println("recvList msg_num: " + msg_num);
			
			mb = messengerDao.getMsgByNum(msg_num);
			
			// 받은 편지함에서 받는 사람 num = login 세션 num 과 같을 때 , 받은사람 번호 + 메세지 번호 + del_chk-1로 업데이트 
			if(mb.getRecv_num() == ((MemberBean)session.getAttribute("loginInfo")).getMem_num() ) {
				System.out.println("del 업데이트1");
				mb.setRecv_num(((MemberBean)session.getAttribute("loginInfo")).getMem_num());
				mb.setDel_chk( mb.getDel_chk() -1 );
				System.out.println("mb.getDel_chk()2 : " + mb.getDel_chk());
			}
			
			
			// del_chk가 0이거나 0보다 작을 때 
			if(mb.getDel_chk() == 0) {
				System.out.println("del_chk 0일 때 delete ");
				System.out.println("mb.getDel_chk()3 : " + mb.getDel_chk());
				messengerDao.deleteMsg(msg_num);
			} else {
				System.out.println("del_chk 0이 아닐 때 update");
				messengerDao.updateForDelMsg(mb);
			}
			
			
        }
		
		return "redirect:/rlist.messenger";
	}
	
	
}
