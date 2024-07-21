package student.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import test.model.TestBean;
import test.model.TestDao;
import test.model.TestResultBean;
import test.model.TestResultDao;

@Controller
@ComponentScan({"student,test"})
public class TestListController {
	
	final String command = "/testList.student";
	final String getPage = "testList";
	
	@Autowired
	TestDao tdao;
	
	@Autowired
	TestResultDao trdao;
	
	@RequestMapping(command)
	public ModelAndView testList(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		String lec_num = ((MemberBean)session.getAttribute("loginInfo")).getLec_num();
		
		int stu_num = ((MemberBean)session.getAttribute("loginInfo")).getMem_num();
		
		List<TestBean> tlist = tdao.getAllTest(lec_num);
		
		List<TestResultBean> trlist = trdao.getAllTestResult(stu_num);
		
		mav.addObject("tlist", tlist);
		mav.addObject("trlist", trlist);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
}
