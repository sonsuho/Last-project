package student.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.RequestBean;
import manager.model.RequestJoinMemberBean;
import student.model.SRequestBean;
import student.model.SRequestDao;
import utility.Paging;

@Controller
public class StudentRequestListController {
	private final String command = "/request2.student";
	private final String getPage = "requestList2";

	@Autowired
	SRequestDao rdao;
	
	@RequestMapping(command)
	public ModelAndView requestList(@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam String mem_num,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", "%"+keyword+"%");
		map.put("whatColumn", whatColumn);
		map.put("mem_num", mem_num);

		int totalCount = rdao.getTotalCountBySitu3(map);
		System.out.println("현재개수:"+totalCount);

		int AlltotalCount = rdao.getAllTotalCount();

		String url = request.getContextPath()+command;


		Paging pageInfo = new Paging(pageNumber,null,totalCount,url,whatColumn,keyword,mem_num,"");


		List<RequestBean> rmlist = rdao.RequestPaging(pageInfo, map);
//		List<RequestJoinMemberBean> pendingList  = new ArrayList<RequestJoinMemberBean>();
//		List<RequestJoinMemberBean> completedList = new ArrayList<RequestJoinMemberBean>();
//
//		for (RequestJoinMemberBean rjb : rmlist) {
//			if (rjb.getAp_situ() == null || rjb.getAp_situ().isEmpty()) {
//				pendingList.add(rjb);
//			} else {
//				completedList.add(rjb);
//			}
//		}

		
		mav.addObject("mem_num",mem_num);
		
		mav.addObject("rmlist",rmlist);
		
		mav.addObject("pageInfo",pageInfo);

		mav.addObject("totalCount",totalCount);

		mav.addObject("AlltotalCount",AlltotalCount);
		
		mav.setViewName(getPage);

		return mav;
	}
}
