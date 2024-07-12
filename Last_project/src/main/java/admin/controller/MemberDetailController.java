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
public class MemberDetailController {

private final String command = "memberDetail.admin";
	
	@Autowired
	LectureDao ldao;
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	@ResponseBody
	public DetailBean detail(@RequestParam("mem_num") int mem_num) {
		
		System.out.println("memberDetail.admin POST 요청");
		
		DetailBean db = new DetailBean();
		
		MemberBean mb = mdao.getNameByNum(mem_num);
		List<LectureBean> lectures = ldao.getLectureByMemNum(mem_num);
		
		db.setMember(mb);
		db.setLectures(lectures);
		
		System.out.println("돌아갑니다...");
		
		return db;
	}
	
}
