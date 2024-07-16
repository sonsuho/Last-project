package admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lecture.model.DetailBean;
import lecture.model.LectureBean;
import lecture.model.LectureDao;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class LectureDetailController {

	private final String command = "lectureDetail.admin";
	
	@Autowired
	LectureDao ldao;
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	@ResponseBody
	public DetailBean detail(@RequestParam("lec_num") int lec_num) {
		
		System.out.println("lectureDetail.admin POST 요청");
		
		DetailBean db = new DetailBean();
		
		LectureBean lb = ldao.getLectureByNum(lec_num);
		List<MemberBean> members = mdao.getStudentByLecNum(lec_num); 
		
		MemberBean manager = mdao.getNameByNum(lb.getManager());
		lb.setManager(manager.getMem_num());
		lb.setM_phone(manager.getPhone());
		lb.setM_email(manager.getEmail());
		
		MemberBean teacher = mdao.getNameByNum(lb.getTeacher());
		lb.setTeacher(teacher.getMem_num());
		lb.setT_phone(teacher.getPhone());
		lb.setT_email(teacher.getEmail());
		
		db.setLecture(lb);
		db.setMembers(members);
		
		System.out.println("돌아갑니다...");
		
		return db;
	}
	
}
