package student.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import student.model.RequestBean;
import student.model.RequestDao;

@Controller
public class RequestController {

	private final String command = "/request.student";
	private final String getPage = "requestForm";
	private final String gotoPage = "studentMain";
	
	@Autowired
	RequestDao requestDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String request(){
		
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView request(@ModelAttribute("req") @Valid RequestBean req, BindingResult result) {
		System.out.println("여기");
		ModelAndView mav = new ModelAndView();
		
		System.out.println("req.getCategory: " + req.getCategory());
		System.out.println("req.getMem_num: " + req.getMem_num());
		System.out.println("req.getTime1: " + req.getTime1());
		System.out.println("req.getTime2: " + req.getTime2());
		System.out.println("req.getSign: " + req.getSign());
		
		if(result.hasErrors()) {
			System.out.println("여기2");
			mav.setViewName(getPage);
			return mav;
		}
		
		System.out.println("여기3");
		requestDao.studentReqInsert(req);
		mav.setViewName(gotoPage);
		return mav;
	}
}
