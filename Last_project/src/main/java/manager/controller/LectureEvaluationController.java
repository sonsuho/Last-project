package manager.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import evaluation.model.EvaluationBean;
import evaluation.model.EvaluationDao;
import evaluation.model.EvaluationResultDao;
import lecture.model.LectureDao;
import manager.model.ManagerDao;
import member.model.MemberBean;

@Controller
public class LectureEvaluationController {
	
	final String command = "/lectureEval.manager";
	final String getPage = "lectureEvalWriteForm";
	final String gotoPage = "lectureEvalWriteSuccess";
	
	@Autowired
	ManagerDao mdao;
	
	@Autowired
	LectureDao ldao;
	
	@Autowired
	EvaluationDao edao;
	
	@Autowired
	EvaluationResultDao erdao;
	
	@RequestMapping(value = command,  method = RequestMethod.GET)
	public ModelAndView writeForm(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		MemberBean manager = (MemberBean)session.getAttribute("loginInfo");
		
		String[] classes = manager.getLec_num().split("/");
		
		List<String> lec_names = new ArrayList<String>();
		
		for(String lec_num : classes) {
			
			String className = ldao.getClassNameByLec(lec_num);
			
			lec_names.add(className);
		}
		
		mav.addObject("lec_names", lec_names);
		mav.addObject("classes", classes);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	@RequestMapping(value = command,  method = RequestMethod.POST)
	public ModelAndView write(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		String[] lec_nums = request.getParameterValues("lec_nums");
		
		for(String lec_num : lec_nums) {
			
			EvaluationBean eb = new EvaluationBean();
			
			String className = ldao.getClassNameByLec(lec_num);
			
			int count = edao.getEvalNumByLec(lec_num) + 1;
			
			eb.setLec_num(Integer.parseInt(lec_num));
			eb.setEval_content("제 " + count + "회 " + className + "강의 평가 조사");
			
			edao.insertEvaluation(eb);
		}
		
		mav.setViewName(gotoPage);
		
		return mav;
	}
}
