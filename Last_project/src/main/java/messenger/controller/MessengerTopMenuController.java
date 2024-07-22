package messenger.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import member.model.MemberDao;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;

@Controller
public class MessengerTopMenuController {

	@Autowired
	MessengerDao messengerDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value = "/topMenu.messenger", method = RequestMethod.GET,  produces = "application/json")
	public @ResponseBody List<MessengerBean> topmenu(HttpSession session) {
		System.out.println("topMenu msg controller");
		MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
		
		int mem_num = loginInfo.getMem_num();
		List<MessengerBean> reclist = messengerDao.getRecentlyMsg(mem_num);
			
		int[] memNumArr = new int[reclist.size()];
	    int index = 0;
	    for (MessengerBean mb : reclist) {
	        memNumArr[index++] = mb.getMem_num();
	        System.out.println("mb.getMem_num(): " + mb.getMem_num());
	    }
	    
	    // memNumArr를 사용하여 memlist 가져오기
	    List<MemberBean> memlist = memberDao.getMemberByNum(memNumArr);

	    // memlist를 맵으로 변환하여 mem_num을 키로 사용
	    Map<Integer, MemberBean> memberMap = new HashMap<Integer, MemberBean>();
	    for (MemberBean member : memlist) {
	        memberMap.put(member.getMem_num(), member);
	    }

	    // reclist의 각 MessengerBean에 해당 멤버의 이미지를 설정
	    for (MessengerBean mb : reclist) {
	        MemberBean member = memberMap.get(mb.getMem_num());
	        if (member != null) {
	            mb.setImage(member.getImage());
	            System.out.println("mb.setImage(member.getImage());: " + member.getImage() );
	        }
	    }
		
		return reclist;
		
	}
	
}
