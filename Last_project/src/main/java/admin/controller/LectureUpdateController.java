package admin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@ResponseBody
	public Map<String, Object> letureUpdate(@RequestParam("lec_num") int lec_num) throws ParseException {
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("lectureUpdate.admin GET 요청");
		
		LectureBean lecture = ldao.getLectureByNum(lec_num);
		// String 타입의 날짜 정보를 Date 객체로 변환
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	    Date lecStartDate = formatter.parse(lecture.getLec_start());
	    Date lecEndDate = formatter.parse(lecture.getLec_end());

	    // Date 객체를 다시 String 타입으로 변환하여 LectureBean 객체에 설정
	    lecture.setLec_start(formatter.format(lecStartDate));
	    lecture.setLec_end(formatter.format(lecEndDate));
	    lecture.setStudent(mdao.getStudent(lecture.getLec_num()));
		System.out.println("lec_num : " + lecture.getLec_num());
		
		/* 매니저, 강사 목록 가져오기 */
		List<MemberBean> managerList = mdao.getMemberByCate("manager");
		List<MemberBean> teacherList = mdao.getMemberByCate("teacher");
		
		map.put("lecture",lecture);
		map.put("managerList",managerList);
		map.put("teacherList",teacherList);
		
		return map;
	}
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> letureUpdate(LectureBean lecture) {
	  System.out.println("lectureUpdate.admin POST 요청");
	  Map<String, Object> map = new HashMap<String, Object>();

	  int cnt = ldao.updateLecture(lecture);

	  if(cnt==-1) {
	    map.put("lecture","실패");
	    return map;
	  }

	  LectureBean lb = ldao.getLectureByNum(lecture.getLec_num());
	  lb.setM_name(mdao.getNameByNum(lb.getManager()).getName());
	  lb.setT_name(mdao.getNameByNum(lb.getTeacher()).getName());
	  lb.setStudent(mdao.getStudent(lecture.getLec_num()));
	  System.out.println("manager : " + lb.getM_name());
	  System.out.println("teacher : " + lb.getT_name());

	  map.put("lecture",lb);
	  return map;
	}
	
}
