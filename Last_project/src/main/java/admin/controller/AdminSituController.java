package admin.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import alarm.model.AlarmService;
import manager.model.RequestBean;
import manager.model.RequestDao;
import member.model.MemberBean;

@Controller
@ComponentScan({"admin","manager","alarm"})
public class AdminSituController {
	
	private final String command = "/changeCompanion.admin";
	private final String command2 = "/changeApproval.admin";
	private final String getPage = "redirect:/request.admin";
	
	@Autowired
	RequestDao rdao;
	
	@Autowired
	AlarmService service;
	
	@RequestMapping(command)
	public ModelAndView companion(@RequestParam int req_num,
								@RequestParam int app_num,
								@RequestParam int mem_num,
								Map<String,String> paramap,
								 HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		RequestBean rb = new RequestBean();
		rb.setReq_num(req_num);
		rb.setApp_num(app_num);
		rb.setAp_situ("반려");
		
		rdao.updateSitu(rb);
		
		mav.setViewName(getPage);
		
        
        MemberBean mb = (MemberBean)session.getAttribute("loginInfo");

        
        paramap.put("fk_recipientno", String.valueOf(mem_num)); // 받는사람 (여러명일때는 ,,으로 구분된 str)
        paramap.put("url", "/request2.manager?mem_num=" );
        paramap.put("url2", String.valueOf(mem_num)); // 연결되는 pknum등...  (여러개일때는 ,,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
        paramap.put("alarm_content", mb.getName() + "님이 문서를 반려하셨습니다. 확인해 주세요." );
        paramap.put("alarm_type", "2" );
        
        
        service.addAlarm(paramap);
		
		return mav;
	}
	
	@RequestMapping(command2)
	public ModelAndView approval(@RequestParam int req_num,
								@RequestParam int app_num,
								@RequestParam int mem_num,
								Map<String,String> paramap,
								 HttpSession session) {
		ModelAndView mav = new ModelAndView();
		RequestBean rb = new RequestBean();
		rb.setReq_num(req_num);
		rb.setApp_num(app_num);
		rb.setAp_situ("승인");
		
		rdao.updateSitu(rb);
		
		mav.setViewName(getPage);
		
        
        MemberBean mb = (MemberBean)session.getAttribute("loginInfo");
		
		paramap.put("fk_recipientno", String.valueOf(mem_num)); // 받는사람 (여러명일때는 ,,으로 구분된 str)
        paramap.put("url", "/request2.manager?mem_num=" );
        paramap.put("url2", String.valueOf(mem_num)); // 연결되는 pknum등...  (여러개일때는 ,,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
        paramap.put("alarm_content", mb.getName() + "님이 문서를 승인하셨습니다. 확인해 주세요." );
        paramap.put("alarm_type", "4" );
        
        
        service.addAlarm(paramap);
		
		return mav;
	}
}
