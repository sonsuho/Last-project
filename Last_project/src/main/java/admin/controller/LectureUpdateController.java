package admin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String letureUpdate(Model model, @RequestParam("lec_num") int lec_num) throws ParseException {
		
		LectureBean lecture = ldao.getLectureByNum(lec_num);
		// String 타입의 날짜 정보를 Date 객체로 변환
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	    Date lecStartDate = formatter.parse(lecture.getLec_start());
	    Date lecEndDate = formatter.parse(lecture.getLec_end());

	    // Date 객체를 다시 String 타입으로 변환하여 LectureBean 객체에 설정
	    lecture.setLec_start(formatter.format(lecStartDate));
	    lecture.setLec_end(formatter.format(lecEndDate));
		model.addAttribute("lecture",lecture);
		System.out.println("lec_num : " + lecture.getLec_num());
		
		/* 매니저, 강사 목록 가져오기 */
		List<MemberBean> managerList = mdao.getMemberByCate("manager");
		List<MemberBean> teacherList = mdao.getMemberByCate("teacher");
		model.addAttribute("managerList",managerList);
		model.addAttribute("teacherList",teacherList);
		
		
		return getPage;
	}
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	public String letureUpdate(LectureBean lecture, Model model) {
		
		/* 매니저, 강사 목록 가져오기 */
		List<MemberBean> managerList = mdao.getMemberByCate("manager");
		List<MemberBean> teacherList = mdao.getMemberByCate("teacher");
		model.addAttribute("managerList",managerList);
		model.addAttribute("teacherList",teacherList);
		
		int cnt = ldao.insertLecture(lecture);
		
		if(cnt==-1) {
			System.out.println("insert 실패");
			return getPage;
		}
		
		return gotoPage;
	}
	
}
