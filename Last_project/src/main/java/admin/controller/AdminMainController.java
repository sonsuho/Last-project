package admin.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lecture.model.LectureBean;
import lecture.model.LectureDao;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class AdminMainController {

	private final String command = "home.admin";
	private final String getPage = "adminMain";
	
	@Autowired
	LectureDao ldao;
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(command)
	public String adminMain(Model model) {
		
		List<LectureBean> lecture = new ArrayList<LectureBean>();
		
		String[] class_name = {"A","B","C","D","E","F","G","H"};
		for(int i=0; i<class_name.length; i++) {
			LectureBean lb = ldao.getLectureByClass(class_name[i]); 
			System.out.println(class_name[i] + "반 lec_num : " + lb.getLec_num());
			// lecture에서 가져온 날짜와 시간 문자열
		    String startDateTimeString = lb.getLec_start();
		    String endDateTimeString = lb.getLec_end();
		    
		    // 날짜와 시간 포맷 설정 ('yyyy-MM-dd hh:mm:ss.s')
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
		    
		    // LocalDateTime 객체로 변환
		    LocalDateTime startDateTime = LocalDateTime.parse(startDateTimeString, formatter);
		    LocalDateTime endDateTime = LocalDateTime.parse(endDateTimeString, formatter);
		    LocalDateTime currentDateTime = LocalDateTime.now();
		    
		    // 전체 기간 계산 (날짜 차이)
		    long totalDays = ChronoUnit.DAYS.between(startDateTime.toLocalDate(), endDateTime.toLocalDate());
		    lb.setTotalDays(totalDays); 
		    
		    // 남은 기간 계산 (날짜 차이)
		    long remainingDays = ChronoUnit.DAYS.between(currentDateTime.toLocalDate(), endDateTime.toLocalDate());
		    lb.setRemainingDays(remainingDays);
		    
		    // 경과 기간 퍼센트 계산
		    double progressPercent = (double) (totalDays - remainingDays) / totalDays * 100; // 진행률 계산
		    progressPercent = Math.min(Math.max(progressPercent, 0), 100); // 0% ~ 100% 범위로 제한
		    lb.setProgressPercent((int)Math.round(progressPercent)); 
		    System.out.println("ProgressPercent : " + lb.getProgressPercent());
		     
		    // 매니저/강사 정보 가져오기
		    MemberBean manager2 = mdao.getNameByNum(lb.getManager());
		    MemberBean teacher2 = mdao.getNameByNum(lb.getTeacher());
		    lb.setM_name(manager2.getName());
		    lb.setM_phone(manager2.getPhone());
		    lb.setM_email(manager2.getEmail());
		    lb.setT_name(teacher2.getName());
		    lb.setT_phone(teacher2.getPhone());
		    lb.setT_email(teacher2.getEmail());
			
		    // 학생수 정보 가져오기
		    lb.setStudent(mdao.getStudent(lb.getLec_num()));
			lecture.add(lb);
		}
		
		model.addAttribute("lecture",lecture);
		
		return getPage;
	}
	
}
