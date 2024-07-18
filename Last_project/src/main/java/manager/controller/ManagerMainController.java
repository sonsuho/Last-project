package manager.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lecture.model.LectureBean;
import lecture.model.LectureDao;
import manager.model.mCalendarBean;
import manager.model.mCalendarDao;
import member.model.MemberBean;


@Controller
public class ManagerMainController {
	private final String command = "/home.manager";
	private final String getPage = "home";
	
	/* calendar추가코드 */
	@Autowired
	mCalendarDao calendarDao;
	
	@Autowired
	LectureDao ldao;
	
	@RequestMapping(value = command , method = RequestMethod.GET)
	public ModelAndView approval(
			@RequestParam(value = "month", required = false) String month,
			Model model,
			HttpSession session
			) {
		
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		
		int mem_num = loginInfo.getMem_num();
		System.out.println("mem_num: " + mem_num);
		
		ModelAndView mav = new ModelAndView();
		List<mCalendarBean> lists = calendarDao.getAllSchedules();

		String lec_num = loginInfo.getLec_num();
		LectureBean lecture = ldao.getLectureByNum(Integer.parseInt(lec_num));

		// lecture에서 가져온 날짜와 시간 문자열
		String startDateTimeString = lecture.getLec_start();
		String endDateTimeString = lecture.getLec_end();

		// 날짜와 시간 포맷 설정 ('yyyy-MM-dd hh:mm:ss.s')
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");

		// LocalDateTime 객체로 변환
		LocalDateTime startDateTime = LocalDateTime.parse(startDateTimeString, formatter);
		LocalDateTime endDateTime = LocalDateTime.parse(endDateTimeString, formatter);
		LocalDateTime currentDateTime = LocalDateTime.now();

		// 전체 기간 계산 (날짜 차이)
		long totalDays = ChronoUnit.DAYS.between(startDateTime.toLocalDate(), endDateTime.toLocalDate());

		// 남은 기간 계산 (날짜 차이)
		long remainingDays = ChronoUnit.DAYS.between(currentDateTime.toLocalDate(), endDateTime.toLocalDate());

		System.out.println(totalDays);
		System.out.println(remainingDays);

		// ModelAndView에 데이터 추가
		mav.addObject("allSchedules", lists);	//calendar 일정
		mav.addObject("totalDays", totalDays); // 전체 날짜 수
		mav.addObject("remainingDays", remainingDays); // 남은 날짜 수
		mav.setViewName(getPage);
		
		return mav;
	}
	
	
}
