package admin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import alarm.model.AlarmService;
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

	@Autowired
	AlarmService service;

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
	public Map<String, Object> letureUpdate(LectureBean lecture,HttpSession session, Map<String,String> paramap) {
		System.out.println("lectureUpdate.admin POST 요청");
		Map<String, Object> map = new HashMap<String, Object>();

		LectureBean olb = ldao.getLectureByNum(lecture.getLec_num());
		int oldManager = olb.getManager();
		int oldTeacher = olb.getTeacher();
		
		int cnt = ldao.updateLecture(lecture);
		LectureBean lb = ldao.getLectureByNum(lecture.getLec_num());

		if(cnt==-1) {
			map.put("lecture","실패");
			return map;
		}

		lb.setM_name(mdao.getNameByNum(lb.getManager()).getName());
		lb.setT_name(mdao.getNameByNum(lb.getTeacher()).getName());
		lb.setStudent(mdao.getStudent(lecture.getLec_num()));
		System.out.println("manager : " + lb.getM_name());
		System.out.println("teacher : " + lb.getT_name());

		map.put("lecture",lb);

		
		// 민곤 알림 추가
		// 기존 강좌 정보 가져오기
	    System.out.println("oldManager:"+oldManager);
	    if (lb != null) {
	        String lecName = lb.getLec_name();

	        // 수정 후 매니저와 강사가 변경되었는지 확인
	        if (oldManager != lb.getManager()) {
	            // 이전 매니저에게 강좌 변경 알림 보내기
	            String oldManagerId = String.valueOf(oldManager);
	            
	            System.out.println("lb.getManager():"+lb.getManager());

	            paramap.put("fk_recipientno", oldManagerId);
	            paramap.put("url", "/lectureList");
	            paramap.put("url2", ".manager");
	            paramap.put("alarm_content", lecName + " 강좌가 변경되었습니다.");
	            paramap.put("alarm_type", "9");

	            service.addAlarm(paramap);

	            // 이전 매니저의 강좌에서 삭제
	            //ldao.deleteManagerFromLecture(lecture.getLec_num(), oldManager);
	        }

	        // 현재 매니저에게 강좌 변경 알림 보내기
	        String managerId = String.valueOf(lb.getManager());

	        paramap.put("fk_recipientno", managerId);
	        paramap.put("url", "/lectureList");
	        paramap.put("url2", ".manager");
	        paramap.put("alarm_content", lecName + " 강좌가 수정되었습니다.");
	        paramap.put("alarm_type", "4");

	        service.addAlarm(paramap);

	        // 수정 후 강사가 변경되었는지 확인
	        if (oldTeacher != lb.getTeacher()) {
	            // 이전 강사에게 강좌 변경 알림 보내기
	            String oldTeacherId = String.valueOf(oldTeacher);

	            paramap.put("fk_recipientno", oldTeacherId);
	            paramap.put("url", "/lectureList");
	            paramap.put("url2", ".teacher");
	            paramap.put("alarm_content", lecName + " 강좌가 변경되었습니다.");
	            paramap.put("alarm_type", "9");

	            service.addAlarm(paramap);

	            // 이전 강사의 강좌에서 삭제
	            //ldao.deleteTeacherFromLecture(lecture.getLec_num(), oldTeacher);
	        }

	        // 현재 강사에게 강좌 변경 알림 보내기
	        String teacherId = String.valueOf(lb.getTeacher());

	        paramap.put("fk_recipientno", teacherId);
	        paramap.put("url", "/lectureList");
	        paramap.put("url2", ".teacher");
	        paramap.put("alarm_content", lecName + " 강좌가 수정되었습니다.");
	        paramap.put("alarm_type", "4");

	        service.addAlarm(paramap);
	    }
	    // 민곤 알림 추가 끝
			return map;


	}
}
