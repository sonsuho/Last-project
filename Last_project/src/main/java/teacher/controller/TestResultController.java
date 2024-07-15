package teacher.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import test.model.TestBean;
import test.model.TestDao;
import test.model.TestResultBean;
import test.model.TestResultDao;

@Controller
public class TestResultController {
	
	final String command = "/testList.teacher";
	final String getPage = "testList";
	
	@Autowired
	TestDao tdao;
	
	@Autowired
	TestResultDao trdao;
	
	@RequestMapping(command)
	public ModelAndView testList(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		String lec_num = ((MemberBean)session.getAttribute("loginInfo")).getLec_num();
		
		List<TestBean> tlist = tdao.getAllTest(lec_num);
		
		List<TestResultBean> trlist = trdao.getAllTestResultByLec(lec_num);
		
		mav.addObject("tlist", tlist);
		mav.addObject("trlist", trlist);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
}