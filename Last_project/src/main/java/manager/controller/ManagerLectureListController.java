package manager.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lecture.model.LectureBean;
import lecture.model.LectureDao;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class ManagerLectureListController {

	private final String command = "lectureList.manager";
	private final String getPage = "myLectureList";
	
	@Autowired
	LectureDao ldao;
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String list(HttpSession session, Model model) {
		
		MemberBean mb = (MemberBean)session.getAttribute("loginInfo");
		System.out.println("mb.getMem_num() : " + mb.getMem_num());
		
		List<LectureBean> list = ldao.getLectureByMemNum(mb.getMem_num());
		for (LectureBean lb : list) {
			lb.setM_name(mdao.getNameByNum(lb.getManager()).getName());
	        lb.setT_name(mdao.getNameByNum(lb.getTeacher()).getName());
		    int stu_cnt = mdao.getStudent(lb.getLec_num());
		    lb.setStudent(stu_cnt);
		    System.out.println("학생수 : " + stu_cnt);
		}
		
		Date currentDate = new Date();
		model.addAttribute("currentDate", currentDate);
		model.addAttribute("lectureList",list);
		
		return getPage;
	}
	
}
