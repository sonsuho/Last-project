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
import manager.model.NoticeBean;
import manager.model.NoticeDao;
import member.model.MemberBean;
import member.model.MemberDao;
import teacher.model.TeacherDao;

@Controller
public class TeacherHomeController {
	
	final String command = "/home.teacher";
	final String getPage = "home";
	
	@Autowired
	MemberDao mdao;
	
	@Autowired
	TeacherDao tdao;
	
	@Autowired
	LectureDao ldao;
	
	@Autowired
	NoticeDao ndao;
	
	/* calendar추가코드 */
	@Autowired
	student.model.sCalendarDao sCalendarDao;
	
	@RequestMapping(command)
	public ModelAndView home(HttpSession session,
			@RequestParam(value = "month", required = false) String month,
			@RequestParam(value="start", required=false) String start,
			 @RequestParam(value="lec_Num", required=false) String lec_Num, Model model
			) {
	    ModelAndView mav = new ModelAndView();
	    
	    List<student.model.sCalendarBean> lists = sCalendarDao.getAllSchedules();
	    
	    MemberBean teacher = (MemberBean) session.getAttribute("loginInfo");

	    int mem_num = teacher.getMem_num();
	    LectureBean lecture = ldao.getLectureForTeacher(mem_num);  
	    
	    
	    List<NoticeBean> noticeList = ndao.getNoticeList_all();
	    
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
	    
	    // 경과 기간 퍼센트 계산
	    double progressPercent = (double) (totalDays - remainingDays) / totalDays * 100; // 진행률 계산
	    progressPercent = Math.min(Math.max(progressPercent, 0), 100); // 0% ~ 100% 범위로 제한
	    
	    // 매니저/강사 정보 가져오기
	    MemberBean manager = mdao.getNameByNum(lecture.getManager());
	    MemberBean teacher2 = mdao.getNameByNum(lecture.getTeacher());
	    lecture.setM_name(manager.getName());
	    lecture.setM_phone(manager.getPhone());
	    lecture.setM_email(manager.getEmail());
	    lecture.setT_name(teacher2.getName());
	    lecture.setT_phone(teacher2.getPhone());
	    lecture.setT_email(teacher2.getEmail());
	    
	    // 학생수 정보 가져오기
	    lecture.setStudent(mdao.getStudent(lecture.getLec_num()));
	    
	    // ModelAndView에 데이터 추가
	    mav.addObject("noticeList", noticeList);	//Notice 공지사항
	    mav.addObject("allSchedules", lists);	//calendar 일정
	    mav.addObject("totalDays", totalDays); // 전체 날짜 수
	    mav.addObject("remainingDays", remainingDays); // 남은 날짜 수
	    mav.addObject("lecture", lecture); // 강좌 정보
	    mav.addObject("progressPercent", Math.round(progressPercent)); // 기간 진행 퍼센트
	    mav.addObject("start", start); // 수업시작/종료시 사용
	    mav.addObject("lec_Num", lec_Num); // 수업시작/종료시 사용
	    
	    // 이전 페이지 설정
	    mav.setViewName(getPage);
	    
	    return mav;
	}
	

}
