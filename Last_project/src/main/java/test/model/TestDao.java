package test.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TestDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public TestDao() {
		System.out.println("TestDao 생성자 생성");
	}
	
	public int insertTest(TestBean tb) {
		
		int cnt = -1;
		
		System.out.println(tb.getTest_opt());
		
		cnt = sqlSessionTemplate.insert("test.model.Test.insertTest", tb);
		
		System.out.println("insetTest cnt : " + cnt);
		
		return cnt;
	}

	public List<TestBean> getAllTest(String lec_num) {
		
		List<TestBean> tlist = sqlSessionTemplate.selectList("test.model.Test.getAllTest", lec_num);
		
		System.out.println("getAllTest tlist 사이즈 : " + tlist.size());
		
		return tlist;
	}

	public TestBean getTestByNum(String test_num) {
		
		TestBean tb = sqlSessionTemplate.selectOne("test.model.Test.getTestByNum", test_num);
		
		System.out.println("getTestByNum test 이름 : " + tb.getTest_name());
		
		return tb;
	}

}
