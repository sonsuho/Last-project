package teacher.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import student.model.StudentDao;
import test.model.TestBean;
import test.model.TestDao;
import test.model.TestResultBean;
import test.model.TestResultDao;

@Controller
public class TestResultContentController {
	
	final String command = "/testResultContent.teacher";
	final String getPage = "testResultContent";
	
	@Autowired
	TestResultDao trdao;
	
	@Autowired
	TestDao tdao;
	
	@Autowired
	StudentDao sdao;
	
	@RequestMapping(command)
	public ModelAndView testResult(@RequestParam(value = "test_num") String test_num) {
		
		ModelAndView mav = new ModelAndView();
		
		List<TestResultBean> trlist = trdao.getAllTestResultByTest(test_num);
		
		TestBean test = tdao.getTestByNum(test_num);
		
		mav.addObject("trlist", trlist);
		mav.addObject("test_name", test.getTest_name());
		
		int count = trlist.size();
		mav.addObject("count", count);
		
		int sum = 0;
		for(TestResultBean result: trlist) {
			sum += result.getPoint();
		}
		double mean = (double)sum/count;
		mav.addObject("mean", mean);
		
		double sum2 = 0;
		for(TestResultBean result: trlist) {
			double deviation = result.getPoint() - mean;
			sum2 += (deviation * deviation);
		}
		double variance = sum2/count;
		mav.addObject("variance", variance);
		
		mav.addObject("standard_deviation", Math.sqrt(variance));
		
		List<String> fail = new ArrayList<String>();
		for(TestResultBean result: trlist) {
			if(result.getPoint() <= 60) {
				fail.add( sdao.getStudentByMem_Num(result.getStu_num()).getName() );
			}
		}
		mav.addObject("fail", fail);
		
		mav.setViewName(getPage);
		
		return mav;
	}
}
