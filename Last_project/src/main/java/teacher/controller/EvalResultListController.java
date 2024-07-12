package teacher.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import evaluation.model.EvaluationBean;
import evaluation.model.EvaluationDao;
import evaluation.model.EvaluationResultBean;
import evaluation.model.EvaluationResultDao;
import member.model.MemberBean;

@Controller
public class EvalResultListController {
	
	final String command = "/evalResultList.teacher";
	final String getPage = "evalResultList";
	
	@Autowired
	EvaluationDao edao;
	
	@Autowired
	EvaluationResultDao erdao;
	
	@RequestMapping(command)
	public ModelAndView evalResultList(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		String lec_num = ((MemberBean)session.getAttribute("loginInfo")).getLec_num();
		
		List<EvaluationBean> elist = edao.getAllEvalByLec(lec_num);
		
		List<EvaluationResultBean> erlist = erdao.getAllEvalResultByLec(lec_num);
		
		mav.addObject("elist", elist);
		mav.addObject("erlist", erlist);
		
		mav.setViewName(getPage);
		
		return mav;
	}
}
