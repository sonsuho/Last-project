package manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class ManagerMainController {
	private final String command = "/home.manager";
	private final String getPage = "home";
	
	
	@RequestMapping(value = command , method = RequestMethod.GET)
	public ModelAndView approval() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	
}
