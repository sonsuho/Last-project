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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import member.model.MemberDao;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;
import utility.Paging;

@Controller
public class MessengerUnreadController {

	private final String command = "/unreadList.messenger";
	
	@Autowired
	MessengerDao messengerDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET, produces = "application/json")
	public @ResponseBody List<MessengerBean> unread(@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			HttpServletRequest request,
			Model model, HttpSession session){

		System.out.println("unread controller");

		MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", "%"+keyword+"%");
		map.put("whatColumn", whatColumn);
		map.put("mem_num", loginInfo.getMem_num());
		
		String url = request.getContextPath() + "/" + this.command;
		int totalCount = messengerDao.getTotalCount(map);
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword, "", "");
		
		List<MessengerBean> unreadList = messengerDao.getUnreadList(map, pageInfo);

	    return unreadList;
		
	}
	
}
