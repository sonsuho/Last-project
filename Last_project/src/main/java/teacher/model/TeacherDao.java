package teacher.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TeacherDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public TeacherDao() {
		System.out.println("TeacherDao 생성");
	}
	
	
	
}
