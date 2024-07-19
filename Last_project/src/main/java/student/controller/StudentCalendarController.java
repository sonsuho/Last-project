package student.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class StudentCalendarController {

	private final String command1 = "/calendar.student";
	private final String getPage = "calendarForm";
	
	@Autowired 
	student.model.sCalendarDao sCalendarDao;

	//calendar.manager 요청
	@RequestMapping(value=command1, method = RequestMethod.GET)
	public String form(
			@RequestParam(value = "month", required = false) String month,
			Model model
			) {
	    List<student.model.sCalendarBean> lists = sCalendarDao.getAllSchedules();
	    model.addAttribute("allSchedules", lists);
	    return getPage;
	}

}
