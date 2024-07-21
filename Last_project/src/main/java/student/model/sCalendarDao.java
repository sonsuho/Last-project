package student.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class sCalendarDao {

	private String namespace = "student.model.Student";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public sCalendarDao() {
		System.out.println("CalenderDao 생성자");
	}

	public List<sCalendarBean> getAllSchedules() {
		List<sCalendarBean> lists = new ArrayList<sCalendarBean>();
		lists = sqlSessionTemplate.selectList(namespace + ".getAllSchedules");
		return lists;
	}

}
