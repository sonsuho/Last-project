package student.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import alarm.model.AlarmService;
import member.model.MemberBean;
import student.model.SRequestBean;
import student.model.SRequestDao;

@Controller
@ComponentScan({"student", "alarm"})
public class SRequestController {

	private final String command = "request.student";
	private final String getPage = "requestForm";
	private final String gotoPage = "redirect:/request2.student";
	
	@Autowired
	SRequestDao requestDao;
	
	@Autowired
    AlarmService service;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String request(){
		
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView request(@ModelAttribute("req") @Valid SRequestBean req, BindingResult result,
								Map<String, String> paramap, HttpSession session) {
		System.out.println("여기");
		ModelAndView mav = new ModelAndView();
		
		System.out.println("mem_num: " +req.getApp_num());
		System.out.println("req.getCategory: " + req.getCategory());
		System.out.println("req.getMem_num: " + req.getMem_num());
		System.out.println("req.getReason: " + req.getReason());
		System.out.println("req.getTitle: " + req.getTitle());
		System.out.println("req.getTime1: " + req.getTime1());
		System.out.println("req.getTime2: " + req.getTime2());
		System.out.println("req.getSign: " + req.getSign());
		
		if(result.hasErrors()) {
			System.out.println("오류");
			mav.setViewName(getPage);
			return mav;
		}
		
		System.out.println("여기3");
		requestDao.studentReqInsert(req);
		mav.setViewName(gotoPage);

		//알림
        MemberBean mb = (MemberBean)session.getAttribute("loginInfo");

        paramap.put("fk_recipientno", String.valueOf(req.getApp_num())); // 받는사람 (여러명일때는 ,,으로 구분된 str)
        paramap.put("url", "/request.manager?mem_num=" );
        paramap.put("url2", String.valueOf(req.getApp_num())); // 연결되는 pknum등...  (여러개일때는 ,,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
        paramap.put("alarm_content", mb.getName() + "님이 결재 문서를 보냈습니다. 확인해 주세요." );
        paramap.put("alarm_type", "1" );
        
        mav.addObject("mem_num",mb.getMem_num());
        
        service.addAlarm(paramap);
		
		return mav;
	}
	
}
