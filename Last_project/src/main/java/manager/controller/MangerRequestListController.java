package manager.controller;

import java.util.ArrayList;
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
import manager.model.RequestDao;
import manager.model.RequestJoinMemberBean;
import utility.Paging;

@Controller
public class MangerRequestListController {
	private final String command1 = "/request.manager";
	private final String command2 = "/request2.manager";
	private final String getPage = "requestList";
	private final String getPage2 = "requestList2";

	@Autowired
	RequestDao rdao;


	@RequestMapping(command1)
	public ModelAndView requestList(@RequestParam(value = "whatColumn", required = false) String whatColumn,
									@RequestParam(value = "keyword", required = false) String keyword,
									@RequestParam(value = "pageNumber", required = false) String pageNumber,
									@RequestParam(value = "mem_num", required = false) String mem_num,
									HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();


		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", "%"+keyword+"%");
		map.put("whatColumn", whatColumn);
		map.put("app_num", mem_num);

		int totalCountBySitu = rdao.getTotalCountBySitu(map); // 나한테 온 문서중에서 상태가 null인것
		System.out.println("상태null개수:"+totalCountBySitu);

		int AlltotalCount = rdao.getAllTotalCount();
		System.out.println("전체개수:"+AlltotalCount);

		String url = request.getContextPath()+command1;


		System.out.println("매니저리스트mem_num:"+mem_num);
		Paging pageInfo = new Paging(pageNumber,null,totalCountBySitu,url,whatColumn,keyword,mem_num,"");


		mav.addObject("pageInfo",pageInfo);

		mav.addObject("totalCountBySitu",totalCountBySitu);

		mav.addObject("AlltotalCount",AlltotalCount);

		mav.setViewName(getPage);


		List<RequestJoinMemberBean> rmlist = rdao.RequestPaging1(pageInfo, map);
		List<RequestJoinMemberBean> pendingList  = new ArrayList<RequestJoinMemberBean>();//승인이 필요한 문서 리스트
		List<RequestJoinMemberBean> completedList = new ArrayList<RequestJoinMemberBean>();//완료된 문서 리스트
		System.out.println("pendingList.size:"+pendingList.size());
		for (RequestJoinMemberBean rjb : rmlist) {
			if (rjb.getAp_situ() == null || rjb.getAp_situ().isEmpty()) {
				pendingList.add(rjb); //상태가 NULL이면 승인이 필요한 문서리스트로
			} else {
				completedList.add(rjb); // 아니면 완료
			}
		}

		mav.addObject("pendingList",pendingList);
		mav.setViewName(getPage);

		return mav;
	}

	@RequestMapping(command2)
	public ModelAndView requestList2(@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "mem_num", required = false) String mem_num,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();


		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", "%"+keyword+"%");
		map.put("whatColumn", whatColumn);
		map.put("app_num", mem_num);

		int totalCount = rdao.getTotalCountByApproval(map);
		System.out.println("현재개수:"+totalCount);

		int AlltotalCount = rdao.getAllTotalCount();
		System.out.println("전체개수:"+AlltotalCount);

		String url = request.getContextPath()+command2;


		Paging pageInfo = new Paging(pageNumber,null,totalCount,url,whatColumn,keyword,"","");


		List<RequestJoinMemberBean> rmlist = rdao.RequestPaging2(pageInfo, map);
		List<RequestJoinMemberBean> pendingList  = new ArrayList<RequestJoinMemberBean>();
		List<RequestJoinMemberBean> completedList = new ArrayList<RequestJoinMemberBean>();

		for (RequestJoinMemberBean rjb : rmlist) {
			if (rjb.getAp_situ() == null || rjb.getAp_situ().isEmpty()) {
				pendingList.add(rjb);
			} else {
				completedList.add(rjb);
			}
		}

		
		mav.addObject("pageInfo",pageInfo);

		mav.addObject("totalCount",totalCount);

		mav.addObject("AlltotalCount",AlltotalCount);
		
		mav.addObject("completedList",completedList);
		
		mav.setViewName(getPage2);

		return mav;
	}
	
	
}
