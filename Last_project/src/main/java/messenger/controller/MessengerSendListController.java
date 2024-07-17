package messenger.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;
import utility.Paging;

@Controller
public class MessengerSendListController {
	//보낸 메신저함 리스트
	
	private final String command = "/slist.messenger";
	private final String gotoPage = "messengerSendList";
	
	@Autowired
	MessengerDao messengerDao;
	
	@Autowired
	MemberDao memberDao;
	
	// 
	@RequestMapping(command)
	public String slist(@RequestParam(value = "pageNumber", required = false) String pageNumber,
						@RequestParam(value = "whatColumn", required = false) String whatColumn,
						@RequestParam(value = "keyword", required = false) String keyword,
						HttpServletRequest request,
						Model model, HttpSession session) {
		List<MemberBean> managerlist = memberDao.getMemberByCate("manager");
		List<MemberBean> teacherlist = memberDao.getMemberByCate("teacher");
		List<MemberBean> studentlist = memberDao.getMemberByCate("student");
		model.addAttribute("managerlist", managerlist);
		model.addAttribute("teacherlist", teacherlist);
		model.addAttribute("studentlist", studentlist);
		
		MemberBean info = (MemberBean) session.getAttribute("loginInfo");
		
		// Null 체크 추가
	    if (info == null) {
	        // 예외 처리 방법 중 하나: 로그인 페이지로 리다이렉트
	        return "redirect:/login.in";
	    }
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", "%"+keyword+"%");
		map.put("whatColumn", whatColumn);
		map.put("mem_num", info.getMem_num());
		
		String url = request.getContextPath() + "/" + this.command;
		int totalCount = messengerDao.getSendTotalCount(map);
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword, "", "");
		
		List<MessengerBean> slist = messengerDao.getMsgSendList(map, pageInfo);
		
		model.addAttribute("slist", slist);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		
		
		return gotoPage;
	}
	
}
