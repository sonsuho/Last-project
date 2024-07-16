package teacher.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import evaluation.model.EvaluationBean;
import evaluation.model.EvaluationDao;
import evaluation.model.EvaluationResultBean;
import evaluation.model.EvaluationResultDao;

@Controller
public class EvalResultContentController {
	
	final String command = "/evalResultContent.teacher";
	final String getPage = "evalResultContent";
	
	@Autowired
	EvaluationDao edao;
	
	@Autowired
	EvaluationResultDao erdao;
	
	@RequestMapping(command)
	public ModelAndView evalResult(@RequestParam(value = "eval_num") String eval_num) {
		
		ModelAndView mav = new ModelAndView();
		
		List<EvaluationResultBean> erlist = erdao.getAllEvalResultByEval(eval_num);
		
		mav.addObject("count", erlist.size());
		
		EvaluationBean eb = edao.getEvalByEval(eval_num);
		
		mav.addObject("eval_name", eb.getEval_content());
		
		int[][] result = new int[9][5];
		
		String[] req = new String[erlist.size()];
		
		for(int j = 0; j < erlist.size(); j++) {
			
			String[] answers = erlist.get(j).getEval_result().split("/");
			
			for(int i = 0; i < 9; i++) {
				int answer = Integer.parseInt(answers[i]) - 1;
				
				result[i][answer]++;
			}
			
			req[j] = answers[9];
		}
		
		mav.addObject("result", result);
		mav.addObject("req", req);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
}
