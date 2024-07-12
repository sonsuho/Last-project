package student.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import evaluation.model.EvaluationBean;
import evaluation.model.EvaluationDao;
import evaluation.model.EvaluationResultBean;
import evaluation.model.EvaluationResultDao;
import member.model.MemberBean;

@Controller
public class EvaluationContentController {
	
	final String command = "/evalContent.student";
	final String command2 = "/evalContent2.student";
	final String getPage = "evalContent";
	final String gotoPage1 = "eval";
	final String gotoPage2 = "evalSuccess";
	
	@Autowired
	EvaluationResultDao erdao;
	
	@Autowired
	EvaluationDao edao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView evalContent(@RequestParam(value = "eval_num", required = false) String eval_num, HttpSession session, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		int stu_num = ((MemberBean)session.getAttribute("loginInfo")).getMem_num();
		
		List<EvaluationResultBean> erlist = erdao.getAllEvalResult(stu_num);
		
		for(EvaluationResultBean erb : erlist) {
			
			if(erb.getEval_num() == Integer.parseInt(eval_num)) {
				
				try {
					
					response.setContentType("text/html;charset=utf-8");
					
					PrintWriter out = response.getWriter();
					
					out.print("<script>alert('이미 응시한 평가 조사입니다')</script>");
					
					out.print("<script>location.href='evalList.student'</script>");
					
					out.flush();
					
					return null;
					
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}
		}
		
		mav.addObject("eval_num", eval_num);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	@RequestMapping(value = command2, method = RequestMethod.POST)
	public ModelAndView test(@RequestParam(value = "eval_num", required = false) String eval_num) {

		ModelAndView mav = new ModelAndView();

		EvaluationBean eb = edao.getEvalByEval(eval_num);
		
		mav.addObject("eval", eb);
		
		mav.setViewName(gotoPage1);
		
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView evalSuccess(@RequestParam(value = "problem1", required = false) String problem1,
									@RequestParam(value = "problem2", required = false) String problem2,
									@RequestParam(value = "problem3", required = false) String problem3,
									@RequestParam(value = "problem4", required = false) String problem4,
									@RequestParam(value = "problem5", required = false) String problem5,
									@RequestParam(value = "problem6", required = false) String problem6,
									@RequestParam(value = "problem7", required = false) String problem7,
									@RequestParam(value = "problem8", required = false) String problem8,
									@RequestParam(value = "problem9", required = false) String problem9,
									@RequestParam(value = "eval_num", required = false) int eval_num,
									@RequestParam(value = "req", required = false) String req,
									HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		MemberBean student = (MemberBean)session.getAttribute("loginInfo");
		
		String lec_num = student.getLec_num();
		
		int stu_num = student.getMem_num();
		
		String eval_result = problem1 + "/" + problem2 + "/" + problem3 + "/"
						   + problem4 + "/" + problem5 + "/" + problem6 + "/"
				           + problem7 + "/" + problem8 + "/" + problem9 + "/" + req;
		
		EvaluationResultBean erb = new EvaluationResultBean();
		
		erb.setEval_num(eval_num);
		erb.setLec_num(Integer.parseInt(lec_num));
		erb.setStu_num(stu_num);
		erb.setEval_result(eval_result);
		
		erdao.insertEvalResult(erb);
		
		mav.setViewName(gotoPage2);
		
		return mav;       
	}
}
