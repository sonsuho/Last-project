package student.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.RequestDao;
import member.model.MemberBean;
import member.model.MemberDao;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;


@Controller
@ComponentScan({"member,messenger,student"})
public class StudentMainController {
	private final String command = "/home.student";
	private final String getPage = "home";
	
	@Autowired
	RequestDao requestDao;
	
	@Autowired
	MessengerDao messengerDao;
	
	@Autowired
	MemberDao memberDao;
	
	/* calendar추가코드 */
	@Autowired 
	student.model.sCalendarDao sCalendarDao;
	
	@RequestMapping(value = command , method = RequestMethod.GET)
	public ModelAndView approval(
			HttpSession session,
			@RequestParam(value = "month", required = false) String month,
			Model model
			) {
		
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		
		int mem_num = loginInfo.getMem_num();
		System.out.println("mem_num: " + mem_num);
		
		List<MessengerBean> reclist = messengerDao.getRecentlyMsg(mem_num);
		session.setAttribute("reclist", reclist);
		
		for(MessengerBean mb :  reclist) {
			System.out.println(mb.getMsg_num());
			System.out.println(mb.getSend_name());
			System.out.println(mb.getSend_time());
		}
		
		ModelAndView mav = new ModelAndView();
		List<student.model.sCalendarBean> lists = sCalendarDao.getAllSchedules();
	    model.addAttribute("allSchedules", lists);
		mav.setViewName(getPage);
		
		return mav;
	}
	
	
}
