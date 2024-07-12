package evaluation.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EvaluationResultDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public EvaluationResultDao() {
		System.out.println("EvaluationResultDao 생성자 생성");
	}

	public List<EvaluationResultBean> getAllEvalResult(int stu_num) {
		
		List<EvaluationResultBean> erlist = sqlSessionTemplate.selectList("evaluation.model.Evaluation.getAllEvalResult", stu_num);
		
		System.out.println("getAllEvalResult erlist 사이즈 : " + erlist.size());
		
		return erlist;
	}

	public int insertEvalResult(EvaluationResultBean erb) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.insert("evaluation.model.Evaluation.insertEvalResult", erb);
		
		System.out.println("insertEvalResult cnt : " + cnt);
		
		return cnt;
	}

	public List<EvaluationResultBean> getAllEvalResultByLec(String lec_num) {
		
		List<EvaluationResultBean> erlist = sqlSessionTemplate.selectList("evaluation.model.Evaluation.getAllEvalResultByLec", lec_num);
		
		System.out.println("getAllEvalResultByLec erlist 사이즈 : " + erlist.size());
		
		return erlist;
	}

	public List<EvaluationResultBean> getAllEvalResultByEval(String eval_num) {
		
		List<EvaluationResultBean> erlist = sqlSessionTemplate.selectList("evaluation.model.Evaluation.getAllEvalResultByEval", eval_num);
		
		System.out.println("getAllEvalResultByEval erlist 사이즈 : " + erlist.size());
		
		return erlist;
	}
	
	
	
}
