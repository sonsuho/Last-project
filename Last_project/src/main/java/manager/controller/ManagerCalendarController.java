package manager.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.mCalendarBean;
import manager.model.mCalendarDao;

@Controller
public class ManagerCalendarController {

	private final String command1 = "/calendar.manager";
	//managerHome.jsp에서 '학원일정' 클릭 시 요청, detailSchedule.jsp에서 뒤로 돌아가기 누르면 요청
	
	private final String detailCommand = "/schedule.manager";
	//calendarForm.jsp 에서 날짜 누르면 요청
		
	private final String viewCommand = "/scheduleView.manager";	//detailSchedule.jsp에서 '제목' 클릭
	private final String insertCommand = "/scheduleInsert.manager";	//detailSchedule.jsp에서 '일정추가' 클릭
	private final String updateCommand = "/scheduleUpdate.manager";	//detailSchedule.jsp에서 '일정수정' 클릭
	private final String deleteCommand = "/scheduleDelete.manager";	//detailSchedule.jsp에서 '일정삭제' 클릭
	
	private final String getPage = "calendarForm";
	
	private final String detailPage = "scheduleDetail";
	private final String viewPage = "scheduleView";
	private final String insertPage = "scheduleInsert";
	private final String updatePage = "scheduleUpdate";
	
	private final String gotoPage = "redirect:/calendar.manager";

	@Autowired
	mCalendarDao calendarDao;

	//calendar.manager 요청
	@RequestMapping(value=command1, method = RequestMethod.GET)
	public String form(
			@RequestParam(value = "month", required = false) String month,
			Model model
			) {
	    List<mCalendarBean> lists = calendarDao.getAllSchedules();
	    model.addAttribute("allSchedules", lists);
	    return getPage;
	}
	
	@RequestMapping(value=detailCommand, method = RequestMethod.GET)
	public ModelAndView scheduleForm(
				@RequestParam(value = "start_date", required = true) String start_date,
				HttpSession session
			) {
		ModelAndView mav = new ModelAndView();
		List<mCalendarBean> lists = calendarDao.getScheduleByStart_date(start_date);
		
		mav.addObject("calendarLists", lists);
		mav.setViewName(detailPage);
		return mav;
	}
	
	/* view */
	@RequestMapping(value=viewCommand, method = RequestMethod.GET)
	public String view(
				@RequestParam(value = "start_date", required = true) String start_date,
				@RequestParam(value = "cal_num", required = true) String cal_num,
				Model model
			) {
		mCalendarBean cb = calendarDao.getCalendarListByCal_num(cal_num);
		model.addAttribute("calendar", cb);
		return viewPage;
	}
	
	/* insert */
	@RequestMapping(value=insertCommand, method = RequestMethod.GET)
	public String insertForm(
				@RequestParam(value = "start_date", required = true) String start_date
			) {
		
		System.out.println("ManagerCalendarController test start_date : " + start_date);
		
		return insertPage;
	}
	
	@RequestMapping(value=insertCommand, method = RequestMethod.POST)
	public ModelAndView insert(
				@ModelAttribute("calendar")@Valid mCalendarBean calendar,
				BindingResult result,
				HttpServletResponse response,
				HttpSession session
			) {
		
		System.out.println("작업자 이름 : " + calendar.getName());
		
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			mav.setViewName(insertPage);
			System.out.println("InsertController 예외처리 발생");
			return mav;
		}
		
		int cnt = -1;
		cnt = calendarDao.insertSchedule(calendar);
		System.out.println("controller insert한 갯수 : " + cnt);
		
		if(cnt != -1) {
//			List<CalendarBean> lists = calendarDao.getScheduleByStart_date(calendar.getStart_date());
//			session.setAttribute("scheduleLists", lists);
			mav.setViewName(gotoPage);
		}
		else {
			mav.setViewName(insertPage);
		}
		mav.addObject("start_date", calendar.getStart_date());
		mav.setViewName("redirect:/schedule.manager");
		return mav;
	}
	
	/* update */
	@RequestMapping(value=updateCommand, method = RequestMethod.GET)
	public String updateForm(
				@RequestParam(value = "start_date", required = true) String start_date,
				@RequestParam(value = "cal_num", required = true) String cal_num,
				@RequestParam(value = "name", required = true) String name,
				Model model
			) {
		mCalendarBean cb = calendarDao.getCalendarListByCal_num(cal_num);
		
		model.addAttribute("calendar", cb);
		
		return updatePage;
	}
	
	@RequestMapping(value=updateCommand, method = RequestMethod.POST)
	public ModelAndView update(
				@ModelAttribute("calendar")@Valid mCalendarBean calendar,
				BindingResult result,
				HttpServletResponse response,
				HttpSession session
			) {
		
		ModelAndView mav = new ModelAndView();
		
		if(result.hasErrors()) {
			mav.setViewName(updatePage);
			System.out.println("updateController 예외처리 발생");
			return mav;
		}
		int cnt = -1;
		cnt = calendarDao.updateSchedule(calendar);
		System.out.println("controller update한 갯수 : " + cnt);
		mav.addObject("start_date", calendar.getStart_date());
		mav.setViewName("redirect:/schedule.manager");
		return mav;
	}
	
	/* delete */
	@RequestMapping(value=deleteCommand, method = RequestMethod.GET)
	public ModelAndView deleteForm(
				@RequestParam(value = "start_date", required = true) String start_date,
				@RequestParam(value = "cal_num", required = true) String cal_num,
				HttpServletResponse response
			) throws IOException {
		
		ModelAndView mav = new ModelAndView();

		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		int cnt = -1;
		cnt = calendarDao.deleteSchedule(cal_num);
		System.out.println("controller delete한 갯수 : " + cnt);
		
		mav.addObject("start_date", start_date);
		mav.setViewName("redirect:/schedule.manager");
		return mav;
	}

	
}
