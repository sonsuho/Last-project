package teacher.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lecture.model.LectureBean;
import lecture.model.LectureDao;
import member.model.MemberBean;
import teacher.model.TeacherDao;

@Controller
public class TeacherHomeController {
	
	final String command = "/home.teacher";
	final String getPage = "home";
	
	@Autowired
	TeacherDao tdao;
	
	@Autowired
	LectureDao ldao;
	
	/* calendar추가코드 */
	@Autowired
	student.model.sCalendarDao sCalendarDao;
	
	@RequestMapping(command)
	public ModelAndView home(HttpSession session,
			@RequestParam(value = "month", required = false) String month,
			Model model) {
	    ModelAndView mav = new ModelAndView();
	    
	    List<student.model.sCalendarBean> lists = sCalendarDao.getAllSchedules();
	    
	    MemberBean teacher = (MemberBean) session.getAttribute("loginInfo");

	    String lec_num = teacher.getLec_num();
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
	    
	    // 이전 페이지 설정
	    mav.setViewName(getPage);
	    
	    return mav;
	}
	
}
