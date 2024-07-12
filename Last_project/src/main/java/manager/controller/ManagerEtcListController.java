package manager.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.EtcBean;
import manager.model.EtcDao;
import utility.Paging;

@Controller
public class ManagerEtcListController {
	private final String command = "/etcList.manager";
	private final String command2 = "/etcList2.manager";
	private final String getPage = "etcList";
	private final String getPage2 = "etcList2";

	@Autowired
	EtcDao edao;

	
	
	@RequestMapping(command)
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

		int totalCountEtc = edao.totalCountEtcBySender_Num(map);
		System.out.println("보낸 문서 개수:"+totalCountEtc);

		String url = request.getContextPath()+command;


		Paging pageInfo = new Paging(pageNumber,null,totalCountEtc,url,whatColumn,keyword);

		java.util.List<EtcBean> elist = edao.getEtcSenderList(pageInfo, map);

		mav.addObject("elist",elist);

		mav.addObject("pageInfo",pageInfo);

		mav.addObject("totalCountEtc",totalCountEtc);


		mav.setViewName(getPage);

		return mav;
	}
	
	@RequestMapping(command2)
	public ModelAndView List2(@RequestParam String mem_num,
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

		int totalCountEtc = edao.totalCountEtcByMem_Num(map);
		System.out.println("보낸 문서 개수:"+totalCountEtc);

		String url = request.getContextPath()+command2;


		Paging pageInfo = new Paging(pageNumber,null,totalCountEtc,url,whatColumn,keyword);

		java.util.List<EtcBean> elist = edao.getEtcList(pageInfo, map);

		mav.addObject("elist",elist);

		mav.addObject("pageInfo",pageInfo);

		mav.addObject("totalCountEtc",totalCountEtc);


		mav.setViewName(getPage2);

		return mav;
	}
}
