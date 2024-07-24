package teacher.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import alarm.model.AlarmDao;
import alarm.model.AlarmService;
import lecture.model.LectureDao;
import lecture.model.On_going_lectureBean;
import lecture.model.On_going_lectureDao;
import member.model.MemberBean;
import student.model.StudentDao;
import teacher.model.TeacherDao;

@Controller
public class TeachingController {
	
	final String command = "/teaching.teacher";
	final String getPage = "teachingForm";
	final String gotoPage = "redirect:/home.teacher";	
	
	@Autowired
	TeacherDao tdao;
	
	@Autowired
	StudentDao sdao;
	
	@Autowired
	AlarmDao adao;
	
	@Autowired
	LectureDao ldao;
	
	@Autowired
	On_going_lectureDao odao;
	
	@Autowired
    AlarmService service;
	
	@RequestMapping(command)
	public String teachingForm() {															// teacher 폴더 속 teachingForm.jsp로 넘어간 다음
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView teaching(@RequestParam(value = "url") String url, HttpSession session , Map<String, String> paramap) {
		
	      
	    MemberBean teacher = (MemberBean)session.getAttribute("loginInfo");
	      
	    int lec_Num = ldao.getLectureByTeacher(teacher.getMem_num());
		
		List<MemberBean> slist = sdao.getStudentByLec_Num(String.valueOf(lec_Num));			// 반복을 통해 해당 강좌를 수강하는 모든 학생들에게 수업 링크가 담긴 메시지를 보낸다
		
		On_going_lectureBean ob = new On_going_lectureBean();
		
		ob.setLec_num(Integer.valueOf(lec_Num));
		ob.setLink(url);
		ob.setOnoff("on");
		
		odao.updateOngoingLecture(ob);														// 진행중인 수업 테이블에서 해당 강좌 번호에 맞는 행을 수정한다
		
		ModelAndView mav = new ModelAndView();
		
		LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedNow = now.format(formatter);
        mav.addObject("currentTime", formattedNow);
		mav.addObject("lec_Num", lec_Num);
		
		mav.setViewName(gotoPage);
		
		//민곤 알림 추가
		StringBuilder stdList = new StringBuilder();
		for (MemberBean mb : slist) {
		    if (stdList.length() > 0) {
		        stdList.append(",");
		    }
		    stdList.append(mb.getMem_num());
		}
		System.out.println(stdList.toString()); // 결과 출력 확인
		
		paramap.put("fk_recipientno", stdList.toString()); // 받는사람 (여러명일때는 ,,으로 구분된 str)
		paramap.put("url", "/classNow" ); 
		paramap.put("url2", ".student"); //url2에 아무것도 안넣으면 알림 클릭했을때 주소창에null로 나와서 오류
		paramap.put("alarm_content", teacher.getName() + "님이 수업을 시작했습니다. 확인해 주세요." );
		paramap.put("alarm_type", "7" );
		
		service.addAlarm(paramap);
		//민곤 알림 추가
		
		mav.addObject("start","start");
		return mav;
	}
}
