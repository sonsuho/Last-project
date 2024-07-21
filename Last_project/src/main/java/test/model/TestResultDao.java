package test.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TestResultDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public TestResultDao() {
		System.out.println("TestDao 생성자 생성");
	}

	public List<TestResultBean> getAllTestResult(int stu_num) {
		
		List<TestResultBean> trlist = sqlSessionTemplate.selectList("testResult.model.TestResult.getAllTestResult", stu_num);
		
		System.out.println("getAllTestResult trlist 사이즈 : " + trlist.size());
		
		return trlist;
	}
	
	public List<TestResultBean> getAllTestResultByLec(String lec_num) {
		
		List<TestResultBean> trlist = sqlSessionTemplate.selectList("testResult.model.TestResult.getAllTestResultByLec", lec_num);
		
		System.out.println("getAllTestResultByLec trlist 사이즈 : " + trlist.size());
		
		return trlist;
	}
	
	public List<TestResultBean> getAllTestResultByTest(String test_num) {
		
		List<TestResultBean> trlist = sqlSessionTemplate.selectList("testResult.model.TestResult.getAllTestResultByTest", test_num);
		
		System.out.println("getAllTestResultByTest trlist 사이즈 : " + trlist.size());
		
		return trlist;
	}	

	public int insertTestResult(TestResultBean trb) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.insert("testResult.model.TestResult.insertTestResult", trb);
		
		System.out.println("insertTestResult cnt : " + cnt);
		
		return cnt;
	}
}
