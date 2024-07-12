package admin.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lecture.model.LectureBean;
import lecture.model.LectureDao;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class LectureUpdateController {

	public final String command = "lectureUpdate.admin";
	public final String getPage = "lectureUpdateForm";
	public final String gotoPage = "redirect:/lectureList.admin";
	
	@Autowired
	LectureDao ldao;

	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String letureUpdate(Model model,
							   @RequestParam("lec_num") int lec_num) {
		
		LectureBean lecture = ldao.getLectureByNum(lec_num);
		
		model.addAttribute("lecture",lecture);
		
		/* 매니저, 강사 목록 가져오기 */
		List<MemberBean> managerList = mdao.getMemberByCate("manager");
		List<MemberBean> teacherList = mdao.getMemberByCate("teacher");
		model.addAttribute("managerList",managerList);
		model.addAttribute("teacherList",teacherList);
		
		
		return getPage;
	}
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	public String letureUpdate(@ModelAttribute("lecture") @Valid LectureBean lecture, BindingResult result,
								 Model model) {
		
		/* 매니저, 강사 목록 가져오기 */
		List<MemberBean> managerList = mdao.getMemberByCate("manager");
		List<MemberBean> teacherList = mdao.getMemberByCate("teacher");
		model.addAttribute("managerList",managerList);
		model.addAttribute("teacherList",teacherList);
		
		if(result.hasErrors()) {
			return getPage;
		}
		
		int cnt = ldao.insertLecture(lecture);
		
		if(cnt==-1) {
			System.out.println("insert 실패");
			return getPage;
		}
		
		return gotoPage;
	}
	
}
