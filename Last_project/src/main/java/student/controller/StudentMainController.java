package student.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
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

import lecture.model.LectureBean;
import lecture.model.LectureDao;
import manager.model.RequestDao;
import member.model.MemberBean;
import member.model.MemberDao;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;


@Controller
@ComponentScan({"member,messenger,manager,student,lecture"})
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
		
		ModelAndView mav = new ModelAndView();
		List<student.model.sCalendarBean> lists = sCalendarDao.getAllSchedules();
	    //model.addAttribute("allSchedules", lists);
	    
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
	    
	    // 경과 기간 퍼센트 계산
	    double progressPercent = (double) (totalDays - remainingDays) / totalDays * 100; // 진행률 계산
	    progressPercent = Math.min(Math.max(progressPercent, 0), 100); // 0% ~ 100% 범위로 제한
	    
	    // 매니저/강사 정보 가져오기
	    MemberBean manager = memberDao.getNameByNum(lecture.getManager());
	    MemberBean teacher = memberDao.getNameByNum(lecture.getTeacher());
	    lecture.setM_name(manager.getName());
	    lecture.setM_phone(manager.getPhone());
	    lecture.setM_email(manager.getEmail());
	    lecture.setT_name(teacher.getName());
	    lecture.setT_phone(teacher.getPhone());
	    lecture.setT_email(teacher.getEmail());
	    
	    // 학생수 정보 가져오기
	    lecture.setStudent(memberDao.getStudent(lecture.getLec_num()));
	    
	    // ModelAndView에 데이터 추가
	    mav.addObject("lecture", lecture); // 강좌 정보
	    mav.addObject("totalDays", totalDays); // 전체 날짜 수
	    mav.addObject("remainingDays", remainingDays); // 남은 날짜 수
	    mav.addObject("progressPercent", Math.round(progressPercent)); // 기간 진행 퍼센트
	    mav.addObject("allSchedules", lists);	//calendar 일정
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
}
