package manager.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class mCalendarDao {

	private String namespace = "manager.model.Manager";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public mCalendarDao() {
		System.out.println("CalenderDao 생성자");
	}

	public int insertSchedule(mCalendarBean calendar) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".insertSchedule", calendar);
		return cnt;
	}

	public List<mCalendarBean> getScheduleByStart_date(String start_date) {
		List<mCalendarBean> lists = new ArrayList<mCalendarBean>();
		lists = sqlSessionTemplate.selectList(namespace + ".getScheduleByStart_date", start_date);
		return lists;
	}

	public mCalendarBean getCalendarListByCal_num(String cal_num) {
		mCalendarBean cb = null;
		cb = sqlSessionTemplate.selectOne(namespace + ".getCalendarListByCal_num", cal_num);
		return cb;
	}

	public int updateSchedule(mCalendarBean calendar) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updateSchedule", calendar);
		return cnt;
	}

	public int deleteSchedule(String cal_num) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".deleteSchedule", cal_num);
		return cnt;
	}

	public List<mCalendarBean> getAllSchedules() {
		List<mCalendarBean> lists = new ArrayList<mCalendarBean>();
		lists = sqlSessionTemplate.selectList(namespace + ".getAllSchedules");
		return lists;
	}

}
