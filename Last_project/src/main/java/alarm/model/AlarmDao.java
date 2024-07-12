package alarm.model;

import java.util.List;

//import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AlarmDao implements InterAlarmDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	// AOP 알람추가하기
	@Override
	public void addAlarm(String value) {
		System.out.println("value:"+value);
		sqlSessionTemplate.insert("mingon.insertAlarm", value);
	}

	// 알람 조회하기
	
	@Override
	public List<AlarmBean> getAlarmList(int mem_num) {
	    System.out.println("getAlarmList MEM_NUM: " + mem_num);
	    List<AlarmBean> alarmList = sqlSessionTemplate.selectList("mingon.selectAlarm", mem_num);
	    
	    if (alarmList == null) {
	        System.out.println("alarmList is null");
	    } else {
	        System.out.println("alarmList.size(): " + alarmList.size());
	    }
	    
	    return alarmList;
	}
	
	// 알람 조회하기
	@Override
	public List<AlarmBean> getPastAlarmList(int mem_num) {
		List<AlarmBean> alarmList = sqlSessionTemplate.selectList("mingon.selectPastAlarm", mem_num);
		return alarmList;
	}

	// 알람 읽기
	@Override
	public void readAlarm(String alarmno) {
		sqlSessionTemplate.update("mingon.updateAlarm", alarmno);
	}
	
	// 모든 알람 읽기
	@Override
	public void readAllAlarm(int mem_num) {
		sqlSessionTemplate.update("mingon.updateAllAlarm", mem_num);
		
	}

	// 안 읽은 소식 개수 알아오기
	@Override
	public int getUnreadAlarmCnt(int mem_num) {
		int cnt = sqlSessionTemplate.selectOne("mingon.getUnreadAlarmCnt", mem_num);
		return cnt;
	}

	


}