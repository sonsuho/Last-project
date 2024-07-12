package manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.RequestBean;
import manager.model.RequestDao;

@Controller
public class ManagerSituController {
	
	private final String command = "/changeCompanion.manager";
	private final String command2 = "/changeApproval.manager";
	private final String getPage = "redirect:/request.manager";
	
	@Autowired
	RequestDao rdao;
	
	@RequestMapping(command)
	public ModelAndView companion(@RequestParam int req_num,
								@RequestParam int app_num) {
		ModelAndView mav = new ModelAndView();
		
		RequestBean rb = new RequestBean();
		rb.setReq_num(req_num);
		rb.setApp_num(app_num);
		rb.setAp_situ("반려");
		
		rdao.updateSitu(rb);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	@RequestMapping(command2)
	public ModelAndView approval(@RequestParam int req_num,
								@RequestParam int app_num) {
		ModelAndView mav = new ModelAndView();
		RequestBean rb = new RequestBean();
		rb.setReq_num(req_num);
		rb.setApp_num(app_num);
		rb.setAp_situ("승인");
		
		rdao.updateSitu(rb);
		
		mav.setViewName(getPage);
		
		return mav;
	}
}
