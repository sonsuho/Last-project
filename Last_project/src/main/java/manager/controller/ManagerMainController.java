package manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.mCalendarBean;
import manager.model.mCalendarDao;


@Controller
public class ManagerMainController {
	private final String command = "/home.manager";
	private final String getPage = "home";
	
	/* calendar추가코드 */
	@Autowired
	mCalendarDao calendarDao;
	
	@RequestMapping(value = command , method = RequestMethod.GET)
	public ModelAndView approval(
			@RequestParam(value = "month", required = false) String month,
			Model model
			) {
		ModelAndView mav = new ModelAndView();
		List<mCalendarBean> lists = calendarDao.getAllSchedules();
	    mav.addObject("allSchedules", lists);
		mav.setViewName(getPage);
		
		return mav;
	}
	
	
}
