package manager.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.EtcBean;
import manager.model.EtcDao;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MangerEtcDetailController {
    private final String command = "/etcDetail.manager";
    private final String getPage = "etcDetail";
    
    @Autowired
    EtcDao edao;
   
    @Autowired
    MemberDao mdao;
    
    @RequestMapping(value=command, method = RequestMethod.GET)
    public ModelAndView etcdetailManager(@RequestParam int etc_num, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        
        System.out.println("서류번호:"+etc_num);
        
        EtcBean eb = edao.getEtcByNum(etc_num);
        
        String[] uploadList = eb.getEtc_file().split("/");
		
		mav.addObject("uploadList", uploadList);
		
		int fileCount = edao.fileCount(etc_num);
        
        System.out.println("받은사람 번호:"+eb.getMem_num());
        
        MemberBean mem = mdao.getNameByNum(eb.getMem_num());//받는사람이름 가져오기
        MemberBean mb = mdao.getNameBySendNum(eb.getSender_num());//보내는사람이름 가져오기
        
        System.out.println("보낸사람이름:"+mb.getName());
        System.out.println("받는사람이름:"+mem.getName());
        
        
        mav.addObject("fileCount",fileCount);
        mav.addObject("sender",mb);
        mav.addObject("receiver",mem);
        mav.addObject("eb",eb);
        
        mav.setViewName(getPage);
        
        return mav;
    }
    
}
