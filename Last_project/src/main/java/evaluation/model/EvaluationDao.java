package evaluation.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EvaluationDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public EvaluationDao() {
		System.out.println("EvaluationDao 생성자 생성");
	}

	public int getEvalNumByLec(String lec_num) {
		
		int count = -1;
		
		count = sqlSessionTemplate.selectOne("evaluation.model.Evaluation.getEvalNumByLec", lec_num);
		
		System.out.println("getEvalNumByLec 수 : " + count);
		
		return count;
	}

	public int insertEvaluation(EvaluationBean eb) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.insert("evaluation.model.Evaluation.insertEvaluation", eb);
		
		System.out.println("insertEvaluation cnt : " + cnt);
		
		return cnt;
	}

	public List<EvaluationBean> getAllEvalByLec(String lec_num) {
		
		List<EvaluationBean> elist = sqlSessionTemplate.selectList("evaluation.model.Evaluation.getAllEvalByLec", lec_num);
		
		System.out.println("getAllEvalByLec elist 사이즈 : " + elist.size());
		
		return elist;
	}

	public EvaluationBean getEvalByEval(String eval_num) {
		
		EvaluationBean eb = sqlSessionTemplate.selectOne("evaluation.model.Evaluation.getEvalByEval", eval_num);
		
		System.out.println("getEvalByEval 이름 : " + eb.getEval_content());
		
		return eb;
	}
	
	
}
