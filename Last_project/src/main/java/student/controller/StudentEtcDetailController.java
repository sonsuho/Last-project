package student.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.EtcBean;
import member.model.MemberBean;
import member.model.MemberDao;
import student.model.SEtcBean;
import student.model.SEtcDao;

@Controller
@ComponentScan({"member","student"})
public class StudentEtcDetailController {
    private final String command1 = "/etcDetail.student";
    private final String command2 = "/etcDetail2.student";
    private final String getPage1 = "etcDetail";
    private final String getPage2 = "etcDetail2";
    
    @Autowired
    SEtcDao edao;
   
    @Autowired
    MemberDao mdao;
    

    
    @RequestMapping(value=command1, method = RequestMethod.GET)
    public ModelAndView etcdetailStudent(@RequestParam int etc_num, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        
        System.out.println("서류번호:"+etc_num);
        
        SEtcBean eb = edao.getEtcByNum(etc_num);
        
        String[] uploadList = eb.getEtc_file().split("/");
		
		mav.addObject("uploadList", uploadList);
		
		int fileCount = edao.fileCount(etc_num);
        
        System.out.println("받은사람 번호:"+eb.getMem_num());
        
        MemberBean mem = mdao.getNameByNum(eb.getMem_num());//받은사람이름 가져오기
        MemberBean mb = mdao.getNameBySendNum(eb.getSender_num());//받은사람이름 가져오기
        
        System.out.println("보낸사람이름:"+mb.getName());
        System.out.println("받는사람이름:"+mem.getName());
        
        
        mav.addObject("fileCount",fileCount);
        mav.addObject("sender",mb);
        mav.addObject("receiver",mem);
        mav.addObject("eb",eb);
        
        mav.setViewName(getPage1);
        
        return mav;
    }
    
    @RequestMapping(value=command2, method = RequestMethod.GET)
    public ModelAndView etcdetailStudent2(@RequestParam int etc_num,@RequestParam int sender_num, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        
        
        EtcBean eb = edao.getEtcBySenderNum(sender_num,etc_num);
        
        String[] uploadList = eb.getEtc_file().split("/");
		
		mav.addObject("uploadList", uploadList);
		
		int fileCount = edao.fileCountBySenderNum(sender_num);
        
        System.out.println("받은사람 번호:"+eb.getMem_num());
        
        MemberBean mem = mdao.getNameByNum(eb.getMem_num());//받은사람이름 가져오기
        MemberBean mb = mdao.getNameBySendNum(eb.getSender_num());//받은사람이름 가져오기
        
        System.out.println("보낸사람이름:"+mb.getName());
        System.out.println("받는사람이름:"+mem.getName());
        
        
        mav.addObject("fileCount",fileCount);
        mav.addObject("sender",mb);
        mav.addObject("receiver",mem);
        mav.addObject("eb",eb);
        
        mav.setViewName(getPage2);
        
        return mav;
    }
}
