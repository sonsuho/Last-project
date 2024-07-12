package manager.model;

import java.util.List;
import java.util.Map;

import manager.model.AlarmDAO;
import manager.model.AlarmVO;

public interface InterAlarmService {

	// AOP 알람추가하기
	void addAlarm(Map<String, String> paraMap);

	// 알람 조회하기
	List<AlarmVO> getAlarmList(int mem_num);
	
	// 지난 알람 조회하기
	List<AlarmVO> getPastAlarmList(int mem_num);

	// 알람 읽기
	void readAlarm(String alarmno);

	// 모든 알람 읽기
	void readAllAlarm(int mem_num);

	// 안 읽은 소식 개수 알아오기
	String getUnreadAlarmCnt(int mem_num);

}