package manager.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.RequestBean;
import manager.model.RequestDao;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
@ComponentScan({"member","manager"})
public class MangerRequestDetailController {
    private final String command = "/requestDetail.manager";
    private final String getPage = "requestDetail";
    
    @Autowired
    RequestDao rdao;
    
    @Autowired
    MemberDao mdao;
    
    @RequestMapping(value=command, method = RequestMethod.GET)
    public ModelAndView requestList(@RequestParam int req_num,
    								@RequestParam int app_num,
    								@RequestParam int mem_num,
    								@RequestParam String title,
    								@RequestParam String reason,
    								@RequestParam String memberName,
    								@RequestParam String time1,
    								@RequestParam String time2,
    								@RequestParam String ap_situ,
    								@RequestParam (value="sign", required = false)String sign,
    								HttpSession session) {
        ModelAndView mav = new ModelAndView();

        System.out.println("app_num:"+app_num);
        System.out.println("req_num:"+req_num);
        System.out.println("mem_num:"+mem_num);
        System.out.println("title:"+title);
        System.out.println("memberName:"+memberName);
        System.out.println("time1:"+time1);
        System.out.println("time2:"+time2);
        System.out.println("sign:"+sign);
        System.out.println("ap_situ:"+ap_situ);
        
        mav.addObject("req_num",req_num);
        mav.addObject("app_num",app_num);
        mav.addObject("mem_num",mem_num);
        mav.addObject("title",title);
        mav.addObject("reason",reason);
        mav.addObject("memberName",memberName);
        mav.addObject("time1",time1);
        mav.addObject("time2",time2);
        mav.addObject("ap_situ",ap_situ);
        if(sign != null) {
        	mav.addObject("sign",sign);
        }
        
        RequestBean rb = rdao.getRequestByNum(req_num);
        String[] uploadList = null;
        if (rb.getSign() != null) {
            uploadList = rb.getSign().split("/");
        }
		
        MemberBean mem = mdao.getNameByNum(rb.getMem_num());//보낸사람이름 가져오기
        MemberBean mb = mdao.getNameBySendNum(rb.getApp_num());//받은사람이름 가져오기
		
		mav.addObject("uploadList", uploadList);
		mav.addObject("mem", mem);//보낸사람
		mav.addObject("mb", mb);//결재자
		System.out.println("mem.mem_num:"+mem.getMem_num());
		mav.addObject("uploadList", uploadList);
        
        mav.setViewName(getPage);
        
        return mav;
    }
    
    
}