package teacher.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import alarm.model.AlarmDao;
import lecture.model.On_going_lectureBean;
import lecture.model.On_going_lectureDao;
import member.model.MemberBean;
import student.model.StudentDao;
import teacher.model.TeacherDao;

@Controller
public class TeachingController {
	
	final String command = "/teaching.teacher";
	final String getPage = "teachingForm";
	final String gotoPage = "teaching";	
	
	@Autowired
	TeacherDao tdao;
	
	@Autowired
	StudentDao sdao;
	
	@Autowired
	AlarmDao adao;
	
	@Autowired
	On_going_lectureDao odao;
	
	@RequestMapping(command)
	public String teachingForm() {															// teacher 폴더 속 teachingForm.jsp로 넘어간 다음
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView teaching(@RequestParam(value = "url") String url, HttpSession session) {
		
		MemberBean teacher = (MemberBean)session.getAttribute("loginInfo");					// session으로 설정된 loginInfo에서 강좌 번호를 가져온 다음
		
		String lec_Num = teacher.getLec_num();												// 해당 강좌 번호에 해당하는 모든 학생 리스트를 구하고
		
		List<MemberBean> slist = sdao.getStudentByLec_Num(lec_Num);							// 반복을 통해 해당 강좌를 수강하는 모든 학생들에게 수업 링크가 담긴 메시지를 보낸다
		
		for(MemberBean student : slist) {
			
			alarm.model.AlarmBean news = new alarm.model.AlarmBean();
			
			news.setFk_recipientno(student.getMem_num());
			news.setUrl("");
			news.setUrl2("");
			news.setAlarm_content("수업 시작");
			news.setAlarm_type("&#128161");
			news.setView_status(0);
			
			//adao.addAlarm(news);
		}
		
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
		
		return mav;
	}
}
