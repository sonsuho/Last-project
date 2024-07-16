package admin.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.RequestDao;

@Controller
@ComponentScan({"manager,admin"})
public class AdminRequestDeleteController {
	private final String commnand="/selectDeleteReq.admin";//결재 문서함
	private final String commnand1="/selectDeleteReq2.admin";//결재 문서함
	
	private final String getPage="redirect:/request.admin";//결재 문서함
	private final String getPage1="redirect:/request2.admin";//결재 문서함
	
	@Autowired
	RequestDao rdao;
	
	
	@RequestMapping(commnand)
	public ModelAndView selectDeleteReq(@RequestParam String [] rowcheck,@RequestParam String ap_delete) {
		ModelAndView mav = new ModelAndView();
		
		for(String i : rowcheck) {
			System.out.println("넘어오는 번호:"+i);
		}
		System.out.println("ap_delete:"+ap_delete);
		
		rdao.rowcheckAp_delete(rowcheck);
		
		int ap_delCount = rdao.delReqCheck(rowcheck);
		System.out.println("ap_delCount:"+ap_delCount);
		
		if(ap_delCount == 0) {
			rdao.selectDelete(rowcheck);
		}
		
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	@RequestMapping(commnand1)
	public ModelAndView selectDeleteReq2(@RequestParam String [] rowcheck,@RequestParam String ap_delete) {
		ModelAndView mav = new ModelAndView();
		
		for(String i : rowcheck) {
			System.out.println("넘어오는 번호:"+i);
		}
		System.out.println("ap_delete:"+ap_delete);
		
		rdao.rowcheckAp_delete(rowcheck);
		
		int ap_delCount = rdao.delReqCheck(rowcheck);
		System.out.println("ap_delCount:"+ap_delCount);
		
		if(ap_delCount == 0) {
			rdao.selectDelete(rowcheck);
		}
		
		
		mav.setViewName(getPage1);
		
		return mav;
	}
	
	
	
	
}
