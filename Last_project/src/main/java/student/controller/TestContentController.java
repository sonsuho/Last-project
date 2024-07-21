package student.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import test.model.TestBean;
import test.model.TestDao;
import test.model.TestResultBean;
import test.model.TestResultDao;

@Controller
@ComponentScan({"student,test"})
public class TestContentController {
	
	final String command = "/testContent.student";
	final String command2 = "/testContent2.student";
	final String getPage = "testContent";
	final String gotoPage1 = "test";
	final String gotoPage2 = "testSuccess";
	
	@Autowired
	TestDao tdao;
	
	@Autowired
	TestResultDao trdao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView testContent(@RequestParam(value = "test_num", required = false) String test_num, HttpSession session, HttpServletResponse response) {
		
		System.out.println("test : " + test_num);
		
		ModelAndView mav = new ModelAndView();
		
		int stu_num = ((MemberBean)session.getAttribute("loginInfo")).getMem_num();
		
		List<TestResultBean> trlist = trdao.getAllTestResult(stu_num);
		
		for(TestResultBean trb : trlist) {
			
			if(trb.getTest_num() == Integer.parseInt(test_num)) {
				
				try {
					
					response.setContentType("text/html;charset=utf-8");
					
					PrintWriter out = response.getWriter();
					
					out.print("<script>alert('이미 응시한 시험입니다')</script>");
					
					out.print("<script>location.href='testList.student'</script>");
					
					out.flush();
					
					return null;
					
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}
		}
		
		mav.addObject("test_num", test_num);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	@RequestMapping(value = command2, method = RequestMethod.POST)
	public ModelAndView test(@RequestParam(value = "test_num", required = false) String test_num) {
		
		System.out.println("test : " + test_num);
		
		ModelAndView mav = new ModelAndView();
		
		TestBean tb = tdao.getTestByNum(test_num);
		
		mav.addObject("test", tb);
		
		mav.setViewName(gotoPage1);
		
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView testSuccess(@RequestParam(value = "problem1", required = false) String problem1,
									@RequestParam(value = "problem2", required = false) String problem2,
									@RequestParam(value = "problem3", required = false) String problem3,
									@RequestParam(value = "problem4", required = false) String problem4,
									@RequestParam(value = "problem5", required = false) String problem5,
									@RequestParam(value = "test_num", required = false) String test_num,
									@RequestParam(value = "answers", required = false) String answers,
									HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		String[] test_answer = answers.split("/");
		
		String[] problems = {problem1, problem2, problem3, problem4, problem5};
		
		MemberBean student = (MemberBean)session.getAttribute("loginInfo");
		
		int score = 0;
		int correct = 0;
		
		for(int i = 0; i < 5; i++) {
			if(problems[i] != null) {				
				if(problems[i].equals(test_answer[i])) {
					correct++;
					score += 20;
				}
			}
		}
		
		TestResultBean trb = new TestResultBean();
		
		trb.setTest_num(Integer.parseInt(test_num));
		trb.setLec_num(Integer.parseInt(student.getLec_num()));
		trb.setStu_num(student.getMem_num());
		trb.setCorrect(correct);
		trb.setPoint(score);
		
		trdao.insertTestResult(trb);
		
		mav.setViewName(gotoPage2);
		
		return mav;
	}
}
