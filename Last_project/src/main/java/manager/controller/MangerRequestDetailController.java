package manager.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.RequestBean;
import manager.model.RequestDao;
import member.model.MemberBean;

@Controller
public class MangerRequestDetailController {
    private final String command = "/requestDetail.manager";
    private final String getPage = "requestDetail";
    
    @Autowired
    RequestDao rdao;
    
    
    @RequestMapping(value=command, method = RequestMethod.GET)
    public ModelAndView requestList(@RequestParam int req_num,
    								@RequestParam int app_num,
    								@RequestParam String title,
    								@RequestParam String reason,
    								@RequestParam String memberName,
    								@RequestParam String time2,
    								@RequestParam (value="sign", required = false)String sign,
    								HttpSession session) {
        ModelAndView mav = new ModelAndView();
        
        List<MemberBean> mlist = (List<MemberBean>) session.getAttribute("mlist");

        System.out.println("테스트용 학생 멤버넘버:"+mlist.get(0).getMem_num()); // 테스트용 출력

        
        System.out.println("app_num:"+app_num);
        System.out.println("req_num:"+req_num);
        System.out.println("title:"+title);
        System.out.println("memberName:"+memberName);
        System.out.println("time2:"+time2);
        System.out.println("sign:"+sign);
        
        mav.addObject("req_num",req_num);
        mav.addObject("app_num",app_num);
        mav.addObject("title",title);
        mav.addObject("reason",reason);
        mav.addObject("memberName",memberName);
        mav.addObject("time2",time2);
        if(sign != null) {
        	mav.addObject("sign",sign);
        }
        
        RequestBean rb = rdao.getRequestByNum(req_num);
        String[] uploadList = rb.getSign().split("/");
		
		mav.addObject("uploadList", uploadList);
        
        mav.setViewName(getPage);
        
        return mav;
    }
    
    
}
