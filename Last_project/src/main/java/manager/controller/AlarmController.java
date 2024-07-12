package manager.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import manager.model.AlarmVO;
import manager.model.InterAlarmService;
import member.model.MemberBean;

@Controller
public class AlarmController {
	
	@Autowired
	private InterAlarmService service;
	
	
	@RequestMapping(value="/alarmModal.alarm")
	public String alarmModal() {
		return "../alarm/alarmModal";
	}
	
	// 알람 조회하기
	@ResponseBody
	@RequestMapping(value = "/getAlarmList.alarm", produces="text/plain;charset=UTF-8")
	public String getDept(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
		
		System.out.println("넘기는loginInfo.getMem_num():"+loginInfo.getMem_num());
		
		List<AlarmVO> alarmList = service.getAlarmList(loginInfo.getMem_num());
		
		JSONArray jsonArr = new JSONArray();
		
		for(AlarmVO alarmvo: alarmList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("pk_alarmno", alarmvo.getPk_alarmno());
			jsonObj.put("url", alarmvo.getUrl());
			jsonObj.put("url2", alarmvo.getUrl2());
			jsonObj.put("alarm_content", alarmvo.getAlarm_content());
			jsonObj.put("alarm_type", alarmvo.getAlarm_type());
			jsonObj.put("writedate", alarmvo.getWritedate());
			
			jsonArr.add(jsonObj);
		}
		
		return jsonArr.toString() ;
	}
	
	
	
	// 알람 조회하기
	@ResponseBody
	@RequestMapping(value = "/getPastAlarmList.alarm", produces="text/plain;charset=UTF-8")
	public String getPastAlarmList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
		
		
		List<AlarmVO> alarmList = service.getPastAlarmList(loginInfo.getMem_num());
		
		JSONArray jsonArr = new JSONArray();
		
		for(AlarmVO alarmvo: alarmList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("pk_alarmno", alarmvo.getPk_alarmno());
			jsonObj.put("url", alarmvo.getUrl());
			jsonObj.put("url2", alarmvo.getUrl2());
			jsonObj.put("alarm_content", alarmvo.getAlarm_content());
			jsonObj.put("alarm_type", alarmvo.getAlarm_type());
			jsonObj.put("writedate", alarmvo.getWritedate());
			
			jsonArr.add(jsonObj);
		}
		
		return jsonArr.toString() ;
	}
	
	
	
	// 알람 읽기
	@ResponseBody
	@RequestMapping(value = "/readAlarm.alarm",  method= {RequestMethod.POST} , produces="text/plain;charset=UTF-8")
	public void readAlarm(HttpServletRequest request) {
		
		String alarmno = request.getParameter("alarmno");
		service.readAlarm(alarmno);
		
	}
	
	
	// 모든 알람 읽기
	@ResponseBody
	@RequestMapping(value = "/readAllAlarm.alarm" , produces="text/plain;charset=UTF-8")
	public void readAllAlarm(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
		
		service.readAllAlarm(loginInfo.getMem_num());
		
	}
	
	
	// 안 읽은 소식 개수 알아오기
	@ResponseBody
	@RequestMapping(value = "/getUnreadAlarmCnt.alarm" , produces="text/plain;charset=UTF-8")
	public String getUnreadAlarmCnt(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
		
		String n = service.getUnreadAlarmCnt(loginInfo.getMem_num());
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
		
	}
	
}