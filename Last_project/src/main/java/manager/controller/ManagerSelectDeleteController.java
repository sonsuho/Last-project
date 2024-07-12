package manager.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.EtcDao;
import manager.model.RequestDao;

@Controller
public class ManagerSelectDeleteController {
	private final String commnand="/selectDeleteReq.manager";//결재 문서함
	private final String commnand1="/selectDeleteReq2.manager";//결재 문서함
	private final String commnand2="/selectDeleteEtc.manager";//기타서류
	
	private final String getPage="redirect:/request.manager";//결재 문서함
	private final String getPage1="redirect:/request2.manager";//결재 문서함
	private final String getPage2="redirect:/etcList.manager";//기타서류
	
	@Autowired
	RequestDao rdao;
	
	@Autowired
	EtcDao edao;
	
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
	
	
	@RequestMapping(commnand2)
	public ModelAndView selectDeleteEtc(@RequestParam String [] rowcheck,@RequestParam String etc_delete) {
		ModelAndView mav = new ModelAndView();
		
		
		System.out.println("etc_delete:"+etc_delete);
		
		rdao.rowcheckEtc_delete(rowcheck);
		
		int etc_delCount = rdao.delEtcCheck(rowcheck);
		System.out.println("etc_delCount:"+etc_delCount);
		
		if(etc_delCount == 0) {
			edao.selectDelete(rowcheck);
		}
		
		mav.setViewName(getPage2);
		
		return mav;
	}
	
	
	
}
