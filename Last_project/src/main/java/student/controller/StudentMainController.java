package student.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lecture.model.LectureBean;
import lecture.model.LectureDao;
import manager.model.RequestDao;
import member.model.MemberBean;
import member.model.MemberDao;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;


@Controller
public class StudentMainController {
	private final String command = "/home.student";
	private final String getPage = "home";
	
	@Autowired
	RequestDao requestDao;
	
	@Autowired
	MessengerDao messengerDao;
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	LectureDao ldao;
	
	@RequestMapping(value = command , method = RequestMethod.GET)
	public ModelAndView approval(HttpSession session) {
		
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		
		int mem_num = loginInfo.getMem_num();
		
		String lec_num = loginInfo.getLec_num();
		
		LectureBean lecture = ldao.getLectureByNum(Integer.parseInt(lec_num));
		
		List<MessengerBean> reclist = messengerDao.getRecentlyMsg(mem_num);
		session.setAttribute("reclist", reclist);
		
		for(MessengerBean mb :  reclist) {
			System.out.println(mb.getMsg_num());
			System.out.println(mb.getSend_name());
			System.out.println(mb.getSend_time());
		}
		
		ModelAndView mav = new ModelAndView();
		
		String start = lecture.getLec_start();
		String end = lecture.getLec_end();
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
	    try {
			Date startDate = dateFormat.parse(start);
			Date endDate = dateFormat.parse(end);
			
			Date today = new Date();
			
		    // 날짜 차이 계산 (밀리초 단위)
		    long totalDurationMillis = endDate.getTime() - startDate.getTime();
		    long passedDurationMillis = today.getTime() - startDate.getTime();
		    long remainingDurationMillis = endDate.getTime() - today.getTime();
		    
		    // 밀리초를 일(day) 단위로 변환
		    long totalDurationDays = totalDurationMillis / (1000 * 60 * 60 * 24);
		    long passedDurationDays = passedDurationMillis / (1000 * 60 * 60 * 24);
		    long remainingDurationDays = remainingDurationMillis / (1000 * 60 * 60 * 24);
			
		    mav.addObject("total", totalDurationDays);
		    mav.addObject("pass", passedDurationDays);
		    mav.addObject("last", remainingDurationDays);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	
}
