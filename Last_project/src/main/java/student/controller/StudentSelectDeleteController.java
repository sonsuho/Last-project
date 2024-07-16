package student.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.EtcDao;
import manager.model.RequestDao;
import member.model.MemberBean;
import student.model.SEtcDao;
import student.model.SRequestDao;

@Controller
public class StudentSelectDeleteController {

	private final String scommnand1="/selectDeleteEtc.student";//기타서류
	private final String scommnand2="/selectDeleteSend.student";//받은 문서함
	private final String scommnand3="/selectDeleteReq2.student";//결재 문서함
	
	private final String sgetPage1="redirect:/etcList.student";//학생서류
	private final String sgetPage2="redirect:/etcSendList.student";//쓴서류
	private final String sgetPage3="redirect:/request2.student";//결재 문서함
	
	@Autowired
	SRequestDao rdao;
	
	@Autowired
	SEtcDao edao;
	
	
	@RequestMapping(scommnand1)
	public ModelAndView selectDeleteStuEtc(@RequestParam String [] rowcheck,@RequestParam String etc_delete,@RequestParam String mem_num) {
		ModelAndView mav = new ModelAndView();
		
		
		System.out.println("etc_delete:"+etc_delete);
		
		rdao.rowcheckEtc_delete(rowcheck);
		
		int etc_delCount = rdao.delEtcCheck(rowcheck);
		System.out.println("etc_delCount:"+etc_delCount);
		
		if(etc_delCount == 0) {
			edao.selectDelete(rowcheck);
		}
		
		mav.addObject("mem_num",mem_num);
		mav.setViewName(sgetPage1);
		
		return mav;
	}
	
	
	@RequestMapping(scommnand2)
	public ModelAndView selectDeleteStuSend(@RequestParam String [] rowcheck,@RequestParam String etc_delete,@RequestParam String sender_num) {
		ModelAndView mav = new ModelAndView();
		
		for(String i : rowcheck) {
			System.out.println("넘어오는 번호:"+i);
		}
		
		//edao.selectDeleteSend(rowcheck);
		System.out.println("etc_delete:"+etc_delete);
		
		rdao.rowcheckEtc_delete(rowcheck);
		
		int etc_delCount = rdao.delEtcCheck(rowcheck);
		System.out.println("etc_delCount:"+etc_delCount);
		
		if(etc_delCount == 0) {
			edao.selectDelete(rowcheck);
		}
		
		mav.addObject("sender_num",sender_num);
		mav.setViewName(sgetPage2);
		
		return mav;
	}
	
	@RequestMapping(scommnand3)
	public ModelAndView selectDeleteStuReq2(@RequestParam String [] rowcheck,
											@RequestParam String ap_delete,
											@RequestParam String mem_num,
											HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		for(String i : rowcheck) {
			System.out.println("넘어오는 번호:"+i);
		}
		System.out.println("ap_delete:"+ap_delete);
		
		rdao.rowcheckSReq_delete(rowcheck);
		
		int ap_delCount = rdao.delSReqCheck(rowcheck);
		System.out.println("ap_delCount:"+ap_delCount);
		
		if(ap_delCount == 0) {
			rdao.selectDelete(rowcheck);
		}
		
		
		mav.addObject("mem_num",mem_num);
		mav.setViewName(sgetPage3);
		
		return mav;
	}
	
	
}
