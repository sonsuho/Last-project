package manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.EtcBean;
import manager.model.EtcDao;
import manager.model.EtcJoinMemberBean;
import manager.model.RequestBean;
import member.model.MemberBean;
import member.model.MemberDao;
import utility.Paging;

@Controller
public class ManagerEtcListController {
	private final String command = "/etcList.manager";//받은 문서
	private final String command2 = "/etcSendList.manager";//내가 쓴 문서
	private final String getPage = "etcList";//받은문서
	private final String getPage2 = "etcSendList";//쓴문서

	@Autowired
	EtcDao edao;

	
	@RequestMapping(command)
	public ModelAndView List2(@RequestParam(value = "mem_num", required = false) String mem_num,
							@RequestParam(value = "whatColumn", required = false) String whatColumn,
							@RequestParam(value = "keyword", required = false) String keyword,
							@RequestParam(value = "pageNumber", required = false) String pageNumber,
							HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		System.out.println("mem_num:"+mem_num);

		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", "%"+keyword+"%");
		map.put("whatColumn", whatColumn);
		map.put("mem_num", mem_num);

		int totalCountEtc = edao.totalCountEtcByMmem_Num(map);
		System.out.println("받은 문서 개수:"+totalCountEtc);

		String url = request.getContextPath()+command;
		
		System.out.println("url:"+url);

		Paging pageInfo = new Paging(pageNumber,null,totalCountEtc,url,whatColumn,keyword,mem_num,"");

		java.util.List<EtcJoinMemberBean> elist = edao.getEtcWithMemberInfo(pageInfo, map);

		mav.addObject("mem_num",mem_num);
		
		mav.addObject("elist",elist);

		mav.addObject("pageInfo",pageInfo);

		mav.addObject("totalCountEtc",totalCountEtc);


		mav.setViewName(getPage);

		return mav;
	}
	
	
	@RequestMapping(command2) // 쓴 문서
	public ModelAndView List(@RequestParam String sender_num,
							@RequestParam(value = "whatColumn", required = false) String whatColumn,
							@RequestParam(value = "keyword", required = false) String keyword,
							@RequestParam(value = "pageNumber", required = false) String pageNumber,
							HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		System.out.println("sender_num:"+sender_num);

		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", "%"+keyword+"%");
		map.put("whatColumn", whatColumn);
		map.put("sender_num", sender_num);

		int totalCountEtc = edao.totalCountEtcByMSender_Num(map);
		System.out.println("쓴 문서 개수:"+totalCountEtc);

		String url = request.getContextPath()+command2;

		Paging pageInfo = new Paging(pageNumber,null,totalCountEtc,url,whatColumn,keyword,"",sender_num);

		java.util.List<EtcJoinMemberBean> elist = edao.getEtcSenderListWithMemberInfo(pageInfo, map);

		mav.addObject("sender_num", sender_num);
		
		mav.addObject("elist",elist);

		mav.addObject("pageInfo",pageInfo);

		mav.addObject("totalCountEtc",totalCountEtc);


		mav.setViewName(getPage2);

		return mav;
	}
	
	
}
