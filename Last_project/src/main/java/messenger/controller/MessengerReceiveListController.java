package messenger.controller;

import java.util.ArrayList;
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
public class MessengerReceiveListController {
	//받은 메신저함 리스트
	
	private final String command = "/rlist.messenger";
	private final String gotoPage = "messengerMain";
	
	@Autowired
	MessengerDao messengerDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(command)
	public String rlist(@RequestParam(value = "pageNumber", required = false) String pageNumber,
						@RequestParam(value = "whatColumn", required = false) String whatColumn,
						@RequestParam(value = "keyword", required = false) String keyword,
						HttpServletRequest request,
						Model model, HttpSession session) {
		
		List<MemberBean> admin = memberDao.getMemberByCate("admin");
		List<MemberBean> managerlist = memberDao.getMemberByCate("manager");
		List<MemberBean> teacherlist = memberDao.getMemberByCate("teacher");
		List<MemberBean> studentlist = memberDao.getMemberByCate("student");
		model.addAttribute("admin", admin);
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
		
		System.out.println("info.getMem_num: " + info.getMem_num());
		System.out.println("whatcolumn: " + whatColumn);
		System.out.println("keyword: " + keyword);
		
		String url = request.getContextPath() + "/" + this.command;
		int totalCount = messengerDao.getTotalCount(map);
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword);
		
		List<MessengerBean> rlist = messengerDao.getMsgRecvList(map, pageInfo);
				
		model.addAttribute("rlist", rlist);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		
		return gotoPage;
	}
	
	
}

