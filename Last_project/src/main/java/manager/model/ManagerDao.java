package manager.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ManagerDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public ManagerDao() {
		System.out.println("ManagerDao 생성자 생성");
	}
}
