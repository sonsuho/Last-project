package manager.model;

import java.util.List;


//import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AlarmDAO implements InterAlarmDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// AOP 알람추가하기
	@Override
	public void addAlarm(String sql) {
		sqlsession.insert("mingon.insertAlarm", sql);
	}

	// 알람 조회하기
	
	@Override
	public List<AlarmVO> getAlarmList(int mem_num) {
	    System.out.println("getAlarmList MEM_NUM: " + mem_num);
	    List<AlarmVO> alarmList = sqlsession.selectList("mingon.selectAlarm", mem_num);
	    
	    // Debugging lines to identify null values
	    if (alarmList == null) {
	        System.out.println("alarmList is null");
	    } else {
	        System.out.println("alarmList.size(): " + alarmList.size());
	    }
	    
	    return alarmList;
	}
	
	// 알람 조회하기
	@Override
	public List<AlarmVO> getPastAlarmList(int mem_num) {
		List<AlarmVO> alarmList = sqlsession.selectList("mingon.selectPastAlarm", mem_num);
		return alarmList;
	}

	// 알람 읽기
	@Override
	public void readAlarm(String alarmno) {
		sqlsession.update("mingon.updateAlarm", alarmno);
	}
	
	// 모든 알람 읽기
	@Override
	public void readAllAlarm(int mem_num) {
		sqlsession.update("mingon.updateAllAlarm", mem_num);
		
	}

	// 안 읽은 소식 개수 알아오기
	@Override
	public String getUnreadAlarmCnt(int mem_num) {
		String n = sqlsession.selectOne("mingon.getUnreadAlarmCnt", mem_num);
		return n;
	}

}