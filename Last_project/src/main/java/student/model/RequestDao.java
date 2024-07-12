package student.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("requestDao")
public class RequestDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "student.model.Student";
	
	public RequestDao() {
		
	}
	
	public void studentReqInsert(RequestBean req) {
		sqlSessionTemplate.insert(namespace + ".studentReqInsert", req);
	}
}
