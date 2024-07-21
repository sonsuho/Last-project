package manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.AttendBean;

@Controller
public class ManagerAttendStatusController {

	private final String viewCommand = "/attStatus.manager";
	
	final String getPage = "attendStatusForm";
	
	@Autowired
	manager.model.ManagerAttendDao mAttendDao;
	
	@RequestMapping(value = viewCommand, method = RequestMethod.GET)
	public String form(
				@RequestParam(value = "mem_num", required = true) String mem_num,
				Model model
			) {
		List<AttendBean> lists = mAttendDao.getAttendListByMem_num(mem_num);
		model.addAttribute("attendLists",lists);
		return getPage;
	}
}
