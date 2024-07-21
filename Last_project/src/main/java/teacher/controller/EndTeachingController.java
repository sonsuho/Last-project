package teacher.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lecture.model.On_going_lectureBean;
import lecture.model.On_going_lectureDao;
import student.model.StudentDao;
import teacher.model.TeacherDao;

@Controller
public class EndTeachingController {
	
	final String command = "/endTeaching.teacher";
	final String getPage = "redirect:/home.teacher";
	
	@Autowired
	TeacherDao tdao;
	
	@Autowired
	StudentDao sdao;
	
	@Autowired
	On_going_lectureDao odao;						// 강사가 수업 종료 버튼을 누르면
	
	@RequestMapping(command)
	public String endTeaching(@RequestParam(value = "lec_Num") String lec_Num) {
		
		On_going_lectureBean ob = new On_going_lectureBean();
		
		ob.setLec_num(Integer.valueOf(lec_Num));	// 해당 강좌의 진행중인 수업 테이블의
		ob.setLink("");								// 링크를 지우고 onoff를 off로 만든다
		ob.setOnoff("off");
		
		odao.updateOngoingLecture(ob);
		
		return getPage;
	}
	
}
